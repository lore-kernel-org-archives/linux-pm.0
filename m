From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 09/12] PM / devfreq: Show whole available frequencies
Date: Thu, 24 Aug 2017 10:42:56 +0900
Message-ID: <1503538979-22693-10-git-send-email-cw00.choi@samsung.com>
References: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014300epcas2p2642c98590f3592ba814e421c6584a7b5@epcas2p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45180 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdHXBnC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 21:43:02 -0400
In-reply-to: <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc: rafael.j.wysocki@intel.com, chanwoo@kernel.org, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The commit a76caf55e5b35 ("thermal: Add devfreq cooling") allows
the devfreq device to use the cooling device. When the cooling down
are required, the devfreq_cooling.c disables the OPP entry with
the dev_pm_opp_disable(). In result, 'available_frequencies'[1]
sysfs node never came to show the whole available frequencies.
[1] /sys/class/devfreq/.../available_frequencies

So, this patch uses the 'freq_table' in the 'struct devfreq_dev_profile'
in order to show the whole available frequencies.
- If 'freq_table' is NULL, devfreq core initializes them by using OPP values.
- If 'freq_table' is initialized, devfreq core just uses the 'freq_table'.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8b0bbfa0a50b..d8ff16419452 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1209,21 +1209,12 @@ static ssize_t available_frequencies_show(struct device *d,
 					  char *buf)
 {
 	struct devfreq *df = to_devfreq(d);
-	struct device *dev = df->dev.parent;
-	struct dev_pm_opp *opp;
 	ssize_t count = 0;
-	unsigned long freq = 0;
-
-	do {
-		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-		if (IS_ERR(opp))
-			break;
+	int i;
 
-		dev_pm_opp_put(opp);
+	for (i = 0; i < df->profile->max_state; i++)
 		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
-				   "%lu ", freq);
-		freq++;
-	} while (1);
+				   "%lu ", df->profile->freq_table[i]);
 
 	/* Truncate the trailing space */
 	if (count)
-- 
1.9.1
