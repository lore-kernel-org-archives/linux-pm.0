From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 02/12] PM / devfreq: Fix locking range for making the
 frequency table
Date: Thu, 24 Aug 2017 10:42:49 +0900
Message-ID: <1503538979-22693-3-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p33d211dd0f29ebee0fc2fd7415d8294d9@epcas2p3.samsung.com>
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: stable-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Even if the freq_table is included in the struct devfreq,
the commit 0ec09ac2cebe ("PM / devfreq: Set the freq_table
of devfreq device") set the frequency table outside the mutex locking.

So, this patch initializes the frequency table within the mutex locking.

Cc: stable@vger.kernel.org
Fixes: 0ec09ac2cebe ("PM / devfreq: Set the freq_table of devfreq device")
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a1c4ee818614..3c5ccb96e165 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -553,11 +553,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
-	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
-		mutex_unlock(&devfreq->lock);
+	if (!devfreq->profile->max_state && !devfreq->profile->freq_table)
 		devfreq_set_freq_table(devfreq);
-		mutex_lock(&devfreq->lock);
-	}
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
-- 
1.9.1
