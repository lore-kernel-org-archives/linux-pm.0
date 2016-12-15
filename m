From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 7/7] PM / devfreq: Simplify the sysfs name of devfreq-event
 device
Date: Thu, 15 Dec 2016 18:30:43 +0900
Message-ID: <1481794243-5046-8-git-send-email-cw00.choi@samsung.com>
References: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

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
