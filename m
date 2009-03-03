From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC][Patch 3/3] s390: cio: Fix device_move() vs.
	dpm_list.
Date: Tue, 3 Mar 2009 11:21:05 +0100
Message-ID: <20090303112105.7c6b1d13@gondolin>
References: <20090224165311.5d103b67@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090224165311.5d103b67@gondolin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Rafael J.
	Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Martin Schwidefsky <schw>
List-Id: linux-pm@vger.kernel.org

Make use of the newly introduced device_pm_move_*() functions
in order to make sure that subchannels and their ccw device are
in the correct order in dpm_list after moving them around.

We don't need to do anything for devices in the orphanage, since
their parent is a pseudo subchannel which won't need suspending.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/s390/cio/device.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

--- linux-2.6.orig/drivers/s390/cio/device.c
+++ linux-2.6/drivers/s390/cio/device.c
@@ -788,6 +788,10 @@ static void sch_attach_device(struct sub
 	spin_unlock_irq(sch->lock);
 }
 
+/*
+ * Note: This function is only called from ccw_device_move_to_orphanage,
+ * so we are guaranteed to hold the dpm_list mutex.
+ */
 static void sch_attach_disconnected_device(struct subchannel *sch,
 					   struct ccw_device *cdev)
 {
@@ -801,6 +805,7 @@ static void sch_attach_disconnected_devi
 	/* Note: device_move() changes cdev->dev.parent */
 	ret = device_move(&cdev->dev, &sch->dev);
 	if (ret) {
+		device_pm_unlock();
 		CIO_MSG_EVENT(0, "Moving disconnected device 0.%x.%04x failed "
 			      "(ret=%d)!\n", cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno, ret);
@@ -808,6 +813,15 @@ static void sch_attach_disconnected_devi
 		put_device(&sch->dev);
 		return;
 	}
+	/*
+	 * We already reorder dpm_list here since we may not hold
+	 * the dpm_list mutex when deregistering other_sch.
+	 * Order of devices will be correct after moving sch since
+	 * sch's parent (the css) is guaranteed to be after cdev
+	 * already.
+	 */
+	device_pm_move_after(&sch->dev, &cdev->dev);
+	device_pm_unlock();
 	sch_set_cdev(other_sch, NULL);
 	/* No need to keep a subchannel without ccw device around. */
 	css_sch_device_unregister(other_sch);
@@ -816,6 +830,10 @@ static void sch_attach_disconnected_devi
 	put_device(&other_sch->dev);
 }
 
+/*
+ * Note: This function is only called from ccw_device_move_to_orphanage,
+ * so we are guaranteed to hold the dpm_list mutex.
+ */
 static void sch_attach_orphaned_device(struct subchannel *sch,
 				       struct ccw_device *cdev)
 {
@@ -832,6 +850,7 @@ static void sch_attach_orphaned_device(s
 	 */
 	ret = device_move(&cdev->dev, &sch->dev);
 	if (ret) {
+		device_pm_unlock();
 		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x from orphanage "
 			      "failed (ret=%d)!\n",
 			      cdev->private->dev_id.ssid,
@@ -840,6 +859,12 @@ static void sch_attach_orphaned_device(s
 		put_device(&sch->dev);
 		return;
 	}
+	/*
+	 * sch's parent (the css) is guaranteed to be after cdev
+	 * already (must have been registered earlier).
+	 */
+	device_pm_move_after(&sch->dev, &cdev->dev);
+	device_pm_unlock();
 	sch_attach_device(sch, cdev);
 	/* Put reference on pseudo subchannel. */
 	put_device(&pseudo_sch->dev);
@@ -897,8 +922,10 @@ void ccw_device_move_to_orphanage(struct
 	 * ccw device can take its place on the subchannel.
 	 * Note: device_move() changes cdev->dev.parent
 	 */
+	device_pm_lock();
 	ret = device_move(&cdev->dev, &css->pseudo_subchannel->dev);
 	if (ret) {
+		device_pm_unlock();
 		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x to orphanage failed "
 			      "(ret=%d)!\n", cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno, ret);
@@ -906,6 +933,11 @@ void ccw_device_move_to_orphanage(struct
 		put_device(&css->pseudo_subchannel->dev);
 		return;
 	}
+	/*
+	 * No need to reorder dpm_list for devices in the orphanage,
+	 * since they have not to be suspended before a subchannel
+	 * (nothing needs to be done suspend-wise for the pseudo subchannel).
+	 */
 	cdev->ccwlock = css->pseudo_subchannel->lock;
 	/*
 	 * Search for the replacing ccw device
@@ -930,6 +962,7 @@ void ccw_device_move_to_orphanage(struct
 		put_device(&sch->dev);
 		return;
 	}
+	device_pm_unlock();
 	sch_create_and_recog_new_device(sch);
 	/* Release reference of subchannel from old cdev. */
 	put_device(&sch->dev);
@@ -1129,9 +1162,11 @@ static void ccw_device_move_to_sch(struc
 	 * Try to move the ccw device to its new subchannel.
 	 * Note: device_move() changes cdev->dev.parent
 	 */
+	device_pm_lock();
 	rc = device_move(&cdev->dev, &sch->dev);
-	mutex_unlock(&sch->reg_mutex);
 	if (rc) {
+		device_pm_unlock();
+		mutex_unlock(&sch->reg_mutex);
 		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x to subchannel "
 			      "0.%x.%04x failed (ret=%d)!\n",
 			      cdev->private->dev_id.ssid,
@@ -1142,6 +1177,15 @@ static void ccw_device_move_to_sch(struc
 		put_device(&sch->dev);
 		goto out;
 	}
+	/*
+	 * We need to reorder the dpm_list here so that unregistering
+	 * the former parent cannot deadlock.
+	 * sch's parent (the css) is already guaranteed to come after
+	 * cdev.
+	 */
+	device_pm_move_after(&sch->dev, &cdev->dev);
+	device_pm_unlock();
+	mutex_unlock(&sch->reg_mutex);
 	if (!sch_is_pseudo_sch(former_parent)) {
 		spin_lock_irq(former_parent->lock);
 		sch_set_cdev(former_parent, NULL);
