Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B925D530;
	Fri, 24 Jul 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886212; cv=fail; b=dYP16obU/cWvYlHG2Z/26zat5ZbcrbVWgqaJ36OokTkQA/JOc/UQzPbAX7I7eyzGEK9Vqvq3VHup82CiBpnynLUc0AlF98faYXmj0G8lwJXZ9lY0/UuTLbwA0nVPQTo63ZsX6g6lipKbU6UwE7O8+C/38V1XwcNMs6hCainTps0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886212; c=relaxed/simple;
	bh=v9EC7asM4eaxEGaKR42vgOTrBV0+aIk7o4GrOzDOYRg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kLHQH5ZrvIPNUXoMzBC9uBmQJRr/zE0YOGNgVCRQeiG84brzb7q7jNDv7zePmLJe4Z/1jrybAXLFAS+xMHp8Hex7uS5+EES2fIBc0K3h8OFtaJ4C7DDcl5lygDUUIEOC2bPYnE0PZHE+v1kUfPupKqUS71qTK7uF3jrbEt3GtAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Od60ESMK; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Od60ESMK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQh36nNJnzPsSr/wR9mYsH+Qgz2PWyiJVJW4TYpUGwee4UXsKgB/S4wIeFdLmHPgEBDCDs8hqKAdy3BxJAh74cKpcCAvwE7YtrB7RzaZBZPMp9XhYm88E+qBC9jSSmdOYXNHJsOTzGdiQO4CF0hfBrAhxl16lw/Pd8jmH/ZnLR1AlZM+doCm1cwclVY8D2rm2IuHps44d77iDwPdcfLGxok8/pXsw1vCJB7Sn5U8VlSLh5he0bfRhVKZNrsxaH5FyTeFL9dzj+1FFH2I0IofZhhfjMdrzU3ZX4MEPWViIR1KIgjaPbZSLtRZMYelqxwVe/gzZC1vie7fml6Bbynhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXWKhT6+B66cq7YalMLE+Eg9IAuGN4cjfB/sV/vX51I=;
 b=px/ES+Cd7ypajMdy5s08zXBBtZ/EoMpPkRp6UEMraCfp0CkPMkEdRKJKJ/DjdJEhMt+E3PnciQB/qH0fdYTKlLA4n/Fn1VpFS1KNjlbb+HUdTVZtzQtAPHjNwZ0vFtJ7x8bLdXbefAGadkyJk/gYgBWXYdn2A9uPjY0PoVEpSo43X9BqwzJsTJSngcYt+SP/XH9ZYrMp4icvLiwhiYQLtdi7rZt6XTB1zLxPQrhGGTMkdmxah3ya+WutAEsRJTk9f5Vnhr8kN/OKoFNUcn34PgoUfSSMsfXHeYVZOnqaLXdH/t1V0BycyUXCAVhrqsQ5NirZAcS36Kx8RtXDc4Gkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXWKhT6+B66cq7YalMLE+Eg9IAuGN4cjfB/sV/vX51I=;
 b=Od60ESMKT1quogNmQ9f+aP0TyvLPDCN9j5x4FXD65y490lVSYTpexGgLg6OGjoq+GrLU+O2KnqMY0wBeLnzW/yz8fN/pE99uNGXomqydkt6T9fkH/tuppNuc20AJY3iuGmRK+gaYxyFkkBkA6mv6s9gloe4UnSt/Ka9MxSssoFgx4xhLcLM/akxLis8zPaAe1hYh4kdxwapH5GzPy85GQyoq6L4O3ruR/kKaidNbtYcci5k5fRYsPYMVsTCsnzXvWSkgnNDOD8ow2Ky2FU+9JjRRD4aAEcJjF7i6MWoa7ZU3oXSJOmneS3Fxyl2ORbvr4fnfQOa6IePH+qIuD+JIWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 09:43:23 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 09:43:23 +0000
Message-ID: <33d51f65-a49c-46c8-b33c-ca815b4b2687@nvidia.com>
Date: Fri, 24 Jul 2026 15:13:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Skip writes to unsupported performance limits
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>
References: <20260723215634.1062264-1-christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260723215634.1062264-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0110.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b3::9) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3263d7-da57-4920-fc08-08dee96800a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	PoClDhb+pjU/aH9kIutofcZ0Qpy+V6q8kfRjKmH6lzd64F5ZM6lGK97ablF7XGt3Vba6kk33VeCPgwN5EOIgnogom/XtCBR+spWAxDsdAgP6nFpzaXmloIHSMA/apmek2EdX9toSleE8JlDbU9KkiYxFokXc1KuCctgCA+W/1uo/QXvqrI/jjonB85Z27Z5KHIyZjbXZH17F/PKFbuuVFcxNTlCD8wrzj4rEY27ON2DY4Byhd1kXGhsqMJoY/NPuN3Y3QRuIPgSH6j6/SIxMwE3kT8XQn+08Iv1+ejbyeCO5OQ3+GQt0nlqhAGY3rXPMGNr5PLrjFyA8bKx2eMWMpOx8uzb1rleFfcFw6S14Ag0x5/Ay7KcaaG3P4KzVufYpvOgh9yTGfNA7pv1pKKy3X/FbpLOkzBjjYj1RXDC0RNRUr8zyQw5Jr6KrI+8M+rg/7KAwpP7pZM6NVOMldiaRGFfzfZQuOeMTdZT5ac2H5CVYSAncirlzJsiDpUPwraCnwoRO6Rau0n5qma3uT5zbqT+R0HRZK8HL7bQlv3xUXbwJ/tPDeVwt6DsAdjdXzSEBe7JlL4Fivofkj8Nenx2aS4V9oU8KNgfooqwy8ejST3qgKt0oC/JTReHAdyi3F3UK1x2nHH+skj6YAaElmZhtvZb6nvrm9LfE2vlPrJWCz9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnYzaWVXM3cxMDZNblBRK0pBaHcvZDlVd1FnaGNxTDlnQVJ2MnA1WUNWQXVx?=
 =?utf-8?B?VUVKdTd2UFpHSXRjVytMR0F6c1BRTUNUaXppaDN5S05pMy9ucVhHZThKck5K?=
 =?utf-8?B?V0daWlpKQ0thNElTR1ZnclpxN1FBRFJad29YcUxSWjd0ZENqbUlJM0Rzd2xn?=
 =?utf-8?B?L3ZSODY3VHUxOVNEZ1QrSnNCeXRFbFA4TE1wVWJId3I4QUZyZVZpRlRVcGRG?=
 =?utf-8?B?NCt4eEUzV3hYMU5NQ2ZlRTB0VmZMYW1lWXE4SG5UbWNCczAwVDdLVk9Wa0Fz?=
 =?utf-8?B?cy8yTExGV0NIcTlPYWkzempyQ3RSUndzVWNDTHk3bVRSVUVuRFluaTQ3eEFI?=
 =?utf-8?B?ZVJHYytwQTg1Z2l5U0IraUc4VUJHN0JjaVhJRXB3WG44S2I1VFlvcGJldGsx?=
 =?utf-8?B?WGhoYjFOSktETXgxWnJHblk3STFIZXVHTlNaakl3WXp0Vk80NXk2dEE5NDJF?=
 =?utf-8?B?NDBJSFJxSEhPdmE4ZnFKM0krVk9WSGU4Tm9KTFRVb2szVDBpb0NBcm5FL2hk?=
 =?utf-8?B?YzBLSEd5Vm1lcUhzem9DeWtBbWZCSmtITmZFMEVEazE5VVVwZEpzVmk1aHVQ?=
 =?utf-8?B?WHl0NDhWTHJaNWxGOGVqRFVPVHZDNWRhQ0xCVEhHa3Zrc1VaYlkvVG9pMVRZ?=
 =?utf-8?B?L3hLYTBNR1dmd1FrUXMzM3dlZStURGVBR0tQaUx6alU0QlRzalJhWEJCTHBq?=
 =?utf-8?B?bXFDOVRmUURkR1B2TWoyVnBrRFI2MllUMnpxeVNORlJRQ0JTUWZTL1ZMQUZ4?=
 =?utf-8?B?QlZsYmtLM3RWYS9tWCtqeDNUb1p2WEkrV0pTcVc3UnRzOWY5Y1FLRlVid0dS?=
 =?utf-8?B?em5KMmEwQUkyeDZZYXlzSDYwdUlPdndheThTcGlkb0tXMFpORVRTeFZreFZQ?=
 =?utf-8?B?Z1k4ZXcxUlRTWmtKUDU5NW5yV2FBdVcwRVJJUk8wQmxDZys5MVIwd0tGc2pT?=
 =?utf-8?B?UHQveG1janJyYXNOSVhrZEVkdHlWRnl6aXdzVDFXRHRoT2RibWpyanY3bFov?=
 =?utf-8?B?a2RCTHhSRVl2ejB5clJ2eWFVeGd4MWVGVFFlRXQ1V28yTlprazZSaGh6R3Bk?=
 =?utf-8?B?VklCQ0lBYjhPY3FzSlBYSW1vTk1laFBJOVl5bVhWaCtSVkRVb1lUeFZsSGR5?=
 =?utf-8?B?a3ZjdGFuTURXWUZaMUtVdnozMWJCSFVBa1B2TEI4S0lQQzhsRDByVlRaZUVx?=
 =?utf-8?B?dXcrL1J6TTVWc1lielVocHVYcUtSSlJib2V2UWxVTU9sRFZGaG02VU5oeUJ3?=
 =?utf-8?B?dEtFN2JJOFk5aHNQVkN3aDBIcWY3MnB0WGg0ZmdtalNnV29DZWt0NFFDc1hl?=
 =?utf-8?B?SDBYZUZheFRzZ2ppZmFXdVZOYmhOY2piVW5CMi9zaHBjR08vZDM5YmJKNE83?=
 =?utf-8?B?Rzh1TCtRUnJqZ0w5cFFKcTlSdUVVSW00ZHMrcm1JY3JTQ1oyeGg3dUIyQmFI?=
 =?utf-8?B?U3VPN1NESnprOFVHcWxGRTM4Qm8vVmFINFpwRGZsSyt5dGdxeUNGOGdNWkxX?=
 =?utf-8?B?QjNON0pJeEg2QnhlYTZyUVRsbE0vSFZobitWUnZoNTVJM1hKMWYwdDhoNEZJ?=
 =?utf-8?B?c0ZnVDBkaHZvaUNUVENqVVhLN0ltc2hLRmwya1lnZ0hqQWpwZTJzVnhjK0hN?=
 =?utf-8?B?MFVmRVVIRjBKR0FhTjJtZlZQTmExbm4xelpkblRkdUJYQ0RDVytQYXhWSzRt?=
 =?utf-8?B?Szc3R2pMYzJRYndKWkdmb3JaK1hNUWphcWFWZ2lhRDZJeHBrelQzanNpbHR2?=
 =?utf-8?B?NEtib2g4Vml2OUszWjlPdjEyRzNJK2NoNWUrazZQWkd0alRSNXVzNnpmVWRV?=
 =?utf-8?B?YnNCUW9ZTS9KbTRZRXRKTFdBOXozSTUyQWwvcW5TMkdOU2NmY1o4VGtLTHhq?=
 =?utf-8?B?T09HZ3E0WW5ybWJHZko3cGlHODBwMno3NEoyRjRJUytNanpNVElOdmh3QThy?=
 =?utf-8?B?ZjRGZG5kdzJoZUhUTGx3VzdRejRhNzk5S1oxSkZWZ2hqTjJmMExBRTljOEtK?=
 =?utf-8?B?ZlF4cTZ2VlVJbDlHZ1BDaGhjZWJzeWQ5NUhocnIycmhiM0t6SWF5YmloYWRB?=
 =?utf-8?B?aHl4UEJ5MVBCN053b2ZBR3dhNUk2TUhNeXNPNTVBT0hLNnMvNWRlTlhPbXgz?=
 =?utf-8?B?TkRhUTdkdXV6Tmx1aVE1SEIvOUY1enJ3TkV4VGkrQzlKYWNYUk1Dc0FjRms5?=
 =?utf-8?B?RTVoa0hOQUJaV25MQXI1YUhqb0pDOW1YQjZjblA5NnlMNGw0cGZZWmptS01J?=
 =?utf-8?B?eTFtV0NtM3JGLytDMUJFK2twNWswb01yRkRGQjY4dVFkWFNiYnZBZSsySTlU?=
 =?utf-8?Q?0HHGjwp9HXHhP7h7WX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3263d7-da57-4920-fc08-08dee96800a1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 09:43:23.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIpyWl8C6efxPtp2s/QgtcJiRvfkUmWQrOzCPeJqhIjL/EPZI4pDZtm7CmMjjDg07ZPkemTCx7z6m0Y0gBELig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912


On 24/07/26 03:26, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> MIN_PERF and MAX_PERF are optional CPPC controls. The cppc-cpufreq
> target callbacks nevertheless populate both values for every request
> without checking whether the controls are implemented.
>
> cppc_set_perf() consequently passes a NULL register descriptor to
> cpc_write(). The write fails width validation and its return value is
> ignored, so the failed access path is repeated on every target request.
>
> Check that each optional limit control is supported before calling
> cpc_write().

Looks good.

DESIRED_PERF is also optional when CPPC2 and autonomous selection are
enabled. Should its write also be guarded with CPC_SUPPORTED()?

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

>
> Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/acpi/cppc_acpi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1d3a94100491..7bac6d5da24b 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1970,9 +1970,9 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>           * value to min and max perf, but they don't mean to set the zero value,
>           * they just don't want to write to those registers.
>           */
> -       if (perf_ctrls->min_perf)
> +       if (perf_ctrls->min_perf && CPC_SUPPORTED(min_perf_reg))
>                  cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
> -       if (perf_ctrls->max_perf)
> +       if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
>                  cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
>
>          if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
> --
> 2.34.1
>
