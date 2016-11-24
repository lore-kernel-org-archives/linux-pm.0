From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/6] PM / devfreq: Modify the device name as devfreq[X] for
 sysfs
Date: Thu, 24 Nov 2016 14:01:04 +0900
Message-ID: <1479963668-22845-3-git-send-email-cw00.choi@samsung.com>
References: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

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
index dfef5ea57e4c..4d2b7e5b8d3c 100644
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
+	dev_set_name(&devfreq->dev, "devfreq%lu",
+			(unsigned long)atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);
-- 
1.9.1
