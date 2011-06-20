From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI / PM: Block races between runtime PM and
 system sleep
Date: Mon, 20 Jun 2011 10:46:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106201039580.2113-100000__25159.4484238469$1308581314$gmane$org@iolanthe.rowland.org>
References: <201106192149.19401.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106192149.19401.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 19 Jun 2011, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> After commit e8665002477f0278f84f898145b1f141ba26ee26
> (PM: Allow pm_runtime_suspend() to succeed during system suspend) it
> is possible that a device resumed by the pm_runtime_resume(dev) in
> pci_pm_prepare() will be suspended immediately from a work item,
> timer function or otherwise, defeating the very purpose of calling
> pm_runtime_resume(dev) from there.  To prevent that from happening
> it is necessary to increment the runtime PM usage counter of the
> device by replacing pm_runtime_resume() with pm_runtime_get_sync().
> Moreover, the incremented runtime PM usage counter has to be
> decremented by the corresponding pci_pm_complete(), via
> pm_runtime_put_noidle().

In both this and the previous patch, the final decrement should be done 
by pm_runtime_put_sync() instead of pm_runtime_put_idle().  Otherwise 
you face the possibility that the usage_count may go to 0 but the 
device will be left active.

Furthermore, since we're going to disable runtime PM as soon as the
suspend callback returns anyway, why not increment usage_count before
invoking the callback?  This will prevent runtime suspends from 
occurring while the callback runs, so no changes will be needed in the 
PCI or USB subsystems.

It also will prevent Kevin from calling pm_runtime_suspend from within
his suspend callbacks, but you have already determined that subsystems
and drivers should never do that in any case.

Alan Stern
