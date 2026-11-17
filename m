Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794896386;
	b=RxB09NBuiaYMN2hH3eVPe0F6bas8qskiVLa787YM/8qtz93abuSQTTYtJV3e8wZHPo7O
	 MiUXxTPIQyJ9mNuj2fODGSkd2KM/WjnpC/0wqp3vkqqk7ccNQXrKEKLjtcjWXRgk55M5H
	 DUbBZM3NXGmek3LLlMr5qLPddBqeCFMKsziE8Dk7cLSnaYyL1ZvvQNcTwI+sqk+DURUJW
	 Tsp2qkvZBmVXhOGTlWV3CzM4akZj5wgcBtPdfD8P7kzLes388omgcenLrglALgyr8vIpO
	 wZMkQPLSvzNV0Yn4g7SMoQINPbEKYskFbjbp3aUSjOP//Y9cnF5c+H2s/b2xzamHlwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896386;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SjlZ78p7wLFEhCXJKZ4jBcn71CYeVjc3jXvLt2HGIow=;
	b=LWGtXhd1cStOCYuzU9LOwUE2jcwlRy2k2wVvSoQf4Rec5kJxdGsmggKzWz5FO8wUGrcZ
	 gtMroCgaZ2mMX4kkeUPMA/0Al9Mlpgd1nxJj6yNY94T/JNgOerFtJOuhFlkAPlYYdvlcg
	 KcQHcBvzBeb3dBmhpBFkthMgoAGAtY7JvcCq79NJiT7vhYjvZfth+g3kAw4hHhBt3rxD6
	 L4Z91gjDYIn515zriZd8+4CBS/X4aKxqZqWJqPWINnE4gzL7MrpLIAr6h16h86FqMf33P
	 t74XYfD6CZ0GacB1wsemIjOHauUlYZZgJCxp2Vw9QUpka90r4IFfUY1g6k5eHefOQnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mHCDa8Fi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.7
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B8606A31C;
	Tue, 17 Nov 2026 06:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E8B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mHCDa8Fi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTRJ1GtlhQLOUd4OKvg9TjsO41HEubfrCHb4+RGlLOQkVkxRa16mrzY1rgqzmtQpqsx8vzYIysaQK8G7GFK+0JE93RmbaW2wCyB/APqmpwltsxA/LHnwghH02v6rF2Uy1+eDylaWtSbqPClzlVA3CwkfOJthmen6eX3MJZ/54hK+F/Uivx+sodTroRMTMjqrmeYXN4cptxMfwIjhsJONAFMTsWdUCGO/gvDcvzUucaprXKx9Nq2IE0XlktNE1q4TfF8/NQ/OT0eN+Mun+o5/Oc3EDBrrkcR6PW1DSgxdZ3udwWUX8yuX6hMfjP0czzbAhx5ACiPcJVyfKQw5RvbhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjlZ78p7wLFEhCXJKZ4jBcn71CYeVjc3jXvLt2HGIow=;
 b=RA+D7KMXC+2L6LBvZ5hlntB+Z/Lq0RxibS5KDfjsyGShGyOhwHWSB6zAmOB6Ik4bVcoSFvZdPs1q29dPZUFpx4BPi3cAZ+YHn5t0dv2cLuBbPDAUVF5SOc4nZpvv0PZWtCuOua0IX0HnlDlBOTS01Nj3k1q2NUnTwyKGSNQb5JowCVE6IXyxiqRQ/8U9WCDI5DE5utIYROUcrwWUl1dLeasHLMhwZnIYNwThIjirQchwK1F/TMRAbfEfNlYfekav9bvrTfQjAj7F3RUShpveqAvziTK62EOsKugHApXN+CluCPzPiMWXqBa6wyTmplspuf/MzuvGt5rqWOpOS96TZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjlZ78p7wLFEhCXJKZ4jBcn71CYeVjc3jXvLt2HGIow=;
 b=mHCDa8Fi/do2Tofw0FIfaATZNOeZg6Gm+tvhh9JnSN6Zlxem9q/2Q5QzaiOU51o2sFbUyUgAp/oQWAcKu1bS1yudWaAsJg+APdoy6ZOXJtx/hi6eKeRPZ8tz1FtQf1ZRO+2zPnKZaoSSD+NBUn/BRFL/gWC1OCOHM1Uul+EbTw0=
Received: from BN9PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:fb::25)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 06:19:41 +0000
Received: from BN6PEPF00000076.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::7d) by BN9PR03CA0050.outlook.office365.com
 (2603:10b6:408:fb::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 06:19:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000076.mail.protection.outlook.com (10.167.248.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 06:19:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 00:19:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 00:19:40 -0600
Received: from [10.136.43.35] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 00:19:37 -0600
Message-ID: <69aee432-502b-4013-83c6-dde70cb59629@amd.com>
Date: Tue, 17 Nov 2026 11:49:31 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: amd-pstate: Set asymmetric CPU capacity on
 hybrid platforms
To: Vishal Badole <Vishal.Badole@amd.com>, <ray.huang@amd.com>,
	<mario.limonciello@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<perry.yuan@amd.com>, <hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
 <20261114150310.1377654-2-Vishal.Badole@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261114150310.1377654-2-Vishal.Badole@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000076:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: accae8cc-3663-48a2-81ef-08df4472c37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|921020|56012099006|4143699003|11063799006|261102130727099003|261026121527099003|261026140227099003|10067099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	d/EyDdlc/v16nQrbOgxuLNdyNw3rT/XxFNOf7DXv0qn7BdzNU2H6htAtFV5ij2xDLMR4oE1nLMMFBwIJc3OqmGzeajNBU7dhFUfjt94+g2uQpsu2qLHN9nPPi9FNPPVuibDouwEJniVem4phSo1Qkd+j6sWo3+FYj+Bxwi+NGTSBUbPXblsBjsFvEQ9/SDIzh1stIpOwtOuyag57sG0udDSOv/lKSUXsLnQf1s2t319ZczuXeeNG1aXu3QG6x7wLo+MrxPj7PxfdmYdQhJAhJGEjVM15WY8CjjDSU6uygTrGlN2UrFxu5Xqt3rnAEHDG3/l66PeE11hchbDzNdF4+seqB0VESkVsykaQPBzf0RtBHDAo2g35lTGKetcL2j3lG57+2UpCvDODy31YTcS/yIeACldlP6Ke+6LicHZKNBcC7x9Ju+qWP5zwdIiDiTqQ5xXB6X1Fy7hX0BVg9aNUJUOZj/mphVA4XW3VTCktGEyDTO/tVKUrKlyiZSLFZxrmctVN944BJBFITBfskK/OgNpwdF7eSJQOfVhr7+2i+5sf7H/630m4UFuscvsLqFCn9fM36YSu80ccjxR7DvJnf9M5I337K60UBzWWN9W7pzBpP9EcPnLILaZ4o0devp4BoigBvUK6+b9/QoTpqyeo3buPtB/s8VtkwkawBI5WAYZIPGeBE511J99bl0W85PnCOXb00IlR/X9E1RIE8o5ry6GM3ekJHpq2in2aT5JYsb1VSc5AKpV7Q7M0SDsOUuP/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(921020)(56012099006)(4143699003)(11063799006)(261102130727099003)(261026121527099003)(261026140227099003)(10067099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9QrmrPkpeJZQHs8BKlFxkBFaaOaJ5bUG+Mu0pWZGBxmQn48ac3nCjHcIt9okwlZtZNC4WOuKZS4MqoH1oOXQQX7JlMWhpU+kxmjcZcCnZ33EcYbldF01oYLDZrO8U9XbCa5oanO7j3m+KqDWf+sXt+e0hf/uPCpAQa+6nSNF+7+PXZjUZUkVX8GtNUZU1x5uee2GGabeP75s9hgYfOovinvxTLCU/ed8wnKHJ2CnlWyqh1LjYqJhtU++KEn71tpr9UlsERkAhNLXppMOdqFj7UDq2HWUaZv6fDVqLZYON9mQXZo3ogxDCesRchiMyeOGDRYaRGEaxwEAspjz0uCPvfdktSBIpQiRkOKtQNaQM9E293LEdCf6WhFTKxVYwx/wwU6vOvw0MyWCLRI7csrvl80KwxclJa2d5w+UJ7PfjPphSAH1AxgF5OWojGM7culI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:19:40.6222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: accae8cc-3663-48a2-81ef-08df4472c37d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000076.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

Hello Vishal,

On 11/14/2026 8:33 PM, Vishal Badole wrote:
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4bedfbfc18b6..59eb2c4c7867 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -29,6 +29,7 @@
>  #include <linux/smp.h>
>  #include <linux/sched.h>
>  #include <linux/cpufreq.h>
> +#include <linux/sched/smt.h>
>  #include <linux/compiler.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> @@ -39,6 +40,8 @@
>  #include <linux/power_supply.h>
>  #include <linux/static_call.h>
>  #include <linux/topology.h>
> +#include <linux/cpuset.h>
> +#include <linux/amd-pstate.h>
>  
>  #include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
> @@ -86,6 +89,10 @@ static struct cpufreq_driver amd_pstate_driver;
>  static struct cpufreq_driver amd_pstate_epp_driver;
>  static int cppc_state = AMD_PSTATE_UNDEFINED;
>  static bool amd_pstate_prefcore = true;
> +static bool amd_pstate_cas = true;
> +static bool amd_pstate_cas_initialized;
> +static u32 amd_pstate_ref_freq_khz;
> +static u32 amd_pstate_ref_highest_perf;
>  static struct quirk_entry *quirks;
>  
>  /*
> @@ -957,8 +964,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  		return;
>  
>  	/* should use amd-hfi instead */
> -	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
> -	    IS_ENABLED(CONFIG_AMD_HFI)) {
> +	if ((cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
> +	     IS_ENABLED(CONFIG_AMD_HFI)) || amd_pstate_cas) {

This keeps getting uglier. I think you should have a preperatory patch to
negotiate this and maybe a late initcall like Mario suggested to actually
toggle the itmt support.

I was thinking something like folows to negotiate the who / what gets
the owenership:

diff --git a/arch/x86/include/asm/amd/hfi.h b/arch/x86/include/asm/amd/hfi.h
new file mode 100644
index 000000000000..2a86d0049b8f
--- /dev/null
+++ b/arch/x86/include/asm/amd/hfi.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_X86_AMD_HFI_H__
+#define __ASM_X86_AMD_HFI_H__
+
+enum amd_hfi_mode {
+	AMD_HFI_UNDEFINED,
+	AMD_HFI_PREFCORE,	/* amd-pstate defined preferred core. */
+	AMD_HFI_ACPI,		/* amd_hfi defined from ACPI PCCT. */
+	AMD_HFI_ASYM_CAPACITY,	/* Amd-pstate defined asymmetric capacity. */
+};
+
+static enum amd_hfi_mode amd_hfi_current_mode = AMD_HFI_UNDEFINED;
+
+static void amd_hfi_set_mode(enum amd_hfi_mode mode)
+{
+	if (mode <= amd_hfi_current_mode)
+		return;
+
+	amd_hfi_current_mode = mode;
+}
+
+static enum amd_hfi_mode amd_hfi_get_mode(enum amd_hfi_mode mode)
+{
+	return amd_hfi_current_mode;
+}
+
+#endif /* __ASM_X86_AMD_HFI_H__ */
---

>  		amd_pstate_prefcore = false;
>  		return;
>  	}
> @@ -969,6 +976,64 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>  	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
>  }
>  
> +bool amd_pstate_cas_active(void)
> +{
> +	return READ_ONCE(amd_pstate_cas_initialized);
> +}
> +EXPORT_SYMBOL_GPL(amd_pstate_cas_active);

You can then just use amd_hfi_get_mode() instead of this.

> +
> +static bool __init amd_pstate_init_cas(void)
> +{
> +	int highest_perf, max_freq;
> +
> +	highest_perf = amd_get_effective_highest_perf(0);

Didn't you mention an efficiency core / LP core could also be
the boot CPU? How are you considering it as your highest
reference then?

I think we can tak a page from how intel_pstate does a
hybrid_set_cpu_capacity() which iterates all online CPUs after driver
registration / if onlining changes the hybrid_max_perf_cpu.

> +	if (highest_perf <= 0) {
> +		pr_warn("Invalid reference highest performance (%d)\n", highest_perf);
> +		return false;
> +	}
> +
> +	max_freq = amd_get_max_frequency(0);
> +	if (max_freq < 0 || (u32)max_freq > U32_MAX / 1000) {
> +		pr_warn("Invalid reference maximum frequency (%d)\n", max_freq);
> +		return false;
> +	}
> +
> +	amd_pstate_ref_highest_perf = highest_perf;
> +	amd_pstate_ref_freq_khz = max_freq * 1000U;
> +
> +	return arch_enable_hybrid_capacity_scale();
> +}
> +
> +static void amd_pstate_set_cpu_capacity(struct amd_cpudata *cpudata,
> +					bool highest_freq_available)
> +{
> +	unsigned long capacity, max_capacity, capacity_freq, base_freq;
> +
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		return;

What is the CONFIG_SMP dependnecy for?

> +
> +	if (highest_freq_available && amd_pstate_ref_freq_khz) {
> +		capacity = cpudata->max_freq;
> +		max_capacity = amd_pstate_ref_freq_khz;
> +		capacity_freq = capacity;
> +		base_freq = max_capacity;
> +	} else {
> +		union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +		capacity = perf.highest_perf;
> +		max_capacity = amd_pstate_ref_highest_perf;

You can just cache the freq corresponding to
amd_pstate_ref_highest_perf and not need two seperate global
variables. 

> +		capacity_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
> +		base_freq = perf_to_freq(perf, cpudata->nominal_freq, max_capacity);
> +	}
> +
> +	guard(mutex)(&sched_domains_mutex);

Why "sched_domains_mutex"? Probably means you are setting
x86_topology_update at the wrong time.

> +	arch_set_cpu_capacity(cpudata->cpu, capacity, max_capacity,
> +			      capacity_freq, base_freq);
> +	topology_set_cpu_scale(cpudata->cpu, arch_scale_cpu_capacity(cpudata->cpu));
> +	x86_topology_update = true;
> +	WRITE_ONCE(amd_pstate_cas_initialized, true);
> +}
> +
>  static void amd_pstate_update_limits(struct cpufreq_policy *policy)
>  {
>  	struct amd_cpudata *cpudata;
> @@ -1043,6 +1108,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
>  	struct cppc_perf_caps cppc_perf;
>  	union perf_cached perf;
> +	bool highest_freq_available;
>  	int ret;
>  
>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -1069,6 +1135,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
>  	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
> +	highest_freq_available = !!max_freq;
>  	if (!max_freq)
>  		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
>  	WRITE_ONCE(cpudata->max_freq, max_freq);
> @@ -1100,6 +1167,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  			 bios_min_freq, cpudata->cpu);
>  	}
>  
> +	if (amd_pstate_cas)
> +		amd_pstate_set_cpu_capacity(cpudata, highest_freq_available);
> +
>  	return 0;
>  }
>  
> @@ -1923,12 +1993,20 @@ static ssize_t prefcore_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>  }
>  
> +static ssize_t cas_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_cas_active()));
> +}
> +
>  static DEVICE_ATTR_RW(status);
>  static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RO(cas);
>  
>  static struct attribute *pstate_global_attributes[] = {
>  	&dev_attr_status.attr,
>  	&dev_attr_prefcore.attr,
> +	&dev_attr_cas.attr,
>  	NULL
>  };
>  
> @@ -2438,12 +2516,23 @@ static int __init amd_pstate_init(void)
>  			return ret;
>  	}
>  
> +	amd_pstate_cas = amd_pstate_cas && IS_ENABLED(CONFIG_SMP) &&
> +			cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES);
> +
> +	/* Enable CAS for processors with heterogeneous cores. */
> +	if (amd_pstate_cas)
> +		amd_pstate_cas = amd_pstate_init_cas();

That two step disable is pretty ugly. Why couldn't you push the
feature checks into amd_pstate_init_cas()?

> +
>  	ret = amd_pstate_register_driver(cppc_state);
>  	if (ret) {
>  		pr_err("failed to register with return %d\n", ret);
>  		return ret;
>  	}
>  
> +	/* Per-CPU capacities are set during registration; rebuild domains once. */
> +	if (amd_pstate_cas)
> +		rebuild_sched_domains();
> +

Isn't this super early into the boot? You don't need to rebuild sched
domains here since they will be done later (I'm having a deja vu moment
from a previous review)

>  	dev_root = bus_get_dev_root(&cpu_subsys);
>  	if (dev_root) {
>  		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
> @@ -2484,8 +2573,17 @@ static int __init amd_prefcore_param(char *str)
>  	return 0;
>  }
>  
> +static int __init amd_cas_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		amd_pstate_cas = false;
> +
> +	return 0;
> +}
> +
>  early_param("amd_pstate", amd_pstate_param);
>  early_param("amd_prefcore", amd_prefcore_param);
> +early_param("amd_cas", amd_cas_param);
>  
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h

Why not arch/x86/include/asm/amd/amd-pstate.h since all of this is
AMd related?

> new file mode 100644
> index 000000000000..eb750abd20f7
> --- /dev/null
> +++ b/include/linux/amd-pstate.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Public interface for the AMD P-state driver.
> + */
> +#ifndef __LINUX_AMD_PSTATE_H__
> +#define __LINUX_AMD_PSTATE_H__
> +
> +#if IS_ENABLED(CONFIG_X86_AMD_PSTATE)
> +bool amd_pstate_cas_active(void);
> +#else
> +static inline bool amd_pstate_cas_active(void) { return false; }
> +#endif
> +
> +#endif /* __LINUX_AMD_PSTATE_H__ */

-- 
Thanks and Regards,
Prateek

