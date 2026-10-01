Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDE51815D;
	Thu,  1 Oct 2026 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875266; cv=fail; b=jIIcnYrHmFIkVufOFFkCbS7VGF182M338FtWDHqbyNpguuV5XOfskh54fom7zoCTBXb9ATW+K8LC+fDoNLhF/2Zp/MqwpPDgvyBYRR2AOpVMvodRVkC0RQw0CyiAkDYxFySSFsvEmynyatiR+PQj9lOKVOrQw7LpkD7VIumzKko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875266; c=relaxed/simple;
	bh=5Jc00KsAA455lDDdicAVC1y174tgYbf/3nVKo2iT1po=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jaXtKjiL0IBvbkaStgVQ5MfCArABZStsqhgn8EXgFRmgVYpdpI0j6tYx9C4NrHLfQk/ReQ+RJtEBZRIbXz84wHQVteLDTP57dBjvCH62mIdcHF6JikdgsdmE4y3r8cDwlQ9GeoYjguxNtF5u2FLWtH0uhr56djudqYAo0Ihg/3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GBKqiWaf; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GBKqiWaf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Toebz+3NjqcUpYnE4pJwocLUvc9acTxOIfgP0bhxONqsJO2buyADgLMz39Gkt90LjZR1l0fcAe2U2K0tEtaiSh/ocwbkmQU8T/FHkPt5tgAD28nkIZZP6zNkQXyD243IiG67elv/MWE9uuyAd8SRJNURtu5LcIjO7C7W1yAQq7qOkfbsYHvRFPqaFWP6CPevhYZFxGzX5lstB4dpEFgOisPjRr5zLZM7uTFHrrelzfdfdTO6HQgopDQDCZ7Cu6S88b/7HsipszBBBu8hQ0uF00kPQbxoOkhX8qcdumX79gBaoMYJSBz5XfQ/HJIPZMyxy/O8X8+JJTl20KznmrrnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1hz/NBf+EDtF1xjsZsgwH50m9ZUZuYWjW8G7bYoNAc=;
 b=OcsrdOPrG97qHVEwCCmPSSy84eyr0i5VshmZYoSjBWDHFAL2RNo8GligBlLnDMlaXj10uVLX7wVuS4tOIeMUn3PWyeCjsa49So8OQ8RRJuMLmZxAlqOhE8Pdayn5u/F/1R+G6ChksN85wF05XuQqyDchEccdCyLetGScnZVXoo6qMSuyUVIa8xPaJXJkXOceu/JWT2NjMfpq+dCvIbodyxZ5w+kJF5FK5d88embvhnY+ZivPuxwAhKPoQoU/2jxobS5pY29o1u5PuxLIxjCLxwH3k3AZXrNuD5JiKPUp4+65gcTkoN3fY8ylUa1j/c5W1a7K3mchqnYoqDpG2uowUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1hz/NBf+EDtF1xjsZsgwH50m9ZUZuYWjW8G7bYoNAc=;
 b=GBKqiWafldUExlznhYfvsQDg/lC9th7nP/sw+46Egn3mWaXWXuowrziB44zUV1cycRpfDAjPPBptYQ3IuZrYshJyrGMnyeQUg5tQjyDXf/3AKwOkCTep1TEp9EGh7w27Ejpt3oPs+oShpivUn5e+V5FYbYy2i3PaMplwTdGcKEQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 17:20:54 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 17:20:54 +0000
Message-ID: <472a05d5-f078-46ec-98e7-99cb2f1cd134@amd.com>
Date: Thu, 1 Oct 2026 12:20:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cpufreq: amd-pstate-ut: Tolerate aliased EPP
 preferences in the EPP test
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20260921190235.3651688-1-mario.limonciello@amd.com>
 <20260921190235.3651688-3-mario.limonciello@amd.com>
 <b3ed027f-8c7b-4ac5-aac6-95d47ac0c41d@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b3ed027f-8c7b-4ac5-aac6-95d47ac0c41d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abe7a6f-20e7-4c31-75e7-08df1fe05935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	F7w1c6fOddf3z2pq2xScKPFuFjUc85EdKYKHnQ16muraU1w2z16gqdM7i908KBg2LvrqQbpw9aTRVXH7/lcztTIG9lq3TyjtM5YOFFSkScSQyMmN7qsHCxnuoXjf9TrY1fW2giWBmLA7puxj6EDUOvAvloY/bRAYT+IMgjFE4fIqYXdtt8E6aMxs4YN1+Mugf7APxoJm9/JkKfoo5SIfUCc5bZYqMqbXFQK20wX2CJfj2VwgaCWsl3LMuQ+2DL2jyPjqRImstddHvjoqFTSsrMTHDK6+eYXE2v/jTUACxD+sX0MKMOLcDMQVa6J2oHe2MOCLRuqp0xaOKGaUxui/fm0sJT3uyczP2I6BVduS5nWjgjloL6phkktA1Y67XG85D7M3B7Q7vzZCF7ywCFAlrP6ScLFwA6zq4AgWtzUGOO5Hj1xkwGvZ6YXUGqU79R8V9N9CeTvngjtrHICFaqYMtglwc01Oq4585ek4vj3p2aH9lUI94dpMusEW3koXq84pGpOTSEfGJ6ciuHXCwgoVBZxRUTXQnimVBW2AOdcozYNjiaosGLiHIlbGVjUI9mHLwXg6HdJzy1ew3x1o9edVaGbmm8nsWuK8+AAKlD/Mw3N7h9/dNu1WK2FNdkdhieGlxMgcKeIGgRa0ioiNBUQXshonOXOeXmBoMhEtT8pnFDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXRKcS9zcVU5bkM0V0tvR1BsUmlWRlVQY0NVTElHdlRkcVc4ekJzbXBVSk14?=
 =?utf-8?B?SVZNbU91NzArTnJ3UmFETWg1WlNUMmFFRkQ1QkZYblBGWnZGcFl4SW9sSGM5?=
 =?utf-8?B?cXdkR2RVdE9aOWhVekJ5MHJhcitwb0Y2dzdEemFLUmQ3NEYyYks5VVpYaVVa?=
 =?utf-8?B?QzBGSGViSWtJR2hnaWlzaWxnUDVnME85c1B0bXhXR0xUZE9lNUlSUDNXcHJC?=
 =?utf-8?B?MzJuM3R5MGt5TXZqSmlqR1p5QU8zQkllWUVuZUtmV3NXWGxORC9VT1pNSnAz?=
 =?utf-8?B?UmJZamJQTURSOS8vUVNnK1V4K0dSNTJDbGhmdkk3aks2c01pWFhPOVlURC9J?=
 =?utf-8?B?bUlMUnd6dENHbnBPMGxxb1docHJBMHJoOW9TSTdmbnZsVkpvQW5BSHd5elpx?=
 =?utf-8?B?S1ZCSjdocWk1OFEwbFdKR200K2g3Z0JHZHBtRC9TS3dHZkZUVExrZlByMUNF?=
 =?utf-8?B?Nm16dlQxOWhxalZSSVVtcXlvVFBBazVjNFpZNzFQMXpCS3NobkZISGxoS1Nu?=
 =?utf-8?B?NFpTRUlYNUsySnByek1uMlUycTJUWnA1Vm5HN2I0N1gwbXhGVVFxTURXSCtw?=
 =?utf-8?B?ZERlb3YvSlBUc2hpYkRvM0dzQVArMnZhWm11OEFiU05ENVR0MVAxWFhNVDVU?=
 =?utf-8?B?dVh5VE84Q0RPMldheUtYSHN5Q0ppODN2Q05NV3BSZUdKVzhBVlBEMU1selNl?=
 =?utf-8?B?WXMwS2F5TUI5NGdNdFlJeTRnRi83amdTblZ2ZUJXM1o4Wk1HRVVhR0JyQXBH?=
 =?utf-8?B?M3NsUlZ0WUhsdkZQUmZudDdIV21XNkR4UExNUnRaY0MzUG1qcEg2NCtOTFJ5?=
 =?utf-8?B?OFRwdUdYOFdFOFZQcHV2bHo4dHV2aXZ5bHczRHV6SVVEOGg3NFJkb2s4d1RK?=
 =?utf-8?B?ajdVYmNRSmUzcHdTQ2ppc0hFbk85RmFVZXpXSTRMWHZCMktGemhTQmw0NmJr?=
 =?utf-8?B?MDFkSlZpYUR6UWs3RGZpaWZGWkhJSGpubGprNUlWQnVyb0xKQzh6SS9SeU5O?=
 =?utf-8?B?SFplaUVBeDVVS1daUFZUWlJta3FlSjFwYWRBeTBCbGRvSE1laDlHL2ZIemIv?=
 =?utf-8?B?c25oY0ZaNDlyeEJ3WHBKbkpQUGE3MllXdG5JNW1KNVVtRVFiNmYwRnlJM21u?=
 =?utf-8?B?ZTlrazE2RTBxUGhzYWEzNnA5MnVVUmo2QUlZRmZvcXlSdEpseCtpUnhuOUxl?=
 =?utf-8?B?NTV3WUVBdnBoeWZDZXhiQ0FyRUJCYS9BMFpmUGhnL1pJYWZBbm5qL3ozdU5k?=
 =?utf-8?B?bGNVT2d4eStKK1JvTlJOOWUyWXoyWWRJeWZnMXBVN0pCektxeGhkKy9HV3ZM?=
 =?utf-8?B?SjliaWhkaGxVc3d0V3ordmljM2pvZ3UxZENNRnRmUWlnVW5SSmFQWThnaG4z?=
 =?utf-8?B?ZUoxL292MUdzVmVlZXRGTWg4Njl3K29WQnRFWXhoN1dIRnpSaHV5YmFOR1BE?=
 =?utf-8?B?S0M2Q0NtY0JzZEowOWwrVURKNExwZ3hRN3NqNTJoU2N0V21XTldHWkpPUXcr?=
 =?utf-8?B?djVnMDdiWk1aWG5SSW50aHdrdmdnL2lvUHI3SXJTVmhzWm9NTkxuVGJqbUE1?=
 =?utf-8?B?VTk4Y3pQZGtqeWUrS0xoWnRZbWRBWUhSSVZmdDlYNFBHZXJFSkZaMjRydVly?=
 =?utf-8?B?ZkVHNkRhSVNqZ24vSEhXWEE2SEg3ZUR3VE5xa3lKTTNMeklJQ1hHVW9URnpC?=
 =?utf-8?B?MXFLLysyR3pld3JJQ1ljSmQrWjhmMFJnM3kxV3J0OU9YZmFOM0pGdTJPNUI3?=
 =?utf-8?B?R1RDTjJ2ZFdONythOXlPaUJTMFdOTU80R3VEdUV1dlZleVcwU292VkxDOUMw?=
 =?utf-8?B?VGEvMVZCMzZHWHpuV3VIK1ZDUXUrVHFWRkJkcC9VZXYvU1ZrMjIrL0p6WFZr?=
 =?utf-8?B?QTdvZTdHeW8xQ1ZnaG9nVDZiSFZxOWVBTnE4eXNOcW1OSW9sSkRIK2xMSDVy?=
 =?utf-8?B?Y3M5K1pKci8vTVlOSjYvYlgzTEh1aDBwTHh1L1NtYWtKQmNyVUh0SnVsRmhy?=
 =?utf-8?B?aW1wTnBPdWkrSFNJTUFOV3FHK3NOVXcrNWZnQ2VrWHVFZ2RJSkRZRFV6RjJw?=
 =?utf-8?B?VnZ1V3NzaWNKOGxTRVpDblgvZDM4ajRRaGtnaW5hNDlrdGFDNU1NN0EwMmNK?=
 =?utf-8?B?OXgweEtsRVUzUG5aemI4RjR3MWxmMEU4ODZaRkNjbkZhcmlkWnZSR281Wm9B?=
 =?utf-8?B?c2VMcVlLbHgrbHVKUFQ1Y2Npcm9Da3QwYytwa2hPZUtlajZoZEY1ekVVUkxL?=
 =?utf-8?B?U0xnOWs2ZFZNb2tQQWxxWWI2d01XbmdDM05wY1dzNVQxK0FzUmdyWkdSaExn?=
 =?utf-8?B?VHRxQllyemNIdXFZZStCMDZNMGVVNmdKY29PNjNsOC92bitiSDRJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abe7a6f-20e7-4c31-75e7-08df1fe05935
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 17:20:54.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lYhobnxV6yWiWat12FyX0sUe+Wzf5qiuFoJdPD3pFaSV6D8f/1qB6PJcIq1zi2k4aEaZfa+OcWIicDeEUPTrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441



On 10/1/26 11:52, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 9/22/2026 12:32 AM, Mario Limonciello wrote:
>> @@ -385,12 +388,27 @@ static int amd_pstate_ut_epp(u32 index)
>>   		strreplace(buf, '\n', '\0');
>>   		/*
>>   		 * "dynamic" mode reports the EPP as "dynamic(profile:X)"
>> -		 * Trim at "(" and just compare tie the epp string.
>> +		 * Trim at "(" and just keep the preference name.
>>   		 */
>>   		strreplace(buf, '(', '\0');
>>   
>> -		if (strcmp(buf, epp_strings[i])) {
>> -			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
>> +		/*
>> +		 * The preference read back may legitimately differ from the one
>> +		 * written: some platforms (e.g. Zen6) program the same raw EPP
>> +		 * value for more than one named preference, so show() reports the
>> +		 * first name that matches that value. Rather than compare the
>> +		 * strings, re-write whatever name was reported and confirm it
>> +		 * programs the same raw EPP value. This verifies the show()/store()
>> +		 * mapping stays consistent while tolerating such aliasing.
>> +		 */
>> +		ret = store_energy_performance_preference(policy, buf, strlen(buf));
>> +		if (ret < 0)
>> +			goto out;
>> +		got_epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>> +
>> +		if (want_epp != got_epp) {
> 
> 
> So this feels a bit hacky since it may be possible an epp
> may be programmed incorrectly in hardware and as a result
> it aliases with a different string.
> 
> Can we use amd_pstate_cpu_epp_values() as a source of truth
> to double verify?

That does sound like a better approach.  I'll test the below.

> 
> Something like below:
> 
>    (Only build tested on bleeding-edge with this patch reverted)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index be10ab90b820..506d7bb2e660 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -304,12 +304,12 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
>   
>   static int amd_pstate_ut_epp(u32 index)
>   {
> -	static const char * const epp_strings[] = {
> -		"dynamic",
> -		"power",
> -		"balance_power",
> -		"balance_performance",
> -		"performance",
> +	enum energy_perf_value_index epp_modes[] = {
> +		EPP_INDEX_DYNAMIC,
> +		EPP_INDEX_POWERSAVE,
> +		EPP_INDEX_BALANCE_POWERSAVE,
> +		EPP_INDEX_BALANCE_PERFORMANCE,
> +		EPP_INDEX_PERFORMANCE,
>   	};
>   	char *buf __free(cleanup_page) = NULL;
>   	struct cpufreq_policy *policy = NULL;
> @@ -378,9 +378,9 @@ static int amd_pstate_ut_epp(u32 index)
>   		}
>   	}
>   
> -	for (i = 0; i < ARRAY_SIZE(epp_strings); i++) {
> +	for (i = 0; i < ARRAY_SIZE(epp_modes); i++) {
>   		memset(buf, 0, PAGE_SIZE);
> -		snprintf(buf, PAGE_SIZE, "%s", epp_strings[i]);
> +		snprintf(buf, PAGE_SIZE, "%s", energy_perf_strings[epp_modes[i]]);
>   		ret = store_energy_performance_preference(policy, buf, strlen(buf));
>   		if (ret < 0)
>   			goto out;
> @@ -396,8 +396,24 @@ static int amd_pstate_ut_epp(u32 index)
>   		 */
>   		strreplace(buf, '(', '\0');
>   
> -		if (strcmp(buf, epp_strings[i])) {
> -			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
> +		if (strcmp(buf, energy_perf_strings[epp_modes[i]])) {
> +			u8 epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
> +
> +			/*
> +			 * The preference read back may legitimately differ from the one
> +			 * written: some platforms (e.g. Zen6) program the same raw EPP
> +			 * value for more than one named preference, so show() reports the
> +			 * first name that matches that value.
> +			 *
> +			 * If strings mismatch, confirm the CPU is programmed with the correct
> +			 * EPP value for the mode. This verifies hardware programming while
> +			 * tolerating such aliasing in driver.
> +			 */
> +			if (epp == amd_pstate_cpu_epp_values(cpudata->cpu_type)[epp_modes[i]])
> +				continue;
> +
> +			pr_err("String EPP value mismatch: %s != %s\n",
> +			       buf, energy_perf_strings[epp_modes[i]]);
>   			ret = -EINVAL;
>   			goto out;
>   		}
> @@ -413,11 +429,12 @@ static int amd_pstate_ut_epp(u32 index)
>   		 * restore it here before dropping policy reference.
>   		 */
>   		if (orig_dynamic_epp) {
> +			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
>   			int ret2;
>   
>   			ret2 = store_energy_performance_preference(policy,
> -								  epp_strings[0],
> -								  strlen(epp_strings[0]));
> +								  dynamic_string,
> +								  strlen(dynamic_string));
>   			if (!ret && (ret2 < 0))
>   				ret = ret2;
>   		}
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f27676e8e9ef..89f911d378ae 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -44,7 +44,6 @@
>   #include <acpi/cppc_acpi.h>
>   
>   #include <asm/msr.h>
> -#include <asm/processor.h>
>   #include <asm/cpufeature.h>
>   #include <asm/cpu_device_id.h>
>   
> @@ -89,46 +88,6 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool amd_pstate_prefcore = true;
>   static struct quirk_entry *quirks;
>   
> -/*
> - * AMD Energy Preference Performance (EPP)
> - * The EPP is used in the CCLK DPM controller to drive
> - * the frequency that a core is going to operate during
> - * short periods of activity. EPP values will be utilized for
> - * different OS profiles (balanced, performance, power savings)
> - * display strings corresponding to EPP index in the
> - * energy_perf_strings[]
> - *	index		String
> - *-------------------------------------
> - *	0		default
> - *	1		performance
> - *	2		balance_performance
> - *	3		balance_power
> - *	4		power
> - *	5		custom (for raw EPP values)
> - *	6		dynamic (platform profile driven selection)
> - */
> -enum energy_perf_value_index {
> -	EPP_INDEX_DEFAULT = 0,
> -	EPP_INDEX_PERFORMANCE,
> -	EPP_INDEX_BALANCE_PERFORMANCE,
> -	EPP_INDEX_BALANCE_POWERSAVE,
> -	EPP_INDEX_POWERSAVE,
> -	EPP_INDEX_CUSTOM,
> -	EPP_INDEX_DYNAMIC,
> -	EPP_INDEX_MAX,
> -};
> -
> -static const char * const energy_perf_strings[] = {
> -	[EPP_INDEX_DEFAULT] = "default",
> -	[EPP_INDEX_PERFORMANCE] = "performance",
> -	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> -	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
> -	[EPP_INDEX_POWERSAVE] = "power",
> -	[EPP_INDEX_CUSTOM] = "custom",
> -	[EPP_INDEX_DYNAMIC] = "dynamic",
> -};
> -static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
> -
>   /*
>    * The numeric EPP value programmed for each named preference. First dimension
>    * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
> @@ -159,7 +118,7 @@ static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
>    * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
>    * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
>    */
> -static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
> +u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
>   {
>   	switch (cpu_type) {
>   	case TOPO_CPU_TYPE_PERFORMANCE:
> @@ -170,6 +129,7 @@ static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
>   		return epp_values[TOPO_CPU_TYPE_ANY];
>   	}
>   }
> +EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_cpu_epp_values);
>   
>   /**
>    * struct amd_pstate_epp_values - EPP values for the four named preferences
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index c7189d177b81..422188c639b1 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -11,6 +11,8 @@
>   #include <linux/pm_qos.h>
>   #include <linux/platform_profile.h>
>   
> +#include <asm/processor.h>
> +
>   #if IS_MODULE(CONFIG_X86_AMD_PSTATE_UT)
>   #define EXPORT_SYMBOL_FOR_PSTATE_UT(symbol) \
>   	EXPORT_SYMBOL_FOR_MODULES(symbol, "amd-pstate-ut")
> @@ -162,6 +164,48 @@ enum amd_pstate_mode {
>   	AMD_PSTATE_MAX,
>   };
>   
> +/*
> + * AMD Energy Preference Performance (EPP)
> + * The EPP is used in the CCLK DPM controller to drive
> + * the frequency that a core is going to operate during
> + * short periods of activity. EPP values will be utilized for
> + * different OS profiles (balanced, performance, power savings)
> + * display strings corresponding to EPP index in the
> + * energy_perf_strings[]
> + *	index		String
> + *-------------------------------------
> + *	0		default
> + *	1		performance
> + *	2		balance_performance
> + *	3		balance_power
> + *	4		power
> + *	5		custom (for raw EPP values)
> + *	6		dynamic (platform profile driven selection)
> + */
> +enum energy_perf_value_index {
> +	EPP_INDEX_DEFAULT = 0,
> +	EPP_INDEX_PERFORMANCE,
> +	EPP_INDEX_BALANCE_PERFORMANCE,
> +	EPP_INDEX_BALANCE_POWERSAVE,
> +	EPP_INDEX_POWERSAVE,
> +	EPP_INDEX_CUSTOM,
> +	EPP_INDEX_DYNAMIC,
> +	EPP_INDEX_MAX,
> +};
> +
> +static const char * const energy_perf_strings[] = {
> +	[EPP_INDEX_DEFAULT] = "default",
> +	[EPP_INDEX_PERFORMANCE] = "performance",
> +	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
> +	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
> +	[EPP_INDEX_POWERSAVE] = "power",
> +	[EPP_INDEX_CUSTOM] = "custom",
> +	[EPP_INDEX_DYNAMIC] = "dynamic",
> +};
> +static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
> +
> +u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type);
> +
>   static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
>   {
>   	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
> ---
> 
> Thoughts?
> 
>> +			pr_err("EPP mapping inconsistent: %s programmed %u but %s programmed %u\n",
>> +			       epp_strings[i], want_epp, buf, got_epp);
>>   			ret = -EINVAL;
>>   			goto out;
>>   		}
> 
