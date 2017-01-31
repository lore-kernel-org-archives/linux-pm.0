From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 2/2] PM / devfreq: Modify the device name as devfreq(X) for
 sysfs
Date: Tue, 31 Jan 2017 16:47:57 +0900
Message-ID: <1485848877-19184-3-git-send-email-cw00.choi@samsung.com>
References: <1485848877-19184-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170131074759epcas1p33b9d7f798aad025c3a3958147f133722@epcas1p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55743 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdAaH6B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 02:58:01 -0500
In-reply-to: <1485848877-19184-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This patch modifies the device name as devfreq(X) for sysfs by using the 'devfreq'
prefix word instead of separate device name. On user-space aspect, user would
find the some devfreq drvier with 'devfreq(X)' pattern. So, this patch modify the
device name as following:
- /sys/class/devfreq/[non-standard device name] -> /sys/class/devfreq/devfreq(X)

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2e685164c549..4aa72b5ed660 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -519,6 +519,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 {
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
+	static atomic_t devfreq_no = ATOMIC_INIT(-1);
 	int err = 0;
 
 	if (!dev || !profile || !governor_name) {
@@ -560,7 +561,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
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

