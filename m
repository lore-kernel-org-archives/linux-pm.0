From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/5] devfreq: Fix devfreq_remove_device() to improve the
 sequence of resource free
Date: Fri, 25 Apr 2014 18:08:10 +0900
Message-ID: <1398416894-6782-2-git-send-email-cw00.choi@samsung.com>
References: <1398416894-6782-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48805 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbaDYJIT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 05:08:19 -0400
In-reply-to: <1398416894-6782-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, cw00.choi@samsung.com, jkosina@suse.cz, labbe.montjoie@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch modify devfreq_remove_device() to improve the sequence of resource
free. If executing existing devfreq_remove_device(), this function always
executes _remove_devfreq() twice. In result, second _remove_devfreq() always
return error value. So, This patch resolves complicated function sequence
as following:

[Flow sequence before modification]
devfreq_remove_device()
   _remove_devfreq(devfreq, false)
      kfree(devfreq);  /* Free devfreq */
      if (!skip ...) { /* skip is false */
         device_unregister(&devfreq->dev)
         put_device(&devfreq->dev);
            ...
            dev->release()
               devfreq_dev_release()
                  _remove_devfreq(devfreq, true) <- Recall to free devfreq
                  /*
		   * Always return error without freeing resource because
		   * already _remove_devfreq() frees the memory of devfreq.
		   */
   }

[Flow sequence after modification]
devfreq_remove_device
   device_unregister(&devfreq->dev)
   put_device(&devfreq->dev);
      ..
      dev->release()
         devfreq_dev_release()
            _remove_devfreq()
               kfree(devfreq); /* Free devfreq */

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index d32c8b6..e960eb0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -437,7 +437,7 @@ update:
  * @devfreq:	the devfreq struct
  * @skip:	skip calling device_unregister().
  */
-static void _remove_devfreq(struct devfreq *devfreq, bool skip)
+static void _remove_devfreq(struct devfreq *devfreq)
 {
 	mutex_lock(&devfreq_list_lock);
 	if (IS_ERR(find_device_devfreq(devfreq->dev.parent))) {
@@ -462,11 +462,6 @@ static void _remove_devfreq(struct devfreq *devfreq, bool skip)
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
-	if (!skip && get_device(&devfreq->dev)) {
-		device_unregister(&devfreq->dev);
-		put_device(&devfreq->dev);
-	}
-
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
@@ -476,14 +471,12 @@ static void _remove_devfreq(struct devfreq *devfreq, bool skip)
  * @dev:	the devfreq device
  *
  * This calls _remove_devfreq() if _remove_devfreq() is not called.
- * Note that devfreq_dev_release() could be called by _remove_devfreq() as
- * well as by others unregistering the device.
  */
 static void devfreq_dev_release(struct device *dev)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
 
-	_remove_devfreq(devfreq, true);
+	_remove_devfreq(devfreq);
 }
 
 static int devfreq_qos_sanity_check(struct device *dev,
@@ -659,7 +652,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
 	if (!devfreq)
 		return -EINVAL;
 
-	_remove_devfreq(devfreq, false);
+	device_unregister(&devfreq->dev);
+	put_device(&devfreq->dev);
 
 	return 0;
 }
-- 
1.8.0

