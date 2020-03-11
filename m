Return-Path: <SRS0=+pCq=44=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0302C10F25
	for <linux-pm@archiver.kernel.org>; Wed, 11 Mar 2020 07:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D2E21D56
	for <linux-pm@archiver.kernel.org>; Wed, 11 Mar 2020 07:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgCKHNo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:13:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:35662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHNo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 03:13:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 98773AF4E;
        Wed, 11 Mar 2020 07:13:42 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:13:41 +0100
Message-Id: <20200311071341.4339-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/cpufreq/cpufreq_stats.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index f9bcf0f3ea30..94d959a8e954 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -90,35 +90,35 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	if (policy->fast_switch_enabled)
 		return 0;
 
-	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
-	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
 		if (len >= PAGE_SIZE)
 			break;
-		len += snprintf(buf + len, PAGE_SIZE - len, "%9u ",
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
 				stats->freq_table[i]);
 	}
 	if (len >= PAGE_SIZE)
 		return PAGE_SIZE;
 
-	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	for (i = 0; i < stats->state_num; i++) {
 		if (len >= PAGE_SIZE)
 			break;
 
-		len += snprintf(buf + len, PAGE_SIZE - len, "%9u: ",
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u: ",
 				stats->freq_table[i]);
 
 		for (j = 0; j < stats->state_num; j++) {
 			if (len >= PAGE_SIZE)
 				break;
-			len += snprintf(buf + len, PAGE_SIZE - len, "%9u ",
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
 					stats->trans_table[i*stats->max_state+j]);
 		}
 		if (len >= PAGE_SIZE)
 			break;
-		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
+		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 	}
 
 	if (len >= PAGE_SIZE) {
-- 
2.16.4

