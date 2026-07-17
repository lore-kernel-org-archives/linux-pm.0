Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65943B14D4;
	Fri, 17 Jul 2026 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325277; cv=fail; b=VHVNLaGK6Q1GjvooO15AdH3E3ewT0TF7dNTaBSo7X032L0+9du1FUayNlq0dWDQljtIr3WusuCvvoux01YkJR0oanjNxhK2JSeIetaagDGzACg+4dKm9nZAiC/RLIFxBFteYpC6fOq5BWNB5bSEVJoyiSy0Rq4SmXFqqYd6cMks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325277; c=relaxed/simple;
	bh=EANHh8/R9Mq/oysjEYutOD5yHaxJUWLMyD+fjBTAqGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyA9Olph20OnLY6qbpTF4a9dLTAKWF0lANNwJyB33cMNAv3kjctX8zOfZd2LjZjnsDH/C+eqetYsRxx4xB0vuvG7coqknG7bRALFlpj7U/GU5GmybHel5w61MBpDodjaxqB9v2i4UU5DzWEw9IoCMWyO9B17DUH/EqC9XTmqPzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kGFbyG62; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kGFbyG62"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQAprv2hzBLW9ZqoyRkGCC0AqcKrpZ2UlwuXoJHb0XqerQu3Z9AkT/9RwdSbvQSh5yYpstSSEHeEA+vtSyBU7Cpu03q6U0GJYcSbwOOYGYtL0uPQ62xopYoMbM0kdueMwi9CN3If8WBGPQKMZR4e3v/39xdwwz/oruTq2u5KHqCm6stmC91LcM2o8amk5w+3kDC9iop9RpimMHN2mrGMFBT3Ilz8ao86gwVW+/cb6WQgaalQAtjnWw5w/VGSTEMynyKG5d/DCCDRNJNL4k4fvZdx7OeCZkGb51N4nqaoTTchj6CnIdOUcV2qkRHu7C3igk2rvbnvvpDSTbcqYMpa+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53uPTuVYjXEexomO5YjnYKjkvrDNkErHJ+5Y/yjPuNk=;
 b=WBVS/yC9MJhLmJK+u0pFEH8Q65QAZnrI68dDlhCJ72hrrq4qTd5WwPMrP7L4e8fMOUzQD2fYyTFqB4U63oNVTcZ7GFfS36Wrw/68Gpljf0GIZX2t/bDZPVR2p1eH4YKKVg/4Lie0x610rAjlZf6J17IfVCqnGDhKWCjtucRKjWgw31Q3hqi7B9HsU0q70tSKoUDZqWFvugI0iXVOTVYNedc5K/AsFXqwEd7UghZYbDaec82ziCssUvZkel8XmbxSy553UCsNhD8rhgSbZR2ml1y79+oepjSLTSSLU+QTMfc3Ca/rEDoE1suBRedQCaZz+PvyK5fG6pibCuQWuOmD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53uPTuVYjXEexomO5YjnYKjkvrDNkErHJ+5Y/yjPuNk=;
 b=kGFbyG62ZSvFu9A3n557f4he+e3nQ9ywqprXejUfDdJgDnaOFe4T15MS9xhMiHCI6fw31nbKXdZfLLvvvbqLigCNk1pBxp1H7tqMvVGL5wOw73fabcCI3nppNLqQERFeRJ2S5GladpkUBaZo+rBrDiu2equ2DpICNvalend/i71E3ynTmHSPfllPSgR6Rg5iroHUgJcihLYY01VAv/9DoF1wIWlbTFmXLLBAvQdRqGQgdnKLLgy5OF2i0RJ+83R1N3GwGYbgHZY7iCASQuIzvMpEq+Crerxg2gh398vhspVQ+ilRYw7JsB/lDEcMAS6BnH9gS7gDV5RvtDNl39udQA==
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 21:54:15 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:80:cafe::63) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 21:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 21:54:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Jul
 2026 14:54:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Jul 2026 14:54:00 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Jul 2026 14:53:55 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v6 2/2] cpufreq: CPPC: Reflect ospm_nominal_perf in boost and limits
Date: Sat, 18 Jul 2026 03:23:30 +0530
Message-ID: <20260717215330.2215058-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717215330.2215058-1-sumitg@nvidia.com>
References: <20260717215330.2215058-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dccf1c-3c98-4d0a-7e1d-08dee44df1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|921020|18002099003|22082099003|3023799007|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bn6VXGNCPZtxCfkIp/ZhgVEHUrYqDEQV9v06moQmCuK/qS4kH+fL03zbi0Imo2qLzN3L/YOGWrPbqptNx/EOcRJJvUb1pDh1TT7OQ4xxzwlDJ3RK41jlh9bw4In8EUdF/yHeSo51V2D/mNXpKvp4kSGNstTv2l1omdNF/1/dC8sunlqizQjs2BsZtB8Q6ljNZSPeU8TfdrnLtzqxDzTVlilIlRFQAUzgTfjJvb3h0oSPcEw40pkJvZrpNvSZt30yn6kM+pFD3fco8n6dCi+Rh0JBrlhXO0LkLIrmYw+drmIvx5pb/JTDNHinJ39oUr1V0iHvcDfx1qI62eho4o+abPuiTEDA2gCRpzCRfp33AeRcWTwoeSX3b/AAz0cz7yV4vL9GdrsrYEw1XTBFBRT6gB1dU9phoyCyLDvInzh4w6WCrTguRsGqp11rO6bL1gxC5/g98gnJPcLcRaxeL5Xa45cvExJIZG1R23TfCZ0EeyAVLeThiM384hCA376pROhVkuGvh3JgXjugm1NSCK5vFCYP2Jkh1ZlFqAeBHihpW+9rQDYaKAiRHJYEhh7HTqyaE/4aXzPSStcvWdwFaEGjjprttu4ecCZ+0PZb5tIuZrhwnIygYgbmyEC7WtU5ggtkrhOwsPrfQBAsZ4ChFLhIrlOZ3l8WlcZvCyvn4O5ARr375+jGn45hqE0pVg6zDrDYxVbxUatgH9d0bwnaSmMmccQSCAwJqH6AIlcyh4SLFHqOr9zD+SRxx8Dq45IiDbPN
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(921020)(18002099003)(22082099003)(3023799007)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GurUrBGbpvKk0vlHl2g+X++ou9DtaSY15fY7Qq+RK4gkUNNn4xtwF4cFOpjBYzOLGKeCpgkch/z75tWV5URe1wQyzvC745W6Vyql5cD5AIXRkmtgxKHCQgbMG2bIVB1Ro8smhLmfo6PvaQhHXlX6rFq7LbUgg1Jfl/F+h8Lm0JBpYlZw4NLyF1XyzL/34JgmucF2Fvtzxpgqx8p3QQSziaQ5sb0UeF+6JKfpSG54kKYX1ZtcxpB831RjgQ2/brQaroFvo0cid339mfjw22JrZNjlazGtDpY2AjXmEBDOGzDLJSahAwSPoHNEpNDVR7MaCd9GSRJJvz0TNbYBctvGVk8i/orNXrzzFXEwashokWKTRVLLMqZSag0jporr6kerGRDbgfdBk6fqlU6I04r/tB7zevlNbV/KsNI22RVUsLJuAtBHpqRJLG95n9mv4paL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:54:15.2762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dccf1c-3c98-4d0a-7e1d-08dee44df1d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651

OSPM Nominal Performance lets OSPM request a nominal level below the
platform-reported nominal. Since boost is the range above nominal,
lowering the nominal enlarges the boost range and drops the non-boost
ceiling.

cppc_cpufreq currently uses the platform nominal as the non-boost
ceiling. Changing the OSPM nominal then leaves the policy limits
unchanged, so the boost and non-boost ranges no longer match the
register.

Reflect the OSPM nominal in the cpufreq policy so that boost and the
frequency limits stay consistent with the register:

  - Add cppc_cpufreq_get_effective_nominal(), which yields the OSPM
    Nominal Performance when set and the platform nominal otherwise.
  - Use it to derive cpuinfo.max_freq for the non-boost ceiling in init()
    and in set_boost() while boost is disabled.

The cpufreq core includes a per-policy boost QoS request among the
constraints that cap scaling_max_freq. It updates that request to match
cpuinfo.max_freq, but only when boost is toggled. Writing
ospm_nominal_freq changes cpuinfo.max_freq without toggling boost, so the
request (boost_freq_req) is left stale and keeps scaling_max_freq at the
old nominal. cppc_cpufreq_reflect_nominal() therefore updates the request
directly when the nominal changes while boost is disabled.

At boot, when highest_perf == nominal_perf there is no boost range, but
lowering the OSPM nominal later from sysfs can create one if
highest_perf > lowest_perf. Since the core registers its boost
FREQ_QOS_MAX request at policy setup only when boost_supported is already
set, set boost_supported in init() when the OSPM register is supported
and such a range is possible. Boost can then be enabled once the nominal
is lowered.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 119 ++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index eb6746810fa6..048bb567ec45 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -761,11 +761,63 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 }
 
+/**
+ * cppc_cpufreq_get_effective_nominal() - Get the effective nominal performance
+ * @policy: cpufreq policy associated with the CPU
+ * @nominal: Updated with the effective nominal performance
+ * @supported: Updated with whether OSPM Nominal Performance is supported.
+ *	       Pass NULL if not needed
+ *
+ * Use the OSPM Nominal Performance value when the register is supported and
+ * contains a nonzero value. Otherwise, use the platform-reported Nominal
+ * Performance. The resulting value is the non-boost performance ceiling.
+ *
+ * Return: 0 on success, or a negative error code if the register cannot be
+ * read or contains a value outside the supported performance range.
+ */
+static int cppc_cpufreq_get_effective_nominal(struct cpufreq_policy *policy,
+					      u32 *nominal, bool *supported)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u32 effective_nominal = caps->nominal_perf;
+	bool ospm_supported = false;
+	u64 ospm_nominal;
+	int ret;
+
+	ret = cppc_get_ospm_nominal_perf(policy->cpu, &ospm_nominal);
+	if (ret == -EOPNOTSUPP)
+		goto out;
+	if (ret)
+		return ret;
+
+	ospm_supported = true;
+
+	/* A zero value means OSPM has not selected a nominal level. */
+	if (!ospm_nominal)
+		goto out;
+
+	if (ospm_nominal < caps->lowest_perf ||
+	    ospm_nominal > caps->nominal_perf)
+		return -EINVAL;
+
+	effective_nominal = (u32)ospm_nominal;
+
+out:
+	*nominal = effective_nominal;
+	if (supported)
+		*supported = ospm_supported;
+
+	return 0;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
+	bool ospm_supported;
+	u32 nominal, perf;
 	int ret;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
@@ -788,8 +840,17 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * nonlinear perf
 	 */
 	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
-	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
-						    caps->highest_perf : caps->nominal_perf);
+
+	ret = cppc_cpufreq_get_effective_nominal(policy, &nominal,
+						 &ospm_supported);
+	if (ret) {
+		pr_debug("CPU%u: failed to get effective nominal: %d\n",
+			 cpu, ret);
+		goto out;
+	}
+
+	perf = policy->boost_enabled ? caps->highest_perf : nominal;
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
@@ -819,9 +880,13 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
-	 * is supported.
+	 * is supported. A writable OSPM Nominal Performance register can also
+	 * open a boost range at runtime by lowering the nominal, so assume
+	 * boost is supported in that case too, letting the core register its
+	 * QoS request up front.
 	 */
-	if (caps->highest_perf > caps->nominal_perf)
+	if (caps->highest_perf > caps->nominal_perf ||
+	    (ospm_supported && caps->highest_perf > caps->lowest_perf))
 		policy->boost_supported = true;
 
 	/* Set policy->cur to max now. The governors will adjust later. */
@@ -992,11 +1057,16 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u32 perf = caps->highest_perf;
+	int ret;
 
-	if (state)
-		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
-	else
-		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
+	if (!state) {
+		ret = cppc_cpufreq_get_effective_nominal(policy, &perf, NULL);
+		if (ret)
+			return ret;
+	}
+
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, perf);
 
 	return 0;
 }
@@ -1025,6 +1095,35 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 	return sysfs_emit(buf, "%d\n", val);
 }
 
+static int cppc_cpufreq_reflect_nominal(struct cpufreq_policy *policy,
+					u32 nominal)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	int ret;
+
+	/*
+	 * While boost is disabled, the nominal is the ceiling. Set
+	 * cpuinfo.max_freq to it and update the core's boost_freq_req to
+	 * match. The core only syncs boost_freq_req when boost is enabled or
+	 * disabled, so a plain nominal change must update it here.
+	 */
+	if (!policy->boost_enabled) {
+		policy->cpuinfo.max_freq =
+			cppc_perf_to_khz(&cpu_data->perf_caps, nominal);
+
+		if (freq_qos_request_active(&policy->boost_freq_req)) {
+			ret = freq_qos_update_request(&policy->boost_freq_req,
+						      policy->cpuinfo.max_freq);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	refresh_frequency_limits(policy);
+
+	return 0;
+}
+
 static ssize_t store_auto_select(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
@@ -1208,6 +1307,10 @@ static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
+	ret = cppc_cpufreq_reflect_nominal(policy, perf);
+	if (ret)
+		return ret;
+
 	return count;
 }
 
-- 
2.34.1

