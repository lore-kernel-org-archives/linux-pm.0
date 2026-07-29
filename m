Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9873C062A;
	Wed, 29 Jul 2026 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309126; cv=none; b=XoN2MWDE/Jv7i0vWYpX0DiO0MhDuLaiY8CldYmURFI8tHMjd7nhzE4gzbfwbmaKqMdOLtb1nt4qTJyeXuWvHOUBvWDdFU6hXRPBYhM6BN842HCvvC9SSixD6pliOdvqsRVREx+i2FbBloBXiK7yGgSsH8zvJmxUuuOEtLv/fB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309126; c=relaxed/simple;
	bh=UHRgH4FtYqNF7EtCqqMuW2wWxCLVku61KQCKe+I7unM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhlzQGLdKe37z/Ad0OFRduKzsE/xuLQJJrSqa8Iok6lGmZIzlZYRC1vViJrE43TYfQJJWl3DFv5rd5bNaha1o0z5NJAYRaWO6UcaQAYNxyMEtYNYYVrkuIDtY6KHuRglQy1ntbeXngoqTMIQ+9yxgZSbyw64k8x8V6Q2dtbNlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OzThzpNG; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OzThzpNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785309119;
	bh=JYabXUw23MXm3K9z3j9Td70Xr3wGG5JkEjW+QaScG3c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OzThzpNGW1vEL31Zf/mO3Tuo01mCfFth5WmH99JBvNN1WAl/E/UibumMdWfl10E/u
	 LDUcAXKJn3p/O+WaZT61Yg+8p4AFOKC0FG0wQiXM93fMQJUjuEdxxotkPhFw0ibS3H
	 ykNUjkggRhVOLxmSxGOMHTYFDgfOtSNfsy6t9Dls=
X-QQ-mid: zesmtpgz6t1785309107tfa5a5d0b
X-QQ-Originating-IP: 7t9aBK2SliuLvTIekGODs2QmU1DxYfC2Y70y8WKn1PY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Jul 2026 15:11:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3390613808785607158
EX-QQ-RecipientCnt: 15
From: Haowen Tu <tuhaowen@uniontech.com>
To: laurent.pinchart@ideasonboard.com,
	rafael@kernel.org
Cc: gregkh@linuxfoundation.org,
	hansg@kernel.org,
	kernel@uniontech.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	oneukum@suse.com,
	pavel@kernel.org,
	stern@rowland.harvard.edu,
	tuhaowen@uniontech.com
Subject: [PATCH v4 4/4] media: uvcvideo: defer streaming restart after hibernation snapshot
Date: Wed, 29 Jul 2026 15:11:23 +0800
Message-Id: <6179cdb467414a1949fabbd4d8dec29affe9c3ea.1785226280.git.tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1785226280.git.tuhaowen@uniontech.com>
References: <20260723084633.GE648629@killaraus.ideasonboard.com> <cover.1785226280.git.tuhaowen@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: New1l5u9k9F/9gAm0IkQLvmIW3LOhWclG5KPL2HGZAd6niqfhVW1lKnh
	zO0wBzlDHCGgJ5HMDaD5ADl4gGTmT6rQqWmSZgq5DOUY0JQ3xlQScKoWkJCExLCXuRuQSvF
	DQCuNdenMhtHQu/J285h6AoN2M5L/P88LydY9mwS0nH6IsHjlVw+bfxoZ39xmyVpoEWUtMk
	RcLXzlUkCR5v1NsesWD6Whqq9jgnfnQRAIH+qTtrTLsc6geKNHZyS00QWkdLRQOh93MUzc+
	T03pjtulQ+1pk2WWQb5dE9mk6hpFVpg992RRbnOSGSraUmHoAOHeE6xM71ViOZ1dUGev2i3
	yl4/eJoh9GPAo2qhrcEgg25GHzAJoDDuVgoCSmGwKlt65WBP5usm6JpchJ6KrKMvbiem59x
	fgyUnysVTKcdJ+HVHLmvNGJbv4cbkYNWD8GK9ojv/368UPghdiPBtK8MKlNXLt0buDGpz7p
	WMqkqolnM00Gs4bW175DoVbqidh/nvnMS2yD8P08mziWTrJ4pb6bTAMyhI2doiRW0qNeEl1
	j/GB0bag68z+Xg0nsUHjmDrCxYNUDXeClfPhcUDxdUKgWwyzM23Baj1gQXmzECM4sdu6fN3
	43JpqWEfEMd/PWKppmcIRpWLNtLWIAuyEI0F/OB/BHTXN5wu3y8hMFJrTadPd+HvMblN61w
	Lo1AGsULDzmks3Yya+yDKymzxFtPC+Cc5N0vGoTeXwveerwqN95t42JjeWutn5OMsCGO6ir
	dT+eRhfUAN/HBuG5cxNFmw0OEppWKDyfjrVbCvnyATiwT2hwsBrUIPVLoqEm5BB8sG/kGVw
	RlqHSIdr5xbU6pyo6SvCwoFRd3eOW4oGOrjbIEexCXMedtJcjndKqvLJPIlVOZBbjPWdeV7
	Ilvlo2o1fi2yjz+WJCZYC52Xz8Qp7mNvMp6d3PClEfheA2B8/LINckIoimWw3SqR8hLhhgp
	HST3gmExA8kuhXpiausE4E/pPQxLg2E1gtoaIgszq1iTfdZnW0GjF9PWWd2X00nQHHoPOeR
	Qtwz01iLC7QjkaPYSiFjyVzJ4q6AEoGosGR+erk7RLyNoZbLPhLTXwsybt5OI=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

When a UVC camera is streaming and the system enters hibernation, the
streaming interface is frozen before the snapshot is created. The
original kernel then resumes devices with PMSG_THAW so it can write the
hibernation image.

Restarting UVC streaming during this transient phase can turn the camera
LED back on and generate USB traffic even though the normal successful
path writes the image and powers off. USB interface resume callbacks do
not receive the PM message, so use pm_hibernation_snapshot_done() to
detect this phase and defer the streaming restart.

The deferred state is kept in the UVC stream. If image writeout succeeds,
the system powers off and no restart is needed. If image writeout fails,
the PM core sends PM_HIBERNATION_IMAGE_WRITE_FAILED before userspace is
thawed; the UVC PM notifier then restarts streams whose resume was
deferred. If that recovery restart fails, fall back to the existing
streamoff error path so userspace is notified instead of waiting on
buffers indefinitely.

Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 56 +++++++++++++++++++++++++++++-
 drivers/media/usb/uvc/uvc_video.c  | 19 +++++++++-
 drivers/media/usb/uvc/uvcvideo.h   |  2 ++
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 31b4ac3b48c1..3cf861e0fa95 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/usb.h>
 #include <linux/usb/quirks.h>
 #include <linux/usb/uvc.h>
@@ -38,6 +39,8 @@ unsigned int uvc_dbg_param;
 unsigned int uvc_timeout_param = UVC_CTRL_STREAMING_TIMEOUT;
 
 static struct usb_driver uvc_driver;
+static LIST_HEAD(uvc_pm_devices);
+static DEFINE_MUTEX(uvc_pm_mutex);
 
 /* ------------------------------------------------------------------------
  * Utility functions
@@ -2200,6 +2203,7 @@ static int uvc_probe(struct usb_interface *intf,
 	INIT_LIST_HEAD(&dev->entities);
 	INIT_LIST_HEAD(&dev->chains);
 	INIT_LIST_HEAD(&dev->streams);
+	INIT_LIST_HEAD(&dev->pm_list);
 	kref_init(&dev->ref);
 	atomic_set(&dev->nmappings, 0);
 
@@ -2346,6 +2350,10 @@ static int uvc_probe(struct usb_interface *intf,
 	if (!(dev->quirks & UVC_QUIRK_DISABLE_AUTOSUSPEND))
 		usb_enable_autosuspend(udev);
 
+	mutex_lock(&uvc_pm_mutex);
+	list_add_tail(&dev->pm_list, &uvc_pm_devices);
+	mutex_unlock(&uvc_pm_mutex);
+
 	uvc_dbg(dev, PROBE, "UVC device initialized\n");
 
 	return 0;
@@ -2370,6 +2378,10 @@ static void uvc_disconnect(struct usb_interface *intf)
 	    UVC_SC_VIDEOSTREAMING)
 		return;
 
+	mutex_lock(&uvc_pm_mutex);
+	list_del_init(&dev->pm_list);
+	mutex_unlock(&uvc_pm_mutex);
+
 	uvc_unregister_video(dev);
 	kref_put(&dev->ref, uvc_delete);
 }
@@ -2447,6 +2459,41 @@ static int uvc_reset_resume(struct usb_interface *intf)
 	return __uvc_resume(intf, 1);
 }
 
+static int uvc_pm_notify(struct notifier_block *nb, unsigned long action,
+			 void *data)
+{
+	struct uvc_device *dev;
+	struct uvc_streaming *stream;
+	int ret;
+
+	if (action != PM_HIBERNATION_IMAGE_WRITE_FAILED)
+		return NOTIFY_DONE;
+
+	mutex_lock(&uvc_pm_mutex);
+	list_for_each_entry(dev, &uvc_pm_devices, pm_list) {
+		list_for_each_entry(stream, &dev->streams, list) {
+			if (!stream->hibernate_resume_deferred)
+				continue;
+
+			stream->hibernate_resume_deferred = 0;
+			ret = uvc_video_resume(stream, 0);
+			if (ret < 0) {
+				mutex_lock(&stream->queue.mutex);
+				vb2_streamoff(&stream->queue.queue,
+					      stream->queue.queue.type);
+				mutex_unlock(&stream->queue.mutex);
+			}
+		}
+	}
+	mutex_unlock(&uvc_pm_mutex);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block uvc_pm_nb = {
+	.notifier_call = uvc_pm_notify,
+};
+
 /* ------------------------------------------------------------------------
  * Module parameters
  */
@@ -3291,8 +3338,15 @@ static int __init uvc_init(void)
 
 	uvc_debugfs_init();
 
+	ret = register_pm_notifier(&uvc_pm_nb);
+	if (ret < 0) {
+		uvc_debugfs_cleanup();
+		return ret;
+	}
+
 	ret = usb_register(&uvc_driver);
 	if (ret < 0) {
+		unregister_pm_notifier(&uvc_pm_nb);
 		uvc_debugfs_cleanup();
 		return ret;
 	}
@@ -3303,6 +3357,7 @@ static int __init uvc_init(void)
 static void __exit uvc_cleanup(void)
 {
 	usb_deregister(&uvc_driver);
+	unregister_pm_notifier(&uvc_pm_nb);
 	uvc_debugfs_cleanup();
 }
 
@@ -3313,4 +3368,3 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRIVER_VERSION);
-
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index f6c8e3223796..2c57b7042856 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/videodev2.h>
@@ -2151,11 +2152,27 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
 	if (!uvc_queue_streaming(&stream->queue))
 		return 0;
 
+	/*
+	 * Defer restarting the streaming hardware during the transient THAW
+	 * phase after a hibernation snapshot has been created. If writing the
+	 * image succeeds, the system powers off and the restart is not needed.
+	 * If writing fails, the PM core notifies the driver before userspace is
+	 * thawed so deferred streams can be restarted.
+	 */
+	if (pm_hibernation_snapshot_done()) {
+		stream->hibernate_resume_deferred = 1;
+		return 0;
+	}
+
 	ret = uvc_commit_video(stream, &stream->ctrl);
 	if (ret < 0)
 		return ret;
 
-	return uvc_video_start_transfer(stream, GFP_NOIO);
+	ret = uvc_video_start_transfer(stream, GFP_NOIO);
+	if (!ret)
+		stream->hibernate_resume_deferred = 0;
+
+	return ret;
 }
 
 /* ------------------------------------------------------------------------
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 0a0c01b2420f..c87eaaaf2749 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -475,6 +475,7 @@ struct uvc_streaming {
 
 	/* Buffers queue. */
 	unsigned int frozen : 1;
+	unsigned int hibernate_resume_deferred : 1;
 	struct uvc_video_queue queue;
 	struct workqueue_struct *async_wq;
 	void (*decode)(struct uvc_urb *uvc_urb, struct uvc_buffer *buf,
@@ -604,6 +605,7 @@ struct uvc_device {
 
 	/* Video Streaming interfaces */
 	struct list_head streams;
+	struct list_head pm_list;
 	struct kref ref;
 
 	/* Status Interrupt Endpoint */
-- 
2.20.1
