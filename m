Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FC38331C;
	Tue,  1 Sep 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257039; cv=fail; b=dl1rwTMxVRcBHNQQSSdtQcNqYWevpukc/gZX3yoeD6YVKMWUhFFIGrQkq3/T7s32rYn3zrioxoIMOcAE2SwFIVMF7koRova+urjDALClrd+O0D55ZSenaFVvQpIkZYHJ4c7w+R+eqOdeTTVN96ANdwGMyJ1gJT46ujAygoKsog4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257039; c=relaxed/simple;
	bh=N73Z0V41R1zSClshahfyHlRwdJwyZ9buC9k1oCLFO7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pr5Ek0tqIkCw1FyiTrtAf3f9d4g4IwI+zpLesLBCdqCI3TBKIITbR/rkdfrvvKV00+fBaQc/LEGlpXcNXrCxxJd9EV/EB5D4a6wITKRG3zhTRNP8+dgc3fRt2wV0TsFrQykkm3JUefPgVzjuLO8y0lVYhd5OfAOlzNEudncK/Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OyBhd4L7; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OyBhd4L7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+UAUMfkFw/6w51sZyl9ZrD42WbS7tMVKLSHmPBaNSJdt/KjQISeGMiExchLWzt6MfYKf0RddMlYhzy+lSAH5xprDvKzlAYrRK0kGmxGRRpAC3ROuXwek35w9zHl9cMhgYxz3wBZsnLdQzOdTb8CuWgeTpSwoSYTNJ3a3lN9umjQ3oyIfhUEq7Qld2BcpGiedjPRSfVuKcwS2nZBz4/3AOszX39kGX0/TWeumb+vOOIgQLY/1ahlqnstzoiPkGDhf647x9hfiUPo5nq8EvhIlPurIyQeYb5LkscmBJDvRsNbbfVmsH1vZLlYOYt+MISxjfOk1NIh9ZZVu5/KVeXatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKrbWGcwPMnJOPa6pSixukoHyi9HH7bC4UktL6nAYvU=;
 b=g/Wb1NJlxK8QX+kVEwfq5Hpx/22cLe+ImTXPSySUhJJY7l2/Wy6U5516500mAhYpYgYxvane6cK/JitZib5tMJ8AchnBtzPVYs4/etlrZOeXOiFgXWXPVH6kKpOF1jkEjkQFQtRm+KKv9WoTda0Q9dX+xGUz4HLx56BUO04yPBSa0FAiJEteL4KRQsy8VmI12E5DfbBdaUfZ8/EP1r4FDxVBS5zP/HrCGpe0G8s1zjonTpEpaf7Vx94fqbT6yVmg88PPjULZaHB98+9c/vTxfjh7cumV+zOjd+C2WA4tmtwdh6L/QyqdR2P2wCPZA/N78hdV2G/71qnhxuT769zNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKrbWGcwPMnJOPa6pSixukoHyi9HH7bC4UktL6nAYvU=;
 b=OyBhd4L7VZelS2lrS4zN2QQeA8oPAtIXWrluGeE5wIZ/n09w1Vmk2YMXvB0hYJNMCIRVNovC+HJ4Kxdsoc0LV3SJSF1ADn6vhhCMXMDMfNQeVaTh4ZA9oZw/9QHwO7puA6FtZ9r+qMcHQ675OXTZNiTxcMLVmhr7upAD9aqJ7faD6wAW5z/4iYeJR3qNOmoN326IiiHHbkm7Tn6A8EyHIrJm65mUOXpiRX+zOc6IVsuQwV661zEvPuzHSs2bLG2OutvgDUVXxRRXHAvk+bOuUqeJGXrAXTwzPc8IvHpn+TyDoqB09BrxK9mOH9jWfqnPh9NC8CXr/K7n6gw4BSthMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 10:03:52 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 10:03:51 +0000
Message-ID: <35c658a3-63ba-4664-ba8a-598ce6121430@nvidia.com>
Date: Tue, 1 Sep 2026 15:33:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: tegra194: fix double-pointer error in
 get_cpu_ndiv
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
 viresh.kumar@linaro.org, thierry.reding@kernel.org, jonathanh@nvidia.com
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260831073009.3772408-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260831073009.3772408-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:264::8) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f636a9d-9795-431b-dbbc-08df0810529e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kO/stgGC+QfT3hLdbhP3IYbCIgXqhvhn1og2kKFT6wUlorMweEa0EfQPmwzDwx58V3ea+vB6HBBYL8E3grAz/9g0MpKDAJe1bC7Yirg48ELMFgmbDyLVtHKhhl/5dIXyYF9VsO2m3uG5nDVaHsYoYeSroeybZiohFWmFvSzbwvj85KEOLnG2eSglyH/n1t5/4hsm1CC99m3TDnlWyMubrEA8XTYwpzeT1GB6GotJo1Xozq2u0pGXyh2oeJ/PwjqzlupjoFJT2iXo1pKki0oF2fAzmaRyjT3TzUnwVy8h73VK5QMASkioQ2wkGan3aL5GCYH9q3Q1Nr9HSRw2cZiPRG8kAXczxODyfR6uq7j1TEGPADejt3I1muzlHuig1vCvAnZ66DjBdgjjYFE0wRlsfLD4mze+4gTzXKtnM5lLLUb8+9LD81xd0WzkSLUduahndlQ8JDZjBzmxLFpzFfpUjpRYmKhjkMUTdgQGEW0uhiFS8+Sb14u+LwFoolFhnYen7uGW8av1ZEGlXID260OkbXIFZ+tuMnQytf4N+gaE3x0LPCoXvLwBTnt3DdOD9700mTfi4ybgdfKzJk3R2l82f1cWtCkargMPj/NvrQ0xBeffVlGBMk4XSqHVXXW8M0nNwn84hi1xmBz0YJ9Cqyu1mPsRerzGdf5H6TpRMv3Eleo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzhpYitHanMrcUJzRXBENXdKYnlDN0lmZ25iTlRYS0VHS21sQnM2L2pQTW95?=
 =?utf-8?B?eE9zQjJGb3lHRTA1UEJnQlRHSEJPLzVkWFRQaDIwZUgzTGhyUTFNQXRMTzYr?=
 =?utf-8?B?US9xTnNwQ3psWUpxL29QaUcwMWVUTWR4WmFkeXViL21TSFhnYm9NSFA3QXA0?=
 =?utf-8?B?UzZvRStkOGlyR0JBSjNYYW5SVlRGVXRKR05GMVlPMmZnb0c5Y3J3c1E4MDJs?=
 =?utf-8?B?eDJlYWYwR3RlRXpZNk9VaGwzc0FidlVYeGJ6ZE9CM1BaL29DZ1pQakxpNENJ?=
 =?utf-8?B?M214YVorUGJ0YzlIMitod201eE10bHJDYmNqV0F5UzJrK2UxY3pYcWV5ZmFJ?=
 =?utf-8?B?blJJWkFSeGhRSGpFZWI3ZERySHJ0b3dJYXBZcm9WVmVQSzYwS0x3bjZ0NzZs?=
 =?utf-8?B?V25oVmZ4VVRLSUFYTWcxUUdobHo2MjZ5R0szS2pta0VaZ0ptQm0waGh4NTdx?=
 =?utf-8?B?ZXR5QkYyQjFFRmFqN0xJQUxUWVFyVVc2YXU3UVVtQytLTlBOZDgwWUtsYjJU?=
 =?utf-8?B?QS9ZeG1OY3VNNy90Vmc2UEFQUzBlNW01eUIvNnZzdGMwR3BYeGE3RmVkaE5a?=
 =?utf-8?B?WU96cXNvVWdqendrWTRnVm5ibjEyS2ZxWEppRDN0dDdRR0dHU1hWOVVGelJW?=
 =?utf-8?B?YlRvU1pPUWxkSGI4bVFGZEZFYTlRTVZBZXhPSWtGczBJV1hoQUlyOHlCTnhq?=
 =?utf-8?B?TE1KWE9DU2U3UmRmc1RvVm5scmJtYmd1a2dQeUdoMmVpeWJ6YnpsazNneHRn?=
 =?utf-8?B?d3k1aWFJRE1wMU14NTNxTkdBUUZEOU4yUHFwckJlTzlyOFMyRE5uWjhSeE1M?=
 =?utf-8?B?WjhEY0hocE15OEdrVlIzeEIwODQ2cmhxZFhoUmxOM0tTRmxZVDlkS0JqU1lr?=
 =?utf-8?B?Lyt3WGpseFdKMXpHWm9WU21IMUdzeDlQWE4rcU9PMi9BakxkMDExa1ZwajlG?=
 =?utf-8?B?MnhyRmZJNzYzd2JQb241eTBhaVlhd0tGb3k5YWNWVi9Yb0FaUlFLNjZsUFRq?=
 =?utf-8?B?bGdKMFdjbG5MUW5TaXdLMUlIMDdMdjd2SHdBL3lWNjlUM0lmeWo3aThpbnJp?=
 =?utf-8?B?N2dOeVZTTE10NEsvM3ZlL1lQZkxKUVl3c01FVERxbkhwSlA0MW5qVVlzaWZM?=
 =?utf-8?B?VFNPbXJiTVpoby8vRC9hYkFYYVNuS0orM0Q3Qkl3b0R4d05lTWQyeWQzaW53?=
 =?utf-8?B?ZHRmbTRXdlVubnltME9zTHVKWkFHcWFvNDlaSGJQZDdSK0kvV0JzeFFkZ0l5?=
 =?utf-8?B?dy9jcXRaWFFsRlBlWGx6WXk5ZmxiV1hGZkxIL2loSklvb0ZZNUw2c2p2eWRI?=
 =?utf-8?B?czhGd0p6bm5aempsNjRCMWs1NUpRdTBGZzd5WHV6eTFFWjhETmlnQ2UwTWg0?=
 =?utf-8?B?Ri9LaWdwZm5TUklpMUlhVm9kdVJjc2gvUE9QMy9uVDRKSkhnV200WmVhUHE3?=
 =?utf-8?B?VkZ4N1U2bkVqQ1lYMkFFcWRZZUpjWk9YbHA1QXZnY3poUTdLODNLS2JnK3NF?=
 =?utf-8?B?R3J0MGpUR0ZyNWhuektyMW5sYVIxbXEyWEVaVDJFMWtRRk1mb1RnWHViaDNJ?=
 =?utf-8?B?dm4zU0tHd2ZvSHhnZW0zYWROR3YvL1VsM1ZNb0lhbWxZTWNFQUxSQWdIM0NX?=
 =?utf-8?B?cEc0S1FHTmtoWXBRa2dsUVZoR1Jab2YxdWR3S0ZKSk9PUE13TksybjBuSkxM?=
 =?utf-8?B?V1U0ZUdnK1BoOTQ2NmFHdUNXRDNzdkd4VEZpRVFEMlkrd0xEdXVxTzVDMGdh?=
 =?utf-8?B?dHQzZVlUblBCNGNibCtzZnFYd1duNHVBaTlTQjVydFlLSVRwcDJOVFRDK2NN?=
 =?utf-8?B?QXJwQ1R4WEhJclpvSGRaTFEyZERzd1Q4djZoYjBBRi9aZEtLK0ZsVXF1dWFW?=
 =?utf-8?B?K3ozUGRsWWR3cjR5MXpCNzNaaXJVSEZWZ0FqemtFMkFqYUVVQXJhL3lyangv?=
 =?utf-8?B?ckEvN1RSeTJ2eTVFZUxkbXkzdk9sdmJQc1MwTkJyNXVBelRxMU04TmlFYmRL?=
 =?utf-8?B?Tll4UVBUY0I0a0RKbWoydGNWWjgxdHpIRW5mckRMTk1lcUdRNnhIczZWdEI4?=
 =?utf-8?B?bi9kc20vU2VaN2JsektPWlZ3WDFSYzNFVlZjY05QVGVvMG05bC9ORS96OXpJ?=
 =?utf-8?B?dklwVlB5SEtUS05kY1dTVk9RWDl2WlVURVlPRXJZcFhGVENEK3RtY0F6MGFL?=
 =?utf-8?B?VjdUY0FHb2xGajZHOHhuN2t6b0FEOHMvSmJHQnQvaHFYazlNK3Z4MVA4ekZL?=
 =?utf-8?B?dFdaUU52V3ZHcEE4bzVsRThDNEpWc0JScVFzZlowdUNjdlNCL283N1dKNXhu?=
 =?utf-8?Q?OabYlbt5PuomBieRUn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f636a9d-9795-431b-dbbc-08df0810529e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 10:03:51.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vNj03som4jmH02bOg4xtMUaD9buWQWMVoobwyBEmKniVcoRZNr4AI12PRdJfU4i37JRYWFAZi9xEblAnUdsvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802


On 31/08/26 13:00, Xueqin Luo wrote:
> External email: Use caution opening links or attachments
>
>
> ndiv is already a u64 pointer, passing &ndiv to smp_call_function_single()
> results in a u64** being written to instead of the caller's u64 variable,
> so the caller always reads back an uninitialized ndiv.  Drop the spurious
> '&'.
>
> Fixes: 0839ed1fd7ac ("cpufreq: tegra194: add soc data to support multiple soc")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>   drivers/cpufreq/tegra194-cpufreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index c6375e14d445..1eb96e9f3310 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -367,7 +367,7 @@ static void tegra194_get_cpu_ndiv_sysreg(void *ndiv)
>
>   static int tegra194_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
>   {
> -       return smp_call_function_single(cpu, tegra194_get_cpu_ndiv_sysreg, &ndiv, true);
> +       return smp_call_function_single(cpu, tegra194_get_cpu_ndiv_sysreg, ndiv, true);
>   }
>
>   static void tegra194_set_cpu_ndiv_sysreg(void *data)
> --
> 2.43.0

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

Thanks,
Sumit


