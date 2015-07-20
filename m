From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 1/2] PM: devfreq: Add the prototype of update_devfreq() to
 export
Date: Mon, 20 Jul 2015 10:13:38 +0900
Message-ID: <1437354819-6108-2-git-send-email-cw00.choi@samsung.com>
References: <1437354819-6108-1-git-send-email-cw00.choi@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1437354819-6108-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch add simply the protoptye of update_devfreq() to devfreq.h header
file to export it. The some device driver (e.g., thermal cooling device) may
use the update_devfreq() to update the range of supported frequency of devfreq
device.

Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/devfreq/devfreq.c | 22 +++++++++++-----------
 include/linux/devfreq.h   |  7 +++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ca1b362d77e2..2aa5e4e9df36 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -163,18 +163,17 @@ int update_devfreq(struct devfreq *devfreq)
 	int err = 0;
 	u32 flags = 0;
 
-	if (!mutex_is_locked(&devfreq->lock)) {
-		WARN(true, "devfreq->lock must be locked by the caller.\n");
-		return -EINVAL;
-	}
-
 	if (!devfreq->governor)
 		return -EINVAL;
 
+	mutex_lock(&devfreq->lock);
+
 	/* Reevaluate the proper frequency */
 	err = devfreq->governor->get_target_freq(devfreq, &freq);
-	if (err)
+	if (err) {
+		mutex_unlock(&devfreq->lock);
 		return err;
+	}
 
 	/*
 	 * Adjust the freuqency with user freq and QoS.
@@ -194,8 +193,10 @@ int update_devfreq(struct devfreq *devfreq)
 	}
 
 	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
-	if (err)
+	if (err) {
+		mutex_unlock(&devfreq->lock);
 		return err;
+	}
 
 	if (devfreq->profile->freq_table)
 		if (devfreq_update_status(devfreq, freq))
@@ -203,6 +204,9 @@ int update_devfreq(struct devfreq *devfreq)
 				"Couldn't update frequency transition information.\n");
 
 	devfreq->previous_freq = freq;
+
+	mutex_unlock(&devfreq->lock);
+
 	return err;
 }
 EXPORT_SYMBOL(update_devfreq);
@@ -218,14 +222,12 @@ static void devfreq_monitor(struct work_struct *work)
 	struct devfreq *devfreq = container_of(work,
 					struct devfreq, work.work);
 
-	mutex_lock(&devfreq->lock);
 	err = update_devfreq(devfreq);
 	if (err)
 		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
 
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
-	mutex_unlock(&devfreq->lock);
 }
 
 /**
@@ -382,9 +384,7 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 	struct devfreq *devfreq = container_of(nb, struct devfreq, nb);
 	int ret;
 
-	mutex_lock(&devfreq->lock);
 	ret = update_devfreq(devfreq);
-	mutex_unlock(&devfreq->lock);
 
 	return ret;
 }
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index ce447f0f1bad..07da551f2709 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -204,6 +204,8 @@ extern int devm_devfreq_register_opp_notifier(struct device *dev,
 extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
 						struct devfreq *devfreq);
 
+extern int update_devfreq(struct devfreq *devfreq);
+
 #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
 /**
  * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
@@ -289,6 +291,11 @@ static inline void devm_devfreq_unregister_opp_notifier(struct device *dev,
 							struct devfreq *devfreq)
 {
 }
+
+static inline int update_devfreq(struct devfreq *devfreq)
+{
+	return 0;
+}
 #endif /* CONFIG_PM_DEVFREQ */
 
 #endif /* __LINUX_DEVFREQ_H__ */
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
