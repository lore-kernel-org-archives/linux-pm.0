From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 4/4] PM / devfreq: Modify the device name as devfreq[X] for
 sysfs
Date: Mon, 16 Jan 2017 21:26:07 +0900
Message-ID: <1484569567-29810-5-git-send-email-cw00.choi@samsung.com>
References: <1484569567-29810-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170116122609epcas5p3e9f106e6d097613cd866107bc0e065c7@epcas5p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1484569567-29810-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org
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
index 8e5938c9c7d6..4bd7a8f71b07 100644
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
