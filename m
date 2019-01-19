From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/3] PM / devfreq: fix indentation in devfreq_add_device()
Date: Sat, 19 Jan 2019 11:04:52 -0500
Message-ID: <20190119160454.23151-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

To beautify the code format.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/devfreq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..076b1c2f40a4 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -683,16 +683,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_out;
 	}
 
-	devfreq->trans_table =
-		devm_kzalloc(&devfreq->dev,
-			     array3_size(sizeof(unsigned int),
-					 devfreq->profile->max_state,
-					 devfreq->profile->max_state),
-			     GFP_KERNEL);
+	devfreq->trans_table = devm_kzalloc(&devfreq->dev,
+					    array3_size(sizeof(unsigned int),
+					    devfreq->profile->max_state,
+					    devfreq->profile->max_state),
+					    GFP_KERNEL);
 	devfreq->time_in_state = devm_kcalloc(&devfreq->dev,
-						devfreq->profile->max_state,
-						sizeof(unsigned long),
-						GFP_KERNEL);
+					      devfreq->profile->max_state,
+					      sizeof(unsigned long),
+					      GFP_KERNEL);
 	devfreq->last_stat_updated = jiffies;
 
 	srcu_init_notifier_head(&devfreq->transition_notifier_list);
-- 
2.17.0
