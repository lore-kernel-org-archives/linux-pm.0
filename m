Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793381345;
	b=pQqxIY2WhTEyEcdlGl3b6MPoxo60Xxcdsed5bYsCbRUmInUqZGGs4lxNQaT2XJwocuHt
	 K6JsLqYFw1kVfvGupAwoUln5gyoaBT7INIJ1skY75QhMC95Y4tDgcDf4VEF5TJr38UCS/
	 Xq1uKdYxEHmh92roqFovWgSm3YKcxX6C7shG77NgaB18tH4MMyNv6GpYbZYjE6+fIkorA
	 3S4CJTBoSccLahcew0UK59YeymnIzbgwp63VNFXssl3RHboN6HocPYawjmfY3+j+b7gRW
	 mJJojwSzyJeqKLJeKD5C4/qh1IrDWaUbI5wnvD0Uf3GbGfx7aTvnjSLqQ5HjUx1zB6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381345;
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
	bh=xpvWQDlYOiijXmGKeWOq5owkuqv/q4EsT3XEZFDqn+E=;
	b=yrQUlHKKdGR/d16nqwCZ/vAn0n0eXXbbIhWdq6/5HbW1cM0BqsIf6JpYgXHvmyQ6g6Lh
	 Lfd/fMUeFn2FlH3nYpxWBAusdpj41ApwpWPSrcS8Xgb8Oci73+Jpfe8SFDrmmslKC5Y8H
	 Ut5MqEPQXt7/a4L2yvYCgTDE18w5NR3C5EvhzQ3DJUucM6+x0U7R5DMbbUbNYnoPHV/ie
	 g0llmLO+wTglvnsN2v0U8UiMvg7SMWfcngoyZwVHrgKqKpGndm9FMu57ygp25f2lUNzsR
	 oZITWDeyGM80pL3Pos3ZyIpTfoo6lhct2KrHageRxROndJIv+CuL6KfY5gYCvb5US5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C9FcXg43;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.9
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507B606A31E;
	Fri, 30 Oct 2026 17:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D507B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C9FcXg43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKxpAwfIx8Dz6X6Mi+JfPK106wxlFEpYLUV9X3S40B/ZegQJHamtpIallemgLvPgD9oaoaI5Cvo60z1VtEBXYzzCMkdJN5kofmE0CCZ9ALOZwmpDJgFtaAcKSR8mc+rDcDuSvu37sOT1cRvWouMgpjQU46OylNm/2c/kESF+bWa0ArQsKjED2SuLHZ9vjqOAyinvpbIzXEtkvd6bqjeXMlMLaEJwfi5l+1BiYJSK9brXRRAQ9LDoAXSNLi8NDDakIsmrWmlVnWhXijBikEOclFQd7H6HuJEMYlnSZ/jBlrws3HwrJYVkLYXXwzulKZfh4UmTAOuWalm4Ed2LFEB2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpvWQDlYOiijXmGKeWOq5owkuqv/q4EsT3XEZFDqn+E=;
 b=T/6t7u+CixHBCE3tC0Zmt+8ynlv5lDxkTIrV5VKZ9dLcoK80fVt/pL3+HBClv321Rt4zG1iJm+2HWTpmoWrapyvO6chesQs94EpaQc84wQiH2963gpB/vV1LCn0Y0Bt7K2bMg8DVhMd5DR0ru+xdXXvxBeqJVgO653cUKVrX7XV684SiwQTqSMhcoQE4XS4RVZUZtXA46PubDPvD9zvuWuqkkKnyRwzWOJslZmP8HoIitRHOjA10ERSLC8XUCreUx6YYMSf2+lkxbynnX/KtcT8IME7o5/z6rE+kH5uY+ac3dAoZooZLtZonDdFgk+NONYyJdS9c1m9/u+6grWGuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpvWQDlYOiijXmGKeWOq5owkuqv/q4EsT3XEZFDqn+E=;
 b=C9FcXg436xKqv795cOUK+sS0OY9/XfYs6eFTbbwTcKum92SGLXTpwsJYR1SLG4KLZAtcCNx72Vla+PuQhZGQCdCreYRzKLuuSNUkYUUo3jije1dzorjRUdI2XHpPLe2qjymroQ6Itushx1yMgdpZog37TQ7cwI0ZnUBpTBOBD/GrZhW8SFKpy+72SJP1xvd14ukauJuDUCw/FUcnQelIdQTgPdvPVvX9DCZOQhc/095w5/3ntXyw1hYKLUbZVVkMHD10B2ljBXiiGggp87U1TGA/DpdX+LJo4ziHmuCkqXnhx/vW04+cASlpbZQIuwGO08CXgU/2At4O1+2DacVRNA==
Received: from PH0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:510:5::9) by
 DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.10; Fri, 30 Oct 2026 17:28:57 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::35) by PH0PR07CA0004.outlook.office365.com
 (2603:10b6:510:5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 17:28:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 17:28:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:27 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 10:28:20 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<mario.limonciello@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v8 1/3] ACPI: CPPC: Add ospm_nominal_perf support
Date: Fri, 30 Oct 2026 22:57:43 +0530
Message-ID: <20261030172745.2045743-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030172745.2045743-1-sumitg@nvidia.com>
References: <20261030172745.2045743-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fc9bc6-e06e-4e74-d673-08df36ab46fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|261026121527099003|261021121427099003|261009223027099003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	xlQlAIj8EUEB/hqqz4MCJF6BDilVRgyE7w68Thr3JPBKYBbmo7T+f3kN79m0udUCAyYyIS55sh+9bTR6sRSouhEdUnhJ0b4I60DqRnNfl7+GaKnMv1fRfXIV0Ijw/bGK1NFoEcwQj6pjug1fTOcu21pkPrvdQ7pLHmAE+0je8PlG8bMla5AaDT5ZZR8dQPli5E4jmKVamYEphrWe6F7ziPtRxUYsOhT4sIi61Hr/xXyWrDOLk4Ya7MbkIIqPRS92vkfeqLP7sNbFCw0EEoCvh7E9mDt3Y3U18ydOQfOMAYL4LUWrgWlwVXsY3agm+JIaSEGTN1Kwgky2+cJpFRq2gcxXoui08xAqcyhJp9U4UphziqyxnCmKw6su6maO/VLZV9MpT54tZ8NSM15D+MlVoYXoy2vJHBSJNBy1yITg2+NF5eqrwm2K5pu1E/Tgr5d5mS/im4mSeN3lJEIaepaqkQq2nI1nYduFrWCZdEsrmkjqfvFUpb9KPtCJXi34L5mhKPBoTco/xDMN91kHvKTDnsD564IL79XbFI+obvNHtOBaDcFiRbk+IbzHlmlK1lOzZOUTLGLGcP4USWms+XGnmaYNORa6YxQ17OFoTDUteWxsqPcdqU309Yo+AuVaprowPTq8kWNinjdh7nRGftbYhIyJ04nvfKiJ4f7xyLR1NkPheBNtsN9w2/90HESTjOE/iRgVzglrALiTXyMv3BPIrrjyj2+5zzb5Z/qKiF3aFI9yv0m8z7tSs0MgESUeFVUp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(261026121527099003)(261021121427099003)(261009223027099003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uwebIvQNxQENqOfy0K7UVcHVCj+6xu7mKYp+SRIsG2Rj0dbrXhDg9PDnEmkOwpDCu5fLeImUIyRw5tcD4H/CEk7r6ns5gqwmXMkcrA0xpoxKMpN6v7jR4UC1EL1+CfmdyvBxHEi3eutFAfqgxwPkCeivndOgnC+b1wJy3j5YcQZgA+b9D6iTFBVUFFqJ5Tr6QR94kfty1Uom5YHi3BYF2M1pTcawcJMFxgWq3L7zEPRenROS0gEutado5J8I2+dPBox58Saw5WjnAeyUXBuF3htstMtS11+We/xsDb08HpKrwuiz+5LG+Fueojlm6GBFbsDysm6F3K/5B60FCSegz/jn/NVPB8edrukL7EYT8hifPzU9VGe6e6z4txAwrDkFgxYcKec1IWkwlabWdXwt14wTS0GG8xaduCrCA41ZuZbT01NpAGt0YSRHrOtlk9hS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:28:56.7853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fc9bc6-e06e-4e74-d673-08df36ab46fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861

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

