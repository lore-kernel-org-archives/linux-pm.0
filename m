From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/3] PM / devfreq: Fix wrong trans_stat of passive devfreq
 device
Date: Wed, 18 Jan 2017 15:56:50 +0900
Message-ID: <1484722611-10555-3-git-send-email-cw00.choi@samsung.com>
References: <1484722611-10555-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170118065653epcas5p2da6963fbad338a3c402c7d99f5e8473f@epcas5p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1484722611-10555-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Until now, the trans_stat information of passive devfreq is not updated.
This patch updates the trans_stat information after setting the target
frequency of passive devfreq device.

Fixes: 996133119f57 ("PM / devfreq: Add new passive governor")
Cc: stable@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c          | 3 ++-
 drivers/devfreq/governor.h         | 2 ++
 drivers/devfreq/governor_passive.c | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a2c575a5a9ab..6c560af2a801 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -135,7 +135,7 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
  * @devfreq:	the devfreq instance
  * @freq:	the update target frequency
  */
-static int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
+int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 {
 	int lev, prev_lev, ret = 0;
 	unsigned long cur_time;
@@ -171,6 +171,7 @@ static int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
 	devfreq->last_stat_updated = cur_time;
 	return ret;
 }
+EXPORT_SYMBOL(devfreq_update_status);
 
 /**
  * find_devfreq_governor() - find devfreq governor from name
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index fad7d6321978..71576b8bdfef 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -38,4 +38,6 @@ extern void devfreq_interval_update(struct devfreq *devfreq,
 extern int devfreq_add_governor(struct devfreq_governor *governor);
 extern int devfreq_remove_governor(struct devfreq_governor *governor);
 
+extern int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
+
 #endif /* _GOVERNOR_H */
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 9ef46e2592c4..443be65f4561 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -112,6 +112,11 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
 	if (ret < 0)
 		goto out;
 
+	if (devfreq->profile->freq_table
+		&& (devfreq_update_status(devfreq, freq)))
+		dev_err(&devfreq->dev,
+			"Couldn't update frequency transition information.\n");
+
 	devfreq->previous_freq = freq;
 
 out:
-- 
1.9.1
