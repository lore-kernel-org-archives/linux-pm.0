From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 1/2] PM / devfreq: Simplify the sysfs name of devfreq-event
 device
Date: Tue, 31 Jan 2017 16:47:56 +0900
Message-ID: <1485848877-19184-2-git-send-email-cw00.choi@samsung.com>
References: <1485848877-19184-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170131074759epcas1p346fd3ae1d6dd7133f995f77ff715525b@epcas1p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36798 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdAaH60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 02:58:26 -0500
In-reply-to: <1485848877-19184-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch just removes '.' character from the sysfs name of devfreq-event
device as following. Usually, the subsystem uses the similiar naming style
such as {framework name}{Number}.
- old : /sys/class/devfreq-event/event.(X)
- new : /sys/class/devfreq-event/event(X)

And this patch initializes the value of 'event_no' with -1
in order to remove the unneeded operation (-1) when calling
the atomic_inc_return(&event_no).

Lastly, this patch adds the ABI document for devfreq-event class.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../ABI/testing/sysfs-class-devfreq-event          | 25 ++++++++++++++++++++++
 drivers/devfreq/devfreq-event.c                    |  4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-devfreq-event

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq-event b/Documentation/ABI/testing/sysfs-class-devfreq-event
new file mode 100644
index 000000000000..ceaf0f686d4a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-devfreq-event
@@ -0,0 +1,25 @@
+What:		/sys/class/devfreq-event/event(x)/
+Date:		January 2017
+Contact:	Chanwoo Choi <cw00.choi@samsung.com>
+Description:
+		Provide a place in sysfs for the devfreq-event objects.
+		This allows accessing various devfreq-event specific variables.
+		The name of devfreq-event object denoted as 'event(x)' which
+		includes the unique number of 'x' for each devfreq-event object.
+
+What:		/sys/class/devfreq-event/event(x)/name
+Date:		January 2017
+Contact:	Chanwoo Choi <cw00.choi@samsung.com>
+Description:
+		The /sys/class/devfreq-event/event(x)/name attribute contains
+		the name of the devfreq-event object. This attribute is
+		read-only.
+
+What:		/sys/class/devfreq-event/event(x)/enable_count
+Date:		January 2017
+Contact:	Chanwoo Choi <cw00.choi@samsung.com>
+Description:
+		The /sys/class/devfreq-event/event(x)/enable_count attribute
+		contains the reference count to enable the devfreq-event
+		object. If the device is enabled, the value of attribute is
+		greater than zero.
diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 9aea2c7ecbe6..8648b32ebc89 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -306,7 +306,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 						struct devfreq_event_desc *desc)
 {
 	struct devfreq_event_dev *edev;
-	static atomic_t event_no = ATOMIC_INIT(0);
+	static atomic_t event_no = ATOMIC_INIT(-1);
 	int ret;
 
 	if (!dev || !desc)
@@ -329,7 +329,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	edev->dev.class = devfreq_event_class;
 	edev->dev.release = devfreq_event_release_edev;
 
-	dev_set_name(&edev->dev, "event.%d", atomic_inc_return(&event_no) - 1);
+	dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no));
 	ret = device_register(&edev->dev);
 	if (ret < 0) {
 		put_device(&edev->dev);
-- 
1.9.1

