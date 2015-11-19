From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4/6] PM / devfreq: Set the freq_table of devfreq device
Date: Thu, 19 Nov 2015 17:17:48 +0900
Message-ID: <1447921070-6045-5-git-send-email-cw00.choi@samsung.com>
References: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447921070-6045-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch initialize the freq_table array of each devfreq device by using
the devfreq_set_freq_table(). If freq_table is NULL, the devfreq framework
is not able to support the frequency transtion information through sysfs.

The OPP core uses the integer type for the number of opps in the opp list
and uses the 'unsigned long' type for each frequency. So, this patch modifies
the type of some variable as following:
- the type of freq_table : unsigned int -> unsigned long
- the type of max_state  : unsigned int -> int

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 50 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/devfreq.h   |  4 ++--
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 49fc7dcf664c..761e46a95c4b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -85,6 +85,45 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
 }
 
 /**
+ * devfreq_set_freq_table() - Initialize freq_table for the frequency
+ * @devfreq:	the devfreq instance
+ */
+static void devfreq_set_freq_table(struct devfreq *devfreq)
+{
+	struct devfreq_dev_profile *profile = devfreq->profile;
+	struct dev_pm_opp *opp;
+	unsigned long freq;
+	int i;
+
+	/* Initialize the freq_table from OPP table */
+	profile->max_state = dev_pm_opp_get_opp_count(devfreq->dev.parent);
+	if (profile->max_state <= 0)
+		return;
+
+	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
+					profile->max_state,
+					sizeof(*profile->freq_table),
+					GFP_KERNEL);
+	if (!profile->freq_table) {
+		profile->max_state = 0;
+		return;
+	}
+
+	rcu_read_lock();
+	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
+		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
+		if (IS_ERR(opp)) {
+			devm_kfree(devfreq->dev.parent, profile->freq_table);
+			profile->max_state = 0;
+			rcu_read_unlock();
+			return;
+		}
+		profile->freq_table[i] = freq;
+	}
+	rcu_read_unlock();
+}
+
+/**
  * devfreq_update_status() - Update statistics of devfreq behavior
  * @devfreq:	the devfreq instance
  * @freq:	the update target frequency
@@ -477,7 +516,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->previous_freq = profile->initial_freq;
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
+	mutex_unlock(&devfreq->lock);
 
+	if (devfreq->profile->max_state <= 0 && !devfreq->profile->freq_table)
+		devfreq_set_freq_table(devfreq);
+
+	mutex_lock(&devfreq->lock);
 	devfreq->trans_table =	devm_kzalloc(dev, sizeof(unsigned int) *
 						devfreq->profile->max_state *
 						devfreq->profile->max_state,
@@ -998,7 +1042,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	struct devfreq *devfreq = to_devfreq(dev);
 	ssize_t len;
 	int i, j;
-	unsigned int max_state = devfreq->profile->max_state;
+	int max_state = devfreq->profile->max_state;
 
 	if (!devfreq->stop_polling &&
 			devfreq_update_status(devfreq, devfreq->previous_freq))
@@ -1007,7 +1051,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	len = sprintf(buf, "   From  :   To\n");
 	len += sprintf(buf + len, "         :");
 	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%8u",
+		len += sprintf(buf + len, "%8ld",
 				devfreq->profile->freq_table[i]);
 
 	len += sprintf(buf + len, "   time(ms)\n");
@@ -1019,7 +1063,7 @@ static ssize_t trans_stat_show(struct device *dev,
 		} else {
 			len += sprintf(buf + len, " ");
 		}
-		len += sprintf(buf + len, "%8u:",
+		len += sprintf(buf + len, "%8ld:",
 				devfreq->profile->freq_table[i]);
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%8u",
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 68030e22af35..c6117ceb0c5d 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -89,8 +89,8 @@ struct devfreq_dev_profile {
 	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
 	void (*exit)(struct device *dev);
 
-	unsigned int *freq_table;
-	unsigned int max_state;
+	unsigned long *freq_table;
+	int max_state;
 };
 
 /**
-- 
1.9.1
