Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793352826;
	b=OHxBRevIhD7itHw7ucwtwh7WwFHjZaYtaKDUYtXpasDdjquHxX3Z3AITPAQ11DjTWuMQ
	 USEY+RF0yK+LPCnWL0i7Tmg0GX8KMPKw2m+DgE+m1Dc4AjOHym7xeXhkmeSPdJy1R/ov5
	 A5pycBBwbog2MHlqJVCtQxyLZOxUTbFs/qlvEOix4tyslHlrh6SBkjboWmUoYjZ/rpyj9
	 8aGTYaOwTLuzW926pr0EvNy5wuEhOo3rSYWXmxJV5+GMZYjcS06h4YgdswM3iMsVHIlxQ
	 7pegjLcrCGE2j56Rccv4oI+UWmOvO/2nlEBD9XFkI2WhBv9TtfP4ol6C56WJrlepDPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352826;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HBhnDf53neLHsBRWUIP2D7E6UITkf2HqTwg3eLqxTm0=;
	b=xTlIAXxwlliHtVKrDZrBKXYsngMKSDaEiG0O02nbKXDWUcUVQDhzF1z35UTwLudOMx+l
	 VCfx20pQapP72DY1xwsRkldJxNi251pZVZayt+GzoCBkiBPRP/tbPCmnO+fDy05fgZlnr
	 TGApGi23TWblfvh8h01MR+ZtLts+TzrAqE2EzHc6RfUjemRaARIxW2oRSEw8igcnyafMj
	 YOebebhc1GAZMrFoDxS3KmlERXMAFi2a8C1QbOwHU/2E/KoyRHwEozBtd8lYM0fl5jjlP
	 2G3pQe0QX99vDKItrjHtGvVFbzl4uKTY8g+XGcK9sZIJ2GbGKGgBfUiIDlXxupxLxog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ro5QKYHN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.14
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C4606A31D;
	Fri, 30 Oct 2026 09:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D2C4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ro5QKYHN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp+dtjrqC+q5eOIwR4BraCM9a2y1rlZOsSbUMxs/bQbZVj0DL8Z6kaM9jdClclrrQsbZbwoU4WP9ov37lfPxNH9SNyPJcQ0gwqcf2b865G5+20wk2yfC/gaiTTPHDc5fkHmXyNGekDwQkojiu5+PM2awdYYnxh4kTssneBaV0HaubAxwGgQ7UVDMUCR40FPQK4jFqBo3jYjFLUrvVPQ/hxI+Dj55+dTYkFWqNtYiwO2ojNhSvJXk1xrA86lUy355Y7hV504zrlF8/+AuurOSI5YuecWYdb+JuwBMDXkGPqaVg0ZBVoYYQElf0ZRgGwcFX70N+gZXGE2Ag6px+IQeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBhnDf53neLHsBRWUIP2D7E6UITkf2HqTwg3eLqxTm0=;
 b=dDpnCZZ9PqqFBzv/9wnrXXhC5VcPf0q32aVNhKS1wHMmf8spO35YsjDTHKAzwRAyCKnNm18avgFmazL5NFjm0yH5OTHQLf2XEj3NKn37QAKQpjJFKp2YYHl8gnel5R5QI4iAQ+McO0V9of+EJEgVaLcp9dowzZg2tORxS2SBiF23xA6KmH0AYD9fzAnPgZ76Fd2YvbEqFNIfS7Sf0hRJcTIcie8qxwZtjUGeMp7TVVNBafZPqFKi8l900he7+w/sD+cJYoc4U5TiBGENjVycU5zzFX9/lp2y+h6gdOoCaBKMhGZyBD2QlOrJlueC+1vAo0CLvC6oBJS0CAH2rVSyvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBhnDf53neLHsBRWUIP2D7E6UITkf2HqTwg3eLqxTm0=;
 b=Ro5QKYHNw1LjAJYC/6bw6EzrT5t0vowPhO1Z11znECfRQJhwX8vOzIslsVg+eYSptGaUFaw1R80Go1dhLaQD7bOXO3vV1ibyFr+oQ1yd8iaW1NU4yF/ygw8fIEomRSM+Sklg2/nrlAs6oHdYRugjBFzeAWL6os8GRECf4nVpkQdO1G6/KoXEmO6o3QhO85OC5CHHfEgyG+FpFAjEdmvL+maJHVSua3sNL/uZZvO4HD9g/GlUu/9JV9YIGjh+qrUwbS2HCtFoEhN39AobmZFcSK68fdXxzsD5ZWr7EzUX/2pB3YkVpbqG60bqUZTwudI7mniIRMpW7ewv6ZV2fK5BMg==
Received: from SJ0PR05CA0115.namprd05.prod.outlook.com (2603:10b6:a03:334::30)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:33:37 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::4f) by SJ0PR05CA0115.outlook.office365.com
 (2603:10b6:a03:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 30 Oct 2026 09:33:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 09:33:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:33:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 02:33:22 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 02:33:14 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v7 1/5] ACPI: CPPC: Order performance-control updates
Date: Fri, 30 Oct 2026 15:03:12 +0530
Message-ID: <20261030093312.1995371-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030092416.1993889-1-sumitg@nvidia.com>
References: <20261030092416.1993889-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a322d93-e428-4a18-65af-08df3668dfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|921020|10067099003|5023799004|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ClmvxDKCf4LASjxJucXdv/ZILFZXIO4aycT+hlcoMlJZYVFIZnpvKPf5P16rvEHhWtm3q5nFrS+p6NXwr6owmWvUX68nYY8i7Ns4EY4VjhSwS/Sm5JhGfeBMa4cHe4w6ZYx12W1IztUATb/jcxUPJsLfV11A9KeBSCJghweyp7GbUpwbAcDN10SxTQTxJXM4L81R5P93G+2DVCmQuzHMZkWbS26Kjoss48Xrtg6iOB1eH2AXaLpxgfeYah5C5gvDg68d6lEdiQT7RcdIyhCfDLlrKYEG6JtgMveMi7PiVqKZCwVR5fFjYWwg+aOcegpGM8BDciCixDdjqQShrWRf78KvSqoeoukoC85TBbaS8ldd4ZTI0PpxGks7SumNRiT/6BKIwBXcKCHqNgQp6O1oUfuOwBjjPblkCajDqu9OnfO5CWEc/Yjz0Fd09CRxx7NCxxdKl/ZNcC3p4tjvpS37dw5rbX9izg5n+PD0FrNcKDdlm+iQJNR5EJeiKbkzvjgnpPUEziaDtq7yuZqXUtC7eb6QFVEQpmeOQWsbMPMQt9ewkRs+yyypoZeL0VN01fueHa4ss0DBnx0mFjt/YUYgMuh8LWYwA86a1vFK1dlcOs8hCK6gIWjgWY1Sp0EDERxLBUbPoF1mibcNjSVXPIgy0yAZ/qGxE8PihEHuidQzo7tBIJFxPFRt1wXGz16jevLXA76IbEEZYdUChz98iiLMnpPBKZuvuSBxFlmcyWZ1VCILGy4awx6UZbO7Z61Xu3Kv
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(921020)(10067099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wBIePq10Eb6hdybtsmzLYmUZMMFkkVktG8J55ysZyxxv1nNbI008k3hdDjNKOxUFBEXOmr49Ftlctx66Sj66rBbD57T0Jq8ViHHyxSfldj0oqcECZZXaPfTYV8ULPXJG4PLBCybcBakzxttywSABHYw8BFlwL52GAeOFiaJ04PKOsmly4szek9MdUz9qPQWn5t4DdLoyuujdSjiMnEOiKRMx/Fc5Cbi1ADXjS4s3AVZ/8/+T7JfviWq2cdXW+LPlbaecWd0nWYl3yJK1kL9KhLci3dU/mf0/desQCaXcRerZgDXeLQYfyT2KccJAj5o9hkvxCWLdbSMiyJ8TuGJrJgONtaymMZtv06fzxYMRewcmGMbnqBWfUCfX2Z2blafsSDUczb+5pDnKUPInRJ8Sh08ztoeIqcH5Cv9o/vaS71SFQ5bN8Ufv/FkF1nCPXIad
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:33:36.9665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a322d93-e428-4a18-65af-08df3668dfe9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0

From: Christian Loehle <christian.loehle@arm.com>

The ACPI specification requires Minimum Performance to remain below
Maximum Performance. When autonomous selection is disabled, Desired
Performance must also remain within those limits.

cppc_set_perf() writes the three controls in a fixed order. This can expose
an invalid tuple after firmware resets the controls or while policy bounds
move across the current desired value.

Read the live limits. Apply non-atomic updates in three phases: widen the
interval, update Desired Performance, then narrow it. Submit PCC controls
in each phase together. Keep the existing single-command path when the
complete tuple is in PCC, reject invalid requests, and stop after the first
failed access.

Make cppc_cpufreq fast switches include the limits only when they differ
from the last successful request. Invalidate the cache across resume and
after a failed request, since firmware may have reset the controls or an
earlier phase of a failed update may have reached the platform. Publish
slow-path limits only after the complete request succeeds.

At policy teardown, lower Minimum Performance together with Desired
Performance so the final request remains valid. On initialization, clamp
Desired Performance to the live interval left by firmware or an earlier
driver instance.

Fixes: 76531df5e13b ("ACPI: CPPC: Add min and max perf register writing support")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
[sumitg:
 - In cppc_read_perf_limits(), skip an unimplemented MIN or MAX, and
   do not fail on a live MIN above MAX.
 - Clamp Desired into the new MIN and MAX instead of rejecting it, as
   amd-pstate resume can round it above MAX.
 - In init(), request the full range if the live MAX is zero or below MIN.
 - Clamp Desired in set_target(), fast_switch() and store_auto_select(),
   to keep the cached value in range.
 - In store_auto_select(), publish the request only after success.]
Link: https://lore.kernel.org/all/01d7f07e-839c-428b-833d-713ed2128f4d@nvidia.com/
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 298 ++++++++++++++++++++++++++-------
 drivers/cpufreq/cppc_cpufreq.c | 141 ++++++++++++----
 include/acpi/cppc_acpi.h       |   1 +
 3 files changed, 348 insertions(+), 92 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 80e2e6b32ce3..f49c6152a013 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -3471,11 +3471,214 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf);
 
+enum cppc_perf_update {
+	CPPC_UPDATE_DESIRED	= BIT(0),
+	CPPC_UPDATE_MIN		= BIT(1),
+	CPPC_UPDATE_MAX		= BIT(2),
+};
+
+/* The caller holds pcc_lock for write if either limit is in PCC. */
+static int cppc_read_perf_limits(int cpu, u32 *min_perf, u32 *max_perf)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *min_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	struct cpc_register_resource *max_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	u64 min = 0, max = U32_MAX;
+	int ret;
+
+	if (!cpc_is_readable(min_reg) || !cpc_is_readable(max_reg))
+		return -EOPNOTSUPP;
+
+	/* Firmware may have reset the controls, so read the live limits. */
+	if (CPC_IN_PCC(min_reg) || CPC_IN_PCC(max_reg)) {
+		ret = send_pcc_cmd(per_cpu(cpu_pcc_subspace_idx, cpu), CMD_READ);
+		if (ret)
+			return ret;
+	}
+
+	/* An absent optional limit leaves that side of the interval open. */
+	if (CPC_SUPPORTED(min_reg)) {
+		ret = cpc_read(cpu, min_reg, &min);
+		if (ret)
+			return ret;
+	}
+	if (CPC_SUPPORTED(max_reg)) {
+		ret = cpc_read(cpu, max_reg, &max);
+		if (ret)
+			return ret;
+	}
+	if (min > U32_MAX || max > U32_MAX)
+		return -EFAULT;
+	if (min > max)
+		pr_debug("CPU:%d live MIN_PERF %llu above MAX_PERF %llu\n",
+			 cpu, min, max);
+
+	*min_perf = min;
+	*max_perf = max;
+	return 0;
+}
+
+static bool cppc_perf_updates_in_pcc(int cpu, unsigned int updates)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
+	return ((updates & CPPC_UPDATE_DESIRED) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[DESIRED_PERF])) ||
+	       ((updates & CPPC_UPDATE_MIN) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[MIN_PERF])) ||
+	       ((updates & CPPC_UPDATE_MAX) &&
+		CPC_IN_PCC(&cpc_desc->cpc_regs[MAX_PERF]));
+}
+
+/* The caller holds pcc_lock for write if an updated control is in PCC. */
+static int cppc_write_perf_controls(int cpu,
+				    struct cppc_perf_ctrls *perf_ctrls,
+				    unsigned int updates, bool sync_desired)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg =
+		&cpc_desc->cpc_regs[DESIRED_PERF];
+	struct cpc_register_resource *min_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	struct cpc_register_resource *max_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	struct cppc_pcc_data *pcc_ss_data;
+	int pcc_ss_id, ret;
+	bool pcc_update = false;
+
+	/* Direct writes precede the PCC command in each ordered phase. */
+	if ((updates & CPPC_UPDATE_DESIRED) && !CPC_IN_PCC(desired_reg)) {
+		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		if (ret)
+			return ret;
+	}
+	if ((updates & CPPC_UPDATE_MIN) && !CPC_IN_PCC(min_reg)) {
+		ret = cpc_write(cpu, min_reg, perf_ctrls->min_perf);
+		if (ret)
+			return ret;
+	}
+	if ((updates & CPPC_UPDATE_MAX) && !CPC_IN_PCC(max_reg)) {
+		ret = cpc_write(cpu, max_reg, perf_ctrls->max_perf);
+		if (ret)
+			return ret;
+	}
+
+	/* Keep Desired Performance valid in every intermediate PCC command. */
+	if (((updates & CPPC_UPDATE_DESIRED) || sync_desired) &&
+	    CPC_IN_PCC(desired_reg)) {
+		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if ((updates & CPPC_UPDATE_MIN) && CPC_IN_PCC(min_reg)) {
+		ret = cpc_write(cpu, min_reg, perf_ctrls->min_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if ((updates & CPPC_UPDATE_MAX) && CPC_IN_PCC(max_reg)) {
+		ret = cpc_write(cpu, max_reg, perf_ctrls->max_perf);
+		if (ret)
+			return ret;
+		pcc_update = true;
+	}
+	if (!pcc_update)
+		return 0;
+
+	pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	pcc_ss_data = pcc_data[pcc_ss_id];
+	WRITE_ONCE(pcc_ss_data->pending_pcc_write_cmd, true);
+	cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
+	cpc_desc->write_cmd_status = 0;
+	return send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+}
+
+/*
+ * Move from the live interval to the requested interval without exposing an
+ * invalid control tuple: widen, update Desired Performance, then narrow.
+ */
+static int cppc_write_ordered_perf(int cpu,
+				   struct cppc_perf_ctrls *perf_ctrls,
+				   bool desired_update, bool min_update,
+				   bool max_update)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg =
+		&cpc_desc->cpc_regs[DESIRED_PERF];
+	struct cppc_perf_ctrls ctrls = *perf_ctrls;
+	unsigned int widen = 0, narrow = 0;
+	u32 current_min, current_max;
+	u32 target_min, target_max;
+	bool desired_done = false;
+	bool sync_desired;
+	int ret;
+
+	ret = cppc_read_perf_limits(cpu, &current_min, &current_max);
+	if (ret)
+		return ret;
+
+	target_min = min_update ? perf_ctrls->min_perf : current_min;
+	target_max = max_update ? perf_ctrls->max_perf : current_max;
+
+	/*
+	 * Check only the new interval. If the live one is inverted, this
+	 * update fixes it.
+	 */
+	if (target_min > target_max)
+		return -EINVAL;
+
+	/* Callers can round Desired just outside the new interval. */
+	if (desired_update && ctrls.desired_perf)
+		ctrls.desired_perf = clamp(ctrls.desired_perf, target_min,
+					   target_max);
+
+	if (min_update) {
+		if (perf_ctrls->min_perf < current_min)
+			widen |= CPPC_UPDATE_MIN;
+		else
+			narrow |= CPPC_UPDATE_MIN;
+	}
+	if (max_update) {
+		if (perf_ctrls->max_perf > current_max)
+			widen |= CPPC_UPDATE_MAX;
+		else
+			narrow |= CPPC_UPDATE_MAX;
+	}
+
+	if (widen) {
+		sync_desired = desired_update && CPC_IN_PCC(desired_reg) &&
+			cppc_perf_updates_in_pcc(cpu, widen);
+		ret = cppc_write_perf_controls(cpu, &ctrls, widen,
+					       sync_desired);
+		if (ret)
+			return ret;
+		desired_done = sync_desired;
+	}
+
+	if (desired_update && !desired_done) {
+		ret = cppc_write_perf_controls(cpu, &ctrls,
+					       CPPC_UPDATE_DESIRED, false);
+		if (ret)
+			return ret;
+	}
+
+	if (!narrow)
+		return 0;
+
+	sync_desired = desired_update && CPC_IN_PCC(desired_reg) &&
+		cppc_perf_updates_in_pcc(cpu, narrow);
+	return cppc_write_perf_controls(cpu, &ctrls, narrow, sync_desired);
+}
+
 /**
  * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
  * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
  *
+ * Callers must serialize updates to the same CPU's performance controls.
+ * Limit updates preserve MIN <= MAX, including intermediate states on
+ * directly accessed registers. An error may leave an earlier write applied.
+ * A nonzero Desired is clamped to the new [MIN, MAX] when a limit is updated.
+ *
  * Return: 0 for success, -ERRNO otherwise.
  */
 int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
@@ -3487,6 +3690,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	bool desired_update, min_update, max_update;
 	bool desired_pcc, min_pcc, max_pcc, pcc_update;
 	bool pcc_layout, direct_layout, mixed_layout;
+	u32 desired_perf;
 	int ret = 0;
 
 	if (!cpc_desc) {
@@ -3502,10 +3706,21 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 		     (perf_ctrls->min_perf || perf_ctrls->min_perf_valid);
 	max_update = cpc_is_writable(max_perf_reg) &&
 		     perf_ctrls->max_perf;
+
+	if (min_update && max_update &&
+	    perf_ctrls->min_perf > perf_ctrls->max_perf)
+		return -EINVAL;
+
+	desired_perf = perf_ctrls->desired_perf;
+	if (desired_perf && min_update && max_update)
+		desired_perf = clamp(desired_perf, perf_ctrls->min_perf,
+				     perf_ctrls->max_perf);
+
 	desired_pcc = desired_update && CPC_IN_PCC(desired_reg);
 	min_pcc = min_update && CPC_IN_PCC(min_perf_reg);
 	max_pcc = max_update && CPC_IN_PCC(max_perf_reg);
 	pcc_update = desired_pcc || min_pcc || max_pcc;
+
 	pcc_layout = (cpc_is_writable(desired_reg) && CPC_IN_PCC(desired_reg)) ||
 		     (cpc_is_writable(min_perf_reg) && CPC_IN_PCC(min_perf_reg)) ||
 		     (cpc_is_writable(max_perf_reg) && CPC_IN_PCC(max_perf_reg));
@@ -3531,9 +3746,10 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * A mixed layout cannot batch fallible direct writes safely: another
 	 * CPU's staged PCC values may no longer match if a direct write fails.
 	 * Serialize the complete mixed transaction and drain an older batch
-	 * before changing a direct control.
+	 * before changing a direct control. A single PCC limit update also
+	 * needs the exclusive lock to read and check the unchanged limit.
 	 */
-	if (mixed_layout) {
+	if (mixed_layout || (pcc_update && min_update != max_update)) {
 		down_write(&pcc_ss_data->pcc_lock);
 		if (pcc_ss_data->pending_pcc_write_cmd) {
 			ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
@@ -3547,50 +3763,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 				goto out_mixed_unlock;
 		}
 
-		if (desired_update && !desired_pcc) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (min_update && !min_pcc) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (max_update && !max_pcc) {
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-
-		if (desired_pcc) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (min_pcc) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-		if (max_pcc) {
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-			if (ret)
-				goto out_mixed_unlock;
-		}
-
-		if (pcc_update) {
-			WRITE_ONCE(pcc_ss_data->pending_pcc_write_cmd, true);
-			cpc_desc->write_cmd_id = pcc_ss_data->pcc_write_cnt;
-			cpc_desc->write_cmd_status = 0;
-			ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
-		}
+		if (min_update || max_update)
+			ret = cppc_write_ordered_perf(cpu, perf_ctrls,
+						      desired_update,
+						      min_update, max_update);
+		else if (desired_update)
+			ret = cppc_write_perf_controls(cpu, perf_ctrls,
+						       CPPC_UPDATE_DESIRED,
+						       false);
 
 out_mixed_unlock:
 		up_write(&pcc_ss_data->pcc_lock);
@@ -3599,22 +3779,14 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 
 	/* A request without PCC updates has no payload to coordinate. */
 	if (!pcc_update) {
-		if (desired_update) {
-			ret = cpc_write(cpu, desired_reg,
-					perf_ctrls->desired_perf);
-			if (ret)
-				return ret;
-		}
-		if (min_update) {
-			ret = cpc_write(cpu, min_perf_reg,
-					perf_ctrls->min_perf);
-			if (ret)
-				return ret;
-		}
-		if (max_update)
-			ret = cpc_write(cpu, max_perf_reg,
-					perf_ctrls->max_perf);
-		return ret;
+		if (min_update || max_update)
+			return cppc_write_ordered_perf(cpu, perf_ctrls,
+						       desired_update,
+						       min_update, max_update);
+		if (desired_update)
+			return cpc_write(cpu, desired_reg,
+					 perf_ctrls->desired_perf);
+		return 0;
 	}
 
 	down_read(&pcc_ss_data->pcc_lock); /* BEGIN Phase-I */
@@ -3632,7 +3804,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * achieve that goal here.
 	 */
 	if (desired_pcc) {
-		ret = cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
+		ret = cpc_write(cpu, desired_reg, desired_perf);
 		if (ret)
 			goto out_pcc_read_unlock;
 	}
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 957fa7775260..ded4f935638e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -321,60 +321,96 @@ static void cppc_cpufreq_get_perf_limits(struct cppc_cpudata *cpu_data,
 	*max_perf = clamp_t(u32, max, caps->lowest_perf, caps->highest_perf);
 }
 
-static void cppc_cpufreq_update_perf_limits(struct cppc_cpudata *cpu_data,
-					    struct cpufreq_policy *policy)
-{
-	cppc_cpufreq_get_perf_limits(cpu_data, policy,
-				     &cpu_data->perf_ctrls.min_perf,
-				     &cpu_data->perf_ctrls.max_perf);
-}
-
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = {};
 	unsigned int cpu = policy->cpu;
 	struct cpufreq_freqs freqs;
+	u32 desired_perf;
 	int ret = 0;
 
-	cpu_data->perf_ctrls.desired_perf =
-			cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &perf_ctrls.min_perf,
+				     &perf_ctrls.max_perf);
+	perf_ctrls.min_perf_valid = true;
+
+	/*
+	 * Keep the cached Desired within [MIN, MAX]. Rounding can put it just
+	 * outside at the ends of the range. The policy limits may also change
+	 * after the governor picked target_freq.
+	 */
+	perf_ctrls.desired_perf = clamp(desired_perf, perf_ctrls.min_perf,
+					perf_ctrls.max_perf);
 
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	ret = cppc_set_perf(cpu, &perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
-	if (ret)
+	if (ret) {
+		WRITE_ONCE(cpu_data->perf_limits_valid, false);
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
 			 cpu, ret);
+		return ret;
+	}
 
-	return ret;
+	WRITE_ONCE(cpu_data->perf_ctrls.desired_perf,
+		   perf_ctrls.desired_perf);
+	WRITE_ONCE(cpu_data->perf_ctrls.min_perf, perf_ctrls.min_perf);
+	WRITE_ONCE(cpu_data->perf_ctrls.max_perf, perf_ctrls.max_perf);
+	WRITE_ONCE(cpu_data->perf_limits_valid, true);
+
+	return 0;
 }
 
 static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_ctrls perf_ctrls = {};
 	unsigned int cpu = policy->cpu;
-	u32 desired_perf;
+	u32 desired_perf, min_perf, max_perf;
+	bool update_limits;
 	int ret;
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
-	cpu_data->perf_ctrls.desired_perf = desired_perf;
-	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+	cppc_cpufreq_get_perf_limits(cpu_data, policy, &min_perf, &max_perf);
 
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	/*
+	 * cppc_set_perf() does not check a Desired-only request, and rounding
+	 * or a policy limit change can put Desired outside [MIN, MAX].
+	 */
+	desired_perf = clamp(desired_perf, min_perf, max_perf);
+	perf_ctrls.desired_perf = desired_perf;
+	update_limits = !READ_ONCE(cpu_data->perf_limits_valid) ||
+			min_perf != READ_ONCE(cpu_data->perf_ctrls.min_perf) ||
+			max_perf != READ_ONCE(cpu_data->perf_ctrls.max_perf);
+	if (update_limits) {
+		perf_ctrls.min_perf = min_perf;
+		perf_ctrls.max_perf = max_perf;
+		perf_ctrls.min_perf_valid = true;
+	}
+
+	ret = cppc_set_perf(cpu, &perf_ctrls);
 	if (ret) {
+		WRITE_ONCE(cpu_data->perf_limits_valid, false);
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
 			 cpu, ret);
 		return 0;
 	}
 
+	WRITE_ONCE(cpu_data->perf_ctrls.desired_perf, desired_perf);
+	if (update_limits) {
+		WRITE_ONCE(cpu_data->perf_ctrls.min_perf, min_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.max_perf, max_perf);
+		WRITE_ONCE(cpu_data->perf_limits_valid, true);
+	}
+
 	return target_freq;
 }
 
@@ -669,6 +705,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	u32 desired_perf;
 	int ret;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
@@ -727,16 +764,39 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (caps->highest_perf > caps->nominal_perf)
 		policy->boost_supported = true;
 
-	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
-	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
+	/*
+	 * The request starts from the live limits, which may be unusable.
+	 * Firmware may leave them zeroed. An interrupted earlier update may
+	 * have left MIN above MAX. cppc_set_perf() would reject either, so
+	 * request the full range instead.
+	 */
+	if (!cpu_data->perf_ctrls.max_perf ||
+	    cpu_data->perf_ctrls.min_perf > cpu_data->perf_ctrls.max_perf) {
+		cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
+		cpu_data->perf_ctrls.min_perf_valid = true;
+		cpu_data->perf_ctrls.max_perf = caps->highest_perf;
+	}
+
+	/*
+	 * Keep the initial request within controls left by an earlier driver
+	 * instance or firmware. The governor will update the full tuple later.
+	 */
+	desired_perf = caps->highest_perf;
+	if (cpu_data->perf_ctrls.max_perf)
+		desired_perf = min(desired_perf, cpu_data->perf_ctrls.max_perf);
+	if (cpu_data->perf_ctrls.min_perf_valid)
+		desired_perf = max(desired_perf, cpu_data->perf_ctrls.min_perf);
+
+	policy->cur = cppc_perf_to_khz(caps, desired_perf);
+	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
+			 desired_perf, cpu, ret);
 		goto out;
 	}
+	cpu_data->perf_limits_valid = true;
 
 	cppc_cpufreq_cpu_fie_init(policy);
 	return 0;
@@ -756,6 +816,8 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	cppc_cpufreq_cpu_fie_exit(policy);
 
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
+	cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
+	cpu_data->perf_ctrls.min_perf_valid = true;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret)
@@ -765,6 +827,16 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	cppc_cpufreq_put_cpu_data(policy);
 }
 
+static int cppc_cpufreq_cpu_resume(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+
+	/* The platform may have reset the controls during suspend. */
+	WRITE_ONCE(cpu_data->perf_limits_valid, false);
+
+	return 0;
+}
+
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -909,24 +981,34 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	cpu_data->perf_ctrls.auto_sel = val;
 
 	if (val) {
-		u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
-		u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
+		struct cppc_perf_ctrls perf_ctrls = {};
 
 		/*
 		 * When enabling autonomous selection, program MIN_PERF and
 		 * MAX_PERF from current policy limits so that the platform
 		 * uses the correct performance bounds immediately.
 		 */
-		cppc_cpufreq_update_perf_limits(cpu_data, policy);
-
-		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+		cppc_cpufreq_get_perf_limits(cpu_data, policy,
+					     &perf_ctrls.min_perf,
+					     &perf_ctrls.max_perf);
+		perf_ctrls.min_perf_valid = true;
+		/* The cached Desired may be outside the new MIN and MAX. */
+		perf_ctrls.desired_perf =
+			clamp(cpu_data->perf_ctrls.desired_perf,
+			      perf_ctrls.min_perf, perf_ctrls.max_perf);
+
+		ret = cppc_set_perf(policy->cpu, &perf_ctrls);
 		if (ret) {
-			cpu_data->perf_ctrls.min_perf = old_min_perf;
-			cpu_data->perf_ctrls.max_perf = old_max_perf;
+			WRITE_ONCE(cpu_data->perf_limits_valid, false);
 			cppc_set_auto_sel(policy->cpu, old_auto_sel);
 			cpu_data->perf_ctrls.auto_sel = old_auto_sel;
 			return ret;
 		}
+		WRITE_ONCE(cpu_data->perf_ctrls.desired_perf,
+			   perf_ctrls.desired_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.min_perf, perf_ctrls.min_perf);
+		WRITE_ONCE(cpu_data->perf_ctrls.max_perf, perf_ctrls.max_perf);
+		WRITE_ONCE(cpu_data->perf_limits_valid, true);
 	}
 
 	return count;
@@ -1059,6 +1141,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
+	.resume = cppc_cpufreq_cpu_resume,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 5bcdb0e553b9..4495ee4ab71e 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -165,6 +165,7 @@ struct cppc_cpudata {
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
+	bool perf_limits_valid;
 };
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-- 
2.34.1

