From: Rajagopal Venkat <rajagopal.venkat@linaro.org>
Subject: [PATCH 1/2] PM / devfreq: Fix compiler warnings
Date: Thu, 21 Mar 2013 18:58:25 +0530
Message-ID: <1363872506-3630-2-git-send-email-rajagopal.venkat@linaro.org>
References: <1363872506-3630-1-git-send-email-rajagopal.venkat@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363872506-3630-1-git-send-email-rajagopal.venkat@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, rjw@sisk.pl, Kevin Hilman <khilman@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rajagopal Venkat <rajagopal.venkat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Fix compiler warnings generated when devfreq is not enabled
(CONFIG_PM_DEVFREQ is not set).

Signed-off-by: Rajagopal Venkat <rajagopal.venkat@linaro.org>
---
 include/linux/devfreq.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 04ad61d..5f1ab92 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -215,7 +215,7 @@ struct devfreq_simple_ondemand_data {
 #endif
 
 #else /* !CONFIG_PM_DEVFREQ */
-static struct devfreq *devfreq_add_device(struct device *dev,
+static inline struct devfreq *devfreq_add_device(struct device *dev,
 					  struct devfreq_dev_profile *profile,
 					  const char *governor_name,
 					  void *data)
@@ -223,34 +223,34 @@ static struct devfreq *devfreq_add_device(struct device *dev,
 	return NULL;
 }
 
-static int devfreq_remove_device(struct devfreq *devfreq)
+static inline int devfreq_remove_device(struct devfreq *devfreq)
 {
 	return 0;
 }
 
-static int devfreq_suspend_device(struct devfreq *devfreq)
+static inline int devfreq_suspend_device(struct devfreq *devfreq)
 {
 	return 0;
 }
 
-static int devfreq_resume_device(struct devfreq *devfreq)
+static inline int devfreq_resume_device(struct devfreq *devfreq)
 {
 	return 0;
 }
 
-static struct opp *devfreq_recommended_opp(struct device *dev,
+static inline struct opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags)
 {
-	return -EINVAL;
+	return ERR_PTR(-EINVAL);
 }
 
-static int devfreq_register_opp_notifier(struct device *dev,
+static inline int devfreq_register_opp_notifier(struct device *dev,
 					 struct devfreq *devfreq)
 {
 	return -EINVAL;
 }
 
-static int devfreq_unregister_opp_notifier(struct device *dev,
+static inline int devfreq_unregister_opp_notifier(struct device *dev,
 					   struct devfreq *devfreq)
 {
 	return -EINVAL;
-- 
1.7.10.4
