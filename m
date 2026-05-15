Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79D3EEAF1;
	Fri, 15 May 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869780; cv=fail; b=BweduvkCLlO/q7803l9F3Y4kBUQ00rDbJfY6Q0RckFMLmMRBUBizVijS/JO0ejN3k+UqlWYx+uZfbi+cquOAienQeB17+LLJCnG1nK53uFaEjhm6tbaEDv1rXs0skS1EIBTcoc65OXDjjVBH4hAyMOgmfMpEjd8VchfqRdKK2iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869780; c=relaxed/simple;
	bh=FFTz0iZixrpCaJCbF4N76MT6t7n6rXITtFNU7FcP4CU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NTtvtfTaTI8g8zvSXuiXMk7yByXRPShsnSKYb06dwuMBu3asVAJ8ZTR12FCX5LWXek8Ioc/s5ZNU6gaNirqKR7mAg9gTR0caooJ5u5VwQx9fAZevqYL37vQGvFjlRN1toMP16mVQWP7A8ECf105UYhpk3ZnPcb3j2CZyGvsPxF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vO8VHDHU; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vO8VHDHU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmwx4F2skREgMbNDNDBrjs31K3vzndwDsDx7ult8//FInRoiU11C6hOKfpU4q4XNTLrBQ1mKqu+REWjhUhuYF6tqIP1F+TzTRLSXg+GnuW+TSUO490CXsgSWmJ3bw6the7mdeEF1reI4r7vrXCQU7sKGd0E6B7Jk151vTgcRauF2M+Jgk3hNc34Ykv1gS8y2tgEq9IJM1wqW9wVlmM2YkhtQLLwheIxsM52Km5IGeXz3j9pVG9a09qXGwfLE/aQNmcVnsvrpx7442/4rRMsfboAxhvn9bTqkAqC+6xj6LDyllDWdMdcYPxOCOBiqg3TtbJQl75MXxbpC2nEOmH7U6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chR/Qr1PjhWOzbDTZyNlCkwJ1XfXO0ku1Fod8LLGeuQ=;
 b=Gz6y7rHePoPNtRQ0oZya0el0/tlu39FYKwYe0WDm6IFUKZXS1rsmCRXY8+7S4gtZie6eQdwjYb0QwOG94EUnGJo8PwJKFBvsjJl7dhz76XOSkFx784e8SIH6kzans2JCTBY+13UWM5ubJOZyq6crqwu8wcJzCMTK7620NFXB3JRHAqK1SRy/JYE3rxW4ofVkXvQcwKYrwh/IXQhc+wQjj4qzABzdjNbJbx5bbghyjJbkbdHX2Vsa7omGbmKxheLohoRWnozkdHiWtUd32BWJpKEzPxYHnh8H9gfuD47OhD1KzbZCsBupg9NhvQYAX37FEw6SHDCCjEEQzxatFmu24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chR/Qr1PjhWOzbDTZyNlCkwJ1XfXO0ku1Fod8LLGeuQ=;
 b=vO8VHDHUcm7r3CgGaE6QgRBFQ0x+SL7UFqkuuwP4n3JwVcz/bk/gHHnohj+8MRsYE/2lkeE/SiD3Ku/Hswnkh05YS5dLVDoStmA2yPkXPiGYu2UfjpV26BbQQrqbFOODS+lORCFgdsJAjq/fc4NaBQfq/eg4XV8mqS2YWwl6w+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 18:29:35 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Fri, 15 May 2026
 18:29:35 +0000
Message-ID: <00e25aaf-6b85-4717-9b63-2c607a446a77@amd.com>
Date: Fri, 15 May 2026 13:29:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Use trace_call__##name() at
 guarded tracepoint call site
Content-Language: en-US
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Huang Rui <ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20260515140121.2239414-1-vineeth@bitbyteword.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260515140121.2239414-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0106.namprd12.prod.outlook.com
 (2603:10b6:802:21::41) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f668d0-bfcd-4bb3-1b1b-08deb2afea0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	XhfQ4srt5KE42kjqJ+oQyYflZ8jIy1ThmxqMywCcBxt45U1G9NMn1ZSTVbWdwpNTYs6xEknZMl+/Mi02GBNcrXUdQuOwlyEfSUSUjOlUigDuOYDV/6oPrRvjU/4vMg2VUy5Xpr32dhGOWiIoXMm94MCcz545aIXM+Qcz/xJ/bCuBUDX3KINyq09RdkPuwdTX23BcVj21CE/ME4tXZAS7KprWA+CUvQ/39PdetTxmzJtMzkdMxH+NCnEs4Qq0z1KYxfYUX9X9wbNI4INsF8m+/SxkOAsd/TGxVtEW6NPx6k6emCG+FwteabXyflB9hotavcQw/xYUoVnpBbV0POsysUArD/oypq0w9YOA0LlkYw3ciFvFLq6vFDMrVuMGMcBuocDvfyAR4O9rQb0vyjn3L4Vawb7QlaNCXRW+Qnvbwt0rkTfciNw1PZo/nVBEUQatZCKezFkU9H5N6ZwKpmnAqe872q6uVymCpKyujKFH+wlO05NY7x7nIYWKafJlo2MOGKNZcBGvb6h0qroa+KXIILxjotOXJYgrGrKwFYLmFSVPJ/S1fLpX9oA8uiXn9WCD7A/4mAlgWrfAFoyzliPVh78TdEsWYn6IZsEC/Yj0Q9RQgdn29hlmuHXk64+bs7BfiEoGvKuQIKiDpsDBhDP77IHlG71b3jAZOTzIFhdvb5+Hs1vJmuw9p0uUGiuse0gPRYrYpk4mYZpq+vKs2fkQRA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzdEQVlUZlpJTmZ4Z3BibTd4cWxMcS9nU1kwQVB2d2wyaWgzc1Q5OEJEbGU1?=
 =?utf-8?B?dnNZNENFN3RtS25EY2x3SlVEV2w0azhzRHo1NGNvZ2gydnF1aFFCUlF4SCs1?=
 =?utf-8?B?eklNMlRXcmM0bThMZmhyVFQxU2grYjB1MHBSZUtuYXZLaGFTUzd2N3R3bFU3?=
 =?utf-8?B?M0QzU0lPeGloNVJvYXQ5cmRPTGExVjlwRTlYM2I0Z090Sy9aKzVyUm9wMVN0?=
 =?utf-8?B?dEJ6SGVrTzdoV1RNNFEvc2kzRkROTjhMTzZDK1YvTXpUdjNEdXh5R21LQ2hP?=
 =?utf-8?B?RThSMVRqc1BvcmdJeTUzcjZWbDV5ajlKWWdWV1dlZFpnZU5Pd1N1WnIySkxl?=
 =?utf-8?B?L09qRWFFS0pkdzVPcU5BOGExQmRMRXowMDdmeW1WMktBTlRlMW5ac2UwTEVB?=
 =?utf-8?B?N0hjVHV1bFcwMlcxM2d6M1IxZ0pDTno4a09HNUdaaDNlWVZoQkNDUjhKcmRR?=
 =?utf-8?B?d213ajkrcFBVYTk4RmtkUTRGOXNhNTdnay9ydEJENHJJVDFzbFpuOVpzUzZj?=
 =?utf-8?B?MDd1SWE1QXVEUUIyM3FBbTd5MHE1NEdOc0NIK1FJeitHVzZqZmVWN0E0K0JW?=
 =?utf-8?B?QXYvT1dFek54WTZGcklJWkprcURSTU93UlkxQW1NNmdDOUU3MGRudW5OMnBn?=
 =?utf-8?B?MXdoUkdWcmk2VUtOd0pRcW45SjhSUUY1d2hPU3g0dXJSNU83c0Z0bjVyQ0Jo?=
 =?utf-8?B?TVFpaVprYSsxUVFKUk1MZ3BSK2RLV29uMVlLS2V4dkJpRzZpcHQyS3dUNDhj?=
 =?utf-8?B?TEQzNkx0d09OdEk0Q1JmUGNGaUF2eHhCYjN0M0RhaWRueko1aThlTWlhRXlv?=
 =?utf-8?B?QWNDZWEydU5zZzR0aEJlTVZtbHB1bWtYZ2JyRStNL0hjdmJ5bit1RElzY2Zp?=
 =?utf-8?B?ZHdqajZjU2ZhcW8xR0swL2czZjdaNHNCNHBjbGtYRnNEc2NkWVhIR09sQXFv?=
 =?utf-8?B?NS9ZUE8ycEcxRktxR2tFeE1mdEJPa2xBdkJyQlBIdS9Xd2VBbVhzb2R2bktk?=
 =?utf-8?B?OXpXeGpHYzlBT3Z6UlY4eGtabzgvakw2ZGFrSlZiZ3pSYlNzVytlUFduRlE5?=
 =?utf-8?B?YXhCUXZVR2I3Wm16bGYxR0Y2eUdicTliZE1VV3l5WW45MlNMbTZJRVE0ZTYv?=
 =?utf-8?B?eHVtT0ZZYzBSdDRsQXJseGxPeEJWRVZUWFk4S2REZHJCVHBwT0hoYlM1ZW5M?=
 =?utf-8?B?bVRveFVVT3B2U1JKaGtITUFMeVV5MjVoMEVBNDRCWXlaME5PWlJzRG9KbDZK?=
 =?utf-8?B?VktXYWhSaldwSkZOZU1ZYUdheVdhUldFWEJja3RVYzVGTE9OTmU5NGNNVXpR?=
 =?utf-8?B?bVBWamozNkwreS9Iam45TjZHQWhtMlJIS3JYekxXVkExb1hGSFZTWFhFMEFl?=
 =?utf-8?B?SEh3MXI2VzlFbmo5c1lqUWZXUG1lODQrTS9WRW1sZmU0dWFNU3VqalZUNU1i?=
 =?utf-8?B?OVhhTzdFNU80N0lnSkhESC9wbTRuMXdtZ2wrek45OHgrUVhVd0RKbHl4Mzk3?=
 =?utf-8?B?VHFwenc3S2NOTUp2dUlCRitkdks3QktMand2Tlkxa3ZKc2RrMlpBQmFWVVdn?=
 =?utf-8?B?UGlXN1NUWlBJeGR0Z1ZnZjdlRDVZR2hNcmdIWmcwWVNrc1kyT0tRcTRPVnpv?=
 =?utf-8?B?UnFtRWlad1BTRWRmejRjaVJ2aXU1Q1ZMbm80ZUs5Y3BPdnhrZU9MUWNUVlBi?=
 =?utf-8?B?dTlyQm0yYVR4ejNxVTRwb0JEL2x0RUJhRGRNSGJ2WUNzVWZzYURWU201Q3Vu?=
 =?utf-8?B?bmhZMzIvSzFjUkwrY3FsS1BqMHBXQmhWTVRtd3pLK0pyRFJTampLcnBoSmph?=
 =?utf-8?B?RlVxL05tOE9KZXRVOFJTdjJUd0tFSHRSMVliaXlBcEtpbS9iRE5oVjhFTDVQ?=
 =?utf-8?B?bUxDTVFlZXlNY0I5OGx2eGs5RXc0KzdheUZ3cXZ3ZHZ1aGFNM3A0ZHZwTUVz?=
 =?utf-8?B?L1pZY0VKR08wb2wvektCV3RTeXBZcS9mL1NiVFl0LzVEVTNKS0NzNE0zajQ5?=
 =?utf-8?B?eXhCK1pZcjJ3bFFzc0s2OWdRbzNaMDZoTzdHcE1KcFZqakk5eW0yYmxHNlNQ?=
 =?utf-8?B?dVcrQnhWcEZJaHdHZ0NEelNBR0lnMk5XNlpkS0tGM3ZNWHorY0JrM0hsdnFo?=
 =?utf-8?B?dEFKckZ3bTNmM0tKeG1jWWxLUlY1OXRPK2FmQUtFTWd4OTAwZmV3MEhCbHVG?=
 =?utf-8?B?ME1KOU1vc1o5d3E1ejhMRHJBQUk4NFdpSW9ObUIvRElub0FZL3FQaHBLSnJr?=
 =?utf-8?B?MzFJNldDVGdoTWMyVmxab1M1d0hsMGYvR0dYNWZsaGZ1Snk5UUJwSDcyQnRv?=
 =?utf-8?Q?vzVoLAOHkF5Gw4a5wh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f668d0-bfcd-4bb3-1b1b-08deb2afea0d
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 18:29:35.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N9YfAl7vDL8RlnYAWyqLgH+cLCfVEs9ySdR2Y2zvqxbjPQGj01fCFvU2kUyVqgESMy/lKEVfV76y5j4dHBGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335



On 5/15/26 09:01, Vineeth Pillai (Google) wrote:
> From: Vineeth Pillai <vineeth@bitbyteword.org>
> 
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Original v2 series:
> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/
> 
> Parts of the original v2 series have already been merged in mainline.
> This patch is being reposted as a follow-up cleanup for the remaining
> unmerged pieces.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

No concerns this going through another tree together.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 453084c67327..4722de25149b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -368,7 +368,8 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
>   
>   out_trace:
>   	if (trace_amd_pstate_cppc_req2_enabled())
> -		trace_amd_pstate_cppc_req2(cpudata->cpu, perf, changed, ret);
> +		trace_call__amd_pstate_cppc_req2(cpudata->cpu, perf, changed,
> +						 ret);
>   	return ret;
>   }
>   

