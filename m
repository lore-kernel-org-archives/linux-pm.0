From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v5 6/7] PM / devfreq: Remove unneeded conditional statement
Date: Mon, 23 Oct 2017 10:32:11 +0900
Message-ID: <1508722332-10628-7-git-send-email-cw00.choi@samsung.com>
References: <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171023013215epcas1p1d25606a511fb6dc2c037cc978ad5dd5a@epcas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28711 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932289AbdJWBcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Oct 2017 21:32:25 -0400
In-reply-to: <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The freq_table array of each devfreq device is always not NULL.
In result, it is unneeded to check whether profile->freq_table
is NULL or not.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/devfreq/devfreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 381f92e5e794..78fb496ecb4e 100644
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
