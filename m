Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278FB472774;
	Mon, 28 Sep 2026 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629152; cv=fail; b=Fg5UYFZzj7brhc5Br6r+4QqD0lwews6oiVIfCUFT4M5xF3i0WtV08DvTaCqELMDweAY+k85n4NO4e7TytnNF1oRN+XlU04obDtUPWr+AtBvw4qDzQCNeLaPFxgexxBZoC4Nx0dKpxX1ER7u1MNsuarEQ6ts9eIlK4Uv4NjWq5lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629152; c=relaxed/simple;
	bh=wlOdRt4RVSG+ySU9JVbH0KUn2i9UK+SSVsYTSbCrWbc=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dhjtRr8obJYiK3wfdAnLdzFabJiT47rWvSEmAtkLyrEqh/OzTC8jZKyRdXgjHLtSZC86XPrxd0yIlfdVLgIeyIeRJo0PRC7sF5VeE62/wlbElI4WQcJaUXqjXOlzznEbU39swd4n2SQ6oDNu6iYXoPBvqnbQa6yM3ez3hIwGABc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lbYEL/ln; arc=fail smtp.client-ip=52.101.53.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lbYEL/ln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxA8/mwNFJwxNOjKeG2IIXTszlMow8s89rpSreSDQv5G45NBoTBTZIkm9ayhiEmegIn956xGA5rRydvUqQWe1m/olxjid9JQzHQ9m/Nsq+RoCc/Zbyf8qIwSmKHiCbRvNT/YNBEZN3OF3U0flIIbG69OaP+03cQoK6j3+FqoqiDvpQUJEof8K/ZXNnx28JwgQjxxALMCATu4GJXQ9vVIPlgfP0W8E0K6EwBJ7pOSm1i87wCk5EPXTQ1QCPuaS9oWH9YXWqMPZ90ypLcT61SfGNiSmjOnLTtz73FOJppZ8yjANZUr4GMNgYRgkuruLpYxMQXhFLz33BvJZJgXYX30cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23/p8uYz4oVdzVmWAtyQt/c85l8CAtrNdTerwclM7gc=;
 b=uGKi4HmP0WuM3vUM85kAG51+j4lW04Z0Ytxv98rRqKnnQSLCeWH7STE57ivyg10dElPkPgjLAld6OtszthdA45sYLWaT80+6bqdUuoBChE1X+ZP7mTrRpiFtsNECQlS4Uw4SGWtywY8BnhcgHcWiC/b0+sBS/Vy4WfbUgF2KVy6Meo564PEDJUUIq6Gcse0MzQbPEoTVZVF/bEUGqyHLCFmEu4HynvfP9rL22KmdlSpGYylfQWFJlu0aQ6jn4kJKxODrx4MmD8Do1364awc3fyQ+oW5RnbpnboCZxuUhara9g6sBXi5diqyMkxfeCnhmSkVPsdGkpBwo+Lc0k8Zo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23/p8uYz4oVdzVmWAtyQt/c85l8CAtrNdTerwclM7gc=;
 b=lbYEL/lnVB7qPw1jKUZTCSc2qglIOmJkfHqawLuwjGDU3A28WNbu3W+6OdGAtWDxtJY3fLV2sUeMXmobmvYr1Oi9n5jIo97TIr63ZQYWWaqTPM0ZfWbyxkkyV3+nxRaM4l1RgLAk6K1ghGIHUI0Lv1w2QNGSMyJoATjIhmnndsc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 20:59:07 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 20:59:07 +0000
Message-ID: <83294b60-a371-43b8-be01-2ff122df2b5f@amd.com>
Date: Mon, 28 Sep 2026 15:59:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate: Update Zen6 client EPP tuning values
Content-Language: en-US
To: Vishal Badole <Vishal.Badole@amd.com>
References: <20260928203523.1290623-1-Vishal.Badole@amd.com>
Cc: ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260928203523.1290623-1-Vishal.Badole@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:b0::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf332f3-684f-4909-6294-08df1da355dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aH/WQR6MEH/de7msPKmUSlrbhtt3+wAXzWTrXNFTRB7yRRBZqY29coGPQGJTqfLWvpSTAyo5kN1+biTuFCl/4OogCzFxXtPu4ZAVi3wupZ7+wS3L7+L/oFweklz85qAQjjDsBJdmXLlp9bOy3vS/CACYTLMj0icQPjAy012NWpu65Bli05U9xel22AV8QG+yRB3whIpqE2swPCgx/TS4hHSFn4mtNSggeKczmCfqdv4Z1PhArpexnU5J4N11Scn+s+cvovGhIjcYnyD44C8GD9WXZhBBIqXZpLJ/Yd1Ww6L/ewIJqKNtLmkPlHDFe+45xcSfNAo/N9c4PKF8n45lLk7RAt5HPWHjFG8c0uTWKCOGawXDHShkjjui1sSGuheENGKbxUiNo7/2/KUnL+zwcs4PkW6JuGdNtAb9brU86y05AmbJkORwxX9KP7bY08har75s9btJGNmtLvzEVYNocbxBpaPAq52AP3o9ug6k3U2LNPf7TpgggNCjZ4BA13q2HO/2f1QHa0wqwfTLQaulfar9d0CRVs120DR1d9ELEYodSdWacc+LW1NYL/JUEzLqUjlQzdQtzy7UwTQJEXhqacQ2HWLKp1MDrz+SeONFJ8/sLX+2hgYpiD4RVNFZaVmEBoe10Q3sw/LTq+l/xoR+4VOwj0IcX/Jql4jfBddORSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVNaSVBFTGErazVaUml5S0orT2xWMzRjMm1Obkp2NXRiZzZGMEtNL2lYT2Y4?=
 =?utf-8?B?M0pGVmJ4RDc1bWNOTzI1WUNqSlJQSVhMQXkxVUJrR29nRkcwckJDSHhwWHM5?=
 =?utf-8?B?YU5SdTFGQXltSHNNeHRQcTdKcStyK3k4MEo4S1kwbXpEb0MvMjNzVTZpempQ?=
 =?utf-8?B?NGNoUXIrem1TQU1zenFHUGp0T0owYzc4cTY0R0FjTjJ6NE90MEZ0QVEwZE1u?=
 =?utf-8?B?UXNTQnorV3lKNC96V2JxYUhaTDFUaTdWYXNHaXNLb2Fwa2ZiOWdFQVhVM1hm?=
 =?utf-8?B?Tzg2ZW5kZW1waG9sWGphVTVMelFrbnBuMXJHQ3NpdGtpQlB5aGtMSXZUS2lr?=
 =?utf-8?B?eDdFbUR2aUxxS2Z0RFZWUTczL21XYWg3SVF4UkxqbjllTlRpUkptYVErK0JK?=
 =?utf-8?B?WXZUemRpR0plQTZkclFsOWN0cVVXakxHa3paSkkvbkFIQjNsZ1ZlVTUyRlJL?=
 =?utf-8?B?ZmxGMVJYTWQrdEJ3WGRlaks5M00vUjRBY2Y2aURkUTJJeWFHR2MxaU9iekJJ?=
 =?utf-8?B?YXNFclhPS3RWWXRMNnhpR3h3dEJnRVFTSFc4NkhVN3B0eTdvd1BHQllqNFIy?=
 =?utf-8?B?SXppK24vTmFLZlRHQ1l6RkUrUkFrVWJWL0ZtNnlUYU9hUTJwQUNaaWRZSzZs?=
 =?utf-8?B?YkE4MXB3eUo1S0tienFRT3NxbUNtTTNRZE5wdlprRFc0NGk5UUs3TFljMTd5?=
 =?utf-8?B?THpZL3pvTldXNnMwTzNCSWpYZ04xRDg0SEtqRnlwcTlIZzU1L2kvQ1N3VVZx?=
 =?utf-8?B?eUNHZTZXUHczYTNLV3NpMDVOZDEwT1NDbEUreWpxU3VwdGUrdlpWWU5QTFFz?=
 =?utf-8?B?UlRQVVIrZFRWaUJJR0xlS1dSYklkVVJJRng5NDl2QjZoc3Z2TXBBYWFkdXIz?=
 =?utf-8?B?WTU2dkJ2NnU2VnoyVnFlaEd0ekdtNDFveVVsbHBIRmVVdVNsR3dvaGI3VFlG?=
 =?utf-8?B?eit0N2JST1lMcW5VYi9RdUcyb1h3eTk1aXN3VHFpMlpGbjRBWklNdWVDUDFm?=
 =?utf-8?B?WFJoRFJZclQxemtIbnJRbnlvK3gzcTRyRi9FS0trMFI3eXRVRDBPYnRKeFUy?=
 =?utf-8?B?Y0tIc2Q5VXV6QUdhSWREMXhHcm5oSjZ6NkhWR0xkQThaY2o4ZzFJa2lZZU8r?=
 =?utf-8?B?WU90VUlxb1FGdXlwQ1VuR3l2UzdUdXhaYVlzK3lxNjh1anhFWGZOVEwwZmY0?=
 =?utf-8?B?K0hBdzQyUEpaUkw5SDZWQWlFTE04WlBTZnZWNU15bzBNZGkyUHNHQjdNVmZn?=
 =?utf-8?B?eDV6TjlrdjhWRGdCWDFRcm9pSTFid2pjam5yZEpzL3F0YUJReUNLNzgrRnV5?=
 =?utf-8?B?SzFvcTJZNWlBVnhqUkRBaWFiUDAwZTVWbVJEbWhhalNsWDI3V3ArL1hNVThW?=
 =?utf-8?B?MTVtQ24zNkppNXlGQzZWbmVGVms4amdSYW9oTlE4U29nMVVjR0hldjVuTmti?=
 =?utf-8?B?ZlY4aUF2UEN0VjBYaHkvMlBJUzNubHlRMndPaHlwWGJLazVUMEJvbCthMmYw?=
 =?utf-8?B?M2dtUnQ0UzU5YUZzNDlRMGtYTk0rbjRhbkljQ2NBNW1IK1JONC9nR3JlaWx2?=
 =?utf-8?B?bEVUbjN5Rm85a014bDVmSTFkSm4zZ3k5VlpFK1cxdUVwKzdiVWNUNVJhZm8x?=
 =?utf-8?B?TE1LaTlyN0lHRWcrazk0Z1RrSDVmK0oxcEs3NWFtOEhtdzZHN3R1Y09uTFlC?=
 =?utf-8?B?N1dtNU5NQ3ZNSXlrMWpLZ1lMcTg1dDNhVi9SR1NEejVjejFpSXlRVXhKVGpL?=
 =?utf-8?B?MUV4SkRndVpLWk5ZQnMvSmkvRHRZWkNibVIrVlhPRHZrQkF1OWJLNVhGZERH?=
 =?utf-8?B?MXZpZWdIeEZhbUVJdmhuYWlSSkpvZS9jUlgwNkVyY0swT0Erdk56ai8xZk9s?=
 =?utf-8?B?VlJXbG03dkllNVJsSE4wb2JPeDRQUVN3Q0JaMG9nbERsY3c5cUd6SjRwTjlH?=
 =?utf-8?B?TjhiYkhkNTdGUkw0NmliWlJHdU5VdUJpSTlnVnBydS93RFJOT3RkUmU5V0ZE?=
 =?utf-8?B?ZzZpRkkyUFJyWmR0cDMwYVIxdCtDQWJ1dmViaTNZdkEvNGR4K0N4V21IaTgy?=
 =?utf-8?B?SXd0QkNQM1R5ekVtb3VwMDViZVM1SWFrSzcwdDJXTE9iVXdPb1NxODAxL1Er?=
 =?utf-8?B?UFhvZHNaMnc1Q0xvOWFWUllPUko2anBPREZmTDRrRUZmeWRvRVVVcTBNbDVx?=
 =?utf-8?B?MDd3cDJxVUhJcDRlY2tWd2kzLzFidXZocTh6L0ZyaWdRelpodEFGUmN2ZFg4?=
 =?utf-8?B?S1E3WjZzcDdUeDg0cnpFZ0QvajRHUUNycWtEVllmdy9FSDhqZ0pYTkdxWnRP?=
 =?utf-8?B?VDVVd3RBd1NRaGhnU2ViUGNhVk1qRnhtbnFIVUh4WVBlY3pNMzhWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf332f3-684f-4909-6294-08df1da355dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 20:59:06.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENn/iOF9/A9+UDTqQL/fN1XgutbG98A2G43a9E9mmH0WVN1+QAzg/LJcdNADDY0pKjpfJDlnPl/2RBy25zcd4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334



On 9/28/26 15:35, Vishal Badole wrote:
> The per-CPU-type EPP values for the Zen6 client platform are further
> tuned based on platform characterization. Adjust the performance and
> low-power core entries so each core type uses its intended EPP settings.
> 
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> ---
> This patch is based on Mario Limonciello's:
>    "cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms"
>    https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?id=114a157e8d30601d024b53564a0fe54202f6567f
> 

Appreciated.

Applied to superm1/linux.git bleeding-edge.

I'll include this in my last PR for 7.4.

>   drivers/cpufreq/amd-pstate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 83960a6336b9..2529cee9a6cc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -211,7 +211,7 @@ static const struct amd_pstate_epp_soc epp_soc_zen6_client __initconst = {
>   		.performance		= 25,
>   		.balance_performance	= 51,
>   		.balance_power		= 64,
> -		.power			= 64,
> +		.power			= 115,
>   	},
>   	.efficiency_core = {
>   		.performance		= 25,
> @@ -221,9 +221,9 @@ static const struct amd_pstate_epp_soc epp_soc_zen6_client __initconst = {
>   	},
>   	.low_power_core = {
>   		.performance		= 25,
> -		.balance_performance	= 51,
> +		.balance_performance	= 64,
>   		.balance_power		= 64,
> -		.power			= 115,
> +		.power			= 64,
>   	},
>   };
>   

