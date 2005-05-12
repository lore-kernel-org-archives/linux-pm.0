From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Thu, 12 May 2005 15:03:33 +0800
Message-ID: <1115881413.9416.30.camel@linux-hp.sh.intel.com>
References: <20050512062125.GA30728@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86446979446597938=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050512062125.GA30728@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============86446979446597938==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-05-12 at 14:21 +0800, Adam Belay wrote:
> On Thu, May 12, 2005 at 09:24:47AM +0800, Shaohua Li wrote: 
> > Hi, 
> > There are still many PCI drivers don't implement
> their .suspend/.resume 
> > methods correctly. I felt it would be quite helpful there is a
> reference 
> > implementation. Here is my thought: 
> >  
> > .suspend() 
> > { 
> >       driver specific operations; 
> >       pci_save_state(); 
> >       pci_enable_wake(); 
> >       /* as a result, PIC/IOAPIC pin is disabled */ 
> >       free_irq();
> 
> We can do this earlier, under driver specific operations, right?
Right, I just list some operations. Some operations are optional and
some order can be slightly adjusted.

> 
> >       /* as a result, bus master/irq router are disabled */ 
> >       pci_disable_device(); 
> >       pci_set_power_state(); 
> > } 
> >  
> > .resume() 
> > { 
> >       pci_set_power_state(PCI_D0); 
> >       pci_restore_state(); 
> >       /* device's irq possibly is changed, driver should take care
> */
> 
> So what do you have in mind here?  Could/should the device's resource 
> configuration also possibly change.
Resources balance need it. For suspend/resume, it's unnecessary
(pci_restore_state will restore the resource configuration). But we must
clean irq to avoid unexpected interrupt issue. Currently, I'd like we
temporarily ignore resources balance.

> >       pci_enable_device(); 
> >       pci_set_master(); 
> >       request_irq(); 
> >       driver specific operations; 
> > }
> 
> MSI support may require something here too, I need to look into it.
> 
> Also, we should disable the irq bit in the PCI configuration header,
> I'm not 
> sure if pci_disable_device() does this now.
Disabling the INTX for MSI? pci_enable_msi isn't called at
pci_enable_device, so pci_disable_msi should be the same. Yes,
pci_enable_msi/pci_disable_msi should be added in the suspend/resume
methods.

> 
> Finally, I'm not sure if pci_save_state() and pci_restore_state()
> should be 
> part of the default procedure.  I'd rather see drivers restoring the
> specific 
> configuration areas they need.
I think pci_save_state and pci_store_state are mandatory and drivers can
do extra config save/restore.

> >  
> > Currently many drivers don't call 
> > free_irq/request_irq/pci_disable_device, which makes unexpected 
> > interrupt occur and even break suspend/resume in some systems. The 
> > reason is we disable PIC/IOAPIC/irq router very later (they are
> treated 
> > as a sysdev), so there is a window between when a device is suspend
> and 
> > when its PIC/IOAPIC/irq router pin are disabled. The ideal way is 
> > PIC/IOAPIC/irq router's pins are disabled soon after no device is 
> > referencing them. I'm now working on disabling irq router if no 
> > reference on it, but first I'd like to know your opinions about the 
> > proposal (the reference .suspend/.resume implementation). 
> So if we find that over 99% of PCI device drivers need to do exactly
> this 
> sequence, then why not just have the ->suspend and ->resume wrappers
> do it 
> automatically?
> 
> And let's say there's a good argument or it's better coding style to
> allow 
> drivers do it on thier own.  We still have two problems: 
> a.) many drivers will get it wrong 
> b.) if we want to change this sequence, every driver must be changed
> 
> But say we added the following functions: 
> pci_suspend_power(PCI-[D1-D3]); 
> pci_restore_power();
> 
> These could do exactly what we have above, and the majority of PCI
> drivers 
> could utilize them.  I think this would simplify things.
It's ok. The question is how many drivers can use it.

Thanks,
Shaohua


--===============86446979446597938==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86446979446597938==--
