From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / PM: Block races between runtime PM and
	system sleep
Date: Mon, 20 Jun 2011 21:42:45 +0200
Message-ID: <201106202142.45802.rjw__47382.1566127755$1308598963$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106201039580.2113-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106201039580.2113-100000@iolanthe.rowland.org>
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Monday, June 20, 2011, Alan Stern wrote:
> On Sun, 19 Jun 2011, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > After commit e8665002477f0278f84f898145b1f141ba26ee26
> > (PM: Allow pm_runtime_suspend() to succeed during system suspend) it
> > is possible that a device resumed by the pm_runtime_resume(dev) in
> > pci_pm_prepare() will be suspended immediately from a work item,
> > timer function or otherwise, defeating the very purpose of calling
> > pm_runtime_resume(dev) from there.  To prevent that from happening
> > it is necessary to increment the runtime PM usage counter of the
> > device by replacing pm_runtime_resume() with pm_runtime_get_sync().
> > Moreover, the incremented runtime PM usage counter has to be
> > decremented by the corresponding pci_pm_complete(), via
> > pm_runtime_put_noidle().
> 
> In both this and the previous patch, the final decrement should be done 
> by pm_runtime_put_sync() instead of pm_runtime_put_idle().  Otherwise 
> you face the possibility that the usage_count may go to 0 but the 
> device will be left active.

OK, that's how the old code worked, BTW, I overlooked that.

> Furthermore, since we're going to disable runtime PM as soon as the
> suspend callback returns anyway, why not increment usage_count before
> invoking the callback?  This will prevent runtime suspends from 
> occurring while the callback runs, so no changes will be needed in the 
> PCI or USB subsystems.

The PCI case is different from the USB one.  PCI needs to resume devices
before calling their drivers' .suspend() callbacks, so it does that in
.prepare().  If the core acquired a reference to every device  before executing
the subsystem .suspend(), then pm_runtime_resume() could be moved from
pci_pm_prepare() to pci_prepare_suspend(), but then additionally it would
have to be called from pci_pm_freeze() and pci_pm_poweroff().  It simply is
more efficient to call it once from pci_pm_prepare(), but then PCI needs to
take the reference by itself.

Also the core doesn't call the subsystem-level .runtime_idle() after the
subsystem-level .complete() has run, which is useful as you pointed out above. :-)

> It also will prevent Kevin from calling pm_runtime_suspend from within
> his suspend callbacks, but you have already determined that subsystems
> and drivers should never do that in any case.

Then reverting commit e8665002477f0278f84f898145b1f141ba26ee26 would be
even better. :-)

Thanks,
Rafael
