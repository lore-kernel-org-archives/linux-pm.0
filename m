From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Tue, 17 Apr 2012 11:11:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204171057470.1364-100000@iolanthe.rowland.org>
References: <20120416211943.GE11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120416211943.GE11484@belkar.wrar.name>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: jrnieder@gmail.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Apr 2012, Andrey Rahmatullin wrote:

> On Mon, Apr 16, 2012 at 04:07:10PM -0400, Alan Stern wrote:
> > This is my next attempt to make the driver-bound and driver-unbound
> > suspend paths as similar as possible.  Apply this to a vanilla kernel;  
> > it is based on 3.4-rc2 plus a few unrelated changes.  See what happens
> > when you suspend without unbinding ehci-hcd -- and be sure to include
> > "no_console_suspend" on the boot command line beforehand.
> It suspends and resumes but the screen is not enabled after resume and the
> network doesn't seem to work either.

Well, at least it's progress.  It's possible that those other problems 
were caused by the rather drastic things the patch does.

Just to make sure, did you test the patch with the script installed 
(that is, with ehci-hcd unbound)?  I assume that will work normally.

Moving on, the next thing is to remove changes from the patch, one at a 
time, until we find one that prevents the system from resuming.  So, 
testing at each step, please remove from the patch:

	1. This change in hcd-pci.c:
+	pci_dev->current_state = PCI_UNKNOWN;

	2. This change in ehci-pci.c:
+	ehci_silence_controller(ehci);

	3. This change in hcd-pci.c:
+	pci_disable_device(pci_dev);

	4. This change in hcd-pci.c:
+	iounmap(hcd->regs);

	5. This change in hcd-pci.c:
+	free_irq(hcd->irq, hcd);

	6. This change in hcd-pci.c:
-	pci_disable_device(pci_dev);
+	pci_disable_enabled_device(pci_dev);

	7. This change in ehci-pci.c:
-	ehci_prepare_ports_for_controller_suspend(ehci, do_wakeup);

Once all those things have been removed, the patch should be the same 
as one you tried earlier, which did crash the machine.

Alan Stern
