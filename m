Return-Path: <SRS0=0y+j=5Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30F8C43331
	for <linux-pm@archiver.kernel.org>; Tue, 31 Mar 2020 18:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52622072E
	for <linux-pm@archiver.kernel.org>; Tue, 31 Mar 2020 18:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCaSpr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:45:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:10382 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgCaSpq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Mar 2020 14:45:46 -0400
IronPort-SDR: mTtNzs03Q8rvYq9ktYTsukjcq5ucyFf/p6v0dEWnzgj95Ospz+s4OzoS6ZE+6MQvrh1Hs1nRIR
 FeKYaK6NYqng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 11:45:46 -0700
IronPort-SDR: qvn1zYRdK/XkmHErCv2cpdl+ognbMXi0rz86jQvqC/WmLvJGXFKrSMn2Sop3NAzS1GF6qZPo7R
 qaIUJwtqq7YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="422396560"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2020 11:45:44 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC] tools/power turbostat: Make the energy variable to be 64 bit
Date:   Wed,  1 Apr 2020 02:44:28 +0800
Message-Id: <f7ff1fe43abd40b21159ba5ac871b1a0420e0c22.1585679838.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585679838.git.yu.c.chen@intel.com>
References: <cover.1585679838.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the energy variable from 32bit to 64bit, so that it
can records long time duration.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 30 ++++++++++++---------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..95f3047e94ae 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -211,12 +211,12 @@ struct pkg_data {
 	long long gfx_rc6_ms;
 	unsigned int gfx_mhz;
 	unsigned int package_id;
-	unsigned int energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
-	unsigned int energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
-	unsigned int energy_cores;	/* MSR_PP0_ENERGY_STATUS */
-	unsigned int energy_gfx;	/* MSR_PP1_ENERGY_STATUS */
-	unsigned int rapl_pkg_perf_status;	/* MSR_PKG_PERF_STATUS */
-	unsigned int rapl_dram_perf_status;	/* MSR_DRAM_PERF_STATUS */
+	unsigned long long energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
+	unsigned long long energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
+	unsigned long long energy_cores;	/* MSR_PP0_ENERGY_STATUS */
+	unsigned long long energy_gfx;	/* MSR_PP1_ENERGY_STATUS */
+	unsigned long long rapl_pkg_perf_status;	/* MSR_PKG_PERF_STATUS */
+	unsigned long long rapl_dram_perf_status;	/* MSR_DRAM_PERF_STATUS */
 	unsigned int pkg_temp_c;
 	unsigned long long counter[MAX_ADDED_COUNTERS];
 } *package_even, *package_odd;
@@ -858,13 +858,13 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "pc10: %016llX\n", p->pc10);
 		outp += sprintf(outp, "cpu_lpi: %016llX\n", p->cpu_lpi);
 		outp += sprintf(outp, "sys_lpi: %016llX\n", p->sys_lpi);
-		outp += sprintf(outp, "Joules PKG: %0X\n", p->energy_pkg);
-		outp += sprintf(outp, "Joules COR: %0X\n", p->energy_cores);
-		outp += sprintf(outp, "Joules GFX: %0X\n", p->energy_gfx);
-		outp += sprintf(outp, "Joules RAM: %0X\n", p->energy_dram);
-		outp += sprintf(outp, "Throttle PKG: %0X\n",
+		outp += sprintf(outp, "Joules PKG: %0llX\n", p->energy_pkg);
+		outp += sprintf(outp, "Joules COR: %0llX\n", p->energy_cores);
+		outp += sprintf(outp, "Joules GFX: %0llX\n", p->energy_gfx);
+		outp += sprintf(outp, "Joules RAM: %0llX\n", p->energy_dram);
+		outp += sprintf(outp, "Throttle PKG: %0llX\n",
 			p->rapl_pkg_perf_status);
-		outp += sprintf(outp, "Throttle RAM: %0X\n",
+		outp += sprintf(outp, "Throttle RAM: %0llX\n",
 			p->rapl_dram_perf_status);
 		outp += sprintf(outp, "PTM: %dC\n", p->pkg_temp_c);
 
@@ -1210,11 +1210,7 @@ void format_all_counters(struct thread_data *t, struct core_data *c, struct pkg_
 }
 
 #define DELTA_WRAP32(new, old)			\
-	if (new > old) {			\
-		old = new - old;		\
-	} else {				\
-		old = 0x100000000 + new - old;	\
-	}
+	old = ((((unsigned long long)new << 32) - ((unsigned long long)old << 32)) >> 32);
 
 int
 delta_package(struct pkg_data *new, struct pkg_data *old)
-- 
2.17.1

