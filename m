From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 7/8] PM / devfreq: Simplify the sysfs name of devfreq-event
 device
Date: Wed, 28 Dec 2016 20:56:51 +0900
Message-ID: <1482926212-19223-8-git-send-email-cw00.choi@samsung.com>
References: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161228115654epcas1p1a55cebc1270e16435d13e6d4d2197b74@epcas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58637 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbcL1L47 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 06:56:59 -0500
In-reply-to: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch just removes '.' character from the sysfs name of devfreq-event
device as following. Usually, the subsystem uses the similiar naming style
such as {framework name}{Number}.
- old : /sys/class/devfreq-event/event.X
- new : /sys/class/devfreq-event/eventX

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 9aea2c7ecbe6..39f8704ad664 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -329,7 +329,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	edev->dev.class = devfreq_event_class;
 	edev->dev.release = devfreq_event_release_edev;
 
-	dev_set_name(&edev->dev, "event.%d", atomic_inc_return(&event_no) - 1);
+	dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no) - 1);
 	ret = device_register(&edev->dev);
 	if (ret < 0) {
 		put_device(&edev->dev);
-- 
1.9.1

