Return-Path: <SRS0=Cnqh=6G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA5C55185
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C85820724
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 14:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDVOlQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:41:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgDVOlP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 10:41:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 123C3ACF2;
        Wed, 22 Apr 2020 14:41:13 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] x86, sched: Prevent divisions by zero in frequency invariant accounting
Date:   Wed, 22 Apr 2020 16:40:55 +0200
Message-Id: <20200422144055.18171-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The product mcnt * arch_max_freq_ratio could be zero if it overflows u64.

For context, a large value for arch_max_freq_ratio would be 5000,
corresponding to a turbo_freq/base_freq ratio of 5 (normally it's more like
1500-2000). A large increment frequency for the MPERF counter would be 5GHz
(the base clock of all CPUs on the market today is less than that). With
these figures, a CPU would need to go without a scheduler tick for around 8
days for the u64 overflow to happen. It is unlikely, but the check is
warranted.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
---
 arch/x86/kernel/smpboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8c89e4d9ad28..fb71395cbcad 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2055,14 +2055,14 @@ void arch_scale_freq_tick(void)
 
 	acnt = aperf - this_cpu_read(arch_prev_aperf);
 	mcnt = mperf - this_cpu_read(arch_prev_mperf);
-	if (!mcnt)
-		return;
 
 	this_cpu_write(arch_prev_aperf, aperf);
 	this_cpu_write(arch_prev_mperf, mperf);
 
 	acnt <<= 2*SCHED_CAPACITY_SHIFT;
 	mcnt *= arch_max_freq_ratio;
+	if (!mcnt)
+		return;
 
 	freq_scale = div64_u64(acnt, mcnt);
 
-- 
2.16.4

