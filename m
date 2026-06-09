Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5023EFFAA;
	Tue,  9 Jun 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995200; cv=fail; b=NzC/pmfxP/LP4lik6KulegnS9gYiRAGpG0lkjhqVoNWJ4wHX54MaSXtlaUkq503BJTqhl/7IK5kDEu00tWXOkBtGK2UxlUQj7kuO8aEcsO6AjLvrYwxLqALBaHk673flLvQSSE1ZJds8IQbJEjK5h37ILnImWFt02vj8tD22uMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995200; c=relaxed/simple;
	bh=t9UOEFnm8wi1haw0acJjezv5OOwxwnxDoWpw83Zx9Q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IvTQ8l5f0QutI9UGiAF65RLy7EkUfBYqujD7mgVTzasVawBLAdxtujAU0H5sjKQZzY6YfO9SJLw8EV9DwVSgpHC2lAWBBJLx7Ovqv2vz3dPu2YIjRKnJZkJ4LxAVP/kJJtp5FOFblu4YJTrQhin1UPSW4aTB6DeQUttqSTbm2Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UCpC7wIC; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UCpC7wIC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jveDxo+2RmnYXn8fAy0xIBci8Ev8TCZYdmT0xcfrKZ8yaOXLup1GAEfg0Asxmh9TIsiQSJTI4moUDMbpqJtNZvpuqcV+C59AnfzhSVxO6j1P1TGScRcnFg9VmO2/mcplZXN8x1xJnEBaZqp0EneVVI2fb0+JCC9loFdoAKtVxsP1ajyF8Np69VXLqjLWWm5+cwHpYJXOFdD+bmXWpxuNAoQPGrF0mXH1LRYA0B7d/jhC2VH8xyoTsz2L7xq+uZD43q/GO9q+QJbKCPChydi1xpLCEpJeNsrhtfJY/fRGWLcQbNs6ZeSC0m21Jc0yG8pLZty3oPd0Pq5FTxe+acrS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9UOEFnm8wi1haw0acJjezv5OOwxwnxDoWpw83Zx9Q4=;
 b=kXsPmgC0jXcC0gKnjtr1fbG3ajvTfsl9Uk7T8XUgsqABRnYnyK9yvsvglucatAIjKlO2b+TchDB0TMIsscSy/gVJvsTPUllaQn4w2swDCL/9h1vjHvN74KyvCadZB5V034Hj91OJYrwcAwOJjwSs6/AILH5hG9OW/ZZ9+hruaCVMb4MBgdN1shX+E88Wi4ok3gOkupSMa+ko8icfk5EDuhhRttmPJPtBdqfG8Z5OW9q2UvjZqWnvVJU+WSCXJN2Krcvn7A/hJQXDixUAiHCjb9uTCfJ3QY0AmcGuJN3MDo+ur9lCJsxAOY6aXhPIRf/4oKylKVteaLuwnHaJYzRzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9UOEFnm8wi1haw0acJjezv5OOwxwnxDoWpw83Zx9Q4=;
 b=UCpC7wIC6CVC+RjRGcrJnFU0F/7BHqvlHlh34uLyawcC4Zy4EQHbZ0HB4R0PR2pd3WlRoarkeVQGTWI52PowEQoXX+UMjxAiiBqzZdUg4Z/r2LgakscVQDhho3exSCPnBtLrQEKLKYl743j8eMUbl6xA0MyAuJ5qhH8Z5IQCRnBG8NHZG6dQzgs+Dj00cXqe5yl3lwSjjJ0P0yKj4GgsA51KOOnaCLg39F5J/udiqRjgfh2GvncJc6Ffuqzomr3LutuqYB+LjXI7mfnVONDsObY1COiT0elvvTBgVbMXk7OtQS6qndDw1kLPwzFg/rbo+robgKlooo01afbL46MFVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Tue, 9 Jun 2026
 08:53:16 +0000
Received: from DM4PR12MB5184.namprd12.prod.outlook.com
 ([fe80::f927:9cb7:cf3a:e741]) by DM4PR12MB5184.namprd12.prod.outlook.com
 ([fe80::f927:9cb7:cf3a:e741%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:53:15 +0000
Message-ID: <ad12ad81-5d39-4090-b53a-13480e85731d@nvidia.com>
Date: Tue, 9 Jun 2026 14:23:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 sumitg@nvidia.com
References: <20260514194822.1841748-1-sumitg@nvidia.com>
 <20260514194822.1841748-3-sumitg@nvidia.com>
 <457972d4-eabd-4db9-8d82-b4c6a5f79465@arm.com>
 <5bf877d5-42b8-4e0d-9afd-6cb9c4b45bb1@nvidia.com>
 <86780f97-29ee-4a72-b311-38c89434b707@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <86780f97-29ee-4a72-b311-38c89434b707@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: a9531c1e-13c6-4b8a-4ca7-08dec6048a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	a8gomzSQ9jwHTI70P1wHF4WJj/7zFTsgmSvOmLogqAZZbAjezIfQbtKJsfonoCPjnbk76NJWJJk8+WCBFxpY/9+2rNY5kIOYHzf9NxC/D/b2zMAzgkksZfhTBT1FNO09SIQbLV//X9IyVJt4+5UFad4PjjI2H6rkFjMCfXiwLj/aP27V6U8YYR/uhHoyYEWcucxObqBbpEOYNqAcAfYx5B42LoxniQUxa/uDY68eRwilimcCmQR7sqi6f4YukhjB9/Za/j64x1+cQrW7+WNZl93b/TR04DKmxlq5Uc3WIrXJYVwhmAuuXhqbfFnh9w0rF0+TaHY98EzmnHCsykIfpBt9WWtwNKa7AAzj4kG7eQKaf5JrB4Rbxy5SosSzXErMzBNYuTpc6UnNVq6Wp9wgzfX52+/052DPcWAHp3SRQqfUGvXf73E3SwPUZJAcceV55Wyfb3wwuLvzVQaPaIICgn1imecHL3kRWTGuMy4U54fQOgblmcprgzCfQx3cVkG31qY6m+lUQYw43Mn6EH1+yZj2oa6k9mqXsWLtUeTvH80FhB8xp6GLOFrpmU6ezF/RtoWzk9sy8ZJ0Q5kZ3XfSUVNg7KPUEWsRtP/camAH82++VPF1DWFrFdZVIq2trYhzMHAg64y/8ppU5nn1H0ZS+QbaLgyPqd9uQ/W5lBcztJxRca85guBHxiTg3thakKaXNlv9QGENF5hbMOX0EVxGcxzYrIZwb7+AYk0Mso2qYAOA14dsnODs+kLNpT5uHEzI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5184.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXRLNk9UeFVPK2xNTE40OVdlQnk1MlJYOXZLckMrb3NRRjZmY2twdlBVOEJw?=
 =?utf-8?B?cFFIcTNYa0pjTmZrNitydDdLbFdvVFljVFlrN0M4MVY5RHJUYXAvZDdqUmJK?=
 =?utf-8?B?QWErWHArSFEzR2xPS0pITWZwK0IvTkpNYUxyNjFyR2U1MXpuUCtyZm96U2hI?=
 =?utf-8?B?QlRnR3UzWUdtWXJyRzJMRU9qd21vM2dOaEM1NGYyY0tiYTB0L2lNRTRpcnBP?=
 =?utf-8?B?RUhEOElYUDlZS1BFSU1MS2VsSWNDOWJyTGwwVmxVQXpOODZOcmxMR3FldVNH?=
 =?utf-8?B?ZXBrQ211OHI0TksrcDN4dDlkaDMvemNDN2l4cmp0VSsySmdBUEphZ3VWKzJk?=
 =?utf-8?B?THNLM0xQbUFXNXEvZjU4NUVZZVpxano4Q0RDVmVDMjcxeHcyRFdYd0NLdjJO?=
 =?utf-8?B?RWNRbTR4N3hjNG9LQmE5WmxrWVRaellJemd2VVZrTmJpc1VkNmdHNXZBT0dl?=
 =?utf-8?B?UWRGZnQvZ1VGNk95QWZMeEFMTlVTUWkrYVV2bWN6U3BIV1ZVZjJvL3JPL1hN?=
 =?utf-8?B?ekNzZVVidTFReXRjcXdaVW5ncVJqd3hBdys0aHJmRzMxNUVJT0tJVEw1Qk1H?=
 =?utf-8?B?L2N6MlNFT2tZUDdtMVBSdHQzVG04bW1BTzVIZktxbFg5dFc4Vm16emVtTlBM?=
 =?utf-8?B?KzV1Q0I3RHIrTmFoTlRzR1BVVEV4QWlGRzVvTFJZZmtFNllOcUs4blptbnkv?=
 =?utf-8?B?dnN3NE5oUEVyVFNCcWRxMlZFNWhNY0ZXQjF1N0RGVnZaNlMwQnBnTDBmZ2xo?=
 =?utf-8?B?UFlTM21ZM0wwZmNqOXA3bW04SnJ1eGtSMG1sV0Y1ZW90NlVUdzZnTUxkcFhV?=
 =?utf-8?B?Y3FFUjE5WEJZUkRYcWJqMVFrUzkrR1dBU002WGxESDBybTJ2OEhNOVFtWDRE?=
 =?utf-8?B?d3hoZExwMUIyNlhBUWxNOGp4L0RtVE00ZUhqNTRwZmYySnBsem9lS1RnVXdp?=
 =?utf-8?B?djFPbU1jSS9pYnVYVmxDWWRkMTNJZmhiVUZNdi82RkF1aDllM2lyZXZ2Z21p?=
 =?utf-8?B?dE80MkFnUjNVc1I1clR2MWwwcFFieVFmdXR1NGFJQytTY2NYS2RiTktaekkx?=
 =?utf-8?B?NmVpRUVNQnpzN3NYL3JDMjEvaFo5SXhDVkU4VEpCM3N4VkRTV3EvZ21sdm1m?=
 =?utf-8?B?aENSenVLWjZ4aFpXbnFnQ3BQN2kvQkd2Sks5eEJ5V2NiT1ZjYVZhU0Z1bG9Y?=
 =?utf-8?B?YjVhejhoZFBjaVhCUHAyYVJZYzlURm5jQjRyWUl5dXV1TEV4TE1YQURIL3ZD?=
 =?utf-8?B?VFVESVpLQmZ0TnBhRjVLaVRFakF4ZEJnalF2cW5SUS9FSE9VbVNyTUdIZGlG?=
 =?utf-8?B?YytJZ0V6anZCNTJBMWF3SmF0aVBpU0VYNk9ha0s0RE02Qy9CdE01NlFsZTNr?=
 =?utf-8?B?RWZMR0V0Q3FmN2EvQXdGQlF5SHd2MVJlY2h2K1RRTVRGUjVJYmJjeUp1Mm40?=
 =?utf-8?B?ZmZaVUVnY2FBd0RNYkJjNGJFSUZmVGdza0plVmFHYTRqT3R5MnFKcFphSW1y?=
 =?utf-8?B?UXdKRnpBVjZlbTI3d0w0NVBscEpKNXBVN1VBNnhXMFM4T3h5MUkxc1FySlBx?=
 =?utf-8?B?cGZ5dVFiSUpnY3p3bWp4eU43THpzYUFMRkhtVFNjU1Q0UHFYTFZFMTBoUzk2?=
 =?utf-8?B?alJwNEtsVy9helBLV0FHTHlwd1lER2xNQllSRmRFQXZNVlp6WkZWNDlNcXRT?=
 =?utf-8?B?T08xMEh4blo2eWY3UDlYY2dPTEVWNTNSQ1pNbmIycUd2dXE2WGVIV1FFR282?=
 =?utf-8?B?NDZ3aXphTHR4R1RoakF4UllGeDJVMXI4K2I5YjJQRStsYXZ4WkRnMk5wWUQy?=
 =?utf-8?B?clV2NndTOVF5OW93Q1g4NUUxZi91Q3ZNTkRXeTYrcEo3WEdrMXRXellaeFNs?=
 =?utf-8?B?dlQ0Mjhub1M0M05BYmowRWlCd2E3K0JYQWZNZ2I2ems0K1l5bklvaGpmdjZH?=
 =?utf-8?B?R3Z4ZFByVkRnUlo0UWIwNG5nQjZhNHpzZ2Ria1hTK2N3UTcvUHg1MTNHZHNo?=
 =?utf-8?B?emRrODBJUXJwYlNCQVh1VCt4U0dpdVgwWXdTVEJKNjVEd1RrdzJqL2w3akZY?=
 =?utf-8?B?UnhzVEYrYW5xTkFOM1ZLVGxGYklRQ3ZwRVpoeHozNHNEZVpxanBreXB3QW9v?=
 =?utf-8?B?SXBxT2NnN2JoVDFLL0tqRHdDNVl0eFlJaUFkMlJkclYrUW1icWh0YzdOamho?=
 =?utf-8?B?N0w4UU90SGRMd1R5ZkhtWU1PMXkzNjVxMUlMSkQ0NXdaUk1walo1MlNxRkFY?=
 =?utf-8?B?UUg1SC9VUk0rK3FyaEFnZXpqNzBWL0xvQTdYY09rNkJTdEt5L09ZOXIwRFlY?=
 =?utf-8?B?cm1FbWNDM0RpQWs4aWhDVnI2REVqcjNMRUdxckpPcXFZRzFTaHNFUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9531c1e-13c6-4b8a-4ca7-08dec6048a69
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:53:15.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6mR7UE1uurGsJceAdQPgafYepQfqyhziqHm/Ix7zl2oWM0SjnIju+lTL1TKEXvKgaQi0avlj+l931m2V0fZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224


On 28/05/26 17:37, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>>
>> Hi Pierre,
>>
>> Thanks for the review and the complementary patch.
>> Going point by point:
>>
>> 1. Rollback for a partially applied multiple CPU write in
>>     store_ospm_nominal_freq(): Agreed, will add into v4.
>>
>> 2. cppc_get_ospm_nominal_perf() and the show/init/exit coherence
>>     checks that rely on it: I'd skip these as the register is write-only
>>     as per spec.
>>
> NIT:
> IIUC having a write-only register doesn't mean we cannot read it.
> Cf. cppc_get_desired_perf()


Good point.
v5 reads the register via a new cppc_get_ospm_nominal_perf().
So, show() returns the register value or "<unsupported>",
and dropped the cache/bool.


>
>> 3. Initializing the register at startup and restoring at exit: In v3, we
>>     dropped the unconditional cpu_init write so user values would
>>     survive CPU hotplug. The spec also makes the explicit init
>>     unnecessary: "If this register is not provided, then OSPM must
>>     assume that the OSPM Nominal Performance value is equal to
>>     the Nominal Performance value.". The unwritten default already
>>     looks well defined.
>
> The concern I had was for the scenario where:
>
> - the driver is loaded
>
> - the user sets an ospm_nominal_freq value
>
> - the driver is unloaded
>
> In such case, the ospm_nominal_freq value will still be set to a
> non-default value. The modifications suggested previously would
> allow to handle that case to come back to the default value.
>
> FWIU, we have:
>
> +------+     +---------+     +-----------+     +------+
> | User | <-> | CPPC    | <-> | CPPC      | <-> | CPPC |
> +------+     | driver  |     | reg       |     | HW   |
>              +---------+     | interface |     | reg  |
>                              +-----------+     +------+
>
> So if we want to handle:
>
> - the case described above
>
> - the case you mentioned, i.e. hot-plugging CPUs
>
> maybe the scratch values should be stored along the CPPC register
> interface. This would allow to handle complex cases where CPUs
> are hotplugged and the driver is loaded/unloaded ?
>
> Note: the same kind of scenario should apply to the auto_sel register
>

Right.
After unload, the register keeps the user set value instead of the
firmware value. In a follow-up, I will restore the firmware value on
unload and reapply the user value across hotplug, grouping the
OSPM-set registers together (ospm_nominal_perf, auto_sel and EPP).
On my test platforms the registers survive hotplug, but that isn't
guaranteed in general.

I think it's better to keep the saved state in the cppc_cpufreq driver
rather than the CPPC register interface. intel_pstate and amd-pstate
do the same.
For reapply, will use a CPU hotplug callback rather than ->online/
->offline hooks. Those are only called when a policy gains its first
online CPU or loses its last one. cppc_cpufreq also has shared
(SHARED_TYPE_ANY) policy, offlining and onlining a single CPU
keeps the policy active, so neither hook is called for it. A per-CPU
hotplug callback is needed to cover that case.

Let me know if you have other thoughts.

Thank you,
Sumit Gupta

