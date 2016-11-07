From: Lin Huang <hl@rock-chips.com>
Subject: [RESEND PATCH v3 1/2] PM/devfreq: add suspend frequency support
Date: Mon,  7 Nov 2016 14:33:39 +0800
Message-ID: <1478500420-22045-2-git-send-email-hl@rock-chips.com>
References: <1478500420-22045-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478500420-22045-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: cw00.choi@samsung.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Add suspend frequency support and if needed set it to
the frequency obtained from the suspend opp (can be defined
using opp-v2 bindings and is optional).

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- use update_devfreq() instead devfreq_update_status()
Changes in v3:
- fix build error

 drivers/devfreq/devfreq.c                 | 18 ++++++++++++++++--
 drivers/devfreq/governor_simpleondemand.c |  9 +++++++++
 include/linux/devfreq.h                   |  8 ++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index da72d97..4c76e79 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -359,8 +359,10 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 		mutex_unlock(&devfreq->lock);
 		return;
 	}
-
-	devfreq_update_status(devfreq, devfreq->previous_freq);
+	if (devfreq->suspend_freq)
+		update_devfreq(devfreq);
+	else
+		devfreq_update_status(devfreq, devfreq->previous_freq);
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
@@ -1254,6 +1256,18 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 }
 EXPORT_SYMBOL(devfreq_recommended_opp);
 
+void devfreq_opp_get_suspend_opp(struct device *dev, struct devfreq *devfreq)
+{
+	struct dev_pm_opp *suspend_opp;
+
+	rcu_read_lock();
+	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
+	if (suspend_opp)
+		devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(devfreq_opp_get_suspend_opp);
+
 /**
  * devfreq_register_opp_notifier() - Helper function to get devfreq notified
  *				   for any changes in the OPP availability
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ae72ba5..a3efee0 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -29,6 +29,15 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	struct devfreq_simple_ondemand_data *data = df->data;
 	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
 
+	/*
+	 * if devfreq in suspend status and have suspend_freq,
+	 * the frequency need to set to suspend_freq
+	 */
+	if (df->stop_polling && df->suspend_freq) {
+		*freq =	df->suspend_freq;
+		return 0;
+	}
+
 	err = devfreq_update_stats(df);
 	if (err)
 		return err;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 98c6993..1bdd5d3 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -172,6 +172,7 @@ struct devfreq {
 	struct delayed_work work;
 
 	unsigned long previous_freq;
+	unsigned long suspend_freq;
 	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
@@ -214,6 +215,8 @@ extern int devfreq_resume_device(struct devfreq *devfreq);
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
+extern void devfreq_opp_get_suspend_opp(struct device *dev,
+					struct devfreq *devfreq);
 extern int devfreq_register_opp_notifier(struct device *dev,
 					 struct devfreq *devfreq);
 extern int devfreq_unregister_opp_notifier(struct device *dev,
@@ -315,6 +318,11 @@ static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 	return ERR_PTR(-EINVAL);
 }
 
+static inline void devfreq_opp_get_suspend_opp(struct device *dev,
+					       struct devfreq *devfreq)
+{
+}
+
 static inline int devfreq_register_opp_notifier(struct device *dev,
 					 struct devfreq *devfreq)
 {
-- 
1.9.1
