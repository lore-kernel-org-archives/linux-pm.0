Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794909842;
	b=cOjo6Qg9vAnkn7CHskQ8/rGuJZphReE47f7ytgJSP0lBFKIJLFfO16fkzU7S0LxpFCng
	 ejXrPyZqGOrSllj2kOVP1MJheipHUhtQcKxI2nnZZilRSj6ZTtp8+cyJIPX9y0FYskmn6
	 4L1OzPnti0xcS5B/QcEKpGKZD3Tpjv0ff9SVVleQm+BOmQpyFfoSme2y0C6/Q4cCWoNgl
	 jy0s2OZGQzcG5QiYFzSTQ6chMQsVVlBoVz9myt+AJQiQY3G7layZQvBHrFM3/rM8RCt09
	 P2I4aXgO2mIKnYwxcKcUc4LILf9H4VEp+MHg0zKgEtg+RYI6c9yndJhsagHCWq0LJVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909842;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
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
	bh=++ahJLqdEH7XFNJD3D77OE35qkxrlUlaOHId4ZFMOJI=;
	b=ixN+eGZpyN5DdHyU0BIJQZ0io9E1fGlkZpxkW4admBJPgGDdHVHbdc6mTl6KG9baPUhR
	 uB9p7wbYkEStAXrchKe5t7H226bF8QBj3J0KMqZKhhCatOYcrBWriI03bliENaqwPMjcc
	 SQ91QwfqW38vWL5WTdkw9PZg3ladjMoqvhVzoyLQ2ndO7qsCf+7jK/UWARW8ew78fZzTR
	 dYPywRX11NkCL9Bp5fWGXquDfni2wGGF42bnW6ztdf8PgsdJwPG5onOBwS5ATyOk3ILJB
	 aBBN+ePFj2shcpuMuvpbqoNM9dxZDfPQbJK5pPTHyPA+5Lk3A0Lel+YCfDab6idOWpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YXp4S7VN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.68
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D7C606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D7C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YXp4S7VN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aakdTV8WdpE9CD3txRrb1XZE0HFNs/NJ8bhUWNnKA6LHmQvcrDga4eIlgmKusGwFbIBTFhfR32vFI1zU4LAt950XpYHhCf95QqoeH/9NXXDvEA+et4oTYOn73I/eI+ZfwuVp1kVJZQ6EEr1MykCHHOYCz3FlnOiCvC8kXfbQn9gsHZXvfZZSD+RnWsrG6sbECdDgjVNiTJ0kMnDaoJ0HTLmSFNPK+SXqtOrV0Id5f14HhiUFtDGRyWc92zoPn5GtHeBSK4uLLjZoDts/KrYm6/NkRLnxZipgs8MZ3NAUEnXWEyYiX021i0sQmhRX4zbkx+973WZuiedRMYXbgRGofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++ahJLqdEH7XFNJD3D77OE35qkxrlUlaOHId4ZFMOJI=;
 b=qQ8UFPXEoeq0rLi31oYlumF5DFHfC/s1u6qFT4awi01O/gL9dITnVgiyu0RIIdBlRZqFP/qWUVdMbmZAeseOdVeBuVTLII05zvfUp3cSFvZhr8rMGGiDocq7ZOohWG6woI79uhe/2Uy+SGxRVWMvZMdMBIZCC8b7O2lfvm3OckHFJVnc/VH/6mUD35pI0bEGMwMgUz2jcTNUqnz0kqv1XUqwg7PBeNqZ+gA9L/O+fZLW4KHJxN02FntLFwC5C1LJ3cYL+On8YZ/vkOGoTtLVJe2NGdQi+kHDZVu/7fN9ZaZ3ArEFJVQCnKi19ehPOvCRS32YFtw3Qvl2XpCba6ZoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++ahJLqdEH7XFNJD3D77OE35qkxrlUlaOHId4ZFMOJI=;
 b=YXp4S7VNCf/RkGrNyMbWzV1TBiReZaJyVnxe55RM2mD8hUX/2VFuQ2rCkYCieUPGf8asoLqmwWkMdnDsdg/P4AFBbHtW0Wj1g6BXXp2X6mXmTqTX+QM1EFcFDTAzy026w+8JKgprYuCLtP/oF+9EdArjfAApfn1jl6XDuQV3Fz4=
Received: from PH8PR21CA0010.namprd21.prod.outlook.com (2603:10b6:510:2ce::10)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 10:03:58 +0000
Received: from CY8PEPF0000005D.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::4c) by PH8PR21CA0010.outlook.office365.com
 (2603:10b6:510:2ce::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.2 via Frontend Transport; Tue, 17
 Nov 2026 10:03:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF0000005D.mail.protection.outlook.com (10.167.247.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Tue, 17 Nov 2026 10:03:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 04:03:57 -0600
Received: from [10.136.43.35] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 04:03:56 -0600
Message-ID: <0e754ab7-6a47-4611-a35b-6fd9e88bda50@amd.com>
Date: Tue, 17 Nov 2026 15:33:55 +0530
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
Subject: Re: [PATCH 5/6] cpufreq/amd-pstate-ut: Restore EPP state at end of
 amd_pstate_ut_epp()
To: Mario Limonciello <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>
References: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-0-682aefd4fed6@amd.com>
 <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-5-682aefd4fed6@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-5-682aefd4fed6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005D:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: f28bc447-c911-4ab0-2340-08df449218b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0Fw6ByjZgumY7zE6yV01icyzwdS/jtz+UtpygIrgqIcQEGvFh8fBM+GmqzAYBB6rRPVNquPVXfBxsgT+DRjwU1lDxKrNF1yEm4hQyo2xoGBcwGfMxbpVOIqCVLcGs7JkzXdxVkGl18vKLaH/Nao/Pf18Ea12sxIIRvFA7tFfuwJcDy2iKrttaTJPzwRivQpwUU+9/QX7IYTKPLKd6HC1L+8RzB1LBmhz6i46m+pVp6PhgF5rUpGv5UldxSwxLEL6yoclpax725YSIuGKhiUpXhvMl8X8bzz1vMJzuG19bIELkDrF0lGBMBwJSGqb96dMWxrJFKwFZIzb3A3FL6qEUTiO8aevOFS4WdxaWhYImwDwvDJpVez1d1rmQ6w2tZogTxW8aO3rByTBe0+D61Ade9ygqDCkeIyoLfZn7HQGe8OMwcRYve9xCrsfLOOJXJD8j9P37gUzapMF6bQFMJTvE+IOXS3L3yV+9IaRXRTRfE1lWT0fnyKAl5ZjUeQiCBk8nA4oUwwKr8vEO/b17r3RCFwP5Z+3hB8RkFKBhmslcZP+SMfdg/VplflboFsTzq6OpGM5ld1cWBpGIXpjX0AKYZua9huGI3eDTdeLA+m/MXQUyCALsScXlrzDnVojj185eyYXRTrtWSTvvWChWKPRfJDLNLUsfK9om5IYbv61Qgm2RxPkJ13iXyH1+ua5FVvptD7CfRESGe0nWLopixT3aw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M06IJK880nwY1PjZspgHirMLTVhsO8EObBzsDwtAF5EW1euzD7VxaXxGz8sFdm3kZw+0rkUW4+gMN9C63sgy4QQE3ndZodPQYy0Ga9OyxiLGzjR3G4z7UDbYaY7xVbRAWFArRveAqaK3rsJT2ZJHSM4F4bzZk4GMeXDGMJMwRKNtNoqLyi+4PyFwvt3Tp9LizIM9txFPFJ32Xa2YpUMPDAbYPGc0tMiXMgYBWKIiSMQGoyYCbeWq63ydcMcrKga02bq/QM3bgxsHQhnBOBycKtkN1j8GB0a2cIwdkSiFfda0sJx5bwTk1rbRZ1yVcwDyEdPtCd4Wa0dmZxCuzARJcyifC0DCV7jxPuZgrumUh2rIy5hciNcAX0U8Smp/oUu+lwn/XYjMBqerrO49D8K6jr571ukR99lkebd+EZPBKJvPpIUyRr9k1kGuGdu2xOHe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:03:57.9727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28bc447-c911-4ab0-2340-08df449218b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000005D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

Hello Mario,

On 11/17/2026 9:07 AM, Mario Limonciello wrote:
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 506d7bb2e6609..a861216534b55 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -315,6 +315,8 @@ static int amd_pstate_ut_epp(u32 index)
>  	struct cpufreq_policy *policy = NULL;
>  	unsigned long orig_dynamic_epp = 0;
>  	enum amd_pstate_mode orig_mode;
> +	bool orig_raw_epp = false;
> +	u8 orig_epp = 0;
>  	struct amd_cpudata *cpudata;
>  	unsigned long orig_policy;
>  	int ret, cpu = 0;
> @@ -329,6 +331,8 @@ static int amd_pstate_ut_epp(u32 index)
>  	if (policy->driver_data) {
>  		cpudata = policy->driver_data;
>  		orig_dynamic_epp = cpudata->dynamic_epp;
> +		orig_raw_epp = cpudata->raw_epp;
> +		orig_epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>  	}
>  
>  	/* Drop reference before potential driver change. */
> @@ -425,16 +429,27 @@ static int amd_pstate_ut_epp(u32 index)
>  	if (policy) {
>  		cpudata->policy = orig_policy;
>  		/*
> -		 * If the driver had enabled dynamic_epp to begin with,
> -		 * restore it here before dropping policy reference.
> +		 * Restore the original EPP state before dropping the policy
> +		 * reference. If dynamic_epp was enabled to begin with, enable it
> +		 * again. Otherwise the test may have left dynamic_epp enabled
> +		 * (leaking the platform profile device) or changed the static
> +		 * EPP, so write back the original value, which also tears down
> +		 * dynamic_epp.
>  		 */
> -		if (orig_dynamic_epp) {
> -			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
> +		if (orig_mode == AMD_PSTATE_ACTIVE) {
> +			char restore[8];
>  			int ret2;
>  
> -			ret2 = store_energy_performance_preference(policy,
> -								  dynamic_string,
> -								  strlen(dynamic_string));
> +			if (orig_dynamic_epp)
> +				strscpy(restore, energy_perf_strings[epp_modes[0]],
> +					sizeof(restore));
> +			else
> +				snprintf(restore, sizeof(restore), "%u", orig_epp);

it. If we restore the original epp via a u8, this will always put the
driver into the raw EPP state - if user started with performance,
they'll start seeing the raw value if they cat the file after ut run.

How about, restoring the actual string like so:

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 506d7bb2e660..bc696f452749 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -311,13 +311,13 @@ static int amd_pstate_ut_epp(u32 index)
 		EPP_INDEX_BALANCE_PERFORMANCE,
 		EPP_INDEX_PERFORMANCE,
 	};
+	char *orig_epp __free(cleanup_page) = NULL;
 	char *buf __free(cleanup_page) = NULL;
 	struct cpufreq_policy *policy = NULL;
-	unsigned long orig_dynamic_epp = 0;
 	enum amd_pstate_mode orig_mode;
 	struct amd_cpudata *cpudata;
 	unsigned long orig_policy;
-	int ret, cpu = 0;
+	int ret = 0, cpu = 0;
 	u16 epp;
 	int i;
 
@@ -325,14 +325,36 @@ static int amd_pstate_ut_epp(u32 index)
 	if (!policy)
 		return -ENODEV;
 
+	/* Prevent any changes. */
+	down_read(&policy->rwsem);
+
 	orig_mode = amd_pstate_get_status();
 	if (policy->driver_data) {
 		cpudata = policy->driver_data;
-		orig_dynamic_epp = cpudata->dynamic_epp;
-	}
 
+		if (orig_mode == AMD_PSTATE_ACTIVE) {
+			orig_epp = (char *)__get_free_page(GFP_KERNEL);
+			if (!orig_epp) {
+				ret = -ENOMEM;
+				goto early_fail;
+			}
+
+			ret = show_energy_performance_preference(policy, orig_epp);
+			if (ret < 0)
+				goto early_fail;
+
+			if (cpudata->dynamic_epp)
+				strreplace(orig_epp, '(', '\0');
+		}
+	}
+early_fail:
 	/* Drop reference before potential driver change. */
+	up_read(&policy->rwsem);
 	cpufreq_cpu_put(policy);
+
+	if (ret < 0)
+		return ret;
+
 	policy = NULL;
 
 	buf = (char *)__get_free_page(GFP_KERNEL);
@@ -424,17 +446,11 @@ static int amd_pstate_ut_epp(u32 index)
 out:
 	if (policy) {
 		cpudata->policy = orig_policy;
-		/*
-		 * If the driver had enabled dynamic_epp to begin with,
-		 * restore it here before dropping policy reference.
-		 */
-		if (orig_dynamic_epp) {
-			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
-			int ret2;
-
-			ret2 = store_energy_performance_preference(policy,
-								  dynamic_string,
-								  strlen(dynamic_string));
+		/* Restore the original EPP */
+		if (orig_epp) {
+			int ret2 = store_energy_performance_preference(policy,
+								       orig_epp,
+								       strlen(orig_epp));
 			if (!ret && (ret2 < 0))
 				ret = ret2;
 		}
-- 
Thanks and Regards,
Prateek

