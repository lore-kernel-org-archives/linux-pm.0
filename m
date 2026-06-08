Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A931D371;
	Mon,  8 Jun 2026 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780892478; cv=fail; b=XDa5+Drd96nYa2h9hcyd/z4YLaT6esqeHxZTE7piD1/4i1KXFK1stN9DmOnntnptdtz4Xclg6YeAqs8T71/fRXRODilDNBo0nLcuajLfmGn/15jRiFsEKzxKWR1cOy8+XD4cEBX2wZqQtbX0Cq8LsqFBGoYMQJ+scU7tOvUBRRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780892478; c=relaxed/simple;
	bh=Xj5+7/W1Mqn+Ys8Az0r6HLTRkUFK0wj5n/uGa5ZTQNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CyKp4FUQcmf9VjJL1vYtb+8z4R8SbkCRP/DeEKvmgajtVWYx8oLtZ28K1+ejwqL0az/kO6SkR6JtiCsDx410onPxdGzpLSeK3qQm9nACnSRSKz1DkJkQmPNp99eYl/QTXUhmQTC3hZTcDYXAufYrrI8RxK3k/x0wuPLmPNWeKVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DiDZKZE2; arc=fail smtp.client-ip=52.101.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DiDZKZE2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpSMEBJ8NspC+67l8cf5SQDS0Q9npJsgHIB6jChqH6cW/vRVH9JoLJgHrRr0R618fZXwwAhhnJttk8uqgF13zA/YeZ+79o2RNEUI6AR2sFHsl1Vhnif2lbkhha3YWZBIziHBg99Lc0SK4Hx2CaCX6ZrbZxsCVQziyNh+mvwYAd4oLzoMxoHTdx3wOa+8m+vm+yvFqAzblXJce9/ncZN2v1GKIFrnxtloubGKx6l0S5+daj7BvDWoWXcwM9c0VZx53Z+UMES1m5yt2fIBdddhboUR+yq5hGDQ3ZN2U3qAqpalOQfynwJGak06u1n8i6PBy/eUo2hkEaxWudILtRzQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14dJUd60W3SPD9uAA7W8jFhq/eDHWorqTM7yWsyAknE=;
 b=hjrxvdpdQo4IbfyJHzn8IClI58Bo646BH1j5b8K+pQStrv3CqSj3eIwJYaEgndFpmNghRTrxqir8M8H5+N/FKIc5TomKN6HXOVPpA9wBfptalrHjmQW8swtPR1K4Ol6WQgqYeCvOHF2oTN8WKjpdYCZdHqZH2Rf1gv9AdQmyYPmq0fhDa8zrmsVsFHfUbn0rExDe1tR7EbeLycUoDUgyzPTN8Ni66U6JeCQrS8PR2B+YhhJbnDKEuTdb4WrsJPVg5ZaepBx+2MCkzqCBteL38Djr6AlAndcJIgDuq2HG+LaiMMbWXobVG8Q+fnRhUqvSEI/aB8PvO4zkVLPWz6kuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=disroot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14dJUd60W3SPD9uAA7W8jFhq/eDHWorqTM7yWsyAknE=;
 b=DiDZKZE29F3pGaL5Wugi+vYS26d0jvCFDXwdnQy8VpkoUZO30KgaPdcrCrouy0EhzEYRTMZ5/DILtsgJrkuPoZh4ar7PGy9xqr3FeMBwo8C5wBq3iLIf4LGbU6LfY+avhvHtf364/L1X3Z48kitRXDI7DSNAGGJ3FmfK7Li8PJ4=
Received: from BLAPR03CA0117.namprd03.prod.outlook.com (2603:10b6:208:32a::32)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 04:21:14 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::52) by BLAPR03CA0117.outlook.office365.com
 (2603:10b6:208:32a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 04:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 04:21:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 7 Jun
 2026 23:21:13 -0500
Received: from [10.136.43.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 7 Jun 2026 23:21:10 -0500
Message-ID: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
Date: Mon, 8 Jun 2026 09:51:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cpufreq/amd-pstate: Fix EPP initialization for
 shared memory systems
To: Marco Scardovi <scardracs@disroot.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <rafael@kernel.org>,
	<ray.huang@amd.com>, <stuartmeckle@gmail.com>, <viresh.kumar@linaro.org>,
	<wyes.karny@amd.com>
References: <20260605103131.88711-1-scardracs@disroot.org>
 <20260606065756.4442-1-scardracs@disroot.org>
 <20260606065756.4442-2-scardracs@disroot.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260606065756.4442-2-scardracs@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b6eab2-6980-4f24-a1e8-08dec5156063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XxIR93/u0Bg+3bNYvl5/Sa39zfnAjVWM1qQ2O9oElDpBugzcny7IL+PiXECclpXDLfhFTS+XHPaWmJMyAV3+z6hgCeKjmCLU+XUgxqoAu1iibmGjVUun7RTnrK7EjQHiFe7dIZTTBFRaD/rlLj+J0obzsgb8FrVczNid2DP2x5jkikmG2wvtCf/Qu1fXCy+OJXIG3RfKasghvV1of7lU93/RyghsogSQLaRnH8t5dSvi23orYg10xv3IqIr6I2IVPQWmHf9QG5tkPQgoX0AH1KNKx6DeeosN05t6rARQA8npYrGZWdv2WmjdahWCtjXBcnd0cOvO98wDJIZ+QyVhQAlWCxdEoNzUejWUSJo2Himbfz4N3n0BYxay11nY7RNYnQQI3tyJhUTDZV4GzdtAWlR09shD0LHchuOaezTSKR0gHfojWh3YpLZ/KcIRPeEKtG7xmQzAbLGNYMbzop1ClIHd7GT3OMwfPt4E7RzJ9qUtlGPSFtSAu/Zk3E53IaojnxZWuYZhItmZjZhsJfP7NoJo2vy4m8ht4qxBhdT4+9qK5cEEK+Y8codwbIoRdhOPVH4GvOG6xE3SmOPg0UgS3zRRqnvNyqOiL8dHwnJlWJ9wa5OnKO3X/twBH8lciSy+NOrXLaX5bbPBeuW5MGaVdgklYr7V02Lx7cI+ft2jB8a1ytInOW86BACx8npcXnKyrcWsT7/pkIc4gA/izohtka7z8TjyinnFVzoFyJPe8+Q=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	opWlY7u6GIT1N5zQ4W6woyKMVxmyz45mTKeDO/zXlR0+OyQt9GKbjFZtDgnDg/+fsbNPI+i/RA2W5AYO+60ssItNRLTncKcgaEohbKkVvduJE6aefEb1Wz9E5Uo9t5WCQEI2p09O/D1NwTN6l5beHYTTDyMWO/Wa6cnrKU/78Kgz+uN5o/3g3xgKQxUb/Cz3ix5H+egIByldMToVBjEykLcXeSPPH+vC0taxBUBs/ufGSewDSs85ft/NjoXTKDceJF08u+478g4o1vi4i9WpQb/waT0FryHWfHwVrGkpGZXW1TlVbJAWTi6xXEIOVkP+ogveCdbQTHd7YPOaawMvC+QFDIjdJnDK0u2TavNedLvJ5cYS8wm9SSYRSw+JqkLzxIHD6BpH5IFBObST5r8ytew94kWKfqagjjEvOc7N0k/TtNSNvKyctnF3RQWmfTKp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 04:21:13.4889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b6eab2-6980-4f24-a1e8-08dec5156063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351

Hello Marco,

I don't mind the changes, except that it can be broken down into
two patches as Mario suggested for easier backporting :-)

Some notes below ...

On 6/6/2026 12:27 PM, Marco Scardovi wrote:
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8d55e2be825b..a35cf126e335 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -199,7 +199,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>  
>  static DEFINE_MUTEX(amd_pstate_driver_lock);
>  
> -static u8 msr_get_epp(struct amd_cpudata *cpudata)
> +static int msr_get_epp(struct amd_cpudata *cpudata)
>  {
>  	u64 value;
>  	int ret;
> @@ -215,12 +215,12 @@ static u8 msr_get_epp(struct amd_cpudata *cpudata)
>  
>  DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
>  
> -static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
> +static inline int amd_pstate_get_epp(struct amd_cpudata *cpudata)

The change to return type and the amd_pstate_epp_cpu_init() bits
should be Patch 1/2 with:

Fixes: 555bbe67a622 ("cpufreq/amd-pstate: Convert all perf values to u8")

and commit message stating the necessary error handling that is
required if amd_pstate_get_epp() fails.

>  {
>  	return static_call(amd_pstate_get_epp)(cpudata);
>  }
>  
> -static u8 shmem_get_epp(struct amd_cpudata *cpudata)
> +static int shmem_get_epp(struct amd_cpudata *cpudata)
>  {
>  	u64 epp;
>  	int ret;
> @@ -525,10 +525,6 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  	perf.lowest_perf = cppc_perf.lowest_perf;
>  	WRITE_ONCE(cpudata->perf, perf);
>  	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
> -
> -	if (cppc_state == AMD_PSTATE_ACTIVE)
> -		return 0;
> -

And this should be Patch 2/2 with:

Fixes: 2dd6d0ebf740 ("cpufreq: amd-pstate: Add guided autonomous mode")

and a commit message that reads it is necessary for AMD_PSTATE_ACTIVE mode
on shared memory system to toggle on AUTO_SEL_ENABLE based on the
ACPI spec for CPPC v2 and below.

>  	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
>  	if (ret) {
>  		pr_warn("failed to get auto_sel, ret: %d\n", ret);
> @@ -1877,6 +1873,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	struct amd_cpudata *cpudata;
>  	union perf_cached perf;
>  	struct device *dev;
> +	int default_epp;
>  	int ret;
>  
>  	/*
> @@ -1926,6 +1923,14 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  
>  	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
>  
> +	/* Cache the firmware programmed EPP */
> +	default_epp = amd_pstate_get_epp(cpudata);
> +	if (default_epp < 0) {
> +		ret = default_epp;
> +		goto free_cpudata1;
> +	}
> +	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &cpudata->cppc_req_cached, default_epp);

I would actually prefer this "cppc_req_cached" change to be a third
patch that says caching the initial EPP saves on an unnecessary
reprogramming later when the EPP is first set but I don't mind it
being part of Patch 1 with a small note in the commit message.

> +
>  	/*
>  	 * Set the policy to provide a valid fallback value in case
>  	 * the default cpufreq governor is neither powersave nor performance.
> @@ -1933,7 +1938,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	if (amd_pstate_acpi_pm_profile_server() ||
>  	    amd_pstate_acpi_pm_profile_undefined()) {
>  		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> -		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
> +		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
>  		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
>  	} else {
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;

-- 
Thanks and Regards,
Prateek

