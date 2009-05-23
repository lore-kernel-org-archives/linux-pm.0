From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: INFO: possible circular locking dependency at
	cleanup_workqueue_thread
Date: Sun, 24 May 2009 01:20:29 +0200
Message-ID: <200905240120.30336.rjw__49531.7545407035$1243120898$gmane$org@sisk.pl>
References: <c4e36d110905120059i4c155508oa00672da0b33a07a@mail.gmail.com>
	<200905230023.16377.rjw@sisk.pl>
	<1243066902.4606.42.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1243066902.4606.42.camel@johannes.local>
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
To: Johannes Berg <johannes@sipsolutions.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@elte.hu>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 23 May 2009, Johannes Berg wrote:
> On Sat, 2009-05-23 at 00:23 +0200, Rafael J. Wysocki wrote:
> 
> > > I just arrived at the same conclusion, heh. I can't say I understand
> > > these changes though, the part about calling the platform differently
> > > may make sense, but calling why disable non-boot CPUs at a different
> > > place?
> > 
> > Because the ordering of platform callbacks and cpu[_up()|_down()] is also
> > important, at least on resume.
> > 
> > In principle we can call device_pm_unlock() right before calling
> > disable_nonboot_cpus() and take the lock again right after calling
> > enable_nonboot_cpus(), if that helps.
> 
> Probably, unless the cpu_add_remove_lock wasn't a red herring after all.
> I'd test, but I don't have much time today, will be travelling tomorrow
> and be at UDS all week next week so I don't know when I'll get to it --
> could you provide a patch and also attach it to
> http://bugzilla.kernel.org/show_bug.cgi?id=13245 please? Miles (the
> reporter of that bug) has been very helpful in testing before.

OK

The patch is appended for reference (Alan, please have a look; I can't recall
why exactly we have called device_pm_lock() from the core suspend/hibernation
code instead of acquiring the lock locally in drivers/base/power/main.c) and
I'll attach it to the bug entry too.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Do not hold dpm_list_mtx while disabling/enabling nonboot CPUs

We shouldn't hold dpm_list_mtx while executing
[disable|enable]_nonboot_cpus(), because theoretically this may lead
to a deadlock as shown by the following example (provided by Johannes
Berg):

CPU 3       CPU 2                     CPU 1
                                      suspend/hibernate
            something:
            rtnl_lock()               device_pm_lock()
                                       -> mutex_lock(&dpm_list_mtx)

            mutex_lock(&dpm_list_mtx)

linkwatch_work
 -> rtnl_lock()
                                      disable_nonboot_cpus()
                                       -> flush CPU 3 workqueue

Fortunately, device drivers are supposed to stop any activities that
might lead to the registration of new device objects and/or to the
removal of the existing ones way before disable_nonboot_cpus() is
called, so it shouldn't be necessary to hold dpm_list_mtx over the
entire late part of device suspend and early part of device resume.

Thus, during the late suspend and the early resume of devices acquire
dpm_list_mtx only when dpm_list is going to be traversed and release
it right after that.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    4 ++++
 kernel/kexec.c            |    2 --
 kernel/power/disk.c       |   21 +++------------------
 kernel/power/main.c       |    7 +------
 4 files changed, 8 insertions(+), 26 deletions(-)

Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -215,8 +215,6 @@ static int create_image(int platform_mod
 	if (error)
 		return error;
 
-	device_pm_lock();
-
 	/* At this point, device_suspend() has been called, but *not*
 	 * device_power_down(). We *must* call device_power_down() now.
 	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
@@ -227,7 +225,7 @@ static int create_image(int platform_mod
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting hibernation\n");
-		goto Unlock;
+		return error;
 	}
 
 	error = platform_pre_snapshot(platform_mode);
@@ -280,9 +278,6 @@ static int create_image(int platform_mod
 	device_power_up(in_suspend ?
 		(error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RESTORE);
 
- Unlock:
-	device_pm_unlock();
-
 	return error;
 }
 
@@ -348,13 +343,11 @@ static int resume_target_kernel(bool pla
 {
 	int error;
 
-	device_pm_lock();
-
 	error = device_power_down(PMSG_QUIESCE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
 			"aborting resume\n");
-		goto Unlock;
+		return error;
 	}
 
 	error = platform_pre_restore(platform_mode);
@@ -407,9 +400,6 @@ static int resume_target_kernel(bool pla
 
 	device_power_up(PMSG_RECOVER);
 
- Unlock:
-	device_pm_unlock();
-
 	return error;
 }
 
@@ -468,11 +458,9 @@ int hibernation_platform_enter(void)
 		goto Resume_devices;
 	}
 
-	device_pm_lock();
-
 	error = device_power_down(PMSG_HIBERNATE);
 	if (error)
-		goto Unlock;
+		goto Resume_devices;
 
 	error = hibernation_ops->prepare();
 	if (error)
@@ -497,9 +485,6 @@ int hibernation_platform_enter(void)
 
 	device_power_up(PMSG_RESTORE);
 
- Unlock:
-	device_pm_unlock();
-
  Resume_devices:
 	entering_platform_hibernation = false;
 	device_resume(PMSG_RESTORE);
Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -271,12 +271,10 @@ static int suspend_enter(suspend_state_t
 {
 	int error;
 
-	device_pm_lock();
-
 	if (suspend_ops->prepare) {
 		error = suspend_ops->prepare();
 		if (error)
-			goto Done;
+			return error;
 	}
 
 	error = device_power_down(PMSG_SUSPEND);
@@ -325,9 +323,6 @@ static int suspend_enter(suspend_state_t
 	if (suspend_ops->finish)
 		suspend_ops->finish();
 
- Done:
-	device_pm_unlock();
-
 	return error;
 }
 
Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -357,6 +357,7 @@ static void dpm_power_up(pm_message_t st
 {
 	struct device *dev;
 
+	mutex_lock(&dpm_list_mtx);
 	list_for_each_entry(dev, &dpm_list, power.entry)
 		if (dev->power.status > DPM_OFF) {
 			int error;
@@ -366,6 +367,7 @@ static void dpm_power_up(pm_message_t st
 			if (error)
 				pm_dev_err(dev, state, " early", error);
 		}
+	mutex_unlock(&dpm_list_mtx);
 }
 
 /**
@@ -614,6 +616,7 @@ int device_power_down(pm_message_t state
 	int error = 0;
 
 	suspend_device_irqs();
+	mutex_lock(&dpm_list_mtx);
 	list_for_each_entry_reverse(dev, &dpm_list, power.entry) {
 		error = suspend_device_noirq(dev, state);
 		if (error) {
@@ -622,6 +625,7 @@ int device_power_down(pm_message_t state
 		}
 		dev->power.status = DPM_OFF_IRQ;
 	}
+	mutex_unlock(&dpm_list_mtx);
 	if (error)
 		device_power_up(resume_event(state));
 	return error;
Index: linux-2.6/kernel/kexec.c
===================================================================
--- linux-2.6.orig/kernel/kexec.c
+++ linux-2.6/kernel/kexec.c
@@ -1451,7 +1451,6 @@ int kernel_kexec(void)
 		error = device_suspend(PMSG_FREEZE);
 		if (error)
 			goto Resume_console;
-		device_pm_lock();
 		/* At this point, device_suspend() has been called,
 		 * but *not* device_power_down(). We *must*
 		 * device_power_down() now.  Otherwise, drivers for
@@ -1489,7 +1488,6 @@ int kernel_kexec(void)
 		enable_nonboot_cpus();
 		device_power_up(PMSG_RESTORE);
  Resume_devices:
-		device_pm_unlock();
 		device_resume(PMSG_RESTORE);
  Resume_console:
 		resume_console();
