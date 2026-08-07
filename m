Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658646EF7E;
	Fri,  7 Aug 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101210; cv=none; b=NpxqXkOK6BAZbOQc3tLRXnCMI9MTFT44yD36F1qaEHMSQivGUJKsi8Dm5sWYaLSEL50qSP9AyJfwFrCj8ad/GNRlj4PoI/fRdvwfCWjvZW8VjgquW9/DGjm8Se17z5vrdLiohuOrMP6ZaWsq2lLKDzWSZT69QGX6aNoD5FPF5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101210; c=relaxed/simple;
	bh=jxRIAnOSZ3sqlfEm7UIiKr7ABs7oyWj+7MeXX62Q4BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=du8g9my/X8YaTmkEOxzGgolLnkZ8oo5tZWf1QeXQ20xMs6L7U1VdBiF1QA+XliUgdH5TqA7QubpDRHgrcgVkU6W+4jm7NiOz+NGaNPzXrca9ZC4+zEAOLsfc5ChbACW61gD+j0X5QaQUE/WwEdtard3q2pMesQbV6MIUxWH0WRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h41jitd7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h41jitd7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01BFB1516;
	Fri,  7 Aug 2026 04:13:24 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE4CC3F86F;
	Fri,  7 Aug 2026 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786101208; bh=jxRIAnOSZ3sqlfEm7UIiKr7ABs7oyWj+7MeXX62Q4BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h41jitd7c4HCEz9G2BbLUcmQ1dHOaSL1+LKhZbUCdt1pBPVs/BUI1SGP5vlQ3Q0De
	 tLqaMebOrvytZDOworBRpFidTDrV2e9mJsD4N1ryshzOiV9G2/jT6Pacn3AP4nyJ58
	 hDCNx973wJC+aufJabKDoxZeeQLhAXkRXCqcM4IM=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhongqiu.han@oss.qualcomm.com,
	Christian Loehle <christian.loehle@arm.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 06/15] ACPI: CPPC: Serialize PCC EPP payload updates
Date: Fri,  7 Aug 2026 12:12:54 +0100
Message-Id: <20260807111303.1062391-7-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807111303.1062391-1-christian.loehle@arm.com>
References: <20260807111303.1062391-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cppc_set_epp_perf() stages Autonomous Selection and Energy Performance
Preference in the PCC shared region before taking pcc_lock. The platform
may still own the subspace, or a concurrent command may consume or
overwrite only part of the new payload.

Take the PCC write lock and wait for OSPM ownership before staging either
control. Keep the lock held until the complete payload has been submitted
with CMD_WRITE, so firmware cannot observe a mixed transaction.

For a mixed PCC/non-PCC description, complete every fallible non-PCC write
before staging PCC data. Cross-address-space updates cannot be atomic, but
a non-PCC failure can no longer leave an unsent value in shared memory for
a later PCC command to consume.

Classify every probe-validated writable control as either PCC or non-PCC.
This covers SystemIO along with FFH and SystemMemory and avoids repeating a
flexible-address-space _OSC decision that probe has already made.

This follows the PCC ownership sequence in ACPI 6.5 Section 14.5.

Fixes: 7bc1fcd39901 ("ACPI: CPPC: Add AMD pstate energy performance preference cppc control")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 72 +++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ca8fd092b44f..29da5ff7ebda 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1826,8 +1826,10 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	struct cpc_register_resource *auto_sel_reg;
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
-	bool autosel_ffh_sysmem;
-	bool epp_ffh_sysmem;
+	bool auto_sel_pcc;
+	bool auto_sel_non_pcc;
+	bool epp_pcc;
+	bool epp_non_pcc;
 	int ret;
 
 	if (!cpc_desc) {
@@ -1838,52 +1840,62 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
 
-	epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
-		(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
-	autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
-		(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
+	auto_sel_pcc = cpc_is_writable(auto_sel_reg) &&
+		CPC_IN_PCC(auto_sel_reg);
+	epp_pcc = cpc_is_writable(epp_set_reg) && CPC_IN_PCC(epp_set_reg);
+	auto_sel_non_pcc = cpc_is_writable(auto_sel_reg) && !auto_sel_pcc;
+	epp_non_pcc = cpc_is_writable(epp_set_reg) && !epp_pcc;
 
-	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
+	/* Complete fallible non-PCC writes before staging PCC data. */
+	if (auto_sel_non_pcc) {
+		ret = cpc_write(cpu, auto_sel_reg, enable);
+		if (ret)
+			return ret;
+	}
+	if (epp_non_pcc) {
+		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
+		if (ret)
+			return ret;
+	}
+
+	if (epp_pcc || auto_sel_pcc) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
 			return -ENODEV;
 		}
 
-		if (cpc_is_writable(auto_sel_reg)) {
+		pcc_ss_data = pcc_data[pcc_ss_id];
+		if (!pcc_ss_data)
+			return -ENODEV;
+
+		down_write(&pcc_ss_data->pcc_lock);
+
+		ret = check_pcc_chan(pcc_ss_id, false);
+		if (ret)
+			goto out_unlock;
+
+		if (auto_sel_pcc) {
 			ret = cpc_write(cpu, auto_sel_reg, enable);
 			if (ret)
-				return ret;
+				goto out_unlock;
 		}
 
-		if (cpc_is_writable(epp_set_reg)) {
+		if (epp_pcc) {
 			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
 			if (ret)
-				return ret;
+				goto out_unlock;
 		}
 
-		pcc_ss_data = pcc_data[pcc_ss_id];
-
-		down_write(&pcc_ss_data->pcc_lock);
 		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
-		up_write(&pcc_ss_data->pcc_lock);
-	} else if (osc_cpc_flexible_adr_space_confirmed &&
-		   (epp_ffh_sysmem || autosel_ffh_sysmem)) {
-		if (autosel_ffh_sysmem) {
-			ret = cpc_write(cpu, auto_sel_reg, enable);
-			if (ret)
-				return ret;
-		}
 
-		if (epp_ffh_sysmem) {
-			ret = cpc_write(cpu, epp_set_reg,
-					perf_ctrls->energy_perf);
-			if (ret)
-				return ret;
-		}
+out_unlock:
+		up_write(&pcc_ss_data->pcc_lock);
+	} else if (epp_non_pcc || auto_sel_non_pcc) {
+		ret = 0;
 	} else {
-		ret = -ENOTSUPP;
-		pr_debug("_CPC in PCC/FFH/SystemMemory are not supported\n");
+		ret = -EOPNOTSUPP;
+		pr_debug("No writable EPP controls for CPU:%d\n", cpu);
 	}
 
 	return ret;
-- 
2.34.1

