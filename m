From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH] PM / devfreq: consistent indentation
Date: Mon, 21 Jan 2019 11:19:40 +0900
Message-ID: <20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
References: <CGME20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Following up with complaints on inconsistent indentation from
Yangtao Li, this fixes indentation inconsistency.

In principle, this tries to put arguments aligned to the left
including the first argument except for in the case where
the first argument is on the far-right side.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4af608a..428a1de 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -528,7 +528,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
 		mutex_lock(&devfreq->lock);
 		if (!devfreq->stop_polling)
 			queue_delayed_work(devfreq_wq, &devfreq->work,
-			      msecs_to_jiffies(devfreq->profile->polling_ms));
+				msecs_to_jiffies(devfreq->profile->polling_ms));
 	}
 out:
 	mutex_unlock(&devfreq->lock);
@@ -537,7 +537,7 @@ EXPORT_SYMBOL(devfreq_interval_update);
 
 /**
  * devfreq_notifier_call() - Notify that the device frequency requirements
- *			   has been changed out of devfreq framework.
+ *			     has been changed out of devfreq framework.
  * @nb:		the notifier_block (supposed to be devfreq->nb)
  * @type:	not used
  * @devp:	not used
@@ -683,12 +683,11 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table =
-		devm_kzalloc(&devfreq->dev,
-			     array3_size(sizeof(unsigned int),
-					 devfreq->profile->max_state,
-					 devfreq->profile->max_state),
-			     GFP_KERNEL);
+	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+			array3_size(sizeof(unsigned int),
+				    devfreq->profile->max_state,
+				    devfreq->profile->max_state),
+			GFP_KERNEL);
 	if (!devfreq->trans_table) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
@@ -696,9 +695,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-						devfreq->profile->max_state,
-						sizeof(unsigned long),
-						GFP_KERNEL);
+			devfreq->profile->max_state,
+			sizeof(unsigned long),
+			GFP_KERNEL);
 	if (!devfreq->time_in_state) {
 		mutex_unlock(&devfreq->lock);
 		err = -ENOMEM;
@@ -1184,7 +1183,7 @@ static ssize_t available_governors_show(struct device *d,
 	 */
 	if (df->governor->immutable) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
-				   "%s ", df->governor_name);
+				  "%s ", df->governor_name);
 	/*
 	 * The devfreq device shows the registered governor except for
 	 * immutable governors such as passive governor .
@@ -1497,8 +1496,8 @@ EXPORT_SYMBOL(devfreq_recommended_opp);
 
 /**
  * devfreq_register_opp_notifier() - Helper function to get devfreq notified
- *				   for any changes in the OPP availability
- *				   changes
+ *				     for any changes in the OPP availability
+ *				     changes
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  */
@@ -1510,8 +1509,8 @@ EXPORT_SYMBOL(devfreq_register_opp_notifier);
 
 /**
  * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq
- *				     notified for any changes in the OPP
- *				     availability changes anymore.
+ *				       notified for any changes in the OPP
+ *				       availability changes anymore.
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  *
@@ -1530,8 +1529,8 @@ static void devm_devfreq_opp_release(struct device *dev, void *res)
 }
 
 /**
- * devm_ devfreq_register_opp_notifier()
- *		- Resource-managed devfreq_register_opp_notifier()
+ * devm_devfreq_register_opp_notifier() - Resource-managed
+ *					  devfreq_register_opp_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  */
@@ -1559,8 +1558,8 @@ int devm_devfreq_register_opp_notifier(struct device *dev,
 EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
 
 /**
- * devm_devfreq_unregister_opp_notifier()
- *		- Resource-managed devfreq_unregister_opp_notifier()
+ * devm_devfreq_unregister_opp_notifier() - Resource-managed
+ *					    devfreq_unregister_opp_notifier()
  * @dev:	The devfreq user device. (parent of devfreq)
  * @devfreq:	The devfreq object.
  */
@@ -1579,8 +1578,8 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
  * @list:	DEVFREQ_TRANSITION_NOTIFIER.
  */
 int devfreq_register_notifier(struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list)
+			      struct notifier_block *nb,
+			      unsigned int list)
 {
 	int ret = 0;
 
@@ -1686,9 +1685,9 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
  * @list:	DEVFREQ_TRANSITION_NOTIFIER.
  */
 void devm_devfreq_unregister_notifier(struct device *dev,
-				struct devfreq *devfreq,
-				struct notifier_block *nb,
-				unsigned int list)
+				      struct devfreq *devfreq,
+				      struct notifier_block *nb,
+				      unsigned int list)
 {
 	WARN_ON(devres_release(dev, devm_devfreq_notifier_release,
 			       devm_devfreq_dev_match, devfreq));
-- 
2.7.4
