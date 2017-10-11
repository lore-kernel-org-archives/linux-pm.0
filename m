From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 6/8] PM / devfreq: Remove unneeded conditional statement
Date: Wed, 11 Oct 2017 12:09:22 +0900
Message-ID: <1507691364-3899-7-git-send-email-cw00.choi@samsung.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030947epcas1p3172d6bb79615a17e08164a150031262e@epcas1p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64241 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755585AbdJKDJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 23:09:49 -0400
In-reply-to: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The commit 0ec09ac2cebe9 ("PM / devfreq: Set the freq_table of devfreq
device") initializes the freq_table array of each devfreq device always.
In result, it is unneeded to check whether profile->freq_table is NULL
or not.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 3b9662ffe603..b28810cae7ee 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -315,10 +315,9 @@ int update_devfreq(struct devfreq *devfreq)
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
