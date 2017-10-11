From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 4/8] PM / devfreq: Show the all available frequencies
Date: Wed, 11 Oct 2017 12:09:20 +0900
Message-ID: <1507691364-3899-5-git-send-email-cw00.choi@samsung.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
        <CGME20171011030946epcas1p30ca5f54e1dd4df92cefd19a385423a41@epcas1p3.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50120 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755039AbdJKDJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 23:09:49 -0400
In-reply-to: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The commit a76caf55e5b35 ("thermal: Add devfreq cooling") allows
the devfreq device to use the cooling device. When the cooling down
are required, the devfreq_cooling.c disables the OPP entry with
the dev_pm_opp_disable(). In result, 'available_frequencies'[1]
sysfs node never came to show the all available frequencies.
[1] /sys/class/devfreq/.../available_frequencies

So, this patch uses the 'freq_table' in the 'struct devfreq_dev_profile'
in order to show the all available frequencies.
- If 'freq_table' is NULL, devfreq core initializes them by using OPP values.
- If 'freq_table' is initialized, devfreq core just uses the 'freq_table'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 799a0cf75d39..1c4b377cacfb 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1185,22 +1185,26 @@ static ssize_t available_frequencies_show(struct device *d,
 					  char *buf)
 {
 	struct devfreq *df = to_devfreq(d);
-	struct device *dev = df->dev.parent;
-	struct dev_pm_opp *opp;
 	ssize_t count = 0;
-	unsigned long freq = 0;
+	unsigned long *freq_table;
+	int i, max_state;
 
-	do {
-		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-		if (IS_ERR(opp))
-			break;
+	mutex_lock(&df->lock);
 
-		dev_pm_opp_put(opp);
-		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
-				   "%lu ", freq);
-		freq++;
-	} while (1);
+	freq_table = df->profile->freq_table;
+	max_state = df->profile->max_state;
 
+	if (freq_table[0] < freq_table[max_state - 1]) {
+		for (i = 0; i < max_state; i++)
+			count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
+					"%lu ", freq_table[i]);
+	} else {
+		for (i = max_state - 1; i >= 0 ; i--)
+			count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
+					"%lu ", freq_table[i]);
+	}
+
+	mutex_unlock(&df->lock);
 	/* Truncate the trailing space */
 	if (count)
 		count--;
-- 
1.9.1
