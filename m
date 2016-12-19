From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC v2 3/7] PM / devfreq: Add DevFreq subsystem suspend/resume
Date: Mon, 19 Dec 2016 03:16:23 +0100
Message-ID: <1482113787-28422-4-git-send-email-tjakobi@math.uni-bielefeld.de>
References: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: linux-pm@vger.kernel.org

This suspend/resume operations works analogous to the
cpufreq_{suspend,resume}() calls in the CPUFreq subsystem.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/devfreq/devfreq.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  10 ++++
 2 files changed, 142 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 3904ebc..7e71c19 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -32,6 +32,8 @@ enum devfreq_flag_bits {
 	DEVFREQ_BIT_STOP_POLLING,
 	/* Bit set if DevFreq device was suspended in devfreq_suspend_device(). */
 	DEVFREQ_BIT_SUSPENDED,
+	/* Bit set if DevFreq device should be resumed in devfreq_resume(). */
+	DEVFREQ_BIT_RESUME,
 };
 
 static struct class *devfreq_class;
@@ -49,6 +51,8 @@ static LIST_HEAD(devfreq_governor_list);
 static LIST_HEAD(devfreq_list);
 static DEFINE_MUTEX(devfreq_list_lock);
 
+static bool devfreq_suspended = false;
+
 /**
  * find_device_devfreq() - find devfreq struct using device pointer
  * @dev:	device pointer used to lookup device devfreq.
@@ -832,6 +836,9 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 	if (!devfreq->governor)
 		return 0;
 
+	if (devfreq_suspended)
+		return -EBUSY;
+
 	ret = devfreq->governor->event_handler(devfreq,
 				DEVFREQ_GOV_SUSPEND, NULL);
 
@@ -860,6 +867,9 @@ int devfreq_resume_device(struct devfreq *devfreq)
 	if (!devfreq->governor)
 		return 0;
 
+	if (devfreq_suspended)
+		return -EBUSY;
+
 	ret = devfreq->governor->event_handler(devfreq,
 				DEVFREQ_GOV_RESUME, NULL);
 
@@ -871,6 +881,128 @@ int devfreq_resume_device(struct devfreq *devfreq)
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
+	struct devfreq_freqs freqs;
+	unsigned long freq;
+	int ret;
+
+	devfreq_suspended = true;
+
+	mutex_lock(&devfreq_list_lock);
+
+	/*
+	 * Suspend all the devices that were not previously suspended through
+	 * devfreq_suspend_device(). In devfreq_resume() we then resume exactly
+	 * these devices.
+	 */
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (test_bit(DEVFREQ_BIT_SUSPENDED, &devfreq->flags))
+			continue;
+
+		ret = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_SUSPEND, NULL);
+		if (ret < 0) {
+			dev_err(&devfreq->dev, "%s: governor suspend failed\n", __func__);
+			continue;
+		}
+
+		__set_bit(DEVFREQ_BIT_RESUME, &devfreq->flags);
+	}
+
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (!devfreq->suspend_freq)
+			continue;
+
+		if (devfreq->profile->get_cur_freq)
+			devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq);
+		else
+			freq = devfreq->previous_freq;
+
+		devfreq->resume_freq = freq;
+
+		freqs.old = devfreq->resume_freq;
+		freqs.new = devfreq->suspend_freq;
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+
+		freq = devfreq->suspend_freq;
+		ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
+
+		if (ret < 0) {
+			dev_err(&devfreq->dev, "%s: setting suspend frequency failed\n", __func__);
+			freqs.new = devfreq->resume_freq;
+			devfreq->resume_freq = 0;
+		} else
+			freqs.new = freq;
+
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
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
+	struct devfreq_freqs freqs;
+	unsigned long freq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+
+	/*
+	 * If a suspend OPP was set during devfreq_suspend(), then try to
+	 * restore the DevFreq here to the original OPP.
+	 */
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (!devfreq->resume_freq)
+			continue;
+
+		freqs.old = devfreq->suspend_freq;
+		freqs.new = devfreq->resume_freq;
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+
+		freq = devfreq->resume_freq;
+		ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
+
+		if (ret < 0) {
+			dev_err(&devfreq->dev, "%s: setting resume frequency failed\n", __func__);
+			freqs.new = devfreq->suspend_freq;
+		} else
+			freqs.new =  freq;
+
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+		devfreq->resume_freq = 0;
+	}
+
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		if (!test_bit(DEVFREQ_BIT_RESUME, &devfreq->flags))
+			continue;
+
+		ret = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_RESUME, NULL);
+		if (ret < 0)
+			dev_err(&devfreq->dev, "%s: governor resume failed\n", __func__);
+
+		__clear_bit(DEVFREQ_BIT_RESUME, &devfreq->flags);
+	}
+
+	mutex_unlock(&devfreq_list_lock);
+
+	devfreq_suspended = false;
+}
+
+/**
  * devfreq_add_governor() - Add devfreq governor
  * @governor:	the devfreq governor to be added
  */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d6bf9a3..a98fa0f 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -173,6 +173,9 @@ struct devfreq {
 
 	unsigned int turbo_refcount;
 
+	unsigned long suspend_freq; /* freq during devfreq suspend */
+	unsigned long resume_freq; /* freq restored after suspend cycle */
+
 	unsigned long previous_freq;
 	struct devfreq_dev_status last_status;
 
@@ -216,6 +219,10 @@ extern int devfreq_turbo_put(struct devfreq *devfreq);
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+/* Suspend/resume the entire Devfreq subsystem. */
+void devfreq_suspend(void);
+void devfreq_resume(void);
+
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
@@ -425,6 +432,9 @@ static inline int devfreq_update_stats(struct devfreq *df)
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
