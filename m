From: Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH v3] PM / devfreq: Restart previous governor if new governor fails to start
Date: Wed, 26 Oct 2016 12:17:05 -0700
Message-ID: <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbcJZTRN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 15:17:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saravana Kannan <skannan@codeaurora.org>, cw00.choi@samsung.com

If the new governor fails to start, switch back to old governor so that the
devfreq state is not left in some weird limbo.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
* Fix NULL deref for real this time.
* Addressed some style preferences.

 drivers/devfreq/devfreq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3ea76..77c41a5 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	struct devfreq *df = to_devfreq(dev);
 	int ret;
 	char str_governor[DEVFREQ_NAME_LEN + 1];
-	struct devfreq_governor *governor;
+	const struct devfreq_governor *governor, *prev_governor;
 
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
@@ -944,12 +944,21 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
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
+		if (prev_governor) {
+			df->governor = prev_governor;
+			strncpy(df->governor_name, prev_governor->name,
+				DEVFREQ_NAME_LEN);
+			df->governor->event_handler(df, DEVFREQ_GOV_START,
+						    NULL);
+		}
+	}
 out:
 	mutex_unlock(&devfreq_list_lock);
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

