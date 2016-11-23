From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC 1/4] PM / devfreq: Add DevFreq subsystem suspend/resume
Date: Wed, 23 Nov 2016 14:51:24 +0100
Message-ID: <1479909087-22659-2-git-send-email-tjakobi@math.uni-bielefeld.de>
References: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: linux-pm@vger.kernel.org

This suspend/resume operations works analogous to the
cpufreq_{suspend,resume}() calls in the CPUFreq subsystem.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/devfreq/devfreq.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   | 10 +++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3ea76..2f1aa83 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -785,6 +785,81 @@ int devfreq_resume_device(struct devfreq *devfreq)
 EXPORT_SYMBOL(devfreq_resume_device);
 
 /**
+ * devfreq_suspend() - Suspend DevFreq governors
+ *
+ * Called during system wide Suspend/Hibernate cycles for suspending governors
+ * in the same fashion as cpufreq_suspend().
+ */
+void devfreq_suspend(void)
+{
+	struct devfreq *devfreq;
+	unsigned long freq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (!devfreq->suspend_freq)
+			continue;
+
+		ret = devfreq_suspend_device(devfreq);
+		if (ret < 0) {
+			dev_warn(&devfreq->dev, "%s: governor suspend failed\n", __func__);
+			continue;
+		}
+
+		devfreq->resume_freq = 0;
+		if (devfreq->profile->get_cur_freq) {
+			ret = devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq);
+			if (ret >= 0)
+				devfreq->resume_freq = freq;
+		}
+
+		freq = devfreq->suspend_freq;
+		ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
+
+		if (ret < 0)
+			dev_warn(&devfreq->dev, "%s: setting suspend frequency failed\n", __func__);
+	}
+
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
+ * devfreq_resume() - Resume DevFreq governors
+ *
+ * Called during system wide Suspend/Hibernate cycle for resuming governors that
+ * are suspended with devfreq_suspend().
+ */
+void devfreq_resume(void)
+{
+	struct devfreq *devfreq;
+	unsigned long freq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (!devfreq->suspend_freq)
+			continue;
+
+		freq = devfreq->resume_freq;
+		ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
+
+		if (ret < 0) {
+			dev_warn(&devfreq->dev, "%s: setting resume frequency failed\n", __func__);
+			continue;
+		}
+
+		ret = devfreq_resume_device(devfreq);
+		if (ret < 0)
+			dev_warn(&devfreq->dev, "%s: governor resume failed\n", __func__);
+	}
+
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
  * devfreq_add_governor() - Add devfreq governor
  * @governor:	the devfreq governor to be added
  */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2de4e2e..555d024 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -171,6 +171,9 @@ struct devfreq {
 	struct notifier_block nb;
 	struct delayed_work work;
 
+	unsigned long suspend_freq; /* freq during devfreq suspend */
+	unsigned long resume_freq; /* freq restored after suspend cycle */
+
 	unsigned long previous_freq;
 	struct devfreq_dev_status last_status;
 
@@ -211,6 +214,10 @@ extern void devm_devfreq_remove_device(struct device *dev,
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+/* Suspend/resume the entire Devfreq subsystem. */
+void devfreq_suspend(void);
+void devfreq_resume(void);
+
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
@@ -410,6 +417,9 @@ static inline int devfreq_update_stats(struct devfreq *df)
 {
 	return -EINVAL;
 }
+
+static inline void devfreq_suspend(void) {}
+static inline void devfreq_resume(void) {}
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
2.7.3
