Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993699;
	b=2fc1JJABh1+FWWEHallkoRVWAF+9ibj1g4OXFHJ6ucNL/dGVHI0ldslu0+wgvry0nPZL
	 lb0jgHTfMIIA4HQ0GRRG2VWslX0pHBpTtLbvQPKVnc9nDZj5/fVfEhhwm286dtUfIQZ+g
	 yVEAoqDY45lBBqpLzN8gY3NMbsJlztQget4clyQZZSf0Jvg1RfSidJTrIM4g41OSv8MxP
	 oNjQ0fjmGyeEzOhrcHjcDDK8baUseTVGuPeD+6anZFYzxUlW5ZEbpkKPkMOPWxypFzxQp
	 SIW13ohcxVgiCp1x2ucetQt9AoENFs77zBIK0/4+gQuav1Wqa036qaQpxyhCoIJTxJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993699;
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
	bh=afyXjCTWhq7b2IL8YBafWuVD9fTLcpUXwCyBkuxLgwo=;
	b=vup69FaSw8g6Ze4Dn5UIsfPMNVa/hW6wq/Xs+mPwtsJmKz7b3kUNo/GDnM5Jt5JWLboO
	 he/qKTvVtg3u1rN+QFNkj4onDeM27rpnBR1FPKlTwoS1cp+2z2srO90wxQaDasgDoXCYY
	 1fSQAkwT9FzNaxRjKxKg+xE1g2m3Fjf9jn/8813vW9TxHl2KxtPhAqp1Ib5OEx4nZ1jLu
	 sQWKPRdamHEj36CBkA+S7H8x+jVyvH6UH4C+YvrtGF2Fq2g641hdhc6AlfcfPfi53aUMT
	 mZL5/nLspOgdozJxUDt5dCHkyeUgrK6RIUTlczWxZtXyXyxeddzpI848F1EX3OOPmjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uUqdrJl1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.43
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652F606A32C;
	Fri,  6 Nov 2026 19:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0652F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uUqdrJl1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKUjdPvoUnpXHvnSooOymq4Z3zK0/+e61hfNheDctnq7TmztmN5NcCWhspRNAZsoUizFksZYGX03ezrgvrg0V8qcOiKbV0/5MitfxBYYgrMu9Dnym2WTq3wj7cSv+GNMj0Mqo9y9Tv6fTdT+5+BuJ7m+ma/nKODfVgPEBAOygjb2ofPacur0+WazGct44xUwz5XXtC6liehJFUCdBBiR6pxEoX4F3OhMWLzKatzvm0YaX10cFyaMod4swRWOmnk3pd2dKsnzw6t+RGz0ZgmcxqVrkj15Z7fs4egBVDBMVZCAdOE2M903MzIUcgBFRa1pQ8pV4bGHklFzSSV63iW9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afyXjCTWhq7b2IL8YBafWuVD9fTLcpUXwCyBkuxLgwo=;
 b=yjHYH86OUG6WKHmUJ/l08WiG3gzODXHKu/j2ynOmK0STopdU6w1B0FEx5v57uSOEnJeFfv1ntOH6AHtIBY79M5f0uU3eRXBouXOsJC1CF3b8LwhFa8RbDJJM2pyXwu9HSkKKfwazv26T/d2gpHtFec7cWC8Vww6lD8ATSTln2473uQDmo2lR4b4Z4+XDpZmSxV2JzRwylgjQ9PMPLZUUR7iAtaXf1RT9X+KbXiFtL5tlrgp7sO7yp4LRvKOso+qEc/S/biut92Q0mcRF2JW7NHIVeIJdFfcylqJ4PvpNTx55eI81K22lvAZTNApTQMhdyv7NUtENXGfE9jnxNhl3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afyXjCTWhq7b2IL8YBafWuVD9fTLcpUXwCyBkuxLgwo=;
 b=uUqdrJl1kKJiyHkSvoBF7Qgji5wpsZodSGYSLFB1EznVq1Dq8Ipr984HfSEiqN89dRPIaHzBt3FnWSlGY5L32JY+EZW7jpwxSbFDEl9QtJj2CRsRE8BDB/6r/SDR7dEAd2BgIab31cvONPU1UTBXJdpCv6r4qQ9w2aO2KvEWKsX5cVQ2J9wDiNHYqyXvka0QiJFfcL+DGYojWICAPbO4b2Kx+Ck45u4TA/SIj40yj6Vj4yD5kw+Wx/GcyukAnHCQ1twQQ+hUBNy2MEQD0EmjptsAhSW6sQ+UUWx48cQT4hqNW0XXsUKLzg1Ml3cyVyTNuXfqN2epSKuv0sCov9JUXg==
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 19:34:47 +0000
Received: from CH3PEPF0002457E.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::13) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 19:34:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0002457E.mail.protection.outlook.com (10.167.252.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 19:34:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 11:34:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:34:27 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 11:34:21 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v9 6/8] ACPI: CPPC: Add ospm_nominal_perf support
Date: Sat, 7 Nov 2026 01:03:02 +0530
Message-ID: <20261106193304.3347374-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106193304.3347374-1-sumitg@nvidia.com>
References: <20261106193304.3347374-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457E:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c3d69c-efb2-4867-3d30-08df3c3d049e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|22082099003|18002099003|6133799003|10067099003|921020|11063799006|261102123227099003|261102130727099003|261026121527099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	QtX8zLUKNczGOwGaETZCiENSAeERzC7TVUZJRGreByaZ7RfQo4NghJlNF1ilfX7zb/lIXIRQdYGrAdzPnB+2er1xSWyR0ZcpJlxlU8tK4JivS0TLKSYy2+5/Rt7VZfPnq+XBIGpbL89LnlX69kPtPaCpbHO/bOWwMllrAQixGAezr590K2MCvRNCNf8HEaeADDAGXFFaTocViHkVGV7d89hwpigPMgIcTayc6ERg2Ac3Z0nEoUuyWqDHF6898fPTCKyu/urYlfzPGdKhsRFXLhWLwp/5d4imdJsmHmkj4LcMAYWVI69x2yyXsIR31xm1NhG4gt8NOemSw4b+zzn8PjnPmZem1g4qgEtgn52SvtWqowzSNutQkl67MoUTulB+TM1pJu4LWDPK971dr/z6UdDnOnI44n0ersVFyy8vm4aHQ6gTYWKeQAyaZ5C73KchaxFSCoJ4f8NgzopKTQuUW3sfpzEjzwhT4NeMXH0Qq2AteZnWiM6Ecpx0gR93JJE+fgz/byGWiMwk/7vP3xFAF3ehurASRCoq1vgEo/oLPxE24x6b82dTQ5mjVLZRxNPmwSVyGfHykyIr6gDOfc/S0P3lKPJKSTk25oskWE3l/PasPFHPkGFnBF0hbA/iHuiT6AhO768lAO8LZTy5D22Tj3bYrJTBL3wVqVgjNL0qjCdsXrE90/Hism7DeIo7crmUdnGfUFwNfPg5WxjwS6Apj8H5q8TRO81W8K4nM5CqY5Utj8eef6wymoCBHW50lcfd
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(921020)(11063799006)(261102123227099003)(261102130727099003)(261026121527099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FNJ+V4+bmDZSSmZXwyvRhMQBUD+lSUoUZJvoIQUAJxMSQB2h7tgg7xGTZiksniRVuLvqUbuAFC840LddjsOHJZvx6jTx8VWsoabgpqBu0QbhwHNxYemxADEM1/tqu1WZZYrvW3BSImkZTAmlALFtfdkwOichrKPZrUwNVGjyfHFH4qfSAOSz6VxlX7HANfGluKhxWmZf84yW4uJB4kc3NOuZwcKWAZyjAypX8Zd+pifG6oLi767dsQdaweOkpMBm1v7GrzdNzDCIP/zW/XKmHlZepWIdrynK0hBvJzCZ2qcYD5rqffS/2E7Doxy0sDLv0K5b3S33gDVWGf/H12DLqA4WVj3Rax5nrGOD2EejEStv/vzERCjchfzK73Ui2tLa7LfJOZwDLiZw22rn/SyZnW7FrZDqV5Vvqji6pXwOn6dp2b0YuwdUCU2zRJFWw3kv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:34:47.6483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c3d69c-efb2-4867-3d30-08df3c3d049e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0002457E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

Expose the OSPM Nominal Performance register (ACPI 6.6, Section
8.4.6.1.2.6), which conveys the nominal performance level at which the
platform may run. Unlike the read-only Nominal Performance register, it
is writable, so OSPM can ask for a nominal level below the
platform-reported one, which then becomes the boundary between boosted
and throttled operation.

Add cppc_set_ospm_nominal_perf() to write the register. Per the spec,
the value must lie in [Lowest Performance, Nominal Performance], which
the caller is responsible for validating.

Add cppc_ospm_nominal_perf_supported() to report whether the platform
implements the register as writable, since a write-only register cannot
be probed by reading it. It uses the same cpc_is_writable() test as the
setter, so support is never reported for a register that a write would
reject, and takes cpc_desc_lock while looking the descriptor up.

The register also joins the writable set that the SystemMemory overlap
validation uses, as the driver now writes it and can compete with
another control sharing an access unit.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 10 +++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 5a1f84fddb7f..3a0ecdd1ab11 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -463,6 +463,7 @@ static bool cpc_reg_is_writable(unsigned int reg_idx)
 	case AUTO_SEL_ENABLE:
 	case AUTO_ACT_WINDOW:
 	case ENERGY_PERF:
+	case OSPM_NOMINAL_PERF:
 		return true;
 	default:
 		return false;
@@ -3232,6 +3233,49 @@ int cppc_set_epp(int cpu, u64 epp_val)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp);
 
+/**
+ * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
+ * @cpu: CPU on which to write register.
+ * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
+ *
+ * OSPM Nominal Performance conveys the desired nominal performance level
+ * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
+ * must lie within [Lowest Performance, Nominal Performance] and may be
+ * set independently of Minimum, Maximum and Desired performance. The
+ * caller is responsible for validating the range.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the platform does not implement the
+ * register as writable, or another negative error code.
+ */
+int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
+
+/**
+ * cppc_ospm_nominal_perf_supported() - Check OSPM Nominal Performance support.
+ * @cpu: CPU to query.
+ *
+ * The OSPM Nominal Performance register is write-only, so its value
+ * cannot be read back. This only reports whether the platform implements
+ * it as a writable register.
+ *
+ * Context: Process context.
+ * Return: true if the register is supported, false otherwise.
+ */
+bool cppc_ospm_nominal_perf_supported(int cpu)
+{
+	struct cpc_desc *cpc_desc;
+
+	guard(mutex)(&cpc_desc_lock);
+	cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
+	return cpc_desc &&
+	       cpc_is_writable(&cpc_desc->cpc_regs[OSPM_NOMINAL_PERF]);
+}
+EXPORT_SYMBOL_GPL(cppc_ospm_nominal_perf_supported);
+
 /**
  * cppc_get_auto_act_window() - Read autonomous activity window register.
  * @cpu: CPU from which to read register.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a5545fd3f8bd..2cec54b4d2e2 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -195,6 +195,8 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
+extern bool cppc_ospm_nominal_perf_supported(int cpu);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, u64 *enable);
@@ -290,6 +292,14 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline bool cppc_ospm_nominal_perf_supported(int cpu)
+{
+	return false;
+}
 static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

