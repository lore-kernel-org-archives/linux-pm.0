From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] USB: Fix suspend-resume of PCI USB
	controllers
Date: Tue, 20 Jan 2009 15:33:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901201526510.5575__3749.84585582769$1232483773$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0901201031490.2612-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0901201031490.2612-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB list <linux-usb@vger.kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> > Alan, does this look ok for you?
> 
> There are a few things I don't like about it:
> 
> 	In usb_hcd_pci_suspend, the failure path for 
> 	pci_set_power_state doesn't undo all the changes
> 	that have already been made.  In fact, the easiest
> 	way to do the rest of the recovery probably is to
> 	call usb_hcd_pci_resume directly.
> 
> 	In the !has_pci_pm path we don't call pci_set_power_state.
> 	This means controllers with legacy power management won't
> 	get suspended.  Maybe pci_set_power_state should be
> 	called always, and has_pci_pm be used only for
> 	interpreting the return code and printing debug messages.
> 
> 	In usb_hcd_pci_resume, the pci_wake_from_d3 call
> 	should be moved up right next to the pci_enable_wake
> 	call.  It makes no sense for them to be separated by
> 	pci_enable_device and pci_set_master.  After all,
> 	even if you can't re-enable the device you probably
> 	don't want it to continue being a wakeup source.
> 
> 	It's a little annoying that several debug messages
> 	in usb_hcd_pci_resume have been removed.  Can't we
> 	display the power state upon entry, before trying to
> 	change it?
> 
> 	It stands out that the resume method contains no call
> 	to match pci_set_power_state() in the suspend method.
> 	There should at least be a comment about it.
> 
> Some of these problems predate Rafael's patch.  Given that it has 
> already helped a number of people, we might want to merge the patch 
> and then make additional changes to address these issues.

Rafael's patch is required for upstream to resume on my T61.

Tested-by: Len Brown <len.brown@intel.com>

Perhaps Greg can apply Rafael's patch now to fix upstream ASAP,
while Alan prepares a 2nd patch to address his observations above?

thanks,
Len Brown, Intel Open Source Technology Center
