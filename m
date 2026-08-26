Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE43ACF0A;
	Wed, 26 Aug 2026 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725854; cv=none; b=p0q0F2aqg7YslvND8l6p7EDiBNaOLhTW4vCjJDOzuHbIU4nYS0Idl68glrIlKQGng8tubzE7J1l0MaARF/+onJNSasSAF1blGQe2QX4m/RGN1Yu959qhWBxZkzoFTxqQZUudSpM6Yi+0RFq71yF4l+bUkSQAcTWdKdee/52Kt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725854; c=relaxed/simple;
	bh=j/ssUcQsC4IwEQIG2ZEHNlF7ZJActf7PVgggxoVked8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZUm1LWj6oFKigMv1VFB8CIyVqmHEpMJtJ5FHnmgLV/RSn0ghmNI5AXZKYJyzKJO65y9/Ca5NqfwKqUXfuus98CFaIeWhDbaS9k/Qp1A3netRyMgjXRwk50i1IyHfja3dyie6szNaNkVlT167uI8NcDl4rgnOT1vnZbzc/qaXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N6exFO6G; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N6exFO6G"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D8681D31;
	Tue, 25 Aug 2026 23:30:43 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF2BF3F7D8;
	Tue, 25 Aug 2026 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725847; bh=j/ssUcQsC4IwEQIG2ZEHNlF7ZJActf7PVgggxoVked8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6exFO6GAw5nmZy2WXTqU8GGVBa08C7aF1pKMkW1bcYj1I3w0hw+iqj6im5bia0V3
	 HHji9+eN/C0ulP8cL28P7iWvyzobWXAI0JfVEx7ab6lZaJvD7FajAjWGdOZtBdp+Pp
	 8NvSQK+whsqOINSNL7Te8a7/ZIFSw7FXniHctuW8=
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
Subject: [PATCH v4 06/15] ACPI: CPPC: Serialize PCC EPP payload updates
Date: Wed, 26 Aug 2026 07:30:10 +0100
Message-Id: <20260826063019.670240-7-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826063019.670240-1-christian.loehle@arm.com>
References: <20260826063019.670240-1-christian.loehle@arm.com>
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

If ownership acquisition or PCC staging fails, abort any older pending
performance batch before releasing the exclusive lock so its Phase-II
waiters receive the error instead of sleeping indefinitely.

This follows the PCC ownership sequence in ACPI 6.5 Section 14.5.

Fixes: 7bc1fcd39901 ("ACPI: CPPC: Add AMD pstate energy performance preference cppc control")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 74 ++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1495511cb10d..5a94317e9a03 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1890,8 +1890,10 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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
@@ -1902,52 +1904,64 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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
+		if (ret)
+			cppc_abort_pending_pcc_write(pcc_ss_data, ret);
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

