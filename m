From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Tue, 17 Apr 2012 12:58:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204171251330.1364-100000@iolanthe.rowland.org>
References: <20120417162534.GL11484@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120417162534.GL11484@belkar.wrar.name>
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

> On Tue, Apr 17, 2012 at 11:11:04AM -0400, Alan Stern wrote:
> > Just to make sure, did you test the patch with the script installed 
> > (that is, with ehci-hcd unbound)?  I assume that will work normally.
> It works normally, yes.
> 
> > 
> > Moving on, the next thing is to remove changes from the patch, one at a 
> > time, until we find one that prevents the system from resuming.  So, 
> > testing at each step, please remove from the patch:
> > 
> > 	1. This change in hcd-pci.c:
> > +	pci_dev->current_state = PCI_UNKNOWN;
> It locks up if this line is removed.

Very bizarre indeed.  All right, leave that line in place and try 
removing the other changes, one at a time.  In fact, let's add one more 
thing to remove from the patch

> > 	2. This change in ehci-pci.c:
> > +	ehci_silence_controller(ehci);
> > 
> > 	3. This change in hcd-pci.c:
> > +	pci_disable_device(pci_dev);
> > 
> > 	4. This change in hcd-pci.c:
> > +	iounmap(hcd->regs);
> > 
> > 	5. This change in hcd-pci.c:
> > +	free_irq(hcd->irq, hcd);
> > 
> > 	6. This change in hcd-pci.c:
> > -	pci_disable_device(pci_dev);
> > +	pci_disable_enabled_device(pci_dev);
> > 
> > 	7. This change in ehci-pci.c:
> > -	ehci_prepare_ports_for_controller_suspend(ehci, do_wakeup);

	8. This change in ehci-pci.c:
+	ehci_reset(ehci);

If you manage to reach the end of this list, you'll essentially be
doing a normal suspend (except for the PCI_UNKNOWN part).

Alan Stern
