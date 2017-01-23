From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 3/4] PM / devfreq: Simplify the sysfs name of devfreq-event
 device
Date: Mon, 23 Jan 2017 12:31:38 +0900
Message-ID: <1485142299-9986-4-git-send-email-cw00.choi@samsung.com>
References: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170123033152epcas5p34efc72ecd1afb21efca58421ab41cbc6@epcas5p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38616 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdAWDbz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 22:31:55 -0500
In-reply-to: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch just removes '.' character from the sysfs name of devfreq-event
device as following. Usually, the subsystem uses the similiar naming style
such as {framework name}{Number}.
- old : /sys/class/devfreq-event/event.[X]
- new : /sys/class/devfreq-event/event[X]

And this patch initializes the value of 'event_no' with -1
in order to remove the unneeded operation (-1) when calling
the atomic_inc_return(&event_no).

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

