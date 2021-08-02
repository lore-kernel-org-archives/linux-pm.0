Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEDFC19F34
	for <linux-pm@archiver.kernel.org>; Mon,  2 Aug 2021 20:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8011D60F35
	for <linux-pm@archiver.kernel.org>; Mon,  2 Aug 2021 20:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhHBUqd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:46:33 -0400
Received: from foss.arm.com ([217.140.110.172]:40308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232294AbhHBUqd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Aug 2021 16:46:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACBDE11D4;
        Mon,  2 Aug 2021 13:46:22 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.10.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F30CF3F70D;
        Mon,  2 Aug 2021 13:46:19 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, nicola.mazzucato@arm.com,
        lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: arm_scmi: Fix error path when allocation failed
Date:   Mon,  2 Aug 2021 21:45:50 +0100
Message-Id: <20210802204550.12647-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Print warning and return an error which would stop the initialization
when cpumask allocation failed.

Fixes: 80a064dbd556 ("scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM")
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ec9a87ca2dbb..b159123e68fd 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -133,8 +133,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
-		ret = -ENOMEM;
+	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL)) {
+		dev_warn(cpu_dev, "failed to allocate cpumask\n");
+		return -ENOMEM;
+	}
 
 	/* Obtain CPUs that share SCMI performance controls */
 	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
-- 
2.17.1

