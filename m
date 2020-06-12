Return-Path: <SRS0=T5KG=7Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB590C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 12 Jun 2020 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A192063A
	for <linux-pm@archiver.kernel.org>; Fri, 12 Jun 2020 18:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFLSKB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:10:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:52458 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgFLSKA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Jun 2020 14:10:00 -0400
IronPort-SDR: +UuUjlDaNx9zn/ne7Pkh6pkw+dp3DIDk4FZcpNZjMD9v1hDV+kOvW5ISpu/oEAgpjlp15+n7JV
 AHDY2dM3/CMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 11:10:00 -0700
IronPort-SDR: nSKNjD0AvxXeQx2X31ulLTYloZsV9FYfxW7IdEu2UWO1KcPhBaLilMcJMr1wOblTLFJWFGObQq
 LQoG5GhaSBjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="261063588"
Received: from amritada-mobl.amr.corp.intel.com (HELO spandruv-mobl3.amr.corp.intel.com) ([10.254.106.203])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2020 11:09:59 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] cpufreq: intel_pstate: Add additional OOB enabling bit
Date:   Fri, 12 Jun 2020 11:09:57 -0700
Message-Id: <20200612180957.1018235-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add additional bit for OOB (Out of band) enabling of P-states. In this
case intel_pstate shouldn't load. Currently, only "BIT(8) == 1" of the
MSR MSR_MISC_PWR_MGMT is considered as OOB. Also add "BIT(18) == 1" as
OOB condition.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
   - As suggested by Doug add OOB in debug message
   - Atleast added local definition of OOB mask

 drivers/cpufreq/intel_pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8e23a698ce04..4e9bfd2509b8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2677,6 +2677,7 @@ static struct acpi_platform_list plat_info[] __initdata = {
 	{ } /* End */
 };
 
+#define BITMASK_OOB	(BIT(8) | BIT(18))
 static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 {
 	const struct x86_cpu_id *id;
@@ -2686,8 +2687,9 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
 		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
-		if (misc_pwr & (1 << 8)) {
-			pr_debug("Bit 8 in the MISC_PWR_MGMT MSR set\n");
+		if (misc_pwr & BITMASK_OOB) {
+			pr_debug("Bit 8 or 18 in the MISC_PWR_MGMT MSR set\n");
+			pr_debug("P states are controlled in Out of Band mode by the firmware/hardware\n");
 			return true;
 		}
 	}
-- 
2.24.1

