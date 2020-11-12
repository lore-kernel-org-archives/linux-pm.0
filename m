Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254DCC5519F
	for <linux-pm@archiver.kernel.org>; Thu, 12 Nov 2020 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D122522227
	for <linux-pm@archiver.kernel.org>; Thu, 12 Nov 2020 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgKLS0b (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:26:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:59028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgKLS0Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Nov 2020 13:26:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A086B05D;
        Thu, 12 Nov 2020 18:26:22 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Doug Smythies <dsmythies@telus.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v4 3/3] x86: Print ratio freq_max/freq_base used in frequency invariance calculations
Date:   Thu, 12 Nov 2020 19:26:14 +0100
Message-Id: <20201112182614.10700-4-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112182614.10700-1-ggherdovich@suse.cz>
References: <20201112182614.10700-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The value freq_max/freq_base is a fundamental component of frequency
invariance calculations. It may come from a variety of sources such as MSRs
or ACPI data, tracking it down when troubleshooting a system could be
non-trivial. It is worth saving it in the kernel logs.

 # dmesg | grep 'Estimated ratio of average max'
 [   14.024036] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1289

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 arch/x86/kernel/smpboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c5dd5f6199d9..3577bb756d64 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2110,6 +2110,7 @@ static void init_freq_invariance(bool secondary, bool cppc_ready)
 	if (ret) {
 		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
+		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
 	}
-- 
2.26.2

