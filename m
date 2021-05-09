Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA29EC433ED
	for <linux-pm@archiver.kernel.org>; Sun,  9 May 2021 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4FC613E8
	for <linux-pm@archiver.kernel.org>; Sun,  9 May 2021 09:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhEIJ2N (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 9 May 2021 05:28:13 -0400
Received: from cumulus.eginity.com ([199.168.187.4]:43302 "EHLO
        nimbus.eginity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhEIJ2N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 May 2021 05:28:13 -0400
X-Greylist: delayed 1092 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 May 2021 05:28:13 EDT
Received: from [192.168.0.10] (unknown [68.204.106.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmerillat@eginity.com)
        by nimbus.eginity.com (Postfix) with ESMTPSA id 18B632043F;
        Sun,  9 May 2021 05:08:55 -0400 (EDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.5 at nimbus
DKIM-Filter: OpenDKIM Filter v2.9.2 nimbus.eginity.com 18B632043F
To:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Dan Merillat <git@dan.eginity.com>
Subject: [PATCH] tools/power/turbostat: fix dump for AMD cpus
Message-ID: <c60a2dcd-acc4-a9da-6518-fc05165ae4ef@eginity.com>
Date:   Sun, 9 May 2021 05:08:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

turbostat --Dump exits early with status 243 (-13)

get_counters() calls get_msr_sum() on zen CPUS
for MSR_PKG_ENERGY_STAT, but per_cpu_msr_sum
has not been initialized.

Signed-off-by: Dan Merillat <git@dan.eginity.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c
b/tools/power/x86/turbostat/turbostat.c
index 47d3ba895d6d..c133fef270f6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6432,6 +6432,8 @@ int main(int argc, char **argv)

 	turbostat_init();

+	msr_sum_record();
+
 	/* dump counters and exit */
 	if (dump_only)
 		return get_and_dump_counters();
@@ -6443,7 +6445,6 @@ int main(int argc, char **argv)
 		return 0;
 	}

-	msr_sum_record();
 	/*
 	 * if any params left, it must be a command to fork
 	 */
-- 
2.31.1

