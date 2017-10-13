From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 6/8] PM / devfreq: Remove unneeded conditional statement
Date: Fri, 13 Oct 2017 16:48:22 +0900
Message-ID: <1507880904-31956-7-git-send-email-cw00.choi@samsung.com>
References: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171013074835epcas1p378b24f20d4feb973aef5319445b81570@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The freq_table array of each devfreq device is always not NULL.
In result, it is unneeded to check whether profile->freq_table
is NULL or not.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 534ead60d1cc..191d4de7bd87 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -311,10 +311,9 @@ int update_devfreq(struct devfreq *devfreq)
 	freqs.new = freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 
-	if (devfreq->profile->freq_table)
-		if (devfreq_update_status(devfreq, freq))
-			dev_err(&devfreq->dev,
-				"Couldn't update frequency transition information.\n");
+	if (devfreq_update_status(devfreq, freq))
+		dev_err(&devfreq->dev,
+			"Couldn't update frequency transition information.\n");
 
 	devfreq->previous_freq = freq;
 	return err;
-- 
1.9.1
