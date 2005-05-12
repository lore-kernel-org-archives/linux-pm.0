From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Thu, 12 May 2005 02:21:25 -0400
Message-ID: <20050512062125.GA30728@neo.rr.com>
References: <1115861087.3817.23.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46683764084301882=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1115861087.3817.23.camel@linux-hp.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============46683764084301882==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2005 at 09:24:47AM +0800, Shaohua Li wrote:
> Hi,
> There are still many PCI drivers don't implement their .suspend/.resume
> methods correctly. I felt it would be quite helpful there is a reference
> implementation. Here is my thought:
> 
> .suspend()
> {
> 	driver specific operations;
> 	pci_save_state();
> 	pci_enable_wake();
> 	/* as a result, PIC/IOAPIC pin is disabled */
> 	free_irq();

We can do this earlier, under driver specific operations, right?

> 	/* as a result, bus master/irq router are disabled */
> 	pci_disable_device();
> 	pci_set_power_state();
> }
> 
> .resume()
> {
> 	pci_set_power_state(PCI_D0);
> 	pci_restore_state();
> 	/* device's irq possibly is changed, driver should take care */

So what do you have in mind here?  Could/should the device's resource
configuration also possibly change.

> 	pci_enable_device();
> 	pci_set_master();
> 	request_irq();
> 	driver specific operations;
> }

MSI support may require something here too, I need to look into it.

Also, we should disable the irq bit in the PCI configuration header, I'm not
sure if pci_disable_device() does this now.

Finally, I'm not sure if pci_save_state() and pci_restore_state() should be
part of the default procedure.  I'd rather see drivers restoring the specific
configuration areas they need.

> 
> Currently many drivers don't call
> free_irq/request_irq/pci_disable_device, which makes unexpected
> interrupt occur and even break suspend/resume in some systems. The
> reason is we disable PIC/IOAPIC/irq router very later (they are treated
> as a sysdev), so there is a window between when a device is suspend and
> when its PIC/IOAPIC/irq router pin are disabled. The ideal way is
> PIC/IOAPIC/irq router's pins are disabled soon after no device is
> referencing them. I'm now working on disabling irq router if no
> reference on it, but first I'd like to know your opinions about the
> proposal (the reference .suspend/.resume implementation).
> 
> Thanks,
> Shaohua

So if we find that over 99% of PCI device drivers need to do exactly this
sequence, then why not just have the ->suspend and ->resume wrappers do it
automatically?

And let's say there's a good argument or it's better coding style to allow
drivers do it on thier own.  We still have two problems:
a.) many drivers will get it wrong
b.) if we want to change this sequence, every driver must be changed

But say we added the following functions:
pci_suspend_power(PCI-[D1-D3]);
pci_restore_power();

These could do exactly what we have above, and the majority of PCI drivers
could utilize them.  I think this would simplify things.

Just some thoughts.

Thanks,
Adam

--===============46683764084301882==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46683764084301882==--
