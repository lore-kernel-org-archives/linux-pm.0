Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF3DC4338F
	for <linux-pm@archiver.kernel.org>; Tue,  3 Aug 2021 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50B360EFD
	for <linux-pm@archiver.kernel.org>; Tue,  3 Aug 2021 09:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhHCJII (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Aug 2021 05:08:08 -0400
Received: from foss.arm.com ([217.140.110.172]:45080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234814AbhHCJII (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 05:08:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 647DE11D4;
        Tue,  3 Aug 2021 02:07:57 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.9.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3DDB3F40C;
        Tue,  3 Aug 2021 02:07:53 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, nicola.mazzucato@arm.com,
        lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] cpufreq: arm_scmi: Fix error path when allocation failed
Date:   Tue,  3 Aug 2021 10:07:44 +0100
Message-Id: <20210803090744.12143-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Stop the initialization when cpumask allocation failed and return an
error.

Fixes: 80a064dbd556 ("scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM")
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
changes:
v2:
- removed dev_warn() since it's not needed in this case
- adjusted the patch description

 drivers/cpufreq/scmi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ec9a87ca2dbb..75f818d04b48 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -134,7 +134,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
-		ret = -ENOMEM;
+		return -ENOMEM;
 
 	/* Obtain CPUs that share SCMI performance controls */
 	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
-- 
2.17.1

