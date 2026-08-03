Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C3377A8F;
	Mon,  3 Aug 2026 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751387; cv=none; b=rhZpK7ceFsh2x5tFOXWIIWtCPfS2cbn4HLdhO5YlowtCm1IK18PKj/6EKQ3F/QrSVcjCahHv8nOetChmOXfUtz813r3gGPlZyCuZUlnkyw6xVbl32/xDRrwTvREJ9X2DcsT/T9P4bXubzUzP6cHjjESxnUEZ51GrTINjfKJlD7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751387; c=relaxed/simple;
	bh=fjmpkl3Ntq52aGykdPAVs2wIJ99r43BbiIRM0bjf3Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZ0+JZztAkx83fN5I+DBIJ985OuGzrTtjGead1uHjZRzmf7dw94YBqjv6dg66zTobs5h5N/OtPMJn64GJn+pzHu2zVgJNsVRi+PLaL9WU1qy/FyVIZinxmd2zHJIyKRQMj/+mPkUw+XKRX58/2ksebyUHrofLKcumIKOj3kdaUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QlF/BPcg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QlF/BPcg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05AE91476;
	Mon,  3 Aug 2026 03:03:01 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 090403F632;
	Mon,  3 Aug 2026 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785751385; bh=fjmpkl3Ntq52aGykdPAVs2wIJ99r43BbiIRM0bjf3Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlF/BPcgdKEETmDBLV+9q2EkSWLnjHDXYS7eVKQwfilBuWF7PG1bdk/ldefjPNg9Z
	 5W2UidGJ7yTT2N7W4O64hCqlkxifCdhzY2GkhllLd4o6pNpCH/fAPDAkziXM+hIg6E
	 slhQvEYg0TnW2i7hmrlQbxuZyBdbB09JoRHxL5Vk=
From: Christian Loehle <christian.loehle@arm.com>
To: christian.loehle@arm.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
	zhongqiu.han@oss.qualcomm.com
Subject: [PATCH v3 3/3] ACPI: CPPC: Stop reading desired_perf in cppc_get_perf()
Date: Mon,  3 Aug 2026 11:02:51 +0100
Message-Id: <14182aecaaa89840f8cfd8d40cf4ddadc84aa844.1785749175.git.christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1785749175.git.christian.loehle@arm.com>
References: <20260729100245.2628302-1-christian.loehle@arm.com> <cover.1785749175.git.christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cppc_get_perf() has one in-tree caller, cppc_cpufreq_get_cpu_data().
It uses the function to preserve existing controls before writing them, but
overwrites desired_perf with highest_perf before the first cppc_set_perf().
Consequently, the current Desired Performance value is not consumed.

Remove the Desired Performance read from this aggregate getter and
document that the field is returned as zero.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 210988d57b71..8ce2033ba993 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1828,22 +1828,22 @@ int cppc_set_enable(int cpu, bool enable)
 EXPORT_SYMBOL_GPL(cppc_set_enable);
 
 /**
- * cppc_get_perf - Get a CPU's performance controls.
+ * cppc_get_perf - Get a CPU's readable performance controls.
  * @cpu: CPU for which to get performance controls.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
  *
+ * Desired Performance is not read and is returned as 0.
+ *
  * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
  */
 int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *desired_perf_reg,
-				     *min_perf_reg, *max_perf_reg,
+	struct cpc_register_resource *min_perf_reg, *max_perf_reg,
 				     *energy_perf_reg, *auto_sel_reg;
-	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
+	u64 min = 0, max = 0, energy_perf = 0, auto_sel = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
-	bool read_desired_perf = cppc_desired_perf_readable();
 	int ret = 0, regs_in_pcc = 0;
 
 	if (!cpc_desc) {
@@ -1856,16 +1856,14 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 		return -EINVAL;
 	}
 
-	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
 	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
 	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
 	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 
 	/* Are any of the regs PCC ?*/
-	if ((read_desired_perf && CPC_IN_PCC(desired_perf_reg)) ||
-	    CPC_IN_PCC(min_perf_reg) ||
-	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
+	if (CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg) ||
+	    CPC_IN_PCC(energy_perf_reg) ||
 	    CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
@@ -1896,12 +1894,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	}
 	perf_ctrls->min_perf = min;
 
-	if (read_desired_perf && CPC_SUPPORTED(desired_perf_reg)) {
-		ret = cpc_read(cpu, desired_perf_reg, &desired_perf);
-		if (ret)
-			goto out_err;
-	}
-	perf_ctrls->desired_perf = desired_perf;
+	perf_ctrls->desired_perf = 0;
 
 	if (CPC_SUPPORTED(energy_perf_reg)) {
 		ret = cpc_read(cpu, energy_perf_reg, &energy_perf);
-- 
2.34.1

