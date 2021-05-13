Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41BCC433B4
	for <linux-pm@archiver.kernel.org>; Thu, 13 May 2021 07:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9926143B
	for <linux-pm@archiver.kernel.org>; Thu, 13 May 2021 07:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhEMIBE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 May 2021 04:01:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231719AbhEMIBD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 May 2021 04:01:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80502ACB1;
        Thu, 13 May 2021 07:59:53 +0000 (UTC)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] cpufreq: intel_pstate: Force intel_pstate to load when HWP disabled in firmware
Date:   Thu, 13 May 2021 09:59:30 +0200
Message-Id: <20210513075930.22657-1-ggherdovich@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On CPUs succeeding SKX, eg. ICELAKE_X, intel_pstate doesn't load unless
CPUID advertises support for the HWP feature. Some OEMs, however, may offer
users the possibility to disable HWP from the BIOS config utility by
altering the output of CPUID.

Add the command line option "intel_pstate=hwp_broken_firmware" so that
intel_pstate still loads in that case, providing OS-driven frequency
scaling.

Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 Documentation/admin-guide/pm/intel_pstate.rst   | 7 +++++++
 drivers/cpufreq/intel_pstate.c                  | 7 ++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..278ec0718dc9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1951,6 +1951,13 @@
 			per_cpu_perf_limits
 			  Allow per-logical-CPU P-State performance control limits using
 			  cpufreq sysfs interface
+			hwp_broken_firmware
+			  Register intel_pstate as the scaling driver despite the
+			  hardware-managed P-states (HWP) feature being disabled in
+			  firmware. On CPU models succeeding SKX, intel_pstate expects
+			  HWP to be supported. Some OEMs may use firmware that hides the
+			  feature from the OS. With this option intel_pstate will
+			  load regardless.
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index df29b4f1f219..1e6f139d5b05 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -689,6 +689,13 @@ of them have to be prepended with the ``intel_pstate=`` prefix.
 	Use per-logical-CPU P-State limits (see `Coordination of P-state
 	Limits`_ for details).
 
+``hwp_broken_firmware``
+	Register ``intel_pstate`` as the scaling driver despite the
+	hardware-managed P-states (HWP) feature being disabled in firmware.
+
+	On CPU models succeeding SKX, ``intel_pstate`` expects HWP to be
+	supported. Some OEMs may use firmware that hides the feature from the
+	OS. With this option ``intel_pstate`` will load regardless.
 
 Diagnostics and Tuning
 ======================
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f0401064d7aa..8635251f86f2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2856,6 +2856,7 @@ static int intel_pstate_update_status(const char *buf, size_t size)
 static int no_load __initdata;
 static int no_hwp __initdata;
 static int hwp_only __initdata;
+static int hwp_broken_firmware __initdata;
 static unsigned int force_load __initdata;
 
 static int __init intel_pstate_msrs_not_valid(void)
@@ -3066,7 +3067,7 @@ static int __init intel_pstate_init(void)
 		}
 	} else {
 		id = x86_match_cpu(intel_pstate_cpu_ids);
-		if (!id) {
+		if (!id && !hwp_broken_firmware) {
 			pr_info("CPU model not supported\n");
 			return -ENODEV;
 		}
@@ -3149,6 +3150,10 @@ static int __init intel_pstate_setup(char *str)
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))
 		hwp_only = 1;
+	if (!strcmp(str, "hwp_broken_firmware")) {
+		pr_info("HWP disabled by firmware\n");
+		hwp_broken_firmware = 1;
+	}
 	if (!strcmp(str, "per_cpu_perf_limits"))
 		per_cpu_limits = true;
 
-- 
2.26.2

