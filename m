Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA8392C3C;
	Wed,  7 Oct 2026 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791385575; cv=fail; b=n2sdxUzZFguq0k2C5L/dzQpLR7FUIHpAHA4YxYeOhMfi3TST6xlIZcsEImNzpMpYFUPhj8r+q/Cb0TWHpSvoWGbwDqBqrWzRDy0Mwi2cmocw4uOd/3mObwFvjWKYlRxrNYrMbKqRAmT9aawK/1Ik7YOfihS3o0/YivaHJ9pt0eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791385575; c=relaxed/simple;
	bh=oAW75nx3DgVNuyt8pxEfxkAd1AIUNVJJNw89Q+S8vW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ac2Wvj84oXZijeYM53TsqX+8dX0IE2KBA1V736lXcA7iYAkj80LQsaQ6HSgK93hqux7g4DYmoX7ffs8C8cn4Astd54iHkLdFZLamc6oNISpL55SqbfZEHqiHbUEtpGURHRssLskVfundatJSkuZlTH1v1hEJhfVM6ZPRvej5ZAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L2tx7+Hq; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L2tx7+Hq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtFsCjWSR9CaXMbx6D4AjpBXoR+Z6XATxn4UGORKsPbJlveI+etG+Nt/vixr86aAt5WB3oHWr36gsC7DOZiPGeOEsuzWwzcbPTdfxwRdxaQM6rGK6GBcScsxjEijgzvZo4Y/z5Cub6EbBRPS4C9Ckha7cnCyYA9UzOeP4xPFx181zTzg5fa4v5jBQ+kTExZgKVEvjjpKjbnqX16EqPZ0WftdccSwP7hle+x/p8JzzCEX+L2BYumIHF4FEGX6QPrdIPhkbtrBojJTVtWWOgVgi8sVLpkO4McSZBVvo1CoQMnDg3TnkhfVRl9IGMFWC4tPBtPU1eAvY4PCdNQfwKZPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPFXuriYs4dMcm58axm3h5HxC6qurkCSVDAhOTiPn1I=;
 b=tr/8kPJwCXemaQseOXx9elrFe+xbh+CVnF02CFtQmShtha0a8qRvEh97AjW1cEvt5g7XkRMsQ067ZYenC7T9NCA7xSk7MVA3c7fiJSaKYa2xJ0iTCGlSrfxARRbMbI1+nQeBxFwnLuI5iK34EgrlgM9rMK9ZuAdzoJsmOmq2uRh3b8waa+Z6G9WOhFqDAdLoAxwgMqLK1o+JjESP75iK+Q+Gs/DxB6MmDlXBlALnGLY5+EA3KK7kTJaLVBDjYm2Alm9PGPRfZK/hGf3d6/VOk4fIOOIyfW5O5u6hqGq8MJrqusDrMiML2TVsp3KobyUuf7UmHGQj1gUZSNTvWBn8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPFXuriYs4dMcm58axm3h5HxC6qurkCSVDAhOTiPn1I=;
 b=L2tx7+Hq6ElzCAhwX/r35kBen/TPXSH2KIsOa3+m3VBksMdYcHmNdxaD4+/UfUH9RRrn/1EMY17wYQ1ENYmuYE+k7iQmzzBptzYPVqd8YgA5oNnuCvp/RAPHLhn4xgkgLjb13WWPE0xP+F14Nm4ZV0bg/wh5pFScRHj0K0rltV8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by BN7PPFDE2ACDA69.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 7 Oct
 2026 15:06:02 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 15:06:00 +0000
Message-ID: <a387ee24-ef09-4983-865c-47ef43fa0964@amd.com>
Date: Wed, 7 Oct 2026 10:05:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for
 TRX40-based motherboards
Content-Language: en-US
To: Kyle Gospodnetich <me@kylegospodneti.ch>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007144150.15113-1-ggherdovich@suse.cz>
 <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
 <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0057.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::6) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|BN7PPFDE2ACDA69:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb5bb41-bf81-4de8-102f-08df24847f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|4143699003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	OU56dCSRmxcq3+2n0N/0Buw8ZKD7JxPLX/HLYBv7FkVLBNWOfsWdHKzIRQYKTE/gEwIlQaT9+2VBaBQL8X6Q39BuXsJqMoPQPerOcVxY1ey7+1CXTjB1s4EefICO5+DrPa39X5MuGRzdUmt7Fveb9YI+pqixghS14/BjNwFuZR4IKch7vTL7UNLe1XgegLXNrVqxe41gzpOUkJ9OFavOAVbqb7psHcJnx6pPWlHkHQIHm3hMbLcVb1BeaxAB9mniDQM+ghYaE4kI0o5SZSEagc7+HQJdhQxWLKlt937H8MlnpFt8GlJA+9u2ZB+rIs+FYckLs0fyW5U3oiHYBm2ffGZTkWd+GArBwMg8FDtf7a22aC41XtuQP1Z2BnTi8yRqfb2vGlz8NVU11uNZgxpvn51kKLCKFJadFbo6GVOhLwwYaIvnCv5Fbh8D7BsEIQEGbPEvqeWaS1dAZDTnE+0yq48ZcVMVyTSxZMX4BnP6S4egnpmYDZ6Z0CIK1vLfTn6GQjrLfI6pQGTr2LjhRz1B+cA73KytmSQDHiZUl5bLkHCazGqkMLS3Ycu8q8TJBrZ2+iTBdiFLr4tIsvijLi4KPy5hbUj6x28yeITZpftNYLWUEPvYWkngiCsxcXn/dOAMcdrVdXD1rGbRV5WMyRUsnP+PH+bcufUf4jmgrIess9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0dKcmc4RkVJbGFZZWphMU4wWGYyT3pNWE5QRmlQYlNnNlJUSTFidS9hVzhQ?=
 =?utf-8?B?Y0NqSlZ5em9pZ3F5RC82aFYxZ2dXd3lkT0dNbTFEVkJzVmN3ZjlFMXpjYzNB?=
 =?utf-8?B?TUd3WWNFa2pJMmdxSXBhU3QyVHU2TzR1SCtzelBCYUMxY0ZkUUxDbG9YdHNQ?=
 =?utf-8?B?Sy8wc2MxSG1CZC84WWh3aGZvK29HZkJMYXBCaGE0emtHTkV0VWVwWGxBUDRT?=
 =?utf-8?B?TS9QOERud2RVNWRpRnJOejlnb05jb3BKSUhmU1JmS2crVXdrang0NUhRYVlW?=
 =?utf-8?B?U1FyZlVWQjJrZFBaNWN3R2JxZGp5K0N0cUdKMC9jNC9GbDlNaHB2WURBRGRp?=
 =?utf-8?B?U2pzdFJCNGlBd0tFd2lXNUhOb2VTY2haZzc4djlTSEJPRjdQV0hrajV1ZTNu?=
 =?utf-8?B?Ujk5MnF5aEhNU2ZWTTcwUm1PdDQrVGV5NTJFL1Rkb3FFcFJSMU0rVjlyN3B0?=
 =?utf-8?B?RUJPa1MyTE5ka3k0RG16ejA3VUt6eVU1V1UwUVYvbHVpanF2TGJiL2tVUXEx?=
 =?utf-8?B?ZWV0T1cxM29HZEJZY2FoVFVSbEoyenZUZjBvd2RLSlBHM1JZMUI0TWlsZzFi?=
 =?utf-8?B?RU95ZDRDTG8wUGxwV1dZdEEyL1lxWFdpQXdDdVZ2NWJBS0pBZXpwUlBQVDI5?=
 =?utf-8?B?Mk9USS9TWEhBemN4NkRrODVJUnlIdSt5aERoUldERE1yVzAxYmd0c29pQTdU?=
 =?utf-8?B?WnYzR1pPdkQrUUEzYWNoVzY5ZHhDRU9Nd2xPcXVrU0ZoWU5nM3NHWEJaMUk2?=
 =?utf-8?B?Q2xycHdSckNjTWVidDBtc0lxV2pKcWdHQ2wxdTQzdlFnZjloZWcraVRjSlFW?=
 =?utf-8?B?MXk4UkJHdEtiQ2hJVVNRTDdJd1EvRlJxUUc0MkUxaHphNTZxdTFOc2lFRllV?=
 =?utf-8?B?aXcxQitoWEdQMm5aMDZrNFpVVzNQOTErcjRtMUJRbjVLMkZPN1pkYi9jUkFk?=
 =?utf-8?B?L29Pc205ZUQ3NDRpLzVzdm1pSjZFOXpmaU1HVnpxS01xUTNpbjBWWjJMTmNv?=
 =?utf-8?B?QS80UFN0Y0Y4dlR5ZGhpR2xBUERjdEQxZWZyZElNL3pYNEg1MUd3YkJ5ZXRq?=
 =?utf-8?B?VDBkVXdmV2o0ZmdWaUF4Y0IrQjNPYmRDdjM5SmY1Ny9XcFRiZ0dzMzJPaCtN?=
 =?utf-8?B?dGl2ZUdoU0NheVpVRlMrQzZONU8vZDZsQjdSQVAzeXQ5RCtYOXVHRit1QWZR?=
 =?utf-8?B?cEhaKzc3aWlxLzVWK1c1bTJnMTdNSDZuNEkraElkOUZ5ZzlqcmxNNnYxZ3lR?=
 =?utf-8?B?TTRNU2JUZ3BmZjJvVEw3d3VTRWVmalZvNHJ2YTRJc3FZcUJyNEVqYVI1M3Zy?=
 =?utf-8?B?Q3pLVW1ZWlV5aWlyb2JUYU0wdjJTS1phQVhtK3ZvVzFZUkNveUp4S0ljYnF3?=
 =?utf-8?B?N1p2OFFsMDFYeGhhOGZVTWJja1hPYk1qaVZYMWI1bUEydjJqUXdsRDMveXVR?=
 =?utf-8?B?aDJPdFJuNFdzYXZsdTJwNFVpVFUwb3pWNmtkTFJBUnIwQS9QMlJjMnFibTEv?=
 =?utf-8?B?VkFoUjFOdFBvdkZ0c0ErTmtEakU4eDdTY1dMcWh0b1pkRmZHVXZFYUI5WE9n?=
 =?utf-8?B?bUp5L2Y3dlR0YkNUcStYMFQxSTNCNFIvbk1NbE9YUTBwc0J4Y3R2a1hJRVVn?=
 =?utf-8?B?OCtWT0ZmbGRlSjJFbWRKRWlxY1lYUUsxWE5RcnNKVkNyYkt1NUR4aUpBQ05k?=
 =?utf-8?B?NStxU1MzcnBQdmNOaDNHbWpBeWRvbWJtc0ZvNUovZ1lCODY0OTQwWmhRa0hx?=
 =?utf-8?B?eVhlbytFYXVnb2FHNVdoMTJWVFV1SW5EekxXWVljdG9RSjJqWStDUHpMK0hr?=
 =?utf-8?B?R2dOeGdxV0xaa0NhOFhOTy9DTGFsSmtLNXRaNU9KRUJiVVVQQUJYMm1ucVV0?=
 =?utf-8?B?MThpRDJ6b2xXNUJPSVRPSHdBOGkrMzdUSzZpSG9CNy90ZkY5S2x6dGFnZ1VQ?=
 =?utf-8?B?cTJUUXJIYzN5YmNVY1B1OFo3Si9PRzhnOXpzVVFjSkptMmo4dEg0bTZRS2hy?=
 =?utf-8?B?ZWhKaVVTT0NrdENhZUV0Y0RxRUJPcGZJU2M2SGlYUytDa2RvU0hkQjBJdUgv?=
 =?utf-8?B?UktvZHNtMml2NFBibEJSUVRmTEFBbUhtaWR4cjVqZnlLaTR0Yzd5aUx6TUlm?=
 =?utf-8?B?cG5XYy9qSjREYURFWkNaWHdJSThrUkNKMVJiQzl4M0x5MzUxSnI5Wlk5UDZT?=
 =?utf-8?B?bk1oMGNyOXp6N0E2aDA2RmVKZDNSNW5hV1RhNlVUSUwxN3dKODg4anZ1bGlO?=
 =?utf-8?B?VWhTMGlVbVNLbktXRGp2amNVOE1VS1hkdGFXb1h2dURhaVUxSUVXa3Q2K1RM?=
 =?utf-8?B?TjcvU09oTjJwUkQzdzZFdVpkeU5RUXBSak8rUGw5NFpZRXBYb3Qydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb5bb41-bf81-4de8-102f-08df24847f31
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 15:06:00.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnNtoXduuVfZLOarfbd2EGdLOCKOmWPl1TWhNoT+LmbvOpk2ogfg0SswePe6j4hKcmgWVpNZxuqOyRGqACshmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFDE2ACDA69

Kyle,

Can you please confirm more about your system?  System Model, vendor, 
BIOS version, BIOS vendor, CPU model.

Thanks,

On 10/7/26 10:04, Kyle Gospodnetich wrote:
> Yes this does appear to be the same problem, thank you!
> 
> -------- Original Message --------
> On Wednesday, 10/07/26 at 07:56 Mario Limonciello <mario.limonciello@amd.com> wrote:
> + Kyle
> 
> Kyle,
> 
> By chance is this the same system that you were talking to me about offline?
> 
> 
> 
> On 10/7/26 09:41, Giovanni Gherdovich wrote:
>> Some motherboard based on the TRX40 chipset has been reported to ship
>> firmware lacking lowest and nominal frequency values in the
>> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
>> Firmware updates aren't available.
> 
> Can you please add more information about the vendor/model of the MB, etc?
>>
>> amd-pstate requires explicit knowledge of nominal frequency, so it
>> can't load on this hardware. The driver already has a mechanism (the
>> so-called "quirks") to accommodate for missing nominal freq in ACPI
>> tables, so here we use it to match against CPU family, model, core
>> count, and BIOS version.
> 
> Yeah; it's intended for this specific case of really old hardware that
> the BIOS isn't going to fix it.
> 
> I don't understand why core count matters though.
> 
>>
>> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>> ---
>>    drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
>>    1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 8bfd46d60843..532ff16dd076 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 = {
>>    	.lowest_freq = 550,
>>    };
>>
>> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c = {
>> +	.nominal_freq = 3800,
>> +	.lowest_freq = 550,
>> +};
>> +
>>    static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
>>    {
>>    	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
>> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>>    	return 0;
>>    }
>>
>> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_id *dmi)
>> +{
>> +	/**
>> +	 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 socket / TRX40 chipset.
>> +	 */
>> +	if (boot_cpu_data.x86 == 0x17 &&
>> +	    boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x3F &&
>> +	    topology_num_cores_per_package() == 24) {
> 
> Does the number of cores actually matter?  Do you mean to say if you
> swap the CPU to another part CPPC works?
> 
>> +		quirks = dmi->driver_data;
>> +		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
> 
> The BIOS bug specifically is lack of values, not invalid values, right?
> Just want to make sure I'm following this right.
> 
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>    static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>>    	{
>>    		.callback = dmi_matched_7k62_bios_bug,
>> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>>    		},
>>    		.driver_data = &quirk_amd_7k62,
>>    	},
>> +	{
>> +		.callback = dmi_matched_trx40_bios_bug,
>> +		.ident = "AMD Ryzen Threadripper 3000",
>> +		.matches = {
>> +			DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends International"),
>> +			DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
>> +			DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
>> +		},
>> +		.driver_data = &quirk_amd_ryzen_threadripper_3000_24c,
>> +	},
>>    	{}
>>    };
>>    MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> 

