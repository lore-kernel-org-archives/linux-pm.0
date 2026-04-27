Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761833262F;
	Mon, 27 Apr 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304213; cv=fail; b=GsPYvU2FMOTG+S1UKSplDm8QdZt6WvNHCIErhY6JgeVrQsEjQDFEs+g6fu4xzrJmRJbKE3PxsGncftYd7WhaVA/IoGPF3POlOYzf7b8hHn0bvzPIFm7Dq9mmOghFm22HNVBG/Df3yn8j72gKxD/vDDMoq+xtAFtavZd6OhKP/Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304213; c=relaxed/simple;
	bh=yryPUzxKe18a9S8EAfa9r7gY5lN2yx06g8ZVzsz3AUE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KM7NQTqYB/4f0jMPPPxqwFH6njaTqqXIsPewR8QniuggkG1Wy4jRn99r0mwVK5TZF25csXmqAVaD/XKS/R3w83i7O1PQk1lV4QzT9M26g4d1n/0VwTLdupRVj7PqsJHOCN08ClJTRlzcNxCq+jUCaj4yAc0lgveQbXL1p/RYnCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5MSnT6wC; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5MSnT6wC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtteGV7dI7MYw/m3F1w8MeJFA2hm/lWq+srVjasteLlYJrHdt0AdD9fgYjzoLM2GYQGPaZWXIXZaEFfkbCoEDrynVn9UsDYBB8fSuEaAYtW8/9Rl2PGgCDyo6M58J026OblCcxd4DWK/sMt49atnjMePnGiUYgtE0TluNntKAtDKJrgeUvW6ttlNHSoBTwREiPqLCX+s1LCCsHATeijvDz5aMTH1+quFN3gf6HIgmXRuvNQYjHIWwgVoqwzfk4lg44I+vAX93+Es5QlH5gLTzgCLvxrq2fHF/m9OxFSB9gMVZDKnn+FKcTSmaBIIoa7s/geddYGn/otKbcDevNNHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bswzxlLeSK2TA9AtqArcq25Xug25Iw3N1DpxXViIj2o=;
 b=Gr/YiDVQ6HW0pio5HJTwijwwkU5rGum7/NipAutGWaWi2zlleFh8GTNNUHSpG3WAN1rAklJRO2xbLJw05eXknvJUfzVG/pdUNTPKG7UdNwJ/MnCmq4fewHa5jyb0gXwivEk5ojQYOB/YaPSTsl7wuR9DYHbhE8B0bpCqWaL/i/z6yEo/rWZBq6g6Pls9Qb1Etf7ePAFvfZRlTow1u/k7/xwuuv7uxD3yDPry/p59j/j9BkXYA/yQ/duAOxveNflSY8LBGEgKnDzCMLXuKEXa7nhwcaVZGMppFgkQI7CvnUmfIOZZ6NhlF21EignnpNFOu8Blk1s7PVtKQnA28acdmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bswzxlLeSK2TA9AtqArcq25Xug25Iw3N1DpxXViIj2o=;
 b=5MSnT6wC68vQZpa6ZboaIq2KCRShIGJ4+YbhfnSrKJsoLgWWj3A3oH51SrTjMhbhWohCZdTU8n4XsjMWX7wMFDfJDBBRBiFBeLKP3dV1KUvYjG2RML5fsgDOLHYCQPCcyTzuh85PwpqWb1UUAS9uGyFLL4wRd89orJkANNj8YRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:36:47 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 15:36:47 +0000
Message-ID: <747cb549-71fd-4627-bca6-6aba3118bbe4@amd.com>
Date: Mon, 27 Apr 2026 10:36:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ACPI: CPPC: Add ospm_nominal_perf support
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20260427051823.280419-1-sumitg@nvidia.com>
 <20260427051823.280419-3-sumitg@nvidia.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260427051823.280419-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:610:118::29) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: be6f6d7d-67d6-4594-eeb3-08dea472cafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n/NpWbKX0IE6veDQNBHbvHzyZ8ffWPzM5DYSSqtwuGQduM+gH8gdHvFQpb6BLPrc6YWdV41WX5vcSOP+URlovIETPAo0KSRc84OJaHZui47910U/MaYErE2mi6R4yGYdZa7yhMGWuRSneIWdvV6ii/6R4D4mrrVhq3/JTZb+7Ts+oOPyx/nDpzqpCDLQ/vWnxyYpb/MnKdDtL5nsOYF5hr29DnGY3Osk9R8bMeUfXhRKvnVRvncsZ6T2eWzmqr2FKihCgNmNP/AmgohV3Zmn24gXg+gC9HONkfNCbccmrhuhV+Mw9PgJB3pI7l1i6g0N1UodFN6Hd/QtpRLn2757qezQlJad/ATHXL1a6FBQyeZVBR9sD6fEh6Hz8/TcY0L14uh3rJki60rNmUDDLxreVoIJIBLQWqIWeTNpUi+E40DxBOaYSkK0vp77P5W+l7ojafOY8MpY9MUzofYsGY8A7mJKaL9iKMqd7A4QFqmhd4yAXCEiZfzylnMD7T7LNDJKyVMhk5rVF/Rw+0QViAW1ZABiCoyvnAwUhbbteVGhTlVi/MZRpc+wgOeKnjKCar2JWA1pmcGekZZQlSG9eWR5uHwEXzrmuCtDWMtN/kArxyHQL5UZzfC2QWvga1IQy672J62Hzcj43Rb4u7WfEn+poSjADfzkeT3XgkZ02ojxRp18RU2jmkGOYYbiLhQ7chhovPovxq9dv3gtK4YZKaTHUJKCTSDrd7kCeZzvuR4JzvtBZVRFQ4cevz2PRMLcU8IOs14GNzh7FwimbMUn5fa7vg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDZzWUJxd3RheGhBbGZwc1djTGtZMlRqUWtmZzRhc2Y4Nm4vMFQvTU9iSnpU?=
 =?utf-8?B?TnZDdlJqTDllcWcrUzVnWk01QlVHQU1EYXZaRG0wc2xSUHpkdWdPdlZpdU5Z?=
 =?utf-8?B?K2c1K1hGdHdlNVd3RVVZQWd2LzhyMElxb0VRQ2UxeTc5c05wd0RHQjFadUJu?=
 =?utf-8?B?aDNCNHlRYm9VdnNmbTUzTCsxL2NzcDVpRlEwNWkvSGZJaDkrZ1Eya1RDRndG?=
 =?utf-8?B?dHRrb1NiQWxVOVV1akdYV2RoamQ1YXpPMUJDTmtuamx3ZnRNT1k4YlE5SWpn?=
 =?utf-8?B?OFJKZTdQVWw3WWR1azZNc2hxcCs0d2k5TlMrZnpzcFF2cW8wQ3F0bGJvczVu?=
 =?utf-8?B?WGZTSVZidTBvRWtZR0h6RkVLayt0cmdsSEpRMVY4QldkQXpzNWM4dWtOK1NV?=
 =?utf-8?B?ZEw2QUREdUQ0TWlhZFM0Mm9OMDNsTnR4cGw0dDFyV0ZMUGFPcGJFOTltUDFl?=
 =?utf-8?B?T1ZBcjRtdUZFa3Y4TGlsUS9OdTNEOWQ0bWoxdGU3eFVGUW9Fa2pqS1pFV2po?=
 =?utf-8?B?SUcrTHNuN05MUis3U1BCQWNWbjdlMHN5T2FtTzNuQWZmZnhjZDZvOWc4Zm9F?=
 =?utf-8?B?bExydFhyOFpJSE8xNmJWQzJqQThwbHhUeUlsbXI2T3JsN0ZYQmhTTG80azdP?=
 =?utf-8?B?SHVDSXlpZkhXNUlBd2t1UmFQTHNVcXBBM0cySEVCa0l1L0dPRDc3WWpzTFZN?=
 =?utf-8?B?N2Nrc1NXaGZsVkYyOU12eVVHRHBvRUJTQ0piYVBOTzNOektpbWhGNFhaVFBQ?=
 =?utf-8?B?MjZDZDF5eTJmZUJ6aXoyQTE3amdRa0FRaUNoeEN0VnJOQmV3WU41c09Jalpo?=
 =?utf-8?B?eitxYURHV2Z0by9GNytpejcyb21FeDBGVTRRd1ROTlBuc1ErQmV0MWs2bWVO?=
 =?utf-8?B?V2hCVUxiT2luNS9kNkxFRzZEZElPUUpRUmFEMlYxUk9hN1U1VjlwODhqOXJM?=
 =?utf-8?B?K2VpbEdrZXptN0ZjTElxNUU5alk2dEJTQlQyTXBQZFo3WVZnRnZ0dHVtVWRu?=
 =?utf-8?B?TnVRVUNhV2xIV3Q4Yy9ENFR6ak1DSDJXV0VxSWw2RzNsUXRJUFVzODg5ZnlM?=
 =?utf-8?B?S0NrZzcycWFsWDUvYXJlQVY5RWpydUtYZlJPVmRLaGtDR0FDdXBRMEVudU9P?=
 =?utf-8?B?NjIvbDNsc3F3MkRNYmhGazg1VUE2REoweXNkTWl0QWF2eVdlSnBvQy9DNlVt?=
 =?utf-8?B?bFNkV3NBc3Zlb1NvdlBJSjg5WFAyVWpJM1d0OEJRRHBYbk1YaXRON09ubkFy?=
 =?utf-8?B?b1pmOWYvTlFmK3VuN01XaFVCRmNocmNBNlBEaGVRMVdlQldtVTRNLzlxV2VT?=
 =?utf-8?B?RjFWYURGc25tVDdXUGN6R1N3bmk1eUxUelBQWDJ4MHpDWG5UUE1FZlMwdnZw?=
 =?utf-8?B?d0cyQ0NnVE82c2MvZnVHd2NYbXdiL2VTTWVVMzV5TnV6MFlKT3pYdTUvL0g0?=
 =?utf-8?B?ZURERjlvemxHM1dRUWErb2dFeVdRbDRDWHN6WnZMeW8vS0cvODlPdmFSNXRo?=
 =?utf-8?B?cWQwTGtqRFFEZWo2YWViTUxSbzZaQmxmT2t5NDdYK25RMXNBbnZzVVdGSkZo?=
 =?utf-8?B?MmlKejNHUEhyV2xxaDkxYUhNeFR3OFNUd1FucWNBaU9LNUNUemdBV2hFVUNy?=
 =?utf-8?B?TUdMdk10Wk5EZXE4L3lTMkVTR0JHZ3RQb2FuS1k2MkxYbnJneTRQeE9JdGtZ?=
 =?utf-8?B?eTIva2UyNXdHTVJ0UW5hNnRuZEhzR0FYMzdlSGpBZlMrd3FtRnFMZkx6UXdV?=
 =?utf-8?B?d2VNcHhzQmEvZWh5ZmNLOXRoMTdjVTBQV2VxVGtxcjVTZmdVaU9TaFlrVEtk?=
 =?utf-8?B?dmpRUFZkd1ViK1FEYXJCN0dzRUhYRE14aE9jdEd3cnJ3bXRhOEFVRUU3eVZi?=
 =?utf-8?B?dmFCY0xLZERVNnhuUmZveGZPdWVoM1VLNGZ6aklOa3JHdUdGQlRCbVU5NWpG?=
 =?utf-8?B?VmpPVWFTakVpcUY0U2hKYlhqalkwYXdvdlZDQ1NLRVhDRGxiK21JbTh6MDM4?=
 =?utf-8?B?SCtTNEl0NUhhMVVsM0l4eWtUNHdBVlFpK0xJb2VzdTAvWmFoK0c4Z0xHMUY2?=
 =?utf-8?B?eHBPaEZ3bmllQnM4L0FRZlZVUVRad2ZsRnFIc3JuRUFheUJDMUpqRmZTNmpp?=
 =?utf-8?B?VmkydmxIWWRjVHJ6UUhYQWpSM0VkTWI5SlNiMzgwSHZkenJ1OHFuYTNHQWhD?=
 =?utf-8?B?TnNkSVVkdnkyZ2hocm5Gc1RvUzlPaWxQV0xwdnNnQzFKalJseXZISGp3Uzdj?=
 =?utf-8?B?Z1dTcjlWeGhnU2E2YlN1L09mV3RtajUyZ0lUNHNMTExjbm1RcGl3MlFMbTV5?=
 =?utf-8?Q?EdrvnuhPuVmdwmEyuz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6f6d7d-67d6-4594-eeb3-08dea472cafd
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:36:47.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdakesxNOSsgsEIhwx+3jgfvcZYEyVqMKL6YyBpF8ntpVI0r+CU0/uSCo6HM9t/1FFWtlaXSgjz4yvgScN19NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602



On 4/27/26 00:18, Sumit Gupta wrote:
> Add acpi_cppc/ospm_nominal_perf sysfs attribute (write-only) and
> cppc_set_ospm_nominal_perf() API for the OSPM Nominal Performance
> register (ACPI 6.6, Section 8.4.6.1.2.6).
> 
> The register conveys the desired nominal performance level at which
> the platform may run. OSPM can request a lower level than platform
> nominal. Valid range is [Lowest Performance, Nominal Performance].
> The value tells the platform what OSPM considers nominal. The
> platform classifies performance above this as boosted and below as
> throttled. It uses that for its power/thermal decisions.
> 
> Initialize to platform nominal at policy init. Override via sysfs
> if needed.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>

Even though it's a write only register; does it make sense to be a write 
only sysfs file?

I say this because if we're writing it at init time and we're the OSPM 
we should be able to track the state of what we wrote and display that 
to userspace if it wants to know.

Furthermore; tracking the state could mean store_ospm_nominal_perf() can 
avoid the extra register write if the state we tracked is the same 
userspace tried to write.

> ---
>   drivers/acpi/cppc_acpi.c       | 42 ++++++++++++++++++++++++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c | 10 ++++++++
>   include/acpi/cppc_acpi.h       |  5 ++++
>   3 files changed, 57 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a1c91ce20cc8..83b4b14652fb 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -155,6 +155,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   static struct kobj_attribute _name =		\
>   __ATTR(_name, 0444, show_##_name, NULL)
>   
> +#define define_one_cppc_wo(_name)		\
> +static struct kobj_attribute _name =		\
> +__ATTR(_name, 0200, NULL, store_##_name)
> +
>   #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
>   
>   #define show_cppc_data(access_fn, struct_name, member_name)		\
> @@ -211,6 +215,26 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
>   }
>   define_one_cppc_ro(feedback_ctrs);
>   
> +static ssize_t store_ospm_nominal_perf(struct kobject *kobj,
> +				       struct kobj_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
> +	u64 val;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_set_ospm_nominal_perf(cpc_ptr->cpu_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +define_one_cppc_wo(ospm_nominal_perf);
> +
>   static struct attribute *cppc_attrs[] = {
>   	&feedback_ctrs.attr,
>   	&reference_perf.attr,
> @@ -222,6 +246,7 @@ static struct attribute *cppc_attrs[] = {
>   	&nominal_perf.attr,
>   	&nominal_freq.attr,
>   	&lowest_freq.attr,
> +	&ospm_nominal_perf.attr,
>   	NULL
>   };
>   ATTRIBUTE_GROUPS(cppc);
> @@ -1683,6 +1708,23 @@ int cppc_set_epp(int cpu, u64 epp_val)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>   
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
> + *
> + * OSPM Nominal Performance allows OSPM to inform the platform of the nominal
> + * performance level it intends to maintain. This is a write-only register per
> + * ACPI specification.
> + *
> + * Return: 0 for success, -EOPNOTSUPP if not supported, -EIO otherwise.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
>   /**
>    * cppc_get_auto_act_window() - Read autonomous activity window register.
>    * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24..d06cba963550 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -715,6 +715,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>   		goto out;
>   	}
>   
> +	/*
> +	 * Initialize OSPM Nominal Performance to inform firmware of
> +	 * OSPM's nominal level. Performance above this value = boost;
> +	 * below = throttle. Uses platform nominal by default.
> +	 */
> +	ret = cppc_set_ospm_nominal_perf(cpu, caps->nominal_perf);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_debug("Failed to set ospm_nominal_perf for CPU%d: %d\n",
> +			 cpu, ret);
> +
>   	cppc_cpufreq_cpu_fie_init(policy);
>   	return 0;
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..ad1035b0e1de 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -180,6 +180,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>   extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>   extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -266,6 +267,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>   {
>   	return -EOPNOTSUPP;

