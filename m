Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C682351C10;
	Fri, 24 Jul 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919336; cv=fail; b=A3P5adehIPqeC+nraASx4jghrPveKKD/nOFNJq7/1Pp395gc3v16qM4h5Rhe4b/1tNk1frojzNTdajmxpU91wpgxYdB5Jj8IOOjaPr+PrK7fdR/Bt6SgvExIdPNf9u8Ry3fESA/JSBtn2WgJZe05ajQWJcTuZsBS0XKgYTbHfuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919336; c=relaxed/simple;
	bh=yIwz63F13Qxh+64ot/Aa5ydQwEpNJbnnDkGrrj52YaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i+2FzQ2Zn/lxPjq50nq+aPV4V+sNE8611rqjJVOyqRKxsAij4ylpkjwcrydhNIGEWzZoTbkj8SzH0gKnQ/N/XyfKSXP8OizFsvmpuWzB36OECvxz3+AtMga70NOkyviJihhELzLmAgCjtZN1nvuhc4iAdojITu9YRMNBXAZbhz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OK0XR+Pz; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OK0XR+Pz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfamU1ZaOppV3tW1FRRLGmDCcSYBPJwU3vG7RZv16wF4r47C38Sa4LHzBAWAbJMhG8NUz0LVIeZrdd2+p7hV7bMo68nWg7cH9sew7qd3B1Z89ycyqiTUHes6lpQQBcoA1lS02jp80c+tpOabsscrSwSyVNwtyOApCXvmaT6F0/VVhLXDQ8q2mE10DBGoitPa49cdCMeCLKzsWAYf+42PpTQvWXAcoX5pdf7hl/mRMLZ9LQtpRF7zVoAbA+oLkyRE10TAW9tFdcnZn0PxTg/6IItDOaIX5GkCKPUIjNUDMg/Robk61M55AmpmTAHfscMz2z+P0S/w5gliAOvVQaMGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k3aEaSIGACCE2Zsd7ONxw6uHpAnd4upjcUHMm2/rmQ=;
 b=LAuOfZN/5WWZ1J+5W+Fc2IV6L8patTxhfII8E1z+JQOpCDTSxpmBEsMkMmNLv7hq6h1Zjr2YPB4K5KgIp5soeoCJKtVD5N3mw5JZVUfac/qkoaltzo/xgg4Kkas4OMX0eDy+R4NEl2Ov/0K3TBrP2Q+NFPSNKOnAi6AEkNeC02R0xbkUQJpfdUNMyYC2/ivTsr3dz6bU5pdYAd35gaYB+pkbymHo7IJ74Zghda+Jr8h2jkohjxmyKLMSW/vOCxogLb/hgf0vSAr7c1vy/J9AOE58bPfr1AYSjdksW3FY/JEa4gH4c33ZufjDjhTQ7KQRTHeu9ELIqyftI5wR5vLG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k3aEaSIGACCE2Zsd7ONxw6uHpAnd4upjcUHMm2/rmQ=;
 b=OK0XR+PzjOXaXp7uRiTwPb0ITOU9nxJeP8kPD9qdSgg38KDsXUhOE2vKbmJc5wKqESZH/k3B49Zqn7U/T1BnkEkCIF029LX5t0Y9NhgoCUSONDiFQ7Dc+lSNBjPIg6YG9gqG2KOFSpL4tauCp8e50mYo7kHPBYN84oPE+MUJjk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 18:55:30 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 18:55:30 +0000
Message-ID: <c58700f8-2d75-4dd5-b30d-aa1f2d95b21c@amd.com>
Date: Fri, 24 Jul 2026 13:55:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] cpufreq/amd-pstate: Add dynamic EPP as an
 "energy_performance_preference" mode
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
 <20260723201228.22584-5-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260723201228.22584-5-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:610:54::26) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1e3b23-677e-4343-c4f8-08dee9b521c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|6133799003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4cGK3RgRwP1Tih2hFfhotySoCqDXC60DYC/fZqpQ9ui2n0ukkqhCGSh48Zu9qSf8TPOo/5Kh2kqm52UzLAq5XWRkZXK25QLmfBWwqxLynetwWfE8QtPxma5BUf5cwz22UHUtDFi0jW7BuabnHo7CbJ5FQfZp/fVbDenrGfmTt0UGXNaCM8BQijThl2W03mH89W378XO9KNHqP+kGAqWqp7omFogcZja+7PLq1degnVTMNVMIurpbzV010zcaDu8UF7WmNDswYjFoTRgXxG2+f5FtdwknW8h2OKo9YKiiwWTFmYfqpFRjFnduNXD0pEZXG1ynJte8F+O8/c+670bWGXJmelPL7qEuecUsB/Yus+SxZ3LAJevq2ERlY8tXr6PDZr1Sq2grq7gYjexRli8y9dSXW2q+PqnxyzqqXg0rvDK+mChnqLRdig8pRS5E0mFjrBeyRlWTZ7eP3tYVOopaV0Zkb84WMTI9k+BdF4KO9+rIeYPPK0NpzQdeHH/CecBv682gcOckytWiEpHLdU1IxHF+yMGREGZOVgziLENlkVX3p3I9mwROYDKRoe8IP38/4GAb6HqPlGCkPwLA7ypxor/4uay+VxjdnRy0qQqXYc6xs+G1LBvysquF38f26aKRNrioAxAPIi5FzRqyzvE4cuWqGVW3Et9GhvfvQPPhCCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(6133799003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWdHZUd1Z2EweGJLYUtVTjRCRlVsa2dQR0pTTW5iVDI1YkFOREk2VnVwb2d1?=
 =?utf-8?B?WFA4TS8rSlJaOFExL1lSeTd1eFdCZW9mV3VjTHYyVmM5aENGQWlkT1FnTHlV?=
 =?utf-8?B?a0pnQXhpc1lQSThRM1YyU2RPbGRMeERZUnNtQUtyS0ZPYWtqYWhSNUFiQVhU?=
 =?utf-8?B?djducWtwYldyZW9rdXFFQWNKYVdMZ1lreDNNYm1lWnh1VWZNWXhubDRhZ2E5?=
 =?utf-8?B?VFhHaWRtM1F4NHBEUUpUMThiYzFQeFNpanBDdFd3TXdTSGdxVTVHS3hvTDJT?=
 =?utf-8?B?UEZ1Y2pGekxmeTlaaXoyUERQM3QzRG40UW5jRlMwcVVVSlR6RXplYWc3WERX?=
 =?utf-8?B?UjhCQjF3WnJTbmlReGs0aFIvUEdFdFprOG9WRWNmd0VTcDlITUpsbnV6YmFJ?=
 =?utf-8?B?ZFAxM2ozc2NaQmMrYXo3Q1ArV0NZeWpzVjN5MktBaXdhcnBZT2g3aFM5THVi?=
 =?utf-8?B?bmYwZlVNRTlQZ1hmQUR5Vkh6T2FueE92QnZDYU9UemlmT1hGeEJaSVZwSHNF?=
 =?utf-8?B?UFFNenpMNldabkVFbXpJTkNlSkVCMWFjT0U4REpzaVZOSzFid05iYmcwekow?=
 =?utf-8?B?TENDKzdqRWs1elBLQWR0MWQ1emprWDluaXV2ekJYMTRSaHNTck15a0ZLU3JC?=
 =?utf-8?B?RXFPSFcweVU2TnczZ0paWTRITTFNMWZ1MkFXR3dPMUlUaElxalZydUtNRXhj?=
 =?utf-8?B?RG1ubHRYdTZ2QXJBYVVUSFNzTEVtM2RxdDhWaU9OOUdnc0YxRmlOQncrSkV5?=
 =?utf-8?B?ZzEyREcyd1NvTWk5SGk1NlpxVFF0VGp2Zi93MmdlUW15M0I0dXhVV0Y3TTRF?=
 =?utf-8?B?LzFVZW9XNnFDeHhneGxhVmUwSWJQY1FqSEZ1KzlBMVFtMmttVmRsOWdQc2wv?=
 =?utf-8?B?NUdzNjlJMkoyaTE3ZjBjQTZ3YklGYk5TVklqTjFBSFRGeWsyKyt4WURPNjlh?=
 =?utf-8?B?UXNNNjVIbW13aFBHWEFEWGRxM0hZZnozcUR5cDRTRzBubW1QNlNyMVVwSzFh?=
 =?utf-8?B?Njh6NENmZUVlV2s4aUdXMm5SbmhWaklqb1BTbHZzUFJFdjQyNGc0UThyK05v?=
 =?utf-8?B?QVJsYmcvVGljbjhNazIxTkF0Tlc2bEh0bE5nZk1IZGVJTHlxV0t5dXFiUjda?=
 =?utf-8?B?aGliZXVPd054MmJmSUx0TmI3SVV6UDlJYTMzQlhycEJCYXNoUmlMelY1TUhQ?=
 =?utf-8?B?cFhnTS9aQmdlSmoyMUozRTFoMUlDY0ZZelVkYjkwQ3hrM05NRitDNEVUTlVw?=
 =?utf-8?B?cVNLOWZZUERIVVFuWERJU2NmcUYxaEFZVEN2elBYUmJWaWd2YjE1bE9IS1ZR?=
 =?utf-8?B?WVA3RGc2RGVoYjBLVzc5enZjbkJuR2JINEdNMnU4QkdnWnF4MmloUFkyNVdO?=
 =?utf-8?B?dk1YOVhIS3N4VXpOdHgxUzg3aHdNUnFreCtkQ1UzeFpDN3RrbDdxZVBqS0Iv?=
 =?utf-8?B?UTUzcjVvYzQzMlJveHFsOFpveE1aYlVsZTJNb1hFYVY4OGpnRHdLSDExRVdY?=
 =?utf-8?B?bzZDVHFETzBlNVZQaWFmWVJYVVNKWXJzNlM5M1JSeXNkOTlHdms0ajAvR1FS?=
 =?utf-8?B?YTRmeDlvM28rYlJScW9ZZVIzTlFzZVM1Zk1kS2lRbE5vNmd4Ui9uOThFaGNL?=
 =?utf-8?B?ZlZQM0psL3ZZQ2VXYkwvQjYrMlkwa2lPK3hhTjJFb2FCdGJKNVVaV2N0NUt0?=
 =?utf-8?B?UHZueHU5aWtrbWRsdUlQNThuQ25HMExPMklrelhhTEh6QUlPOG5wblZJTnhG?=
 =?utf-8?B?d05LUnM2eVdOUGRMaE5JNmpLNTMzU0U1bktoR3RmNlM3MEszUlZNVUl5NEpI?=
 =?utf-8?B?L2JoWkdKOFNiSm5JSVpvdUpKUEFLSUNOL3hvV3lFS0tGV1JoSDVTaW5uODJY?=
 =?utf-8?B?OUQ1ZStuTnNMYkhXR2JUMkc3UkxvT0tvMVgxV2wwRkZZZ2gyR1FlclZOMW9U?=
 =?utf-8?B?NmQwODRKcWpOYzVHek1FbVJGcHJsNnJka2hHT0JZRUJCVlBLdFkzQVhjUDg1?=
 =?utf-8?B?bS9RZnFQMEk5WXpyWlJPRG9BbFhUeVQ1cjlWZ084SEZDYjdXME1aQWQ4Wld5?=
 =?utf-8?B?SHl0bFJkelJlS29nTzN5UHdLSVVOSXZlUllVNk9DYXQwVXI0Wllra29oQk1X?=
 =?utf-8?B?WTcxWmRaRnJuMEQwdUxlNmRFbExCYnhjYkNReHFrOGY4R1YySTk2ZnI1M0Fn?=
 =?utf-8?B?cUVIWHFqL3M3MFpxTXA0K0s3TkFaQkJHMnFFY1U0eStnUmFPU1FZcnhibVJl?=
 =?utf-8?B?Q3ZYZEZXazNpQTVjSU9kaDRYUXVYb284cGVMQXdTRGJHb3k0djE3ajZMN3VH?=
 =?utf-8?Q?XpoJpfSO6U+I3k53f/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1e3b23-677e-4343-c4f8-08dee9b521c2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 18:55:30.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkKn76yNk2PL/ubdGbA6XLej38jONX6RoY4yfn+C5eS0gHwikKwMIff0ZL1bPRvTm3AS9DBa0LfF1Oiu4sZQ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345



On 7/23/26 15:12, K Prateek Nayak wrote:
> Conver the global "dynamic_epp" toggle into a per-CPU
Convert

> "energy_performance_preference" mode "dynamic" that allows toggling the
> functionality of "dynamic_epp" at a per-CPU level.
> 
> Instead of being a system-wide toggle, users can opt into the
> functionality of dynamic EPP on a per-CPU basis by switching to the
> powersave governor and selecting the "dynamic" mode from the available
> performance preferences.
> 
> Unlike the previous implementation that had to check for driver mode
> before toggling on the functionality, block writes to certain sysfs
> files, potentially disallow policy change, etc. the per-CPU toggle fits
> naturally into the intended design and provides more granular control to
> the user.
> 
> The dynamic_epp file is now redundant as the option to toggle it on is
> controlled via energy_performance_preference, and the dynamic_epp file
> will be removed in the subsequent commit.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Changelog rfc v1..v2:
> 
> o Removed "dynamic_epp" global control related changes since it will be
>    removed in the subsequent commit.
> ---
>   drivers/cpufreq/amd-pstate.c | 57 +++++++++++++++++++++++++++++++-----
>   1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 7d1feed0e11e..fc90e4108c22 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -106,6 +106,7 @@ static struct quirk_entry *quirks;
>    *	3		balance_power
>    *	4		power
>    *	5		custom (for raw EPP values)
> + *	6		dynamic (platform profile driven selection)
>    */
>   enum energy_perf_value_index {
>   	EPP_INDEX_DEFAULT = 0,
> @@ -114,6 +115,7 @@ enum energy_perf_value_index {
>   	EPP_INDEX_BALANCE_POWERSAVE,
>   	EPP_INDEX_POWERSAVE,
>   	EPP_INDEX_CUSTOM,
> +	EPP_INDEX_DYNAMIC,
>   	EPP_INDEX_MAX,
>   };
>   
> @@ -124,6 +126,7 @@ static const char * const energy_perf_strings[] = {
>   	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
>   	[EPP_INDEX_POWERSAVE] = "power",
>   	[EPP_INDEX_CUSTOM] = "custom",
> +	[EPP_INDEX_DYNAMIC] = "dynamic",
>   };
>   static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
>   
> @@ -134,7 +137,7 @@ static unsigned int epp_values[] = {
>   	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
>   	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
>   };
> -static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 1);
> +static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 2);
>   
>   typedef int (*cppc_mode_transition_fn)(int);
>   
> @@ -1274,6 +1277,7 @@ EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
>   static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> +	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
>   	int ret;
>   	u8 epp;
>   
> @@ -1314,6 +1318,9 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
>   cleanup:
>   	amd_pstate_clear_dynamic_epp(policy);
>   
> +	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, prev);
> +	/* Restore previous EPP if toggling Dynamic EPP failed. */
> +	amd_pstate_set_epp(policy, epp);
>   	return ret;
>   }
>   
> @@ -1384,7 +1391,7 @@ static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
>   static ssize_t show_energy_performance_available_preferences(
>   				struct cpufreq_policy *policy, char *buf)
>   {
> -	int offset = 0, i;
> +	int i, offset = 0;
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   
>   	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
> @@ -1407,11 +1414,6 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>   	bool raw_epp = false;
>   	u8 epp;
>   
> -	if (cpudata->dynamic_epp) {
> -		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
> -		return -EBUSY;
> -	}
> -
>   	/*
>   	 * if the value matches a number, use that, otherwise see if
>   	 * matches an index in the energy_perf_strings array
> @@ -1422,6 +1424,23 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>   		ret = sysfs_match_string(energy_perf_strings, buf);
>   		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
>   			return -EINVAL;
> +
> +		if (ret == EPP_INDEX_DYNAMIC) {
> +			/*
> +			 * Dynamic EPP was already enabled for this CPU.
> +			 * Nothing to do.
> +			 */
> +			if (cpudata->dynamic_epp)
> +				return count;
> +
> +			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
> +			ret = amd_pstate_set_dynamic_epp(policy);
> +			if (ret)
> +				return ret;
> +
> +			return count;
> +		}
> +
>   		if (ret)
>   			epp = epp_values[ret];
>   		else
> @@ -1433,6 +1452,13 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
>   		return -EBUSY;
>   	}
>   
> +	/*
> +	 * Dynamic EPP was enabled previously!
> +	 * Switch back to the static EPP mode.
> +	 */
> +	if (cpudata->dynamic_epp)
> +		amd_pstate_clear_dynamic_epp(policy);
> +
>   	ret = amd_pstate_set_epp(policy, epp);
>   	if (ret)
>   		return ret;
> @@ -1450,7 +1476,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>   
>   	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>   
> -	if (cpudata->raw_epp)
> +	if (!cpudata->dynamic_epp && cpudata->raw_epp)
>   		return sysfs_emit(buf, "%u\n", epp);
>   
>   	switch (epp) {
> @@ -1470,6 +1496,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
>   		return -EINVAL;
>   	}
>   
> +	if (cpudata->dynamic_epp)
> +		return sysfs_emit(buf, "dynamic(profile:%s)\n", energy_perf_strings[preference]);
> +
>   	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   EXPORT_SYMBOL_GPL(show_energy_performance_preference);
> @@ -2030,6 +2059,18 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>   	if (!policy->cpuinfo.max_freq)
>   		return -ENODEV;
>   
> +	/* Must be a switch between PERFORMANCE and POWERSAVE */
> +	if (cpudata->policy != policy->policy) {
> +		/*
> +		 * Disable dynamic_epp when switching
> +		 * out of CPUFREQ_POLICY_POWERSAVE.
> +		 */
> +		if (cpudata->dynamic_epp) {
> +			WARN_ON_ONCE(cpudata->policy != CPUFREQ_POLICY_POWERSAVE);
> +			amd_pstate_clear_dynamic_epp(policy);
> +		}
> +	}
> +
>   	cpudata->policy = policy->policy;
>   
>   	ret = amd_pstate_epp_update_limit(policy, true);

