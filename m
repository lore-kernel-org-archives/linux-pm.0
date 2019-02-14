From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/4] PM / devfreq: Handle monitor suspend/resume in the devfreq core
Date: Wed, 13 Feb 2019 17:30:40 -0800
Message-ID: <20190214013042.254790-3-mka@chromium.org>
References: <20190214013042.254790-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214013042.254790-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

devfreq expects governors to call devfreq_monitor_suspend/resume()
in response to DEVFREQ_GOV_SUSPEND/RESUME events. Since the devfreq
core itself generates these events and invokes the governor's event
handler the suspend/resume of the load monitoring can be done in the
common code.

Call devfreq_monitor_suspend/resume() when the governor reports a
successful handling of DEVFREQ_GOV_SUSPEND/RESUME and remove these
calls from the simpleondemand and tegra governors. Make
devfreq_monitor_suspend/resume() static since these functions are now
only used by the devfreq core.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c                 | 18 ++++++++----------
 drivers/devfreq/governor.h                |  2 --
 drivers/devfreq/governor_simpleondemand.c |  8 --------
 drivers/devfreq/tegra-devfreq.c           |  2 --
 4 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1d3a43f8b3a10..7fab6c4cf719b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -447,15 +447,13 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
  * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq instance
  * @devfreq:	the devfreq instance.
  *
- * Helper function to suspend devfreq device load monitoing. Function
- * to be called from governor in response to DEVFREQ_GOV_SUSPEND
- * event or when polling interval is set to zero.
+ * Helper function to suspend devfreq device load monitoring.
  *
  * Note: Though this function is same as devfreq_monitor_stop(),
  * intentionally kept separate to provide hooks for collecting
  * transition statistics.
  */
-void devfreq_monitor_suspend(struct devfreq *devfreq)
+static void devfreq_monitor_suspend(struct devfreq *devfreq)
 {
 	mutex_lock(&devfreq->lock);
 	if (devfreq->monitor_state != DEVFREQ_MONITOR_RUNNING) {
@@ -468,17 +466,14 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
-EXPORT_SYMBOL(devfreq_monitor_suspend);
 
 /**
  * devfreq_monitor_resume() - Resume load monitoring of a devfreq instance
  * @devfreq:    the devfreq instance.
  *
- * Helper function to resume devfreq device load monitoing. Function
- * to be called from governor in response to DEVFREQ_GOV_RESUME
- * event or when polling interval is set to non-zero.
+ * Helper function to resume devfreq device load monitoring.
  */
-void devfreq_monitor_resume(struct devfreq *devfreq)
+static void devfreq_monitor_resume(struct devfreq *devfreq)
 {
 	unsigned long freq;
 
@@ -501,7 +496,6 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 out:
 	mutex_unlock(&devfreq->lock);
 }
-EXPORT_SYMBOL(devfreq_monitor_resume);
 
 /**
  * devfreq_interval_update() - Update device devfreq monitoring interval
@@ -903,6 +897,8 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 					DEVFREQ_GOV_SUSPEND, NULL);
 		if (ret)
 			return ret;
+
+		devfreq_monitor_suspend(devfreq);
 	}
 
 	if (devfreq->suspend_freq) {
@@ -944,6 +940,8 @@ int devfreq_resume_device(struct devfreq *devfreq)
 					DEVFREQ_GOV_RESUME, NULL);
 		if (ret)
 			return ret;
+
+		devfreq_monitor_resume(devfreq);
 	}
 
 	return 0;
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index f53339ca610fc..d136792c0cc91 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -59,8 +59,6 @@ struct devfreq_governor {
 
 extern void devfreq_monitor_start(struct devfreq *devfreq);
 extern void devfreq_monitor_stop(struct devfreq *devfreq);
-extern void devfreq_monitor_suspend(struct devfreq *devfreq);
-extern void devfreq_monitor_resume(struct devfreq *devfreq);
 extern void devfreq_interval_update(struct devfreq *devfreq,
 					unsigned int *delay);
 
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index c0417f0e081e0..52eb0c734b312 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -103,14 +103,6 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 		devfreq_interval_update(devfreq, (unsigned int *)data);
 		break;
 
-	case DEVFREQ_GOV_SUSPEND:
-		devfreq_monitor_suspend(devfreq);
-		break;
-
-	case DEVFREQ_GOV_RESUME:
-		devfreq_monitor_resume(devfreq);
-		break;
-
 	default:
 		break;
 	}
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c59d2eee5d309..79efa1e51bd06 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -591,11 +591,9 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 	case DEVFREQ_GOV_SUSPEND:
 		tegra_actmon_disable_interrupts(tegra);
-		devfreq_monitor_suspend(devfreq);
 		break;
 
 	case DEVFREQ_GOV_RESUME:
-		devfreq_monitor_resume(devfreq);
 		tegra_actmon_enable_interrupts(tegra);
 		break;
 	}
-- 
2.20.1.791.gb4d0f1c61a-goog
