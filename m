Return-Path: <SRS0=YPYM=VB=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6DC0651F
	for <linux-pm@archiver.kernel.org>; Thu,  4 Jul 2019 16:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB59218D0
	for <linux-pm@archiver.kernel.org>; Thu,  4 Jul 2019 16:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfGDQfB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:35:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:33035 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfGDQfB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 12:35:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="169480512"
Received: from conghuic-mobl.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.172.41])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 09:34:59 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 08/13] intel_rapl: cleanup hardcoded MSR access
Date:   Fri,  5 Jul 2019 00:34:40 +0800
Message-Id: <1562258085-3165-9-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are still some places in the common code that have hardcoded
MSR access, convert them to follow the abstracted register access.

Reviewed-and-tested-by: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 7a97d33..aa54c06 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -767,22 +767,24 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
  */
 static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
 {
-	u64 msr_val;
+	struct reg_action ra;
 	u32 value;
 
-	if (rdmsrl_safe_on_cpu(cpu, rp->priv->reg_unit, &msr_val)) {
-		pr_err("Failed to read power unit MSR 0x%x on CPU %d, exit.\n",
+	ra.reg = rp->priv->reg_unit;
+	ra.mask = ~0;
+	if (rp->priv->read_raw(cpu, &ra)) {
+		pr_err("Failed to read power unit REG 0x%x on CPU %d, exit.\n",
 			rp->priv->reg_unit, cpu);
 		return -ENODEV;
 	}
 
-	value = (msr_val & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
+	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
 	rp->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
 
-	value = (msr_val & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
+	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
 	rp->power_unit = 1000000 / (1 << value);
 
-	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
+	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
 	rp->time_unit = 1000000 / (1 << value);
 
 	pr_debug("Core CPU %s energy=%dpJ, time=%dus, power=%duW\n",
@@ -793,21 +795,24 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
 
 static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 {
-	u64 msr_val;
+	struct reg_action ra;
 	u32 value;
 
-	if (rdmsrl_safe_on_cpu(cpu, rp->priv->reg_unit, &msr_val)) {
-		pr_err("Failed to read power unit MSR 0x%x on CPU %d, exit.\n",
+	ra.reg = rp->priv->reg_unit;
+	ra.mask = ~0;
+	if (rp->priv->read_raw(cpu, &ra)) {
+		pr_err("Failed to read power unit REG 0x%x on CPU %d, exit.\n",
 			rp->priv->reg_unit, cpu);
 		return -ENODEV;
 	}
-	value = (msr_val & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
+
+	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
 	rp->energy_unit = ENERGY_UNIT_SCALE * 1 << value;
 
-	value = (msr_val & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
+	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
 	rp->power_unit = (1 << value) * 1000;
 
-	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
+	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
 	rp->time_unit = 1000000 / (1 << value);
 
 	pr_debug("Atom %s energy=%dpJ, time=%dus, power=%duW\n",
@@ -1180,15 +1185,14 @@ static void rapl_remove_platform_domain(struct rapl_if_priv *priv)
 
 static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 {
-	u32 reg;
-	u64 val = 0;
+	struct reg_action ra;
 
 	switch (domain) {
 	case RAPL_DOMAIN_PACKAGE:
 	case RAPL_DOMAIN_PP0:
 	case RAPL_DOMAIN_PP1:
 	case RAPL_DOMAIN_DRAM:
-		reg = rp->priv->regs[domain][RAPL_DOMAIN_REG_STATUS];
+		ra.reg = rp->priv->regs[domain][RAPL_DOMAIN_REG_STATUS];
 		break;
 	case RAPL_DOMAIN_PLATFORM:
 		/* PSYS(PLATFORM) is not a CPU domain, so avoid printng error */
@@ -1200,7 +1204,9 @@ static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 	/* make sure domain counters are available and contains non-zero
 	 * values, otherwise skip it.
 	 */
-	if (rdmsrl_safe_on_cpu(cpu, reg, &val) || !val)
+
+	ra.mask = ~0;
+	if (rp->priv->read_raw(cpu, &ra) || !ra.value)
 		return -ENODEV;
 
 	return 0;
-- 
2.7.4

