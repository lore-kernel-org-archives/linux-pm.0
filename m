From: Sundar <sunder.svit@gmail.com>
Subject: Tracing # of rtpm transitions
Date: Fri, 12 Oct 2012 19:21:35 +0530
Message-ID: <CAMHCuPXNNkwfU4vjrhswhp_8rtgSkV9zse5o-hbwBp1tSYhS3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, vivek.thakkar@intel.com
List-Id: linux-pm@vger.kernel.org

<I sent an another email from sundar.iyer@intel.com, but I think it
hasnt got through>

Hi,

We need to count/trace the runtime PM transitions for all components.

Is this small snippet of change valid? This can be extended to include
a transition to active state, get exposed in sysfs, controls to reset
the value like other existing sysfs entries.

Or is the wakeup_count the correct means to figure out the resume events?

diff --git a/drivers/base/power/runtime.c
b/drivers/base/power/runtime.c index 1f339d5..233f8f5 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -52,6 +52,8 @@ static void __update_runtime_status(struct device
*dev, enum rpm_status status)
        update_pm_runtime_accounting(dev);
        trace_runtime_pm_status(dev, status);
        dev->power.runtime_status = status;
+       if (status == RPM_SUSPENDED)
+               atomic_inc(&dev->power.transition_suspend_count);
 }

 /**
siyer5@pnp-buildsrv-4:~/ICS/hardware/intel/linux-2.6$ git diff
include/linux/pm.h diff --git a/include/linux/pm.h
b/include/linux/pm.h index 411e4f4..076a0e3 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -442,6 +442,7 @@ struct dev_pm_info {
        wait_queue_head_t       wait_queue;
        atomic_t                usage_count;
        atomic_t                child_count;
+       atomic_t                suspend_transition_count;
        unsigned int            disable_depth:3;
        unsigned int            ignore_children:1;
        unsigned int            idle_notification:1;

Cheers!


-- 
---------
The views expressed in this email are personal and do not necessarily
echo my employers.
