Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CA3439F8B;
	Fri, 24 Jul 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900598; cv=none; b=L8guaKhCSrzVKnsqjbvfUsyqf9F+/D8kJvmtGRlrWd7xNw7RgxpBTMFjxvbSut2FhL70fw4mTF3GR0pLXow04sPpbT49d8VZTclLUxyucn6e8Yg42MfhiJguuMUdQ4P/1oOleqRFm6TwJWaaKBuTgUPJ4ah3aAKhCaqyMt2nAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900598; c=relaxed/simple;
	bh=eNP5GqOW7zsH2R03Okaf82MSE794/afd4AaWtwVDhXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TteoIVAlD0afXaJU4UX2wjM8s5LowR9UbweymcXtLaWjif+y2j5ZfTX34fVHELrnX+FbbxfHba6P8Zd9imk+FHZI0me1O4+PVyvwFmkp8bdyfD1bqSjt3b6lwaUzQnRavLM405ujA3BnxL9aSEJN2ufxwl5gj36LABkZghA3pDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vAneIkqs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vAneIkqs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 828281477;
	Fri, 24 Jul 2026 06:43:10 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.66.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0ACDE3F59E;
	Fri, 24 Jul 2026 06:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784900594; bh=eNP5GqOW7zsH2R03Okaf82MSE794/afd4AaWtwVDhXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vAneIkqsNtELSt78+OyV+SJPCbyfA9QhK6ZqhTD75Y5FT9klhlElzdTL7S1oGcRuw
	 9vcVcKD2Pd3hriq3ISSr7GQupl+n/3JzvZYAix8DiIjyCJKNi5Z8hW5FGKEGS3ayFY
	 fNzW/Fuelg95UXMcGeW2HYYnzmvtVqulgs/F/6KA=
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 3/3] ACPI: CPPC: Evaluate performance-control PCC use once
Date: Fri, 24 Jul 2026 14:42:51 +0100
Message-Id: <20260724134251.1632824-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724134251.1632824-1-christian.loehle@arm.com>
References: <20260724134251.1632824-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cppc_set_perf() evaluates the same immutable address-space predicates
before and after each phase of a performance-control update. This repeats
the three-control PCC test three times for every target request.

Evaluate the predicate once after resolving the control descriptors and
reuse the result throughout the transaction.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2793d6b7d40d..cd1c4a30eb6f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -2002,6 +2002,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	struct cpc_register_resource *desired_reg, *min_perf_reg, *max_perf_reg;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
+	bool regs_in_pcc;
 	int ret = 0;
 
 	if (!cpc_desc) {
@@ -2012,6 +2013,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
 	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
 	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	regs_in_pcc = CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) ||
+		      CPC_IN_PCC(max_perf_reg);
 
 	/*
 	 * This is Phase-I where we want to write to CPC registers
@@ -2020,7 +2023,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * Since read_lock can be acquired by multiple CPUs simultaneously we
 	 * achieve that goal here
 	 */
-	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
+	if (regs_in_pcc) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -2056,7 +2059,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
 		cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
 
-	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
+	if (regs_in_pcc)
 		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
 	/*
 	 * This is Phase-II where we transfer the ownership of PCC to Platform
@@ -2104,7 +2107,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * case during a CMD_READ and if there are pending writes it delivers
 	 * the write command before servicing the read command
 	 */
-	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
+	if (regs_in_pcc) {
 		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
 			/* Update only if there are pending write commands */
 			if (pcc_ss_data->pending_pcc_write_cmd)
-- 
2.34.1

