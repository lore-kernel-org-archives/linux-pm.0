From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: missing rcu_read_lock() added for
 find_device_opp()
Date: Thu, 22 Nov 2012 15:36:32 +0900
Message-ID: <1353566192-7079-1-git-send-email-myungjoo.ham@samsung.com>
References: <20121121134621.GA30575@mail.hallyn.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20121121134621.GA30575@mail.hallyn.com>
Sender: linux-kernel-owner@vger.kernel.org
To: serge@hallyn.com
Cc: myungjoo.ham@gmail.com, linux-pm@vger.kernel.org, rjw@sisk.pl, keescook@chromium.org, serge.hallyn@canonical.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

opp_get_notifier() uses find_device_opp(), which requires to
held rcu_read_lock. In order to keep the notifier-header
valid, we have added rcu_read_lock().

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/devfreq.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1388d46..5275883 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1023,11 +1023,18 @@ struct opp *devfreq_recommended_opp(struct device *dev, unsigned long *freq,
  */
 int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
 {
-	struct srcu_notifier_head *nh = opp_get_notifier(dev);
+	struct srcu_notifier_head *nh;
+	int ret = 0;
 
+	rcu_read_lock();
+	nh = opp_get_notifier(dev);
 	if (IS_ERR(nh))
-		return PTR_ERR(nh);
-	return srcu_notifier_chain_register(nh, &devfreq->nb);
+		ret = PTR_ERR(nh);
+	rcu_read_unlock();
+	if (!ret)
+		ret = srcu_notifier_chain_register(nh, &devfreq->nb);
+
+	return ret;
 }
 
 /**
@@ -1042,11 +1049,18 @@ int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
  */
 int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
 {
-	struct srcu_notifier_head *nh = opp_get_notifier(dev);
+	struct srcu_notifier_head *nh;
+	int ret = 0;
 
+	rcu_read_lock();
+	nh = opp_get_notifier(dev);
 	if (IS_ERR(nh))
-		return PTR_ERR(nh);
-	return srcu_notifier_chain_unregister(nh, &devfreq->nb);
+		ret = PTR_ERR(nh);
+	rcu_read_unlock();
+	if (!ret)
+		ret = srcu_notifier_chain_unregister(nh, &devfreq->nb);
+
+	return ret;
 }
 
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
-- 
1.7.5.4
