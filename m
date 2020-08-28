Return-Path: <SRS0=beHt=CG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C13C433E2
	for <linux-pm@archiver.kernel.org>; Fri, 28 Aug 2020 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4852A20C56
	for <linux-pm@archiver.kernel.org>; Fri, 28 Aug 2020 17:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgH1Rdz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:33:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgH1Rdz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 13:33:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A11FD6E;
        Fri, 28 Aug 2020 10:33:54 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 07EC63F71F;
        Fri, 28 Aug 2020 10:33:52 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v4 1/5] arch_topology: validate input frequencies to arch_set_freq_scale()
Date:   Fri, 28 Aug 2020 18:32:59 +0100
Message-Id: <20200828173303.11939-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828173303.11939-1-ionela.voinescu@arm.com>
References: <20200828173303.11939-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current frequency passed to arch_set_freq_scale() could end up
being 0, signaling an error in setting a new frequency. Also, if the
maximum frequency in 0, this will result in a division by 0 error.

Therefore, validate these input values before using them for the
setting of the frequency scale factor.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/base/arch_topology.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 75f72d684294..5708eb724790 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -33,6 +33,11 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 	unsigned long scale;
 	int i;
 
+	if (unlikely(!cur_freq || !max_freq)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
 	/*
 	 * If the use of counters for FIE is enabled, just return as we don't
 	 * want to update the scale factor with information from CPUFREQ.
-- 
2.17.1

