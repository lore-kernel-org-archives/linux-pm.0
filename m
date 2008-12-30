From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/10] PCI PM: Make new suspend-resume
	callbacks carry out core operations
Date: Tue, 30 Dec 2008 23:33:44 +0100
Message-ID: <200812302333.45560.rjw__29668.0601816208$1230677547$gmane$org@sisk.pl>
References: <200812190049.34343.rjw@sisk.pl> <200812281607.28007.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812281607.28007.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 28 December 2008, Rafael J. Wysocki wrote:
> On Friday 19 December 2008, Rafael J. Wysocki wrote:
> > Hi Len,
> > 
> > The patch below adds the callbacks that save/restore the standard PCI config
> > registers, change the power state of the device etc. to the new suspend-resume
> > callbacks (which are not yet used by device drivers), so that the drivers don't
> > have to worry about these operations.
> > 
> > The saving and restoring of the standard PCI config registers is done with
> > interrupts off, the other things are done with interrupts enabled.
> > 
> > The patch should apply to the current linux-next tree.
> 
> Below is a new version of the patch.
> 
> Now, the standard config spaces of devices are restored with interrupts
> disabled, but only if the bridges the devices are behind are in D0.  Otherwise,
> the operation is attempted again with interrupts enabled (presumably the
> bridge would be put into D0 before that happens).
> 
> Also, pci_disable_device() is not called during resume and
> pci_reenable_device() is used to enable the devices that were enabled during
> suspend.  This allows us to automatically call pci_set_master() for devices
> that were bus masters before suspend.  Additionally, the pci_reenable_device()
> may be overriden by the driver, by disabling the device during suspend.
> 
> Finally, bridges are handled a bit differently from the regular devices (they
> are not put into low power states during suspend and pci_enable_wake() is
> not called for them.
> 
> The patch should apply on top of linux-next with the patch fixing
> pci_update_current_state() I sent yesterday
> (http://marc.info/?l=linux-kernel&m=123039199607159&w=4).

In the meantime I realized that the pcibios_enable_device() called from
pci_reenable_device() in the resume code path should be balanced by a "suspend"
call of the same kind.

Also, I decided to split the patch into a series of smaller patches with their
own changelogs to make it easier to follow the changes.  Perhaps this way
it will be more clear what I'm after.

The patches should apply to linux-next with the patch from
http://marc.info/?l=linux-kernel&m=123039199607159&w=4 on top.

Comments welcome.

Happy New Year to everyone,
Rafael
