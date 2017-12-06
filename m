From: Vikas Bansal <vikas.bansal@samsung.com>
Subject: [PATCH V1] PM: In kernel power management domain_pm created for
 async schedules
Date: Wed, 06 Dec 2017 12:07:14 +0000
Message-ID: <20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
References: <CGME20171206120714epcms5p70081d5bc518c3bb5f9cca4f56b203abf@epcms5p7>
Reply-To: vikas.bansal@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Description:

If there is a driver in system which starts creating async schedules
just after resume (Same as our case, in which we faced issue).
Then async_synchronize_full API in PM cores starts waiting for completion
of async schedules created by that driver (Even though those are in a domain).
Because of this kernel resume time is increased (We faces the same issue)
and whole system is delayed.
This problem can be solved by creating a domain for
async schedules in PM core (As we solved in our case).
Below patch is for solving this problem.

Changelog:
1. Created Async domain domain_pm.
2. Converted async_schedule to async_schedule_domain.
3. Converted async_synchronize_full to async_synchronize_full_domain



Signed-off-by: Vikas Bansal <vikas.bansal@samsung.com>
Signed-off-by: Anuj Gupta <anuj01.gupta@samsung.com>
---
 drivers/base/power/main.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index db2f044..042b034 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -39,6 +39,7 @@
 #include "power.h"
 
 typedef int (*pm_callback_t)(struct device *);
+static ASYNC_DOMAIN(domain_pm);
 
 /*
  * The entries in the dpm_list list are in a depth first order, simply
@@ -615,7 +616,8 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_noirq, dev);
+			async_schedule_domain(async_resume_noirq, dev, 
+			&domain_pm);
 		}
 	}
 
@@ -641,7 +643,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, "noirq");
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
@@ -755,7 +757,8 @@ void dpm_resume_early(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_early, dev);
+			async_schedule_domain(async_resume_early, dev, 
+			&domain_pm);
 		}
 	}
 
@@ -780,7 +783,7 @@ void dpm_resume_early(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, "early");
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
 }
@@ -919,7 +922,7 @@ void dpm_resume(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume, dev);
+			async_schedule_domain(async_resume, dev, &domain_pm);
 		}
 	}
 
@@ -946,7 +949,7 @@ void dpm_resume(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
@@ -1156,7 +1159,7 @@ static int device_suspend_noirq(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_noirq, dev);
+		async_schedule_domain(async_suspend_noirq, dev, &domain_pm);
 		return 0;
 	}
 	return __device_suspend_noirq(dev, pm_transition, false);
@@ -1202,7 +1205,7 @@ int dpm_noirq_suspend_devices(pm_message_t state)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	if (!error)
 		error = async_error;
 
@@ -1316,7 +1319,7 @@ static int device_suspend_late(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_late, dev);
+		async_schedule_domain(async_suspend_late, dev, &domain_pm);
 		return 0;
 	}
 
@@ -1361,7 +1364,7 @@ int dpm_suspend_late(pm_message_t state)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	if (!error)
 		error = async_error;
 	if (error) {
@@ -1576,7 +1579,7 @@ static int device_suspend(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend, dev);
+		async_schedule_domain(async_suspend, dev, &domain_pm);
 		return 0;
 	}
 
@@ -1622,7 +1625,7 @@ int dpm_suspend(pm_message_t state)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	if (!error)
 		error = async_error;
 	if (error) {
-- 
1.7.9.5
