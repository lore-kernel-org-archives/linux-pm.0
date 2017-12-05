From: Vikas Bansal <vikas.bansal@samsung.com>
Subject: In kernel power management domain_pm created for async schedules
Date: Tue, 05 Dec 2017 09:24:18 +0000
Message-ID: <20171205092418epcms5p5c9404c09716e2efe84114cae3ce6b534@epcms5p5>
References: <CGME20171205092418epcms5p5c9404c09716e2efe84114cae3ce6b534@epcms5p5>
Reply-To: vikas.bansal@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62858 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdLELWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 06:22:50 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20171205112248epoutp01525ac3767d53085c5646b8ae8b19d1ad~9Yibg66hz1118211182epoutp01F
        for <linux-pm@vger.kernel.org>; Tue,  5 Dec 2017 11:22:48 +0000 (GMT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

>From 8e948f8c697d661f38c2c3a85787e4c48b165adc Mon Sep 17 00:00:00 2001
From: Vikas Bansal <vikas.bansal@samsung.com>
Date: Tue, 5 Dec 2017 01:14:41 -0800
Subject: [PATCH] Put all the async schdules in PM core in domain with name
 domain_pm. This avoids pm core to wait for async schedules
 in system other than PM core.


Signed-off-by: Vikas Bansal <vikas.bansal@samsung.com>
---
 drivers/base/power/main.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index db2f044..2d19dfb 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -39,6 +39,7 @@
 #include "power.h"
 
 typedef int (*pm_callback_t)(struct device *);
+ASYNC_DOMAIN(domain_pm);
 
 /*
  * The entries in the dpm_list list are in a depth first order, simply
@@ -615,7 +616,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_noirq, dev);
+			async_schedule_domain(async_resume_noirq, dev, &domain_pm);
 		}
 	}
 
@@ -641,7 +642,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, "noirq");
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
@@ -755,7 +756,7 @@ void dpm_resume_early(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_early, dev);
+			async_schedule_domain(async_resume_early, dev, &domain_pm);
 		}
 	}
 
@@ -780,7 +781,7 @@ void dpm_resume_early(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, "early");
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
 }
@@ -919,7 +920,7 @@ void dpm_resume(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume, dev);
+			async_schedule_domain(async_resume, dev, &domain_pm);
 		}
 	}
 
@@ -946,7 +947,7 @@ void dpm_resume(pm_message_t state)
 		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
@@ -1156,7 +1157,7 @@ static int device_suspend_noirq(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_noirq, dev);
+		async_schedule_domain(async_suspend_noirq, dev, &domain_pm);
 		return 0;
 	}
 	return __device_suspend_noirq(dev, pm_transition, false);
@@ -1202,7 +1203,7 @@ int dpm_noirq_suspend_devices(pm_message_t state)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	if (!error)
 		error = async_error;
 
@@ -1316,7 +1317,7 @@ static int device_suspend_late(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_late, dev);
+		async_schedule_domain(async_suspend_late, dev, &domain_pm);
 		return 0;
 	}
 
@@ -1361,7 +1362,7 @@ int dpm_suspend_late(pm_message_t state)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
-	async_synchronize_full();
+	async_synchronize_full_domain(&domain_pm);
 	if (!error)
 		error = async_error;
 	if (error) {
@@ -1576,7 +1577,7 @@ static int device_suspend(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend, dev);
+		async_schedule_domain(async_suspend, dev, &domain_pm);
 		return 0;
 	}
 
@@ -1622,7 +1623,7 @@ int dpm_suspend(pm_message_t state)
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
