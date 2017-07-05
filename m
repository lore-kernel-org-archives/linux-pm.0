From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/5] powernv:idle: Change return type of pnv_probe_idle_states to int
Date: Wed,  5 Jul 2017 22:08:13 +0530
Message-ID: <1499272696-28751-3-git-send-email-ego@linux.vnet.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751716AbdGEQig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2017 12:38:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v65Gcaog121228
        for <linux-pm@vger.kernel.org>; Wed, 5 Jul 2017 12:38:36 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bgvxy34jq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 05 Jul 2017 12:38:35 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 5 Jul 2017 12:38:35 -0400
In-Reply-To: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

In the current idle initialization code, if there are failures in
pnv_probe_idle_states, then no platform idle state is
enabled. However, since the error is not propagated to the top-level
function pnv_init_idle_states, we continue initialization in this
top-level function even though this will never be used.

Hence change the the return type of pnv_probe_idle_states from void to
int and in case of failures, bail out early on in
pnv_init_idle_states.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index b747bb5..a5990d9 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -813,26 +813,27 @@ static int __init pnv_idle_parse(struct  device_node *np, int dt_idle_states)
 /*
  * Probe device tree for supported idle states
  */
-static void __init pnv_probe_idle_states(void)
+static int __init pnv_probe_idle_states(void)
 {
 	struct device_node *np;
 	int dt_idle_states;
-	int i;
+	int i, rc;
 
 	np = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!np) {
 		pr_warn("opal: PowerMgmt Node not found\n");
-		return;
+		return -ENODEV;
 	}
 	dt_idle_states = of_property_count_u32_elems(np,
 			"ibm,cpu-idle-state-flags");
 	if (dt_idle_states < 0) {
 		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
-		return;
+		return -ENOENT;
 	}
 
-	if (pnv_idle_parse(np, dt_idle_states))
-		return;
+	rc = pnv_idle_parse(np, dt_idle_states);
+	if (rc)
+		return rc;
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300))
 		pnv_power9_idle_init();
@@ -842,6 +843,8 @@ static void __init pnv_probe_idle_states(void)
 			continue;
 		supported_cpuidle_states |= pnv_idle.states[i].flags;
 	}
+
+	return 0;
 }
 
 static int __init pnv_init_idle_states(void)
@@ -852,7 +855,8 @@ static int __init pnv_init_idle_states(void)
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		goto out;
 
-	pnv_probe_idle_states();
+	if (pnv_probe_idle_states())
+		goto out;
 
 	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
 		patch_instruction(
-- 
1.9.4
