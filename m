Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C840B6E0
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266883; cv=fail; b=ggHc8llWmNpUc8OcLf4poSQh+kazN/jeePh7XHhM11O/i+a47TL5u9PGFvCir5+db14LMmJU5peB3FpiNvZQDnHw4K3E+66F7S2agSwctWgRzkMAC4L1wLWusI1s4rq/hDJ5PaO/jabdzkgGIkSwL6y+gUSKKegp7qglvmH1wOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266883; c=relaxed/simple;
	bh=taanhLw/CYAoPP9N9dutMnLwjgvJ/luy7yL7cYa3uF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dp3osyKsEU/q6Gmky1GlCrkG4ka4b9b5bRAqH6lCFo0jVMxTlGANhO04aNTNmW9RdA+ju9IbDpIXb/Ekv3gOQYrchhJ2qpltNt/bObrn16gR+V+IMDPys9amXyC+9h4efnQb/H8Jl5TuMjYzIyFOZVbbnfREjDDboAfeo23a73M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BXsltLSG; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BXsltLSG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1G4Q32V8uzM+HD6AmR6C+d41vQBveW+qzfi7PQzreZYuVhvBVH3HUzkGgNM6hYJdnsRAxscKHsjgRHfMfyj3eXa800gxDgs31VVhnrL4oomTYfEfro7Nguuox46HlzUBgW9LZ5/ggtXCGMX//BVHHWNsCgxFSgkTguJThLAmDeC+TOT2lgEiicBexkvObsnkdkmAAcOO17R8o493uZLmqiCvJTeqK0lqNx3SlGVjyjQSkqyfKbR/EPnG5NZcRUYHg2azNz1XS3h81vBzfP8eJyZTGWtLYPEWqDHL+WL2VGMerKypbR7acUB302EyWKH0/lCVcjZQ96Xitjqiz3Nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAv+voAQSwqoidArWmPpWQCgRIKJLorAf5Da6kB81VI=;
 b=HvW/ROaoPUOdjYoTUbbngG52+K1xC5/kbsVo29oWQgVnhy7ysm3uv7oO0Ay6wYVw86wMdzzR4CXNcDzydouxutjhpqlQv8Ljiya7dqglZSbmU+seR55IRGyNc3TaEInMFh1uiKnF1BhlZ6UE+UPHIjL3s6P5w2tBQowTOMbVzrr7AWF+Q6v0A4sGKmRyvg2i7K8Nj4cyp9Fs/1MCUSiUvli4iBffkwyr/FcazxSQYzWaOioVP4WUTrxBA1M795dOLizlzFbLoBuZa9p2p7X8AlKOdoZyqetXtE88VlHJ3nj0e8WUkpA+5yI2gvEroyQ1vO4Kv7ETXLp6b8PQ4RAiGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAv+voAQSwqoidArWmPpWQCgRIKJLorAf5Da6kB81VI=;
 b=BXsltLSGqJEJNf+ufo5E5oGQW38CyO3SFMOdLUe8vtzp/B782jcjM5IC9o0zuCHapzyNlzgy5IG5t+WUBWI5mdvmce39Ni2OyDFmBVp7C/WosazfuYYV1DsREs2XNrT9uGHtqXPbJ5YDoUJWuBNXYvUfg4hmRChyznlL2mn5gIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 19:01:15 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 19:01:15 +0000
Message-ID: <b2b60a42-53f1-4ee7-8361-2a07737e1bad@amd.com>
Date: Fri, 8 May 2026 14:01:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CPU running at fixed frequency (~1.7 GHz) with
 kernel 7.1-rc1
Content-Language: en-US
To: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Huang Rui <ray.huang@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>
References: <14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de>
 <f35244cb-1f17-42a9-9479-5eee196cae5e@amd.com>
 <f0b13b69-f5fa-4346-b1cd-dbae4a450c80@freenet.de>
 <fbfea6b5-eb13-484d-bf66-6fb1dee4d30d@amd.com>
 <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
 <dba72492-e96f-4fd8-9520-89fee242271f@amd.com>
 <dea2c864-bd47-4bc8-a46b-f061771c2b4d@freenet.de>
 <f4fd9018-2a05-454b-a887-9b1c9a8a14df@amd.com>
 <33a693a8-a460-49b7-83cb-1ab7b66ce69e@freenet.de>
 <46eaec7d-a359-40c8-9c5c-57ecc3506805@leemhuis.info>
 <8c39f42a-f024-4f05-8d77-a95e7ca1c702@amd.com>
 <b5882c89-aa71-4205-ab25-ca9f038340df@freenet.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b5882c89-aa71-4205-ab25-ca9f038340df@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::15) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cdf2ca-00ec-44cc-4275-08dead342dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KpVX5JwdvbgsfWCBvuwu17mUN59NUuxqDM5ToiD5xm0KsuhTptk6hlmZ2A/f29b4GirhVwJgnA86ou/4Oa7V5tM8ShnOoD1aAhAimrYFGXXASb6Hvfe3X4JpQJht8T6ACJGXl7hgTeiO9eBdurTDm9Nq+v8SbSpL28bwGwZYfkKhoTBToKsDJVT7UmRlB5gvCGC8REMutpRmPI5KjFq8Evu2FkiKjUvI9N42pezqTaIduwQF4tq309CmDs6Z4lgzogF6p+iUAwyvkEo6UoMrI73/kw5SigeHaL9AfJeYvy4Px/GliOXwpLXEiOUpzKLplNW1DgvdHOpwe/2OYPI2ZE01LaPjhxIX59ix6TYFEw5rJDiNxsWJeIiSkV93Iyfbbx9Q8ci8dEO5PIu6YNG6H1T4CQTu9JSRJ49GRUL7Cm6nIQgmTAPUy2be1JTdjc0otT8NknxfoBfn1f/nxOXmJVZLHC7gUuBXLWeiDLV7V/khgEQcR0EHXEfHcmPfrrbGMsptzD1sTY9RRe8kX1el1L/m8eJQPJNnX0F/nwwSZY28XxSQbr0UK6sbkjaMTm0UvER15s3V1EnZrJpIRWz9y9vmkQpipuOAWTO19d+4CzspxrWdmsWf4mDIVWCnLZ4/cNQHyCqZMrAmHAqoP6eUpLbUAwuaOAIA6DYgAROmRzL049jf0GR1nyXUDGDboB0a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCt1ZlEySjBZa1V5WVhUaXlVRytLSXRmUGZPZmplaUY5ajR6N01lcXZMd2dG?=
 =?utf-8?B?YVQ2dUZrODNGUndOMk9ud001RHo2NklDTGxseFd2R0RZV2Y4SUJ4N3FMSFZN?=
 =?utf-8?B?RVREeUsxQm5tL0RZc1FwUjJRaUJtK2t4OVlZV0Jzek15SEVsK0JkU2tKU2lY?=
 =?utf-8?B?dnYvZXROb0tudU81WXduSWZ1ZjYyWFQ1R1pETzZpbTRvbVU3TGxYRVVvbWlh?=
 =?utf-8?B?d01QNTkvQlBUM25JNkZjcWVQUHhGVEIwRVpJVnJVUzA0ZEVrS014SUh4Tm1V?=
 =?utf-8?B?Wm90d1Zub3B6OHdFVVpaaFFHWWN1a0xQRTk5dUp6cHV3NzY3SUFDazVSQ3kr?=
 =?utf-8?B?bUdxaWgzZFp2emlwZDloVWJrZ2NLaHhTU2hsaHBLL0ErV2hrbjArZ0piZVpB?=
 =?utf-8?B?dm5YcXlIakpmcE91UVlvVVNVRVlKb2tudFVqQjNqc0tNSkNsVE52emZIT0FB?=
 =?utf-8?B?VlpUZXpLZ0dOV0h3VHpUK1pGNzVrMDRjZ1hySW5oUDdmbmI4UU5WZFZSZGh0?=
 =?utf-8?B?Y3RVVDZadkdTeDRmV1lLZEpveDl3akhqWlRmWEZBZHhnZ0dUMjlxTnh1dzhB?=
 =?utf-8?B?SWdHdVB0RllHWmFpcVlON2NFVE1zTmE4VEYxZlV2ZU1jSU1QN2x0Y0RSUG5R?=
 =?utf-8?B?ZDFDK1pTbU9xVFhtSlFQRGlXaFI1bk0zYTF2R2V2ZEZFL1ZERlVjVTVUTzFr?=
 =?utf-8?B?eFpvN2xZNDg4Ym83NGlUd0YzZWphWnpHUVRLbnFsc0I2QjVhUitVL0Z4Qksw?=
 =?utf-8?B?SWR0RUUvaElFN2FCcS9TaU03OWw5VnZEdkxobFNzNEVFWjNXOEtqUjB0R01u?=
 =?utf-8?B?ZmVpVUxUL1Yvc1F5b1RPemRtemhpTHIrZnJ3TzJPWjVYZ2Z5UU5nY0cyaGZU?=
 =?utf-8?B?cU5laGpUem81eFJHSmVwS2pvbk5tTC8yNGFIbFhscjVnY0REUldnQUJwTmEr?=
 =?utf-8?B?ZHZwalJLYnhhYVczc1ZoVjg5czVWaWFnZllzanFQT1djTDN2elNYTG9TUnlm?=
 =?utf-8?B?T3NUVUZNYkN3ZWQwQzBCZWJuT1d2VGd5Z3NuM1BudDFtVHVwaWlCQjM1YVZ4?=
 =?utf-8?B?NXFabTVDdDBTWkpuQm9Qb01VRXl1YVdJaXZsQm85VUMxcklHbSt6SFpLdlla?=
 =?utf-8?B?YkFzMk9lNDNTQUpPcFhOeFpXeUxqSVhmZWFnVWM5OVZheUIrMTg4RXAxdXRK?=
 =?utf-8?B?dE9ZT0FUUmljeUFjRG5NelFqSnNFeVl6ZHNkS3ZyNUJJNmsyUmRuaGFnZS9K?=
 =?utf-8?B?azJUUGRidXNmTWtoK014bHhHem9oWnhQRndTdTgrekJCVjhZSXRqZDc3UXc3?=
 =?utf-8?B?M3YwbG9GUzRUVWZmL042RTlEejl4dTRXYWVoWFBuZDczQmI2WngreUFzNVRa?=
 =?utf-8?B?Wm13UkFOcEVGNUZKK3Y5MnJPV2Fvc0JMaWpTdlMwZG1JRktzeVlKVUg4ZlRR?=
 =?utf-8?B?cEdaMHNObHBxK3NQZUN1U3NnbHgzaGtKOU9iS0Y5bVJuUi9KV2Zma1g3NStC?=
 =?utf-8?B?QUdtejVpWGl2bHBkbGRuR1RoMGppK1dyZ2kwdHcvem9jVk1pODQxcWhtMS8w?=
 =?utf-8?B?YzJZZzFQV0JJQW5hWWR2TjRCMnh3cTZsVzF5cVo4RnF1WTVGL0x6dVl4Z1h5?=
 =?utf-8?B?NVh4aUU3M0ZWeVAxL3ZVb2dtMmU5TGJTTjc5S0lhcHRDb0d4MXV0aDBCaDls?=
 =?utf-8?B?RzM5WHdUTlp3MDFneGR2UVk5RWM1S2JxZ3F2bVRhTjE2V2ZKUS9aWVl5d25v?=
 =?utf-8?B?RENFaUtsQm16dE9RTEJaR2graEUvRE5MdGZvVlMwVWFPeDk3akdGL2JSNzJi?=
 =?utf-8?B?OWc1V1YyeTNtc001bWptSnJ3RDM3bE5mdmhZSE1jSUQxbUFRb2RxRGc3R2Jy?=
 =?utf-8?B?WVpLSkR4WUZhZ1NZdzBVbVBTc3psVXc0U2ZXZkRqTEtFR0RQQU1DYkIyMHdk?=
 =?utf-8?B?ODlYZ2g5NU80TmZFbkFnTkVwSUo2K0piaDM0bS8rL094T21UY0dYbEdkblcy?=
 =?utf-8?B?WXN0N1ZaY21iNFRWQnBJN2FVTU9Sdm9sZDM2U1gyS2VLSFdaaUlEV2ZQazAy?=
 =?utf-8?B?ZFIySENibUVVSmx5Tzl4UVE4Ukpib1hZL0RjL3RHZVBPTmM1MXowdHhaWWFT?=
 =?utf-8?B?R1ZpZ3J0VjliNUxxUjVPVTFGWWd6T2hpT1dUMEtpUklhQ2Jpa3YwZTlpN3BZ?=
 =?utf-8?B?N09ZeStlK0toWkpHK0d5R2V1S1hzVFlIZnNDZ2c0TkVzVTVQZGVGdEtIcmYz?=
 =?utf-8?B?YU9KTzhiVEtmOTdTRG5zOXN4OCtoOUlKSVZpNjRpQkllclNFdVhEbnVGVWVB?=
 =?utf-8?B?eXZXUGJlNmFPU0FWMktmVzg5MldST1NMeUVVd0xzclo5eHN4VlJzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cdf2ca-00ec-44cc-4275-08dead342dc4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 19:01:15.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfLqB17y4Hqb53L0aKqtJfb67j05RtgF3jNHytmnW3C+Ps9BoR6OHxZU09SOZw69S5XVi0tBFNhYSb2V0yLM6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059



On 5/8/26 13:56, Viktor Jägersküpper wrote:
> Am 08.05.26 um 14:57 schrieb Mario Limonciello:
>> On 5/8/26 04:31, Thorsten Leemhuis wrote:
>>>
>>> Side notes:
>>>
>>> * another report about an issue like this was filed here and contains a
>>> patch from Mario for testing:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=221473
>>
>> Yes please see if that helps.
>>
> 
> This patch doesn't fix the bug. I believe this makes sense if you look at the
> debugging output below, but that's just a guess.

OK.

> 
>>>
>>> * there is a whole patch series with fixes for the culprit:
>>> https://lore.kernel.org/all/20260508051748.10484-1-kprateek.nayak@amd.com/
>>>
>>
>> I don't think any of these will help; but that would a fine surprise if so.
>>
> 
> This patch series fixes the bug when I boot with "amd_dynamic_epp=disable" (I built
> the kernel with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y). I didn't bisect to find out
> which patch contains the partial fix, but I can do this if it helps.
> 
> If you need further information (acpidump and/or output from amd-pstate tool), just
> tell me.

When you have dynamic EPP enabled it sets up platform profile.  With 
that series in place does changing platform profile help?

> 
> Last week I got this output after applying a debugging patch from you:
>>> On 4/29/26 20:34, Viktor Jägersküpper wrote:
>>>> Am 29.04.26 um 19:14 schrieb Mario Limonciello:
>>>>>
>>>>> OK thanks.  Here is a debugging patch that should show what's happening in the new paths from e30ca6dd5345c5b8ba05f346a8e81105352fe571 so we can confirm root cause on your system.
>>>>
>>>> These are the dmesg lines concerning amd-pstate:
>>>> [    0.845044] amd_pstate: amd_pstate: CPU 0: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.845047] amd_pstate: amd_pstate: CPU 0: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.845059] amd_pstate: amd_pstate: CPU 0: platform_profile_register succeeded
>>>> [    0.845060] amd_pstate: amd_pstate: CPU 0: registering power supply notifier
>>>> [    0.849046] amd_pstate: amd_pstate: CPU 1: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.849047] amd_pstate: amd_pstate: CPU 1: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.849058] amd_pstate: amd_pstate: CPU 1: platform_profile_register succeeded
>>>> [    0.849059] amd_pstate: amd_pstate: CPU 1: registering power supply notifier
>>>> [    0.853043] amd_pstate: amd_pstate: CPU 2: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.853044] amd_pstate: amd_pstate: CPU 2: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.853054] amd_pstate: amd_pstate: CPU 2: platform_profile_register succeeded
>>>> [    0.853054] amd_pstate: amd_pstate: CPU 2: registering power supply notifier
>>>> [    0.857043] amd_pstate: amd_pstate: CPU 3: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.857044] amd_pstate: amd_pstate: CPU 3: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.857054] amd_pstate: amd_pstate: CPU 3: platform_profile_register succeeded
>>>> [    0.857054] amd_pstate: amd_pstate: CPU 3: registering power supply notifier
>>>> [    0.861045] amd_pstate: amd_pstate: CPU 4: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.861046] amd_pstate: amd_pstate: CPU 4: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.861056] amd_pstate: amd_pstate: CPU 4: platform_profile_register succeeded
>>>> [    0.861057] amd_pstate: amd_pstate: CPU 4: registering power supply notifier
>>>> [    0.865044] amd_pstate: amd_pstate: CPU 5: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.865046] amd_pstate: amd_pstate: CPU 5: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.865057] amd_pstate: amd_pstate: CPU 5: platform_profile_register succeeded
>>>> [    0.865058] amd_pstate: amd_pstate: CPU 5: registering power supply notifier
>>>> [    0.870044] amd_pstate: amd_pstate: CPU 6: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.870046] amd_pstate: amd_pstate: CPU 6: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.870058] amd_pstate: amd_pstate: CPU 6: platform_profile_register succeeded
>>>> [    0.870058] amd_pstate: amd_pstate: CPU 6: registering power supply notifier
>>>> [    0.874044] amd_pstate: amd_pstate: CPU 7: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.874045] amd_pstate: amd_pstate: CPU 7: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.874056] amd_pstate: amd_pstate: CPU 7: platform_profile_register succeeded
>>>> [    0.874057] amd_pstate: amd_pstate: CPU 7: registering power supply notifier
>>>> [    0.878045] amd_pstate: amd_pstate: CPU 8: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.878046] amd_pstate: amd_pstate: CPU 8: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.878055] amd_pstate: amd_pstate: CPU 8: platform_profile_register succeeded
>>>> [    0.878056] amd_pstate: amd_pstate: CPU 8: registering power supply notifier
>>>> [    0.882045] amd_pstate: amd_pstate: CPU 9: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.882046] amd_pstate: amd_pstate: CPU 9: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.882055] amd_pstate: amd_pstate: CPU 9: platform_profile_register succeeded
>>>> [    0.882056] amd_pstate: amd_pstate: CPU 9: registering power supply notifier
>>>> [    0.886045] amd_pstate: amd_pstate: CPU 10: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.886046] amd_pstate: amd_pstate: CPU 10: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.886055] amd_pstate: amd_pstate: CPU 10: platform_profile_register succeeded
>>>> [    0.886056] amd_pstate: amd_pstate: CPU 10: registering power supply notifier
>>>> [    0.890045] amd_pstate: amd_pstate: CPU 11: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.890046] amd_pstate: amd_pstate: CPU 11: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.890056] amd_pstate: amd_pstate: CPU 11: platform_profile_register succeeded
>>>> [    0.890056] amd_pstate: amd_pstate: CPU 11: registering power supply notifier
>>>> [    0.894046] amd_pstate: amd_pstate: CPU 12: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.894047] amd_pstate: amd_pstate: CPU 12: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.894056] amd_pstate: amd_pstate: CPU 12: platform_profile_register succeeded
>>>> [    0.894057] amd_pstate: amd_pstate: CPU 12: registering power supply notifier
>>>> [    0.898046] amd_pstate: amd_pstate: CPU 13: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.898047] amd_pstate: amd_pstate: CPU 13: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.898055] amd_pstate: amd_pstate: CPU 13: platform_profile_register succeeded
>>>> [    0.898056] amd_pstate: amd_pstate: CPU 13: registering power supply notifier
>>>> [    0.902046] amd_pstate: amd_pstate: CPU 14: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.902048] amd_pstate: amd_pstate: CPU 14: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.902059] amd_pstate: amd_pstate: CPU 14: platform_profile_register succeeded
>>>> [    0.902059] amd_pstate: amd_pstate: CPU 14: registering power supply notifier
>>>> [    0.906046] amd_pstate: amd_pstate: CPU 15: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.906048] amd_pstate: amd_pstate: CPU 15: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.906060] amd_pstate: amd_pstate: CPU 15: platform_profile_register succeeded
>>>> [    0.906060] amd_pstate: amd_pstate: CPU 15: registering power supply notifier
>>>> [    0.910046] amd_pstate: amd_pstate: CPU 16: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.910048] amd_pstate: amd_pstate: CPU 16: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.910058] amd_pstate: amd_pstate: CPU 16: platform_profile_register succeeded
>>>> [    0.910059] amd_pstate: amd_pstate: CPU 16: registering power supply notifier
>>>> [    0.914047] amd_pstate: amd_pstate: CPU 17: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.914048] amd_pstate: amd_pstate: CPU 17: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.914059] amd_pstate: amd_pstate: CPU 17: platform_profile_register succeeded
>>>> [    0.914060] amd_pstate: amd_pstate: CPU 17: registering power supply notifier
>>>> [    0.918049] amd_pstate: amd_pstate: CPU 18: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.918051] amd_pstate: amd_pstate: CPU 18: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.918081] amd_pstate: amd_pstate: CPU 18: platform_profile_register succeeded
>>>> [    0.918082] amd_pstate: amd_pstate: CPU 18: registering power supply notifier
>>>> [    0.922049] amd_pstate: amd_pstate: CPU 19: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.922051] amd_pstate: amd_pstate: CPU 19: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.922070] amd_pstate: amd_pstate: CPU 19: platform_profile_register succeeded
>>>> [    0.922071] amd_pstate: amd_pstate: CPU 19: registering power supply notifier
>>>> [    0.926049] amd_pstate: amd_pstate: CPU 20: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.926052] amd_pstate: amd_pstate: CPU 20: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.926073] amd_pstate: amd_pstate: CPU 20: platform_profile_register succeeded
>>>> [    0.926074] amd_pstate: amd_pstate: CPU 20: registering power supply notifier
>>>> [    0.930049] amd_pstate: amd_pstate: CPU 21: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.930052] amd_pstate: amd_pstate: CPU 21: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.930071] amd_pstate: amd_pstate: CPU 21: platform_profile_register succeeded
>>>> [    0.930072] amd_pstate: amd_pstate: CPU 21: registering power supply notifier
>>>> [    0.934050] amd_pstate: amd_pstate: CPU 22: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.934052] amd_pstate: amd_pstate: CPU 22: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.934072] amd_pstate: amd_pstate: CPU 22: platform_profile_register succeeded
>>>> [    0.934073] amd_pstate: amd_pstate: CPU 22: registering power supply notifier
>>>> [    0.938050] amd_pstate: amd_pstate: CPU 23: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>> [    0.938052] amd_pstate: amd_pstate: CPU 23: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>> [    0.938073] amd_pstate: amd_pstate: CPU 23: platform_profile_register succeeded
>>>> [    0.938074] amd_pstate: amd_pstate: CPU 23: registering power supply notifier
>>>>
>>>>
>>>
>>
> 

