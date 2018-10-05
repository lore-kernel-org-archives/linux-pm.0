From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [workqueue/driver-core PATCH 5/5] PM core: Use new
 async_schedule_dev command
Date: Fri, 05 Oct 2018 11:34:30 -0700
Message-ID: <20181005183430.8790.75055.stgit@localhost.localdomain>
References: <20181005183239.8790.28631.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005183239.8790.28631.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, alexander.h.duyck@linux.intel.com
List-Id: linux-pm@vger.kernel.org

This change makes it so that we use the device specific version of the
async_schedule commands to defer various tasks related to power management.
By doing this we should see a slight improvement in performance as any
device that is sensitive to latency/locality in the setup will now be
initializing on the node closest to the device.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/power/main.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3f68e2919dc5..8495d9b1e9d0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -726,7 +726,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_noirq, dev);
+			async_schedule_dev(async_resume_noirq, dev);
 		}
 	}
 
@@ -883,7 +883,7 @@ void dpm_resume_early(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume_early, dev);
+			async_schedule_dev(async_resume_early, dev);
 		}
 	}
 
@@ -1047,7 +1047,7 @@ void dpm_resume(pm_message_t state)
 		reinit_completion(&dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
-			async_schedule(async_resume, dev);
+			async_schedule_dev(async_resume, dev);
 		}
 	}
 
@@ -1366,7 +1366,7 @@ static int device_suspend_noirq(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_noirq, dev);
+		async_schedule_dev(async_suspend_noirq, dev);
 		return 0;
 	}
 	return __device_suspend_noirq(dev, pm_transition, false);
@@ -1569,7 +1569,7 @@ static int device_suspend_late(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend_late, dev);
+		async_schedule_dev(async_suspend_late, dev);
 		return 0;
 	}
 
@@ -1830,7 +1830,7 @@ static int device_suspend(struct device *dev)
 
 	if (is_async(dev)) {
 		get_device(dev);
-		async_schedule(async_suspend, dev);
+		async_schedule_dev(async_suspend, dev);
 		return 0;
 	}
 
