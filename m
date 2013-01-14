From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH] PM / Runtime: Fix the twice judgement in
 rpm_suspend/resume()
Date: Tue, 15 Jan 2013 01:48:18 +0800
Message-ID: <1358185698.1223.13.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com
List-Id: linux-pm@vger.kernel.org


In function rpm_suspend/resume(), when going into the for(;;),
the pre-condition judgement has been done, and the variable runtime_status
are always protected by &power.lock, so it is not necessary to judge
them again before unlock_irq &power.lock in for(;;).

This patch clean them up.

Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
---
 drivers/base/power/runtime.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 3148b10..32d6497 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -377,14 +377,14 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 		for (;;) {
 			prepare_to_wait(&dev->power.wait_queue, &wait,
 					TASK_UNINTERRUPTIBLE);
-			if (dev->power.runtime_status != RPM_SUSPENDING)
-				break;
 
 			spin_unlock_irq(&dev->power.lock);
 
 			schedule();
 
 			spin_lock_irq(&dev->power.lock);
+			if (dev->power.runtime_status != RPM_SUSPENDING)
+				break;
 		}
 		finish_wait(&dev->power.wait_queue, &wait);
 		goto repeat;
@@ -557,15 +557,15 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		for (;;) {
 			prepare_to_wait(&dev->power.wait_queue, &wait,
 					TASK_UNINTERRUPTIBLE);
-			if (dev->power.runtime_status != RPM_RESUMING
-			    && dev->power.runtime_status != RPM_SUSPENDING)
-				break;
 
 			spin_unlock_irq(&dev->power.lock);
 
 			schedule();
 
 			spin_lock_irq(&dev->power.lock);
+			if (dev->power.runtime_status != RPM_RESUMING
+			    && dev->power.runtime_status != RPM_SUSPENDING)
+				break;
 		}
 		finish_wait(&dev->power.wait_queue, &wait);
 		goto repeat;
@@ -989,15 +989,15 @@ static void __pm_runtime_barrier(struct device *dev)
 		for (;;) {
 			prepare_to_wait(&dev->power.wait_queue, &wait,
 					TASK_UNINTERRUPTIBLE);
-			if (dev->power.runtime_status != RPM_SUSPENDING
-			    && dev->power.runtime_status != RPM_RESUMING
-			    && !dev->power.idle_notification)
-				break;
 			spin_unlock_irq(&dev->power.lock);
 
 			schedule();
 
 			spin_lock_irq(&dev->power.lock);
+			if (dev->power.runtime_status != RPM_SUSPENDING
+			    && dev->power.runtime_status != RPM_RESUMING
+			    && !dev->power.idle_notification)
+				break;
 		}
 		finish_wait(&dev->power.wait_queue, &wait);
 	}
-- 
1.7.0.4
