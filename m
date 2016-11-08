From: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v4] PM/devfreq: add suspend frequency support
Date: Tue,  8 Nov 2016 17:11:29 +0800
Message-ID: <1478596289-7442-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Add suspend frequency support and if needed set it to
the frequency obtained from the suspend opp (can be defined
using opp-v2 bindings and is optional).

Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
Changes in v2:
- use update_devfreq() instead devfreq_update_status()
Changes in v3:
- fix build error
Changes in v4:
- move dev_pm_opp_get_suspend_opp() to devfreq_add_device()

 drivers/devfreq/devfreq.c                 | 15 +++++++++++++--
 drivers/devfreq/governor_simpleondemand.c |  9 +++++++++
 include/linux/devfreq.h                   |  9 +++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3ea76..d9d56e1 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -363,7 +363,10 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
 		mutex_unlock(&devfreq->lock);
 		return;
 	}
-
+	if (devfreq->suspend_freq) {
+		update_devfreq(devfreq);
+		devfreq->suspend_flag = true;
+	}
 	devfreq_update_status(devfreq, devfreq->previous_freq);
 	devfreq->stop_polling = true;
 	mutex_unlock(&devfreq->lock);
@@ -394,7 +397,8 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
 
 	devfreq->last_stat_updated = jiffies;
 	devfreq->stop_polling = false;
-
+	if (devfreq->suspend_freq)
+		devfreq->suspend_flag = false;
 	if (devfreq->profile->get_cur_freq &&
 		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
 		devfreq->previous_freq = freq;
@@ -528,6 +532,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
 	int err = 0;
+	struct dev_pm_opp *suspend_opp;
 
 	if (!dev || !profile || !governor_name) {
 		dev_err(dev, "%s: Invalid parameters.\n", __func__);
@@ -563,6 +568,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
+	rcu_read_lock();
+	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
+	if (suspend_opp)
+		devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
+	rcu_read_unlock();
+
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
 		devfreq_set_freq_table(devfreq);
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ae72ba5..84b3ce1 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -29,6 +29,15 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	struct devfreq_simple_ondemand_data *data = df->data;
 	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
 
+	/*
+	 * if devfreq in suspend status and have suspend_freq,
+	 * the frequency need to set to suspend_freq
+	 */
+	if (df->suspend_flag) {
+		*freq =	df->suspend_freq;
+		return 0;
+	}
+
 	err = devfreq_update_stats(df);
 	if (err)
 		return err;
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 2de4e2e..c463ae1 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -172,6 +172,7 @@ struct devfreq {
 	struct delayed_work work;
 
 	unsigned long previous_freq;
+	unsigned long suspend_freq;
 	struct devfreq_dev_status last_status;
 
 	void *data; /* private data for governors */
@@ -179,6 +180,7 @@ struct devfreq {
 	unsigned long min_freq;
 	unsigned long max_freq;
 	bool stop_polling;
+	bool suspend_flag;
 
 	/* information for device frequency transition */
 	unsigned int total_trans;
@@ -214,6 +216,8 @@ extern int devfreq_resume_device(struct devfreq *devfreq);
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
+extern void devfreq_opp_get_suspend_opp(struct device *dev,
+					struct devfreq *devfreq);
 extern int devfreq_register_opp_notifier(struct device *dev,
 					 struct devfreq *devfreq);
 extern int devfreq_unregister_opp_notifier(struct device *dev,
@@ -348,6 +352,11 @@ static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
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
2.6.6
