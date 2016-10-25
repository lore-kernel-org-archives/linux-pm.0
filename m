From: Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH] PM / devfreq: Restart previous governor if new governor fails to start
Date: Mon, 24 Oct 2016 18:59:59 -0700
Message-ID: <1477360800-11509-1-git-send-email-skannan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

If the new governor fails to start, switch back to old governor so that the
devfreq state is not left if some weird limbo.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 drivers/devfreq/devfreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3ea76..243253e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
-	struct devfreq_governor *governor;
+	const struct devfreq_governor *governor, *prev_gov;
 
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
@@ -944,12 +944,17 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 			goto out;
 		}
 	}
+	prev_gov = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
 	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
-	if (ret)
+	if (ret) {
 		dev_warn(dev, "%s: Governor %s not started(%d)\n",
 			 __func__, df->governor->name, ret);
+		df->governor = prev_gov;
+		strncpy(df->governor_name, prev_gov->name, DEVFREQ_NAME_LEN);
+		df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
+	}
 out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
