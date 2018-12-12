From: Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4] PM / devfreq: Restart previous governor if new governor fails to start
Date: Wed, 12 Dec 2018 19:23:13 +0530
Message-ID: <20181212135313.30268-1-sibis@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, skannan@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

If the new governor fails to start, switch back to old governor so that the
devfreq state is not left in some weird limbo.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---

V4:
* Removed prev_governor check.

V3:
* Fix NULL deref for real this time.
* Addressed some style preferences.

V2:
* Fixed typo in commit text
* Fixed potential NULL deref

 drivers/devfreq/devfreq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 141413067b5c..ba2875a0b90e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1024,7 +1024,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
-	struct devfreq_governor *governor;
+	const struct devfreq_governor *governor, *prev_governor;
 
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
@@ -1053,12 +1053,19 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 			goto out;
 		}
 	}
+	prev_governor = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
-	if (ret)
+	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
+		df->governor = prev_governor;
+		strncpy(df->governor_name, prev_governor->name,
+			DEVFREQ_NAME_LEN);
+		df->governor->event_handler(df, DEVFREQ_GOV_START,
+					    NULL);
+	}
 out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
