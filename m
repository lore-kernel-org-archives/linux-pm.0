Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED4EC4361B
	for <linux-pm@archiver.kernel.org>; Mon, 14 Dec 2020 12:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C4424052
	for <linux-pm@archiver.kernel.org>; Mon, 14 Dec 2020 12:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407162AbgLNMJI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 14 Dec 2020 07:09:08 -0500
Received: from foss.arm.com ([217.140.110.172]:46462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbgLNMJC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Dec 2020 07:09:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1515E31B;
        Mon, 14 Dec 2020 04:08:17 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF2C23F66B;
        Mon, 14 Dec 2020 04:08:15 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] ACPI: processor: fix NONE coordination for domain mapping failure
Date:   Mon, 14 Dec 2020 12:07:40 +0000
Message-Id: <20201214120740.10948-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For errors parsing the _PSD domains, a separate domain is returned for
each CPU in the failed _PSD domain with no coordination (as per previous
comment). But contrary to the intention, the code was setting
CPUFREQ_SHARED_TYPE_ALL as coordination type.

Change shared_type to CPUFREQ_SHARED_TYPE_NONE in case of errors parsing
the domain information. The function still returns the error and the caller
is free to bail out the domain initialisation altogether in that case.

Given that both functions return domains with a single CPU, this change
does not affect the functionality, but clarifies the intention.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Subject edit ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Hi guys,

I'm sending v2 of some of the patches at [1] in light of the discussions
at [2].

This patch is a trivial rebase on linux next 20201211, submitted separately
due to its lack of dependency on the other patches.

[1] https://lore.kernel.org/linux-pm/20201105125524.4409-1-ionela.voinescu@arm.com/#t
[2] https://lore.kernel.org/linux-pm/20201210142139.20490-1-yousaf.kaukab@suse.com/

Thank you,
Ionela.

 drivers/acpi/cppc_acpi.c         | 2 +-
 drivers/acpi/processor_perflib.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a852dc4927f7..62f55db443c1 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -512,7 +512,7 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
 		/* Assume no coordination on any error parsing domain info */
 		cpumask_clear(pr->shared_cpu_map);
 		cpumask_set_cpu(i, pr->shared_cpu_map);
-		pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+		pr->shared_type = CPUFREQ_SHARED_TYPE_NONE;
 	}
 out:
 	free_cpumask_var(covered_cpus);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 0dcedd652807..32f0f554ccae 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -708,7 +708,7 @@ int acpi_processor_preregister_performance(
 		if (retval) {
 			cpumask_clear(pr->performance->shared_cpu_map);
 			cpumask_set_cpu(i, pr->performance->shared_cpu_map);
-			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_NONE;
 		}
 		pr->performance = NULL; /* Will be set for real in register */
 	}
-- 
2.29.2.dirty

