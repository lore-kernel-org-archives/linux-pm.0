From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 11/31] cpufreq/sfi: use kmemdup rather than duplicating its
 implementation
Date: Fri, 07 Aug 2015 09:59:17 +0200
Message-ID: <1438934377-4922-12-git-send-email-a.hajda@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:23212 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbbHGIAd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 04:00:33 -0400
In-reply-to: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/cpufreq/sfi-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
index ffa3389..992ce6f 100644
--- a/drivers/cpufreq/sfi-cpufreq.c
+++ b/drivers/cpufreq/sfi-cpufreq.c
@@ -45,12 +45,10 @@ static int sfi_parse_freq(struct sfi_table_header *table)
 	pentry = (struct sfi_freq_table_entry *)sb->pentry;
 	totallen = num_freq_table_entries * sizeof(*pentry);
 
-	sfi_cpufreq_array = kzalloc(totallen, GFP_KERNEL);
+	sfi_cpufreq_array = kmemdup(pentry, totallen, GFP_KERNEL);
 	if (!sfi_cpufreq_array)
 		return -ENOMEM;
 
-	memcpy(sfi_cpufreq_array, pentry, totallen);
-
 	return 0;
 }
 
-- 
1.9.1

