From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/3] PM / devfreq: Remove unnecessary separate _remove_devfreq()
Date: Wed, 18 Jan 2017 15:56:51 +0900
Message-ID: <1484722611-10555-4-git-send-email-cw00.choi@samsung.com>
References: <1484722611-10555-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170118065653epcas5p25728109e3bc2458dc16c23904f908c66@epcas5p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1484722611-10555-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The _remove_devfreq() releases the all resources of the devfreq
device. This function is only called in the devfreq_dev_release().
For that reason, the devfreq core doesn't need to leave the
_remove_devfreq() separately. This patch releases the all
resources in the devfreq_dev_release() and then removes the
_remove_devfreq().

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6c560af2a801..c908c10c200a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -480,11 +480,15 @@ static int devfreq_notifier_call(struct notifier_block *nb, unsigned long type,
 }
 
 /**
- * _remove_devfreq() - Remove devfreq from the list and release its resources.
- * @devfreq:	the devfreq struct
+ * devfreq_dev_release() - Callback for struct device to release the device.
+ * @dev:	the devfreq device
+ *
+ * Remove devfreq from the list and release its resources.
  */
-static void _remove_devfreq(struct devfreq *devfreq)
+static void devfreq_dev_release(struct device *dev)
 {
+	struct devfreq *devfreq = to_devfreq(dev);
+
 	mutex_lock(&devfreq_list_lock);
 	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
 		mutex_unlock(&devfreq_list_lock);
@@ -506,19 +510,6 @@ static void _remove_devfreq(struct devfreq *devfreq)
 }
 
 /**
- * devfreq_dev_release() - Callback for struct device to release the device.
- * @dev:	the devfreq device
- *
- * This calls _remove_devfreq() if _remove_devfreq() is not called.
- */
-static void devfreq_dev_release(struct device *dev)
-{
-	struct devfreq *devfreq = to_devfreq(dev);
-
-	_remove_devfreq(devfreq);
-}
-
-/**
  * devfreq_add_device() - Add devfreq feature to the device
  * @dev:	the device to add devfreq feature.
  * @profile:	device-specific profile to run devfreq.
-- 
1.9.1
