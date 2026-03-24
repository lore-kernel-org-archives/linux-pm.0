Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0535F172;
	Tue, 24 Mar 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388295; cv=fail; b=j0gdbwxLOTSHlsJ/mZ9xohE6KJQlKyF2XkosbS/Xv612iFJa8hrXVmHcnS6gmv5cZMq2lzT5PdKBzNS+SF5jgd+K5Bhw2TV3UFvvdcRJ1Jr6chlBOByPzcSyiPs6BBX47VuGpix7DoSBkazLhLj+WUuYorB88lGs7co5YHg/ufc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388295; c=relaxed/simple;
	bh=LfJy6NOAWVUbp00Zb0nkPBteZ+ah3e4N6XqjCeapzEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V1MRaX8CWQAFqff5fh9/luxqy370XVlSSqJZenZ85bw6XqmZ4l7vd+WUO0F45LIzQqW2DFKifcQlF+t8rUdmpw99wHO1A66ApaGirHKTsnQJQMsYmf+0e54Nkm8Dt9Q7//kcgX7E2PGKYcAswGoUhbANUSnScN2kKf3YZThJD0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rlxrfu3/; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rlxrfu3/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqykZeV/NAczenNMwF6ToQ/yBn1427AWHbSB02FAN90qMVSRTjfjx6V2AOC5UI5/L4IfTUHsbR1lVP3h/v1wHif2+5TiCEnL+nGDtme/pG1VzQJXDHpuuz6G8cbEAIBnhnJmNzCxME/yGlzaTBVsGCxXdKt6ivNmkOKewDTAWN1wxQ5gqcGU2MGBmu1NjaNqyaGXd1Xcdt6ha2g5jgtOAmhkK/5+tzpoJts5QgtQpVN/thqMUKviF/s5LGa78OurJXj2nakH3I+mpF+nfzttMpWwgYWVVIjjy040FSjdc8uFqffdmNhVcsMpPUaqX10tBBY4Q1dZGyudmLWYEfQCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5Sv/O9bAAw8sOS7/c2/QZO3JPAgx+ID2gHOyPoKZak=;
 b=nuG3HG5FyrkGhvOJ6aQvOjx5nnGPS4DTGkWb4xeA0oJ4Oevk87oZeXRxoQ5i2Z0U+tO1tRHwIyK/A2R+WEDoc9mPOpXGsZYvwO+g96nELrSDL0RGdJRJTCaW7bd/DJhi1JBrNusNrzSLsPyyX36u1nHM0g7BGUkcBG0B2KQBqqBAhKEkDqWoGZpTCsGJBvlbPWZCid47fvTg35h+f6cBVOeqGp6qfMocY61JedNQnnPy6izGiPEgwAQPYJQEviQzXoOWkCbl//s48uruLUVzDSuKspxlLAHhEfmRMhoJuEXzQnBQ1G6RG8+jppeYXuNr5OCizFzJzkHemn3OMLXo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5Sv/O9bAAw8sOS7/c2/QZO3JPAgx+ID2gHOyPoKZak=;
 b=Rlxrfu3/XTbhODk7Q3KjIdgS5r8fPLF/YOvCw68KE1YPCLNevuafNpr7V8cmQrheu9OSDFR5y0hwBS+7KnkgCeJUvxoK0VpsXlZZ9WSMTOHdvSDo4c1ELG3qmZYdlUgi3ohCzqO1+EnvHoQzk0yGaJjnRJbYIVJYV0d2ZiJvnyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:38:09 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 21:38:09 +0000
Message-ID: <48262f07-a852-44e0-92a0-1215bc48e9cf@amd.com>
Date: Tue, 24 Mar 2026 16:38:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] amd-pstate: Add support for CPPC_REQ2 and
 FLOOR_PERF
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
 <20260320144321.18543-6-gautham.shenoy@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260320144321.18543-6-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:408:fb::8) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a68f3f-9e63-4dca-d13b-08de89eda476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	frHJExSKRj5jN1ftR89x8wVef6N1Dvv3w/FG8QUIjk0Qyzn3vJgvk+NZxkMBJAmH8eQCnxoWDS2ioxVG/2CBktJF0GF1w/flCKJ0tv7nlEPxVkKJr2bR7KiMjR6miSFXbgHudk4RrRxBXqY4Nnm2TBuzzENEQOr+IIpxE/SHa/KU98kKIaVtjjry0gSRZxvaeWAdrxFNFwCd2J4Dn+LAi6LSykjrZfDemebc0jdg/rDUoS3PxqCUnfqLfeDlDO9ac7cEWWSiOMX2L/SrlF5kl4XVwwA7/yMt19wxM+1wrghYe1nbPzYqsHg03zYSpko3yXxwuhBx85bYTq2JeUKFPSuukaiCOysTSqrt+CL6Z5/UGozW5lifSCHZsEMpUNE+5c84WiPnCQCH1Uh83V0XMQMyaxaV9ICE1c6i9R68P9hvoq1+3EGFzB/VeCZg3Xj+dm2X997JEp/q+EaZPJVeWM1Alo1DkmWa48qKwGxaV772/i27fvIqhIo9b2nXrmhfOtnUOi46lEW/dUO/disNHbNYaRfVzqxcqjsyM0+jxWysUv/DkwXyrjkZf7PTlsafn/Of4tTJC8MoRagXyzY4GkmyGB8HYFptADtaI+iJ5cmAk7kZetyVLScRDgGERMgINFjIXJzjO75z0KF/GHjl0fT8g9fzm3fprMGenTdGmcMSe0xSbF5YdSKX24EZP7U392YT+/oyFam1FdEvuDNc6lbzgaKpZCQmYTK/2ng4yOrh0IJ4RP0vvQEB/GqHxsFd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm05TzlBU2pkMCtmcHFyV3hHMTU3Z1lpNGpsYnIvNmdEMVVNQ0F6alpoRTdQ?=
 =?utf-8?B?TUU5ZmtzYTg3NDZzT3JTL2lsMFNmWmV3azg1azhtU0pWRlZnY2ZpQmxHMytG?=
 =?utf-8?B?U25qOXhCNi9BalMzbzlrZDRmbGJWTDh4RHhzb0FoMTU4VUpPbk1CRmhuV2lM?=
 =?utf-8?B?M0Y1QjlieU5OMUdQaWtTUDRwSzhWZFpjSDRKMG9SVmtPaCt4Y0UwZGhVNVVv?=
 =?utf-8?B?OURjSmZQSGtyOUlQT3FuWEpxWHJmZ1FEMjRLc1ZmZWM5V0R3eUlkQVNTd1l4?=
 =?utf-8?B?VHd2TlZnNUtxb2ZvRCt2TS9FN1ExczE4SnVUZ2lwekJpRlpCTExiZjQ3R1pO?=
 =?utf-8?B?NkJvYU1DUnFjc3FkUVY2RHdJREJ2eURxcTlScGRFYS9mZTJ2YkF2MlpaQkVB?=
 =?utf-8?B?OWxLMy9CTlRkSVdJNUQreXNFM1lrdERMaXArMGZ6RmdEdVJLTWYyY2N3cGx6?=
 =?utf-8?B?T3I1bGs1RVY3NmhoTjQ1R2cvT3ByY3ZBUkpMZUFRWS9BUmJmU25RT2Ezc0VL?=
 =?utf-8?B?QWdNbTY0NmNkeUFrNXozUnRTOWE2WE9zVVFRVG05VHlNUkE3T2VRWDlTVWlF?=
 =?utf-8?B?QXA5anVCQ3NsME5VaTRMa1cwa2F0ZEExM1hzSUVQUk1QMjQ0OThpeE1mMHc0?=
 =?utf-8?B?MW91THpnVktrSm5Ec05ZdXlUaXI3UG9nM2NpcGcweG5LVDh4dW4ya3lJMkFM?=
 =?utf-8?B?S0YrYlNjOVhoNmtXVlZITEhkWnJLbG1rSDZaNEwrdFF5MGtzNXBQSDlYYUdU?=
 =?utf-8?B?bkRaNnRDT2FnN044cFpwQy9JT0FBcTNYeCtQQUY2dXJ6K05Jd1JLU3JPRUZC?=
 =?utf-8?B?ZFJNcC9pMXcwbnk0QlVxMEVadmNtNmg4dnk0UnExRWYxU1NuWUpDN0lsVll5?=
 =?utf-8?B?NUF5QzEvcEtleXVnWnpLTFlRbTNpL2dUSUN3bDdlWWdLOExmSVVmVlQ1K29G?=
 =?utf-8?B?QU1OZ0l5NUh2cWNPSlQ1TXV0bllOeFgzQ1FkRjN2N3dlcEE0MDZJRGhwTDJC?=
 =?utf-8?B?Yi9IejVYNmdjVzlXT1VELyt0YUdabThENEl4c2cxTXhQZVVFV2dWZEF5QVpn?=
 =?utf-8?B?NDN5ZXBwZkRwV3VEZFdQM0N5ZEVFbS90cjU3OVliR0lENkZnMjdBVlJVVzdW?=
 =?utf-8?B?a2F1ZzlEYUd1RExtN25Mc1VsbmJ6NlE5VHoxa1ExYWhBMXVHb3RDNTNOU1hH?=
 =?utf-8?B?bTVPb3V6bURkVE5tV080SnhQb1VxVC9MOFhuNzJjem13SXV6VjJPWGI4YzRV?=
 =?utf-8?B?NXh0VkQwTnpiTzRxakVUMnNackU5WmVKdU13ekJSTGdhZ3kxb2k5ZXcyeGpz?=
 =?utf-8?B?blhibGF1TFdPRFJxK0lkaGp2eEFTWTgvZ3hpaGtFWS9WbzBHeGVsaFpVbkpO?=
 =?utf-8?B?OXl5MUhrS3NEVjdXN3pxUFdqbU5uc3d0QlQ3cUtyS2xLWmFPTG9hU25wbUFY?=
 =?utf-8?B?U2NIUE9WcjAyS2FKRlFuZzVHYVRva29QeExwUmpwWGo3RkN1d0pFSW5kRjJV?=
 =?utf-8?B?OGJZc0lhYXAxeFNIanc3dWxCcUxheVRMaVk3MDlyMEJGZnpxWXdYSzYrQjJR?=
 =?utf-8?B?NmdmeEFZcy84dFJsakx6MnpMV0tNZkZhcUlEdTg2UWF0dmd3S2kyZVdvK1lv?=
 =?utf-8?B?UUJzVHBFcFduTXViMlBrVXkxN3dGa3M3K29WUjRNRW9PbmdkdUh3dlQxMzVT?=
 =?utf-8?B?VW93QmQrYUJ6cFdvUGFzb3JOa1lKQ3R6Z041Rm1WQWlNakZ2c1BMQkhQbGx1?=
 =?utf-8?B?OHBBelJienBwODdRWGdjOG9zT1IrWE1lVkt6aGh0ZCsvMER2UGVYRkFkWDlH?=
 =?utf-8?B?dnZpcENjaXVHQlFhaE1aYkxkcnkyVHhQbnJtekk1TFA5b2Q5RFBJbzd0aC9M?=
 =?utf-8?B?T2h0bFlYMmM0NmpuNWFENEJ0Vk8ydmdadXVmbWNUTzZiWU4vT0c5WlBLVitO?=
 =?utf-8?B?bkVIM1AyRnQ3TnBETHdyellmYlZsaVZkSGdpV1pWQk9PclN3OUxhRFlnRmF2?=
 =?utf-8?B?Y20vckhiUGllSjhYYXVPTndTajVwRFgxOEd5Tm9vd0kyaC9OOGl4OGk5TnQx?=
 =?utf-8?B?bDRZa3lONlVCQXJrVy9CRlVacVRLTEZ3UFhPRXNPd3pVTi9zUUZWMzBBaGE5?=
 =?utf-8?B?ODl6a0JJelV5OStPVGRBR1g4dEhYSmp2MVBJVnJyYWRZQ2hIYytCeXhqeTZG?=
 =?utf-8?B?MXF6YkxVTDQvTTFROUZoMkJRVlpuM24wSlhjN2wvZC9SdUlVMVFIRnN5MXdo?=
 =?utf-8?B?V2NGVmpRWXppMDBXYWtoZFlzQWsvd1NvVkttdGgvMjRPY2psWXhBSUozSXlp?=
 =?utf-8?B?clBJb3BQeXRDc0loOTZZSFBnQ3o5R3hKSjFieGQ3UW5qN05hQmwwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a68f3f-9e63-4dca-d13b-08de89eda476
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:38:09.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pb43MMfKaTmI0Bq/70XQslCG8a7gCrFq0riSZiXh7K/DDzxRqjDJ3BrUDn/Cd+EqVVcOaYmvSFEBChif+h96kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306



On 3/20/26 09:43, Gautham R. Shenoy wrote:
> Some future AMD processors have feature named "CPPC Performance
> Priority" which lets userspace specify different floor performance
> levels for different CPUs. The platform firmware takes these different
> floor performance levels into consideration while throttling the CPUs
> under power/thermal constraints. The presence of this feature is
> indicated by bit 16 of the EDX register for CPUID leaf
> 0x80000007. More details can be found in AMD Publication titled "AMD64
> Collaborative Processor Performance Control (CPPC) Performance
> Priority" Revision 1.10.
> 
> The number of distinct floor performance levels supported on the
> platform will be advertised through the bits 32:39 of the
> MSR_AMD_CPPC_CAP1. Bits 0:7 of a new MSR MSR_AMD_CPPC_REQ2
> (0xc00102b5) will be used to specify the desired floor performance
> level for that CPU.
> 
> Add support for the aforementioned MSR_AMD_CPPC_REQ2, and macros for
> parsing and updating the relevant bits from MSR_AMD_CPPC_CAP1 and
> MSR_AMD_CPPC_REQ2.
> 
> On boot if the default value of the MSR_AMD_CPPC_REQ2[7:0] (Floor
> Perf) is lower than CPPC.lowest_perf, and thus invalid, initialize it
> to MSR_AMD_CPPC_CAP1.nominal_perf which is a sane default value.
> 
> Save the boot-time floor_perf during amd_pstate_init_floor_perf(). In
> a subsequent patch it will be restored in the suspend, offline, and
> exit paths, mirroring how bios_min_perf is handled for
> MSR_AMD_CPPC_REQ.
> 
> Link: https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>   arch/x86/include/asm/msr-index.h |  5 ++
>   drivers/cpufreq/amd-pstate.c     | 78 +++++++++++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.h     |  6 +++
>   3 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 6673601246b3..e126c7fb69cf 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -765,12 +765,14 @@
>   #define MSR_AMD_CPPC_CAP2		0xc00102b2
>   #define MSR_AMD_CPPC_REQ		0xc00102b3
>   #define MSR_AMD_CPPC_STATUS		0xc00102b4
> +#define MSR_AMD_CPPC_REQ2		0xc00102b5
>   
>   /* Masks for use with MSR_AMD_CPPC_CAP1 */
>   #define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
>   #define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
>   #define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
>   #define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
> +#define AMD_CPPC_FLOOR_PERF_CNT_MASK	GENMASK_ULL(39, 32)
>   
>   /* Masks for use with MSR_AMD_CPPC_REQ */
>   #define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
> @@ -778,6 +780,9 @@
>   #define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
>   #define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
>   
> +/* Masks for use with MSR_AMD_CPPC_REQ2 */
> +#define AMD_CPPC_FLOOR_PERF_MASK	GENMASK(7, 0)
> +
>   /* AMD Performance Counter Global Status and Control MSRs */
>   #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
>   #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4de2037a414c..53b8173ff183 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -329,6 +329,65 @@ static inline int amd_pstate_set_epp(struct cpufreq_policy *policy, u8 epp)
>   	return static_call(amd_pstate_set_epp)(policy, epp);
>   }
>   
> +static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u64 value, prev;
> +	int ret;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
> +		return 0;
> +
> +	value = prev = READ_ONCE(cpudata->cppc_req2_cached);
> +	FIELD_MODIFY(AMD_CPPC_FLOOR_PERF_MASK, &value, perf);
> +
> +	if (value == prev)
> +		return 0;
> +
> +	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
> +	if (ret) {
> +		pr_err("failed to set CPPC REQ2 value. Error (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	WRITE_ONCE(cpudata->cppc_req2_cached, value);
> +
> +	return ret;
> +}
> +
> +static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	u8 floor_perf;
> +	u64 value;
> +	int ret;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
> +		return 0;
> +
> +	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, &value);
> +	if (ret) {
> +		pr_err("failed to read CPPC REQ2 value. Error (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	WRITE_ONCE(cpudata->cppc_req2_cached, value);
> +	floor_perf = FIELD_GET(AMD_CPPC_FLOOR_PERF_MASK,
> +			       cpudata->cppc_req2_cached);
> +
> +	/* Set a sane value for floor_perf if the default value is invalid */
> +	if (floor_perf < cpudata->perf.lowest_perf) {
> +		floor_perf = cpudata->perf.nominal_perf;
> +		ret = amd_pstate_set_floor_perf(policy, floor_perf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	cpudata->bios_floor_perf = floor_perf;
> +
> +	return 0;
> +}
> +
>   static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>   {
>   	struct amd_cpudata *cpudata = policy->driver_data;
> @@ -426,6 +485,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
>   	WRITE_ONCE(cpudata->perf, perf);
>   	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
> +	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
>   
>   	return 0;
>   }
> @@ -1024,6 +1084,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   							      cpudata->nominal_freq,
>   							      perf.highest_perf);
>   
> +	policy->driver_data = cpudata;
>   	ret = amd_pstate_cppc_enable(policy);
>   	if (ret)
>   		goto free_cpudata1;
> @@ -1036,6 +1097,12 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   	if (cpu_feature_enabled(X86_FEATURE_CPPC))
>   		policy->fast_switch_possible = true;
>   
> +	ret = amd_pstate_init_floor_perf(policy);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
> +		goto free_cpudata1;
> +	}
> +
>   	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
>   				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
>   	if (ret < 0) {
> @@ -1050,7 +1117,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   		goto free_cpudata2;
>   	}
>   
> -	policy->driver_data = cpudata;
>   
>   	if (!current_pstate_driver->adjust_perf)
>   		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
> @@ -1062,6 +1128,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>   free_cpudata1:
>   	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>   	kfree(cpudata);
> +	policy->driver_data = NULL;
>   	return ret;
>   }
>   
> @@ -1072,6 +1139,7 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>   
>   	/* Reset CPPC_REQ MSR to the BIOS value */
>   	amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
> +	amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
>   
>   	freq_qos_remove_request(&cpudata->req[1]);
>   	freq_qos_remove_request(&cpudata->req[0]);
> @@ -1598,6 +1666,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	if (ret)
>   		goto free_cpudata1;
>   
> +	ret = amd_pstate_init_floor_perf(policy);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
> +		goto free_cpudata1;
> +	}
> +
>   	current_pstate_driver->adjust_perf = NULL;
>   
>   	return 0;
> @@ -1605,6 +1679,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   free_cpudata1:
>   	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
>   	kfree(cpudata);
> +	policy->driver_data = NULL;
>   	return ret;
>   }
>   
> @@ -1617,6 +1692,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>   
>   		/* Reset CPPC_REQ MSR to the BIOS value */
>   		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
> +		amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
>   
>   		kfree(cpudata);
>   		policy->driver_data = NULL;
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index cb45fdca27a6..f04561da4518 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -62,9 +62,12 @@ struct amd_aperf_mperf {
>    * @cpu: CPU number
>    * @req: constraint request to apply
>    * @cppc_req_cached: cached performance request hints
> + * @cppc_req2_cached: cached value of MSR_AMD_CPPC_REQ2
>    * @perf: cached performance-related data
>    * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
>    * 		  priority.
> + * @floor_perf_cnt: Cached value of the number of distinct floor
> + *                  performance levels supported
>    * @min_limit_freq: Cached value of policy->min (in khz)
>    * @max_limit_freq: Cached value of policy->max (in khz)
>    * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> @@ -87,10 +90,13 @@ struct amd_cpudata {
>   
>   	struct	freq_qos_request req[2];
>   	u64	cppc_req_cached;
> +	u64	cppc_req2_cached;
>   
>   	union perf_cached perf;
>   
>   	u8	prefcore_ranking;
> +	u8	floor_perf_cnt;
> +	u8	bios_floor_perf;

It looks like you forgot to update doc for bios_floor_perf

>   	u32	min_limit_freq;
>   	u32	max_limit_freq;
>   	u32	nominal_freq;

