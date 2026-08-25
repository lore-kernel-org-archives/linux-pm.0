Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFD3EDE4A;
	Tue, 25 Aug 2026 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649360; cv=fail; b=EydJ1qUPuad4tFmxCFpRle8TRPwO3vzJjoAXTk0DOXNIIqEA8devNxA/OnX/Ex4RArYNlJM5xxEW+WUujflVaRSNQbE4c82TtX6OVeA49edImci3eBNCGJ2V3ZbpJfxW/ZYu9iIZZ3t0w1Q17PqecMXv0N5r9VGKOHGzs1hICYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649360; c=relaxed/simple;
	bh=as3ao6x3ta7rFOFUI5vtSTsOeI8irBHFc7TwAfHEy6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RjwAm5Lhui8qFeVsWaH/PiYofvemQXak8a9xiQCzYhxoZ2htFL4ULndknGG4ok88Utih9n8GLnhIrliQIqVWiDV1kp8lGnIh3jNbfBjWgzTBOjS6ERMOPKZ643IX/oPpqBoQRcL9GdhliLbKn5xBb6Y8JT2t7NgqnmRDcNjDJjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gROfO1FV; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gROfO1FV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCP4ZoBjJ6LCvg+yD1pglGyINjD0WjF1KYOjM8uDajvU+LHdado3DZi2MCUDWufFfGRm+uYX0w8dVAAliuSHrl3NN5pXglyeBoaujOUx//r/yqLLkQG2/Nh8O97mfhQ3qEaXAFblDN4RuauYCksECDCPrejvQb+Ta3ODfvCqjD7B1ZrrvVo4eW87gktdnyqTKSbIqIZXbjB8LTJhBSeLYKo8pafVA+jrzGdD0m3hzoJ5e1QkT3XYEoqhGpNcoHspNK8YJx3ykQ5cum7whZHR/CVTU/8+6WxqEjIhzF0RVDv+kI7yg4pI392h5+ogXxxI0b09ygyOZJMIlYnFg2JyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvFSOvQoo4H01Gf07znHeNueBx0RjJrHaotoX6W72PY=;
 b=o4AABDjj7m4M9bSqyV3xtWAfC8pwfYiRFSxXZXycIsETzofOhxcJqfXoGE0FERul3OGwZnJl6VUJvjeApnStOuSIa9GRws2C6cwisvIDPQbNiZ/pEAy+e4HjZ5Q1ZIFEqXDXJakUAOTB7IGc7runi547wpZD8An/QUo1cyRuUVcFIglgqudwq6UlPeg7fDKlRChnayO7sPD/lCref9QP8VRj6gzK6QfMJdXQ9uqYFeZIGbhAmIN0H/al95eh9yK1zyp4cyqxmmLRe/cGk0Bz1frNPmxQcDWg7z85uqNy9QMmePzFldSpHCwyQLts9RZ+SxJ7JCbRGSL6Hb1YZyfUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvFSOvQoo4H01Gf07znHeNueBx0RjJrHaotoX6W72PY=;
 b=gROfO1FVLAhSYKFkQnHtoUmbIOACGVHknhbbBNqRUbytD0oRiwVm203dXGvqlKuDN3pEEbue5d6Ip8irME3GHjiuY6Gj6EfN3JXtRj17nnYH9coh7y6hWJTq4UJvXcbWq1CeMv9SsHj6WGtqMIIg59zvhQvs9zP51vBZFSzgoDA2blOgefeM3DR99gPf/HyKNmLgl2jVu61nz3k5YMCcRY4wr1+tZRUc7tl2ueqTMy0FOUfawj/uvrWFEPauHGI7WHa9IneIeDQPEOW2iuJpUceMJtUkZvBFcgGsfx0T19POnRkQ2jH+kqqm6XQngAbfroEx7HiSb9NEz4d2P78V7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 09:15:54 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 09:15:53 +0000
Message-ID: <cfc940e7-653e-4902-ac49-99bc7623c1bd@nvidia.com>
Date: Tue, 25 Aug 2026 14:45:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] ACPI: CPPC: Clear Performance Limited without a
 stale read
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, Sashiko <sashiko-bot@kernel.org>
References: <20260809062549.1415955-1-christian.loehle@arm.com>
 <20260809062549.1415955-16-christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260809062549.1415955-16-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::14) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 30dc30c5-ce56-4490-ba3d-08df0289765d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|6133799003|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	HaJsb6Wq0CvN5ciPYakJLr/FifvJ5exR9a8VilxwLu8UmCu5vF5jdjZpp5p8QQBA9ChxpMpxcrHGauyjbnw3MPbD+qtgTDBYHbeL3VEMGCj2ZBt/1SNzzX5mbs7DihGpCGZ+E1beFtMJcbpCtxgdqwci6WkLIIlnCdzUJpY15q56T0Fn6CUfiPmt/HfQxZUuj+CjJXS6Ovbkz+YgGJ3U9hNS6NDMlBJIhhr4uocpneh6Z6I/rQXvGBpRDWMIRaI4HELvj2YkkPRkWtvqbyHa5rfbXt8WO7r+zgrnmFmYn4P1AYRyfezG8gviyp9x6MYRhHruJy1fdH5OHUherbiMKCfjIn8OHlXaDBx9EId5F4ewqgH+0oe2ucX4P8Rg3jHoHfe5fedW4c5OoEp33B0vMmC/mKJoRVi+HRA29oLb379csQLAyAwi+mvv5ndnwZLurLa1dkCBKGcUYB+dKOp7epvRbGrQYjj99aF9I97J30W33SZR4xBfk0UZe1C5eohnJ3ul4BRZT8/XtyG1k/Fyr/7bfbsCt5paM8kI9EsHgVPnVyX6cviuyfuulrYCtmvhv3j/oAs/X8vRSYzw5KWfHIcpwY9+Udm9Dsdo5DhgVk6YCUXkXsY0H/nXvBpEon4yBz1w2wQl246zsDx0G9dKvEH92KRNeGp4BuA6a8gHr0I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dllua211VTF2WmpOT09ySWxzSUxSOEdxbXNQejNmUWxsWWI3N1htaVRrR0hh?=
 =?utf-8?B?VHJYMFBMR084N1V0ejhwRnNweVB5UDlrajFLRDhyZUpKVUoraUgzcmpld005?=
 =?utf-8?B?a3E0WGxRMzNCKzFQbWtES3p6UTBVdjRVdWtENlpvbFpyQjd4dVhQckVpckhM?=
 =?utf-8?B?YnlKd0tsd0VWYjNKZUJ2NnlrdVhRYUFIVEUxeVJYNDdEdUN4MzQrTXg1bnVw?=
 =?utf-8?B?UFJ4c1h2UHBBNGt6WUVydFVjeCtzeXBGdVBJN2FIa3NYRmpPYzZwRHNnV0lX?=
 =?utf-8?B?dG53aGhwRm9UOU5iYXp1VWNqaDFJVElDSTI1c3NHREkxbTBCdUU2Q3ByY3Nz?=
 =?utf-8?B?aHBLbTEvbkROTHJuSE1TMmhzWXdtNUloZE93dEV5VWFvOFJPRFhSOXJLZ0ZZ?=
 =?utf-8?B?V2FrTEMxMk55MTRyVnR2TDY0ZzVqc1BheGhzc01Gck5lRkJtUUtWWFJ5VUIw?=
 =?utf-8?B?elJLMkdLMjNQQlR2UHlxMEcyU2I5YUVQbFkrVTF2RFM3TFI4OWphejc3Q2Z2?=
 =?utf-8?B?Z3J5Z2Vpa2RnZThZbDkreG9GUnJER2phTW1BSUxPM3hSTUluQUx0WU5RUGdT?=
 =?utf-8?B?TDYvNGtUMUVYU2lra2h3cktHZWU0Nmtkc2Z6NGdiSXZpNmZSUHM1TFdUdm8y?=
 =?utf-8?B?dFZvL25Gc0RvN1JPZVU4YjMwWEVxN0c2L1Z2RHJ3Rkg4b1FMT2c3dlJqOEx6?=
 =?utf-8?B?Y2Y4ZGorNi80RkpUcThSdjYxcVJDS29hamhoeVpTRFlwSDV2Ky9jWWtseFpF?=
 =?utf-8?B?L09SWmtQMFZ3Sk9tMit2ZG9GaWFFRkdLckRxK2h2Q2xTbVU3UVdwVG1BcVNm?=
 =?utf-8?B?TkpWS1c3K2NiYUFaT0pVa1V4ZUJSTEpQa0VYeVV0Y29vUXJvT2kwQ3lxZ3hi?=
 =?utf-8?B?MFlRbjBnRTZ6aytvYkdIZjRJMkFyMy9xWTNtUU9ZMDVKNUNmb1RjT0hEUDVr?=
 =?utf-8?B?MzFhMTBQWGo5U1hWTFNxaThWNG1xYTNzZ3UwalRFaWFmTmhKN0YyaEc5eXNj?=
 =?utf-8?B?UWMrYzJYL203Ukpqd3QyTEVBUU41cXJRU3AzMkw4b3E2U29qNjNSbXdzU2dn?=
 =?utf-8?B?OTNmVGhhQjhCYnlwYnoxSWx4NlF0UHpWM0c3cmQvR2NOdEJNV2RXcUIyLzM0?=
 =?utf-8?B?cW11cjFtRDVacmttdzFrcTI2eFJ5NVlaajdBdjVDYi9QaUVoY3BBa1lGMm1W?=
 =?utf-8?B?Z3AxaG8wL2R6Q0gxSGlFQzh5eUowNCtrZ3pOKzZENk5BSzh0LzZnMEJpODBj?=
 =?utf-8?B?ZTJacGVBNFhKTXJ5WlhXRC9GOVdsOFhPcWg1S2JXbkQxYlZUdlprVXgrOU1k?=
 =?utf-8?B?Q1BQdWlvblEwUXFXQkljdXR4UTFCVSt4THk5VjdzQmtFOXp2WlVYYUduRm9w?=
 =?utf-8?B?ZHNmM2xWNm1FTHFuZXFHSzd5QkZ5QmY4R3ppakpCZndTTjlMc2t3QXBDcG5k?=
 =?utf-8?B?R3hUYVQ1UHByQkxmOHJOZ2RvVTB6eU11dzIreTBmS0hmbVJXcWl1ajA5b0RR?=
 =?utf-8?B?cERMZTNBSWtVVnI5U1UyeVgvZEpnWGJCNUFlNlBBL3dpQ2dCM0FMUy9wZFF0?=
 =?utf-8?B?cUU1YXh4MjlNZ1AwN3RIOURrY1FXZVM3c2gxU2JVQlhqdHc3dEh5WXF4NitS?=
 =?utf-8?B?WEpGbkpEbG1PaTdxb0RrZGJSa2dNSHpkYVZtZHZ2em5sb205c3pQNDV1SUc5?=
 =?utf-8?B?MVFwMy9mRHA2REY5dFQ1b0o2VHBDby9SR21mdGVaWGZzak1GYkF2NkxpUjBQ?=
 =?utf-8?B?VXNCU3JRUzhLRWRRdFhiYWhkQTc4QVdtQ3NTd1pMN2k1QXBnRVA2OUVpRDVv?=
 =?utf-8?B?QUFKbEVWS1VJSjhsSi9SdEk4aE5RckdmMWJRdEFWek9vbS9zQVVITnBPbFdU?=
 =?utf-8?B?YWNzYVcrQllpOXRBdzVKSGhKODNBRjJQVTVtaHFmU2VuT2NHRjVVK0MxQmtT?=
 =?utf-8?B?WVRXd2c5d3RtcHFncmlXNzlWS0N2ZjFXbGFBOWdWdmlEV3crZkpuRGtMY09s?=
 =?utf-8?B?WEV2a2hmemdkK2lydmFqOEdvdTlTamlpaFQxa0xldjEyMlZqNzcxTmdsdUsx?=
 =?utf-8?B?TGhGRXVuKzRDa2JORFZBVkJXN3RzRGtBQ21aK1dWazNoaTIreCsvWTVBTTA4?=
 =?utf-8?B?TW9Ta2RYV2FBZnFaS0lvWjdiMXBIU3NaUFVzLzhyR0JGLzd4ZTVFMzlscDln?=
 =?utf-8?B?dnl3cmVQOFhFaUZ2SmNIZ3VGY09iUjR0VEplTy84aTNMWG5PUW5ZNTJMcGZP?=
 =?utf-8?B?WVA1SjAyZ015TEtRVSsrRHUrSmE5R21CZ1Y2RFpOZ0hVa1htK2t3U2VEN29X?=
 =?utf-8?B?MTAyS1VLd0FUejljZFBPeGRnRm5mU0F1TUpkK2ttclpEMnF3Ulo5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dc30c5-ce56-4490-ba3d-08df0289765d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 09:15:53.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L81aCjsejTv/9m7rA9RfOBJ5o/xnsnpbO6bw7xbBTiyT/Bjqxkzclq3+ERo3mEGMMtJsMz/BK4j/6kKhqC68A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295


On 09/08/26 11:55, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> The Performance Limited status bits are sticky and write-zero-to-clear.
> ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
> accesses.
>
> cppc_set_perf_limited() currently reads the register, computes a new value,
> and writes it in a separate transaction. If the platform reports another
> excursion between those transactions, the stale write can clear that new
> event.
>
> Write zero to the requested bits and one to the other defined status bits
> directly. Keep reserved bits zero as required for hardware status registers
> by ACPI 6.6 Section 4.6.1. This removes the stale read window.
>
> Reject SystemMemory descriptions which require read-modify-write to
> preserve the containing access unit, because the per-descriptor spinlock
> cannot interlock that RMW with platform updates. Also reject 64-bit
> SystemMemory descriptions on 32-bit kernels, where generic readq()/writeq()
> may be split into two 32-bit operations and cannot provide the required
> portable interlocked access. A naturally aligned full-width QWord remains
> supported on 64-bit kernels, where the architecture provides a native
> 64-bit MMIO accessor.
>
> Performance Limited status is not required for CPPC control. If firmware
> describes it using an access that Linux cannot interlock safely, disable
> that status register instead of rejecting the processor's otherwise usable
> _CPC package.
>
> Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/acpi/cppc_acpi.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)

On my test platform Performance Limited is a 2-bit field at offset 0 with
Access Size 3 (DWord), so bit_width (2) != access_width (32). This is a
valid GAS description. The mismatch only means that the generic writer
would use RMW.

I agree with removing the stale read. However, even if writes are rejected
for this partial width layout, reads do not require RMW. Could the register
remain readable instead of being disabled completely?

If the register must be disabled, the current fallback is reported
incorrectly. Performance Limited is mandatory in _CPC. cpc_disable_reg()
replaces it with an Integer 0, but cppc_get_reg_val() only recognizes
that as unsupported for registers in REG_OPTIONAL, which does not
include PERF_LIMITED. Reads therefore succeed with zero while writes
return -EOPNOTSUPP, so userspace sees "never limited" instead of
"<unsupported>". This hides real events on a platform that can signal
them.

Also, pr_err followed by pr_warn emits two messages per CPU for this
nonfatal fallback. Could these messages be consolidated?

Thanks,
Sumit
....


