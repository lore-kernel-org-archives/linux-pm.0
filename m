Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C79C54EE9
	for <linux-pm@archiver.kernel.org>; Fri, 16 Sep 2022 12:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIPL77 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Sep 2022 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIPL76 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2022 07:59:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E914183B0
        for <linux-pm@vger.kernel.org>; Fri, 16 Sep 2022 04:59:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="286016306"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="286016306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 04:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="862715451"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2022 04:59:52 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Len Brown <lenb@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rui Zhang <rui.zhang@intel.com>, Yu Chen <yu.c.chen@intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] turbostat: do not dump TRL if turbo is not supported
Date:   Fri, 16 Sep 2022 14:59:50 +0300
Message-Id: <20220916115950.53961-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Do not dump turbo ratio limits if platform does not support turbo, because it
is confusing and the TRL MSRs may even include misleading information. And they
are not supposed to be relied on if turbo is not supported.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 831dc32d45fa..d0aa72827c71 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -230,6 +230,7 @@ unsigned int do_slm_cstates;
 unsigned int use_c1_residency_msr;
 unsigned int has_aperf;
 unsigned int has_epb;
+unsigned int has_turbo;
 unsigned int is_hybrid;
 unsigned int do_irtl_snb;
 unsigned int do_irtl_hsw;
@@ -4080,13 +4081,11 @@ static void remove_underbar(char *s)
 	*to = 0;
 }
 
-static void dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
+static void dump_turbo_ratio_info(unsigned int family, unsigned int model)
 {
-	if (!do_nhm_platform_info)
+	if (!has_turbo)
 		return;
 
-	dump_nhm_platform_info();
-
 	if (has_hsw_turbo_ratio_limit(family, model))
 		dump_hsw_turbo_ratio_limits();
 
@@ -4108,7 +4107,15 @@ static void dump_cstate_pstate_config_info(unsigned int family, unsigned int mod
 
 	if (has_config_tdp(family, model))
 		dump_config_tdp();
+}
 
+static void dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
+{
+	if (!do_nhm_platform_info)
+		return;
+
+	dump_nhm_platform_info();
+	dump_turbo_ratio_info(family, model);
 	dump_nhm_cst_cfg();
 }
 
@@ -5505,7 +5512,6 @@ void process_cpuid()
 {
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int fms, family, model, stepping, ecx_flags, edx_flags;
-	unsigned int has_turbo;
 	unsigned long long ucode_patch = 0;
 
 	eax = ebx = ecx = edx = 0;
-- 
2.37.3

