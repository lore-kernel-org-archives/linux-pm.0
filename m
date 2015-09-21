From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [PATCH] PM / devfreq: Fix governor_store()
Date: Mon, 21 Sep 2015 20:23:52 +0200
Message-ID: <1442859832-8900-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:54181 "EHLO
	smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932086AbbIUS3s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 14:29:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Writing the currently set governor into sysfs currently
seems to fail.
Fix this by setting the return code to zero before
leaving governor_store().

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/devfreq/devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 3927ed9..4f1b0ce 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -795,8 +795,10 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 		ret = PTR_ERR(governor);
 		goto out;
 	}
-	if (df->governor == governor)
+	if (df->governor == governor) {
+		ret = 0;
 		goto out;
+	}
 
 	if (df->governor) {
 		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
-- 
2.0.5

