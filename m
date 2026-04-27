Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28C3612EF;
	Mon, 27 Apr 2026 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262132; cv=none; b=Bi25OYUj76RL/ljtmy6U26QXNPR2+YTtMP0WeklOBTFuJrEwB5pBIwfAJvUyAFCh51amlikr8L1qOgePWKvvo+vguelgAEpE4s/UMcV22Mlj/qXYX6ExWGAKWScz6ax8LdoOLD7cYv0QuGiFxcJZ51N29xvcVEGaS+8M9uu4nYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262132; c=relaxed/simple;
	bh=J+uIJRhW8avviHoXF6FmqKso0BFymxyRVQchCEPrNFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyieJTGpQ4C5xltuUwbJUfxVaV4e1cY368hpXrZKM6/VjHh18MpQmmjcoRSqtla19dvk0sJjrmZx9oelwvykn+tnTtP/02FhNdPi3R5mfjAAeZy2HQtFvAtL9BtabhZSVPY7AUpI+ptnsnD1Ra119vT27M3PpX/QlqkhTl1owEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uORQgMrV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uORQgMrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8194FC2BCB5;
	Mon, 27 Apr 2026 03:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262132;
	bh=J+uIJRhW8avviHoXF6FmqKso0BFymxyRVQchCEPrNFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uORQgMrVILuRPaLGWUmJ0KhNRulIp0kR2FqBdD5SqQQsqDw5F3zlhNQ8ZTfX93DVF
	 qIffCws3fdeDNV5TYb3zI/bLHI7pivaDsbkc6S6R34LGAreAt3l+jtwuoTqQiUHLP3
	 b//0guFi6k1QWMID4a+nm2Dt6Zs2xbk4eHlNKZtlqWURMLVGde5/4PVwd/pmLinH/i
	 q1dj+XkqKDe2GP1jRKsawXe7t4nd1qyjq1WGQvHjMBewDYKA87sihq2EPXtOst+1S3
	 I2cJoT3ZThzzcrsrXAW/kZ5eksqkIgLKJjz0NVBmuftNKsK3HUGBFpLe/tr4/rR193
	 fRXSu/Yrn7Gwg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 3/6] ACPI: CPPC: Add support for reading HighestFreq
Date: Sun, 26 Apr 2026 22:55:17 -0500
Message-ID: <20260427035520.1427080-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427035520.1427080-1-superm1@kernel.org>
References: <20260427035520.1427080-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A future revision of the ACPI specification will be including
a definition for HighestFreq.  Add support for reading it.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 31 +++++++++++++++++++++----------
 include/acpi/cppc_acpi.h |  7 ++++++-
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index cbfebc50b6eab..f446ef5f7305b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -182,6 +182,7 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_freq);
 
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
@@ -222,6 +223,7 @@ static struct attribute *cppc_attrs[] = {
 	&nominal_perf.attr,
 	&nominal_freq.attr,
 	&lowest_freq.attr,
+	&highest_freq.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cppc);
@@ -751,19 +753,20 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/*
 	 * Disregard _CPC if the number of entries in the return package is not
 	 * as expected, but support future revisions being proper supersets of
-	 * the v3 and only causing more entries to be returned by _CPC.
+	 * the v4 and only causing more entries to be returned by _CPC.
 	 */
 	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
 	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
 	    (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
-	    (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
+	    (cpc_rev == CPPC_V5_REV && num_ent != CPPC_V5_NUM_ENT) ||
+	    (cpc_rev > CPPC_V5_REV && num_ent <= CPPC_V5_NUM_ENT)) {
 		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
 			 num_ent, pr->id);
 		goto out_free;
 	}
-	if (cpc_rev > CPPC_V4_REV) {
-		num_ent = CPPC_V4_NUM_ENT;
-		cpc_rev = CPPC_V4_REV;
+	if (cpc_rev > CPPC_V5_REV) {
+		num_ent = CPPC_V5_NUM_ENT;
+		cpc_rev = CPPC_V5_REV;
 	}
 
 	cpc_ptr->num_entries = num_ent;
@@ -1361,9 +1364,10 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *highest_reg, *lowest_reg,
 		*lowest_non_linear_reg, *nominal_reg, *reference_reg,
-		*guaranteed_reg, *low_freq_reg = NULL, *nom_freq_reg = NULL;
+		*guaranteed_reg, *low_freq_reg = NULL, *nom_freq_reg = NULL,
+		*highest_freq_reg = NULL;
 	u64 high, low, guaranteed, nom, ref, min_nonlinear,
-	    low_f = 0, nom_f = 0;
+	    low_f = 0, nom_f = 0, high_f = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0, regs_in_pcc = 0;
@@ -1380,6 +1384,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	reference_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
 	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
 	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
+	highest_freq_reg = &cpc_desc->cpc_regs[HIGHEST_FREQ];
 	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
 
 	/* Are any of the regs PCC ?*/
@@ -1387,7 +1392,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
 		(CPC_SUPPORTED(reference_reg) && CPC_IN_PCC(reference_reg)) ||
 		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) ||
-		CPC_IN_PCC(guaranteed_reg)) {
+		CPC_IN_PCC(guaranteed_reg) || CPC_IN_PCC(highest_freq_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1450,7 +1455,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		goto out_err;
 	}
 
-	/* Read optional lowest and nominal frequencies if present */
+	/* Read optional lowest, highest and nominal frequencies if present */
 	if (CPC_SUPPORTED(low_freq_reg)) {
 		ret = cpc_read(cpunum, low_freq_reg, &low_f);
 		if (ret)
@@ -1463,9 +1468,15 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 			goto out_err;
 	}
 
+	if (CPC_SUPPORTED(highest_freq_reg)) {
+		ret = cpc_read(cpunum, highest_freq_reg, &high_f);
+		if (ret)
+			goto out_err;
+	}
+
 	perf_caps->lowest_freq = low_f;
 	perf_caps->nominal_freq = nom_f;
-
+	perf_caps->highest_freq = high_f;
 
 out_err:
 	if (regs_in_pcc)
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 38bf9013c6e2e..79f1eef957a45 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -21,14 +21,16 @@
 #define CPPC_V2_REV	2
 #define CPPC_V3_REV	3
 #define CPPC_V4_REV	4
+#define CPPC_V5_REV	5
 #define CPPC_V2_NUM_ENT	21
 #define CPPC_V3_NUM_ENT	23
 #define CPPC_V4_NUM_ENT	25
+#define CPPC_V5_NUM_ENT	27
 
 #define PCC_CMD_COMPLETE_MASK	(1 << 0)
 #define PCC_ERROR_MASK		(1 << 2)
 
-#define MAX_CPC_REG_ENT 23
+#define MAX_CPC_REG_ENT 25
 
 /* CPPC specific PCC commands. */
 #define	CMD_READ 0
@@ -114,6 +116,8 @@ enum cppc_regs {
 	NOMINAL_FREQ,
 	OSPM_NOMINAL_PERF,
 	RESOURCE_PRIO,
+	HIGHEST_FREQ,
+	CURRENT_FREQ,
 };
 
 /*
@@ -131,6 +135,7 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
+	u32 highest_freq;
 };
 
 struct cppc_perf_ctrls {
-- 
2.43.0

