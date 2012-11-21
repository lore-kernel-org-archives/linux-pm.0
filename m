From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: missing rcu_read_lock() added for
 find_device_opp()
Date: Wed, 21 Nov 2012 19:10:34 +0900
Message-ID: <1353492634-10730-1-git-send-email-myungjoo.ham@samsung.com>
References: <CAGXu5j+g8inUZV43GFQzs9KpRvjPGPTJsXinb4Y=wOuOf2jnVQ@mail.gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45309 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220Ab2KUKKn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Nov 2012 05:10:43 -0500
In-reply-to: <CAGXu5j+g8inUZV43GFQzs9KpRvjPGPTJsXinb4Y=wOuOf2jnVQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, keescook@chromium.org, serge.hallyn@canonical.com, linux-kernel@vger.kernel.org, myungjoo.ham@gmail.com

opp_get_notifier() uses find_device_opp(), which requires to
held rcu_read_lock. In order to keep the notifier-header
valid, we have added rcu_read_lock().

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/devfreq.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 45e053e..e91cb22 100644
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
+	if (!ret)
+		ret = srcu_notifier_chain_register(nh, &devfreq->nb);
+	rcu_read_unlock();
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
+	if (!ret)
+		ret = srcu_notifier_chain_unregister(nh, &devfreq->nb);
+	rcu_read_unlock();
+
+	return ret;
 }
 
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
-- 
1.7.5.4

