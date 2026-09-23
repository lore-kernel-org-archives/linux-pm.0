Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B614F3E3C5A;
	Wed, 23 Sep 2026 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197862; cv=fail; b=uCitv6umc0Dn5rhuKgLqM7C+WXOYVuz93xpNyjOuTVjmAruv3s2r8phSHc5Uxb/iIS1dlWlb1EGlGPhPGVgQatuy/sM5PsdnbdQ5bG7BEl2vwtRI2xfHV5yrTmyEEzN41KlnPGxa4uQLdUI20GoPKM0EwKwWA0uMaeO/8q6bpe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197862; c=relaxed/simple;
	bh=C6BTNGLGsAriwTprhvb0QLDkmI+f9B7S9LtPLHjMJ14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cls5vdjDRM8/rcu/m2nx2zNH0CKr/7OxO2rQ9ETBsIZwS23btfA39FYnSx6pqJHhlRVkwMSkwNGE/RrhkL+iqnOWhskvfdlG+CHYzdMdNo9VpIp54DWjlrFPZtmgI8VROD9f7oNduxmjsu09omMFFp2+MjsjU1dfdsZypqbIM5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tRKamG6U; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tRKamG6U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM6mwUJwSTF+uoUoK3U/E2pQaZfWgW5gyDx1ZYlfY/PG/iDTnnrwHUzwqt29+1UXRrQOHY8oq4/2Wg22QToH3OMdRPI6G6mRHOhPg5QwrrVbtVEh5bRHrxLUO+F01g3Wqi9xIlLECU2pu7ILGcvcOZPCAqSr7g6wl3lYCgBJtKel1/NAYeR9nzJv+AW2mcTXyzz6YCtqIlRf/NfXHxMm49uX0y89LOqZVDz2lOnZYjzI/GlVHetjFWb2EAWGkDkb9r4Kc7/rg/mob2oHxISg7+hVIuEg0run2ZrxNcFHAbewer5EOZPiDGgRuiFOLeCOROm1QQc1SvFY4Owz/vOVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQqhtiBv30w/Ky4qVWKEh1bk9XbfE1wJj3TrUxfT7As=;
 b=YJQpMAyLyUGDtpelHYaUT50k9u1dinHU4SPqnWGuANnS2fjj0TCvVY9fxof96uCpst5dCpy2ZoMPlkrDdlO+aAmm0VRRhOrXXhyTaewpEW61+gIrrRNW+xcm2EswNvdmqOTTir+6TUEVlXdKaaDiP3HFS3lb25UXe4M8R4ix4RBwWriPkNKj8G4zV97juA+ZPFonUzvlE0FnpP8AERgGm22N4B8WzOT9r5dnaDjt4/a3BWbQrviISPpv+lhKhujl5xMl+kimZ49g+V1jhycmrSvaNJzGOOVa00mnBaHj+iSM1Ri8tQKr9Sb2Npewk/ze4oLBn3MZPiA7uOFbGV7QhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQqhtiBv30w/Ky4qVWKEh1bk9XbfE1wJj3TrUxfT7As=;
 b=tRKamG6UqVLqogEAOVyCCbOKgr5mQMNHBX1esaWcGx2p68SIDwsHe0lUr7sv+Kg+c3eDIxfMCfochx7QHP+XiEC8h9v1rogvebd9yuHwNJsEGhnrVdo5ozjJCilb24reLi2G62ndDJkSyI3VEqLKtUAbEaBVjYhvtleE6BRskRw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 21:10:47 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 21:10:47 +0000
Message-ID: <8f06af84-c0fb-4d24-8868-bf16a1678b4a@amd.com>
Date: Wed, 23 Sep 2026 16:10:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
 <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
 <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
 <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
 <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
 <60a5c26c-8fe2-477f-b576-2a18d8b6394d@amd.com>
 <fc70f3b0-6ac5-7ac9-dca8-595b65785718@ik.me>
 <b29e9341-70cb-4201-99fc-ef307dd10fa5@amd.com>
 <aab50dd0-5141-bded-0b58-0f01ae9621d5@ik.me>
 <c42ab776-6fa9-4e8e-acae-fa921a5ac108@amd.com>
 <0d1686e8-a50e-6f3b-2923-a0eca6ab4271@ik.me>
 <b6015026-fe8c-4823-ad39-c630350c0cc1@amd.com>
 <c58f84c7-bfe6-58db-cad5-6859e96a7daf@ik.me>
 <afb1949a-8465-cfc8-bddb-bc27783af223@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <afb1949a-8465-cfc8-bddb-bc27783af223@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::18) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b75a8e4-43f7-4890-fc1b-08df19b72320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|3023799007|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1cRcn9gcFUuPVphmDR9iVqokBRNUCD0ycwW9TJOFxVsle9OB4XF9kLF6afxNEhYEyv0RMxeUKOwe/rputdtOQc93moQBrZ1nyld3fZUYPG/gBccXlbPMbN9w2MJyqD2PGp3bXa3lKAgo0+6AmBR4e+ZwUijddseKOiZWY4/5SzXoFMMvxC/x+oD8vkE54xeB7xd436eFOlYCuHONA8dHzzmZnUz2o7g5xDoTLeuAj9/vCOkkbfVBgj149rIlvsUzMxP4Cuqq8KIJ3g2iZuNvV9vP3BOVTlNQna/NktResY5OBRZXQKQE/gDKqwhS1AZzFVJp66mFRyoGgjuDwpvHYOrPEB44PQY2eDri0h4sndEHTnzwEJBK9usknjEwFuZBXd7sFQxsI0UvLsWfzB52gdKklN3x80SyYU/d/QlnXNIw/1FqB4H1lLOJkATxX2upsLaLHUbIt755IAaEv5J4TZ5rFHMoYE9QToqdKkwoHCBmaVeJllnxZCjU/kw6AYc7k8M+Bm1KHVybhwzNi5Q+Fe65Eu1AxtUv2ehc692OSOYag2u4r1MaiipaLMjNGIdk+VcDQ2nOnDVo/zUnm/KlMcMa8odHhAWi63J2lOJ07ZBTn77I2fkWaG1NK/14hP6IsbHSzfSbAmS/l2jpKw0TwrXR03PPGp/aEn0AjaN/npM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkZhY2dyZDZ0QkJ3NjdqVmtKazJTRjV2OHZuV1gvN2YxVHR2dm5UTDZaTW1I?=
 =?utf-8?B?bUk3cDJadWRUV2g0QXUzQVgvNStzY1hpT2xzcnhMekRER2tHZW5jcUFObzRE?=
 =?utf-8?B?ZXhEclJZUjJ2dmJSL2ZQQU1iaVdkaXduZkY2WUR6WFJ3Z3JpWXV4a0F5TVZM?=
 =?utf-8?B?Qm1XMW9HTWpYbXZzQVdSdFk2Lzd0ejNXZG9pa3cxMTQrMDYvV3ltMVoySE9a?=
 =?utf-8?B?OU9GT3ZheXJwMEFyZnVqZWRBdjJFSHRrNEZkb2h0bDM1MktobUJMNXFzVzVw?=
 =?utf-8?B?ZTdNVExHQnhva296SW5sVE5mZko1SWw0bTFXL2o2UWw5dWJ6TTdwZWR5REk1?=
 =?utf-8?B?TEhZSTdZRGNveGVud3FNNWdVaUZiRTdBU2xUYW1yOWNNL21UOUVvTExYWEwz?=
 =?utf-8?B?RXNiYmRJd2M5WkVsWFBJSkxJak1XamU5YzJYNlhzakF5Q1lRcVNDN1Q1Y2hp?=
 =?utf-8?B?bURRdGxHc0ZTUXNLUzBwU2NuSzdnYVRGdjRudUM3MFhJa2F6Nk5tNUZRSjNx?=
 =?utf-8?B?cG9semsvT3RwOUNLelVQVEhMZk9JZlNNRXEzdUpuTGNsazdWbEFqWGlTVVlm?=
 =?utf-8?B?NitpQ2JXdWZRR0NyR240Z2g4WlEyY1JScmVXMW54bTAyYW5Tb3puY2Zobmgz?=
 =?utf-8?B?WFYrOWZWdUkzNktIYzlEUmZmODVZbGFXaWo0OGZPU1MzVEo5eDk3MTY2NnlX?=
 =?utf-8?B?UUdTRzBxcWZlU0dqL0QvcDNGLzMvOWZEbXZCNXBQT1U3UmdId0hDTlJMdGZL?=
 =?utf-8?B?R1EzSzM4YzluV2pubTRFdHpYVVc3dUFySllSdnVjTmIvNkpENUw3dUdRUGFh?=
 =?utf-8?B?aC92M3B0SXI1Mjc4Z1ZtQkxtc1E3bWgzRzVrRDNLZmhGZi9CNGlSQVFoSnVu?=
 =?utf-8?B?d3NvN1JLZzlSUWtVLzhHRFBML09pTm9aL0I1ZjhWV21xUVcvRHlHM1J5bmRm?=
 =?utf-8?B?MzJ4SytYU1FPdzJidnNXdEpaSlo3blg0Q3o1YVdoVUFvUitIWDhsWGVFTEFp?=
 =?utf-8?B?bkZRQy9BS2tCVmhWT3ZtSUV4Y1FKZGJvTEpsM0hQc2FpV25tOThaZGZWS2RQ?=
 =?utf-8?B?SndpdUdPQVBpVWRuT0ZCbjhCV1dIUzVqQXhXWGlOY0lhMVNHWTBPU3Ztc2pW?=
 =?utf-8?B?aTY5Z0Jtb2R5VUdoU291c2hiaXRxZmVBbzFuTUNrRDl4eEJTSy85a1c3bFN2?=
 =?utf-8?B?ZE1uRml3c0ZFRjNHYTBrdng2ZXBRVS9VaDBNSk0yaHhZZUlnWTExWXh2Wmhz?=
 =?utf-8?B?MzBsNkl3WXVhaHFZbmxjc09jbXFsRUlodW9GWkR4TEE2ZTM5SjVqVm1UNEkw?=
 =?utf-8?B?TzlreHEwNllidDdxTXFqNkZQR1hIMnBYWVJLTXQvaTV5TU1yU0UxTFdZc2cy?=
 =?utf-8?B?ckQrMlJXYXJmMXFkMDJIWTdVSTZmM1VrUEhkOUJLK1RIQ21hVXcwNUI2eXJL?=
 =?utf-8?B?VFFBR2ZENE03UE5MekR4VmRObCtockY1TGVFMUlSV1MyaXFEQk5nVERwODF1?=
 =?utf-8?B?cDhGLyswbmNoSnlPdnBOZ0JjSlZpNGVFd2MySm10eFhYWGh2T09xT0lRRkZ1?=
 =?utf-8?B?VzVJZ2lhTEhMbWYxS2xUOTQyOW42alY0WDRmWUZ6TE1JaU5ZL2VZYkYxSWVx?=
 =?utf-8?B?aUkrdjBXTW9oRFEyT1VSditrTkNEV0FwcGUrYWczbTg3Y2UrQWRvaHl6QmY5?=
 =?utf-8?B?LzFNUlQ5R3FveVM1WVV0LzJLTElDZmRCTVdpblhQNG1DeG5HMU03dHloc0x4?=
 =?utf-8?B?NEtlMnB1MlRMTkJQbXUrWExBZU5VZ1E4QzVuREtRSWtSWGFPdGp6SEFRRitQ?=
 =?utf-8?B?Yzh3TGxqekg3NnVJcTg2cE5mRExQc3YwQTVIa0JjMEk1dzdZT1RaMWFWY3Zw?=
 =?utf-8?B?U0lvQ2Jtc3lRUndLZ2pZdXVoU2VSc3dNSDIrRm5LMDFPdU9kZUNtZGpPUDBX?=
 =?utf-8?B?MDFMaVNmRVdJRExTcmdOdS9Ta0lzSk0yeUY5S1FLWkZqOTc2dWF3ZUtxT1Vx?=
 =?utf-8?B?Q3FmY25oc0ovU2xRR0hDWkFSS1htMkhNVGNpWnMvcnE0VkJobFJZUWRZWFRL?=
 =?utf-8?B?VzJxUEl3ZGhxZHVvSmJSV0c2dUhFMWc1UE5aY3lYTnFmM3Nsd21xY1ZJYjZR?=
 =?utf-8?B?T1ZMZjZmNVNPVEx6UnkwSUJWdHRlS2xsVHlOeFA4QzBjcWNMTUxkay9sWVhs?=
 =?utf-8?B?ZkYvdW5vdC9ldmYvZmR2Syt2SVdvSWxkNzhiTEVlNmRhMzVKemVQSHh1eGVM?=
 =?utf-8?B?VytSeTdDNytseFpwOEx2NEp5NUFEZEZNUTV2SHJNRmlrWmtKMWxXMnJYWHVR?=
 =?utf-8?B?eFptVVFnOWNxbk1xZC9BaGRKYzFtR3ZHTXFGNzZRN2FxWFMrWFdIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b75a8e4-43f7-4890-fc1b-08df19b72320
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:10:47.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BCCGmCsVv775goCwE/na0Jus+RoYr3x18R499tTzKdXCH+zN6Fg8xNMFpKoqhFzwF8evXOa5aCZNBhhLrmXYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919

On 9/23/26 15:48, Fourhundred Thecat wrote:
> the bug reproduces on 7.3-rc4.
> 
> Built 7.3-rc4 from the torvalds snapshot, migrated my 6.18.51 config 
> with make olddefconfig, IOMMU enabled, all 24 CPUs online, no IOMMU boot 
> parameters. Same result: the machine suspends and never wakes, forced 
> power off required.
> 
> Both attempts recorded by the same script, neither produced a resume block:
> 
>    === 2026-09-23T22:15:02 BEFORE
>    cmdline:     (6.18.51, no iommu parameters)
>    cpus online: 0-23
>    iommu:       ivhd0
>    ff_rt_clk:   0
>    S0ix Entry Time: 0 / Exit Time: 0 / Residency Time: 0
>    suspending with +30s alarm
> 
>    === 2026-09-23T22:39:06 BEFORE
>    cmdline:     (7.3.0-rc4, no iommu parameters)
>    cpus online: 0-23
>    iommu:       ivhd0
>    ff_rt_clk:   0
>    S0ix Entry Time: 0 / Exit Time: 0 / Residency Time: 0
>    suspending with +30s alarm
> 
> Both used a programmed RTC wakealarm at +30s and were left untouched for 
> several minutes.
> 
> Relevant details of the 7.3-rc4 build, so this is not a configuration 
> difference:
> 
>    CONFIG_AMD_IOMMU=y, CONFIG_IOMMU_PT=y, CONFIG_IOMMU_PT_AMDV1=y
>    CONFIG_NR_CPUS=24, CONFIG_MODULES not set
>    CONFIG_DEBUG_FS=y, CONFIG_PM_DEBUG=y, CONFIG_DYNAMIC_DEBUG=y
>    CONFIG_AMD_MP2_STB=y, CONFIG_X86_MSR=y, CONFIG_DMIID=y
>    CONFIG_LOG_BUF_SHIFT=20, CONFIG_RANDSTRUCT_NONE=y
>    kernel is not tainted, builds with zero warnings
> 
> Only 243 config lines differ between my 6.18.51 and 7.3-rc4 configs. 
> Both commits you pointed me at are present in 7.3-rc4: rtc-cmos uses 
> platform_get_irq_optional(), and iommu/amd carries the "No ACPI device 
> matched UID" check. As on 6.18, that FW_BUG message does not appear here 
> either.
> 
> Two things worth noting about the 7.3 build specifically. The new IOMMU 
> page table layer is in use (CONFIG_IOMMU_PT / IOMMU_PT_AMDV1 replacing 
> CONFIG_IOMMU_IO_PGTABLE), so that rework does not change the outcome. 
> And AMD_PMF and DRM_ACCEL_AMDXDNA are not compiled into either kernel - 
> DRM_ACCEL and AMD_SFH_HID are both off in my config - so neither driver 
> is involved in any of these results at all, which is a stronger 
> statement than the initcall_blacklist tests I reported earlier.
> 
> Where that leaves things. With the IOMMU enabled and all 24 CPUs, on 
> both 6.18.51 and 7.3-rc4:
> 
>    lid switch, internal keyboard, power button, USB mouse with wakeup
>    armed, and a programmed ACPI RTC alarm        all fail to wake
> 
>    intremap=off, iommu=pt, amd_iommu_intr=legacy  all still hang
>    pm_test freezer / devices / platform           all pass
>    PC6 and CC6 enabled per amd-s2idle             yes
> 
>    amd_iommu=off                                  wakes normally,
>                                                   Last S0i3 Status Success,
>                                                   13.3s residency,
>                                                   pm_wakeup_irq 9
> 
> Since it fails identically on 6.18 and 7.3 there is no working kernel 
> version to bisect against. The only variable that changes the outcome is 
> whether the IOMMU is enabled, and secondarily whether more than 16 CPUs 
> are brought up at boot.

To me this still feels like a BIOS bug.  I wouldn't discount the 
possibility that think-lmi didn't apply a setting properly or something 
like that.

Can you please try to manually go into your BIOS and reset BIOS default 
settings?  Does it reproduce with IOMMU left on?


