From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: acquire device locks prior to suspending
Date: Mon, 17 Dec 2007 17:50:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0712171747080.19559-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Dec 2007 Andrew Morton wrote:

> On Thu, 13 Dec 2007 17:58:37 +0100 "Rafael J. Wysocki" <rjw at sisk.pl <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>> wrote:
> 
> > On Thursday, 13 of December 2007, Andrew Morton wrote:
> > > On Fri, 21 Sep 2007 15:37:40 -0400 (EDT) Alan Stern <stern at rowland.harvard.edu <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>> wrote:
> > > 
> > > > This patch (as994) reorganizes the way suspend and resume
> > > > notifications are sent to drivers.  The major changes are that now the
> > > > PM core acquires every device semaphore before calling the methods,
> > > > and calls to device_add() during suspends will fail.
> > > 
> > > Causes my t61p to deadlock during suspend-to-RAM.  Really late - the little
> > > moon symbol has started to flash but the LCD is still powered and the
> > > cursor still blinks.  Only a poweroff restores control.
> > 
> > Most probably, one of the drivers or a CPU hotplug notifier unregisters a
> > device during suspend (wrong).
> > 
> > Please boot with no_console_suspend and check if the box survives (with this
> > patch applied):
> > 
> > # echo 8 > /proc/sys/kernel/printk
> > # echo processors > /sys/power/pm_test
> > # echo mem > /sys/power/state
> > 
> > If it doesn't, you can try 
> > 
> > # echo platform > /sys/power/pm_test
> > # echo mem > /sys/power/state
> > 
> > and
> > 
> > # echo devices > /sys/power/pm_test
> > # echo mem > /sys/power/state
> 
> hm, that was all fairly helpful.  <looks at the document> <erk, long>
> 
> This:
...
> gives me this:
> 
> http://userweb.kernel.org/~akpm/pc131699.jpg
> 
> which identifies your culprit: msr.
> 
> I'd suggest that the above debug patch be turned into some
> boot-option-enabled thing and that it be rolled out with this locking
> change for a while at least.

Going through the debugging changes you made led to some
process-of-elimination reasoning:

	There's no need to trace the locking of dpm_list_mutex,
	since the things done while that mutex are held are quite
	safe and should never deadlock (other than trying to
	acquire other locks!).

	There's no need to trace the locking of pm_sleep_rwsem.
	It gets locked for writing just once, at the very start
	of the device-suspend sequence.  If that failed, it would
	be easy to diagnose.  The only other place it is locked
	uses down_read_trylock, which can't block.

	This leaves only dev->sem, which is acquired in
	lock_all_devices and device_pm_remove.  But the call in
	device_pm_remove isn't a good place to monitor.  It worked
	in this case, but if the device has a driver then the deadlock
	will occur earlier, in device_release_driver.

	On further thought, the call in lock_all_devices should be
	safe enough.  It doesn't do anything until all the locks
	have been acquired, and so far it hasn't caused any problems.

Put together, this suggests a better strategy.  Instead of monitoring
the various locking calls, instead we should warn about dangerous
actions on the part of drivers.  In both cases where problems
occurred, it was because a driver tried to unregister a device during
suspend.  It's easy to detect such actions and print a big fat
warning.  We might as well warn about attempts to register too.

Andrew, can you confirm that the patch below, without any of your
changes, would indeed have caught the problem with the msr driver?
For proper testing you have to:

	boot with "no_console_suspend";

	"echo 8 >/proc/sys/kernel/printk" before suspending.
	Perhaps also "echo processors >/sys/power/pm_test".

If it does, I'll submit this properly with a changelog and
Signed-Off-By line.  It's a lot simpler than your checks, doesn't need
a command-line parameter, and can safely be used all the time.

Alan Stern


Index: usb-2.6/drivers/base/core.c
===================================================================
--- usb-2.6.orig/drivers/base/core.c
+++ usb-2.6/drivers/base/core.c
@@ -789,8 +789,11 @@ int device_add(struct device *dev)
 	int error;
 
 	error = pm_sleep_lock();
-	if (error)
+	if (error) {
+		dev_warn(dev, "Illegal %s during suspend\n", __FUNCTION__);
+		dump_stack();
 		return error;
+	}
 
 	dev = get_device(dev);
 	if (!dev || !strlen(dev->bus_id)) {
@@ -953,6 +956,13 @@ void device_del(struct device * dev)
 	struct device * parent = dev->parent;
 	struct class_interface *class_intf;
 
+	if (pm_sleep_lock()) {
+		dev_warn(dev, "Illegal %s during suspend\n", __FUNCTION__);
+		dump_stack();
+	} else {
+		pm_sleep_unlock();
+	}
+
 	if (parent)
 		klist_del(&dev->knode_parent);
 	if (MAJOR(dev->devt))
