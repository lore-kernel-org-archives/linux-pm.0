From: Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH] PM / devfreq: Allocate memory using the right data type
Date: Tue, 15 Jul 2014 20:10:43 -0700
Message-ID: <1405480243-25915-1-git-send-email-skannan@codeaurora.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Suman Tatiraju <sumant@codeaurora.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

From: Suman Tatiraju <sumant@codeaurora.org>

Long and int have different sizes on a 64-bit machine. Allocate
memory for the time_in_state table using the right data type.

Change-Id: I335277674018c0ea759aa0996309d52578ea1fd5
Signed-off-by: Suman Tatiraju <sumant@codeaurora.org>
Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 drivers/devfreq/devfreq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 65eed38..349e28ea 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -483,9 +483,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 						devfreq->profile->max_state *
 						devfreq->profile->max_state,
 						GFP_KERNEL);
-	devfreq->time_in_state = devm_kzalloc(dev, sizeof(unsigned int) *
-						devfreq->profile->max_state,
-						GFP_KERNEL);
+	devfreq->time_in_state = devm_kzalloc(dev,
+					sizeof(*(devfreq->time_in_state)) *
+					devfreq->profile->max_state,
+					GFP_KERNEL);
 	devfreq->last_stat_updated = jiffies;
 
 	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
-- 
1.8.2.1

The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
