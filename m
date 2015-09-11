From: Xiaolong Ye <yexl@marvell.com>
Subject: [PATCH] PM / devfreq: Fix incorrect type issue.
Date: Fri, 11 Sep 2015 11:05:23 +0800
Message-ID: <1441940723-12360-2-git-send-email-yexl@marvell.com>
References: <1441940723-12360-1-git-send-email-yexl@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441940723-12360-1-git-send-email-yexl@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yizhang@marvell.com, kliu5@marvell.com
Cc: Xiaolong Ye <yexl@marvell.com>
List-Id: linux-pm@vger.kernel.org

time_in_state in struct devfreq is defined as unsigned long, so
devm_kzalloc should use sizeof(unsigned long) as argument instead
of sizeof(unsigned int), otherwise it will cause unexpected result
in 64bit system.

Signed-off-by: Xiaolong Ye <yexl@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ca1b362..ac9845a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -482,7 +482,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 						devfreq->profile->max_state *
 						devfreq->profile->max_state,
 						GFP_KERNEL);
-	devfreq->time_in_state = devm_kzalloc(dev, sizeof(unsigned int) *
+	devfreq->time_in_state = devm_kzalloc(dev, sizeof(unsigned long) *
 						devfreq->profile->max_state,
 						GFP_KERNEL);
 	devfreq->last_stat_updated = jiffies;
-- 
1.7.9.5
