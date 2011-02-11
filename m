From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Allow pm_runtime_suspend() to succeed during
	system suspend
Date: Fri, 11 Feb 2011 21:00:23 +0100
Message-ID: <201102112100.23996.rjw__32200.4683934667$1297454844$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1101311119190.1931-100000@iolanthe.rowland.org>
	<201101311919.49225.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101311919.49225.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 31, 2011, Rafael J. Wysocki wrote:
> On Monday, January 31, 2011, Alan Stern wrote:
> > On Mon, 31 Jan 2011, Kevin Hilman wrote:
> > 
> > > I understand how this works, but frankly I'm still a bit fuzzy on why.
> > > 
> > > I guess I'm still missing a good understanding of what "interfering with a
> > > system power transition" means, and why a runtime suspend qualifies as
> > > interfering but not a runtime resume.
> > 
> > These are good questions.  Rafael implemented this design originally; 
> > my contribution was only to warn him of the potential for problems.  
> > Therefore he should explain the rationale for the design.
> 
> The reason why runtime resume is allowed during system power transitions is
> because in some cases during system suspend we simply have to resume devices
> that were previously runtime-suspended (for example, the PCI bus type does
> that).
> 
> The reason why runtime suspend is not allowed during system power transitions
> if the following race:
> 
> - A device has been suspended via a system suspend callback.
> - The runtime PM framework executes a (scheduled) suspend on that device,
>   not knowing that it's already been suspended, which potentially results in
>   accessing the device's registers in a low-power state.
> 
> Now, it can be avoided if every driver does the right thing and checks whether
> the device is already suspended in its runtime suspend callback, but that would
> kind of defeat the purpose of the runtime PM framework, at least partially.

In fact, I've just realized that the above race cannot really occur, because
pm_wq is freezable, so I'm proposing the following change.

Of course, it still doesn't prevent user space from disabling the runtime PM
framework's helpers via /sys/devices/.../power/control.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Allow pm_runtime_suspend() to succeed during system suspend

The dpm_prepare() function increments the runtime PM reference
counters of all devices to prevent pm_runtime_suspend() from
executing subsystem-level callbacks.  However, this was supposed to
guard against a specific race condition that cannot happen, because
the power management workqueue is freezable, so pm_runtime_suspend()
can only be called synchronously during system suspend and we can
rely on subsystems and device drivers to avoid doing that
unnecessarily.

Make dpm_prepare() drop the runtime PM reference to each device
after making sure that runtime resume is not pending for it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -669,7 +669,6 @@ static void dpm_complete(pm_message_t st
 		mutex_unlock(&dpm_list_mtx);
 
 		device_complete(dev, state);
-		pm_runtime_put_sync(dev);
 
 		mutex_lock(&dpm_list_mtx);
 		put_device(dev);
@@ -1005,12 +1004,9 @@ static int dpm_prepare(pm_message_t stat
 		if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
 			pm_wakeup_event(dev, 0);
 
-		if (pm_wakeup_pending()) {
-			pm_runtime_put_sync(dev);
-			error = -EBUSY;
-		} else {
-			error = device_prepare(dev, state);
-		}
+		pm_runtime_put_sync(dev);
+		error = pm_wakeup_pending() ?
+				-EBUSY : device_prepare(dev, state);
 
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
