Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83E3749E8;
	Mon,  3 Aug 2026 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751384; cv=none; b=Ld7Np3xAtipbjw2c8vLPetIfo5JIC3ZAs71PnNo5FyDVoKnEmWLeGsWC+C6+RyVrbjD3Epn6/jx1mrTBP+XMwUrtRvV5C/N3SkEynjVd6ErkktxQUdDvDRPIlMEwPhBNYA56v/NOjSFgcKKXXffRvLEWMTekvOppWTNzDV+jDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751384; c=relaxed/simple;
	bh=N5i8lCBq5ATn2JQLxF3uEd9Jiqi76J5Sc3I8Bxay8c8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmrLEQF+MPQcsI+pW9HJnno6u8VZhw6qYup4ma5v76O+2DKLXkevfKaxCPk1LHgbgilop5xjcJJgYBgGiCfAR9dSjUhuNgw0z5R/bn8YCiQNnHLG/9Wjs5teYbaw5Az+IfriuRdVWOFgboGL6rb5HQ/3uVFSOHsBnyOA4tQqWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=liTBZQZt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="liTBZQZt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FF31143D;
	Mon,  3 Aug 2026 03:02:58 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FF273F66F;
	Mon,  3 Aug 2026 03:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785751382; bh=N5i8lCBq5ATn2JQLxF3uEd9Jiqi76J5Sc3I8Bxay8c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liTBZQZtZG2fQqPX27mmOFQSgdGKxh4K9lwDfbBlEktSge5NaKJjM54GdpEzTSmh0
	 azmbmRuhd3u1Qw+2lN8ZDzP0X0rI42nZnjaHZSDSxoVrUgLWM3Zgj0uEcAscuKecpn
	 9z8LOINtAFAey75rpwqYISsjwV+/Y11OGRq+lsZg=
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
Subject: [PATCH v3 2/3] ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
Date: Mon,  3 Aug 2026 11:02:50 +0100
Message-Id: <7bebbf542419fb8d786ba1fcd195c668c22c1e64.1785749175.git.christian.loehle@arm.com>
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

ACPI 6.6 changed the Optional Attribute of Desired Performance from
Read/Write to Write. cppc_get_perf() nevertheless reads the register when
initializing performance controls, even though cppc-cpufreq overwrites the
value before using it.

Use the readability check from cppc_get_desired_perf() and leave
desired_perf zero instead of reading it on ACPI 6.6 or later. Also exclude
the register from PCC read-command detection so it cannot trigger an
otherwise unnecessary read command.

Fixes: 658fa7b1c47a ("ACPI: CPPC: Add cppc_get_perf() API to read performance controls")
Cc: stable@vger.kernel.org
Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6e5381f8de38..210988d57b71 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1843,6 +1843,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
+	bool read_desired_perf = cppc_desired_perf_readable();
 	int ret = 0, regs_in_pcc = 0;
 
 	if (!cpc_desc) {
@@ -1862,7 +1863,8 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 
 	/* Are any of the regs PCC ?*/
-	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
+	if ((read_desired_perf && CPC_IN_PCC(desired_perf_reg)) ||
+	    CPC_IN_PCC(min_perf_reg) ||
 	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
 	    CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
@@ -1894,7 +1896,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	}
 	perf_ctrls->min_perf = min;
 
-	if (CPC_SUPPORTED(desired_perf_reg)) {
+	if (read_desired_perf && CPC_SUPPORTED(desired_perf_reg)) {
 		ret = cpc_read(cpu, desired_perf_reg, &desired_perf);
 		if (ret)
 			goto out_err;
-- 
2.34.1

