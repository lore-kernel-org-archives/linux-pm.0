From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 4/4] PM / devfreq: Modify the device name as devfreq[X] for
 sysfs
Date: Mon, 23 Jan 2017 12:31:39 +0900
Message-ID: <1485142299-9986-5-git-send-email-cw00.choi@samsung.com>
References: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170123033152epcas5p3c2d5ced0fcce359e8fd2d0576462c029@epcas5p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42906 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdAWDb5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 22:31:57 -0500
In-reply-to: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch modifies the device name as devfreq[X] for sysfs by using the 'devfreq'
prefix word instead of separate device name. On user-space aspect, user would
find the some devfreq drvier with 'devfreq[X]' pattern. So, this patch modify the
device name as following:
- /sys/class/devfreq/[non-standard device name] -> /sys/class/devfreq/devfreq[X]

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8e5938c9c7d6..493f9ce250ff 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -527,6 +527,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 {
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
+	static atomic_t devfreq_no = ATOMIC_INIT(-1);
 	int err = 0;
 
 	if (!dev || !profile || !governor_name) {
@@ -568,7 +569,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_lock(&devfreq->lock);
 	}
 
-	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
+	dev_set_name(&devfreq->dev, "devfreq%d",
+				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
-- 
1.9.1

