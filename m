From: Santosh Mardi <gsantosh@codeaurora.org>
Subject: [PATCH] devfreq: add error check for sscanf in userspace governor
Date: Mon,  7 Aug 2017 18:36:45 +0530
Message-ID: <1502111205-22560-2-git-send-email-gsantosh@codeaurora.org>
References: <1502111205-22560-1-git-send-email-gsantosh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502111205-22560-1-git-send-email-gsantosh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gsantosh@qti.qualcomm.com, gsantosh@codeaurora.org, skannan@quicinc.com, rgottimu@qti.qualcomm.com
List-Id: linux-pm@vger.kernel.org

store_freq function of devfreq userspace governor
executes further, even if error is returned from sscanf,
this will result in setting up wrong frequency value.

Add proper error check to bail out if any error is returned.

Signed-off-by: Santosh Mardi <gsantosh@codeaurora.org>
---
 drivers/devfreq/governor_userspace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 77028c2..1d0c9cc 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -53,12 +53,15 @@ static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&devfreq->lock);
 	data = devfreq->data;
 
-	sscanf(buf, "%lu", &wanted);
+	err = sscanf(buf, "%lu", &wanted);
+	if (err != 1)
+		goto out;
 	data->user_frequency = wanted;
 	data->valid = true;
 	err = update_devfreq(devfreq);
 	if (err == 0)
 		err = count;
+out:
 	mutex_unlock(&devfreq->lock);
 	return err;
 }
-- 
1.9.1
