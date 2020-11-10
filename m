Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF2EC55ABD
	for <linux-pm@archiver.kernel.org>; Tue, 10 Nov 2020 18:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3572168B
	for <linux-pm@archiver.kernel.org>; Tue, 10 Nov 2020 18:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgKJSbH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:31:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:34534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgKJSbH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 13:31:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C75F4ABD1;
        Tue, 10 Nov 2020 18:31:05 +0000 (UTC)
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
Subject: [PATCH v2 0/3] Add support for frequency invariance to AMD EPYC Zen2
Date:   Tue, 10 Nov 2020 19:30:51 +0100
Message-Id: <20201110183054.15883-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v1 at https://lore.kernel.org/lkml/20201110083936.31994-1-ggherdovich@suse.cz/

Changes wrt v1:

- made initialization safe under CPU hotplug.
  The function init_freq_invariance_cppc now lets only the first caller
  into init_freq_invariance().

Giovanni Gherdovich (2):
  x86, sched: Use midpoint of max_boost and max_P for frequency
    invariance on AMD EPYC
  x86: Print ratio freq_max/freq_base used in frequency invariance
    calculations

Nathan Fontenot (1):
  x86, sched: Calculate frequency invariance for AMD systems

 arch/x86/include/asm/topology.h |  8 ++++
 arch/x86/kernel/smpboot.c       | 84 +++++++++++++++++++++++++++++++--
 drivers/acpi/cppc_acpi.c        |  3 ++
 3 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.26.2

