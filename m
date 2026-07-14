Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659528B7DA;
	Tue, 14 Jul 2026 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049392; cv=fail; b=gMr/5S54TRK6BwBLH6BdQsWuiTsyees8jm4YEepTiSr/rjVle//cB7Tx4Yy4N1dn+nENnWDI8ZIT6iDUV0217nXOgjOhfz4nU9wEdPFAhkiB84tsjxZz3QY6CTJprCqX6WFeyBNxfkCkylMbJjAdaDJmUxFjitpK19uiZ36r4Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049392; c=relaxed/simple;
	bh=KO/ZAYrSDEVx3MA4EcwUM+2uE1F8jOedbM0bDiPEYPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gVt7MJ0O4J5tBexjJqehoXU75/WfCWaP45YylcRqH50cZtB+pOhv4pKuCT8LdqZOc5qr63RNFiO2lqdMmYzz5IzNOKCh1ER0BWFcWE1E5Uy91WZ6BF0NKYeE0V8RoowYKhAXJ7u7H3t2tFGbfzutteKbfOmJlgqEhCHj00O0JZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A/8PXHqj; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A/8PXHqj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2YkMJqsapDf4a8BAEvlVBC1AA8en2LZ+aPephczwDTXEQl1R827AOB4RzHB5z4BXNUeZRA46XFOEDRsCyS5ONld3VN6jjS5CgpN6SpzNdSlDlCPEebc+zfvQD0tT6eLjcSCxixtbd7FCzwV4PKPHptF2CoK5ZzZXHCvdqxQo1Spr9BQea9vVqGbozMHHfkLGIfnHeLNmZ++tsvIweHhVwpIV7W2Or8+hrh+jPNRsJLPC8zrB4besnSF4Wf3nsE73wPpvmD64Uw2tQvbNkjKLe4upqt9beJajnLr3hV906zSKITjhUaJSWvUcfmm7UAAOP6KgkMBCSkzJkn6tkAWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdKrSFJerivh5pNmw/O3vckJ12a2Ao1GJWf4/XyRAko=;
 b=KuUvNNXYq8ogPpSEswyeulraz0v0CNS3LDGpP6pIQh31B2oAB/6lu5uSPmazqVkxPOsXrlEzv3sZOQsuSW1dt4hcX1Dj/Y1Q6J0Je7VxmH6wtUMbKmCD//75yNwbsOJW4aKs6sQzaIeCS3325PkoYKFIxM2rKD39U14Z213G0gknM0WgIJJn1bcqyvj+7n7ZdVj9GHprRt88l8+RT6r5be6Fz5uJ5eYIunVnFu0yo1afsFRpgd8fmJPyxm6MoYggbKEOt3H2l/rTbnoo5olCMAXE219sA+/L7m9pIH8meEbYxON8vW3fuw+P3Ptk1B8K4SuPJfBSxR4D7O06IWdVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdKrSFJerivh5pNmw/O3vckJ12a2Ao1GJWf4/XyRAko=;
 b=A/8PXHqjqLO7tN/KN8ghhCvgnt/GvTLvJ/kmUHEHjXb/mJ4VNkAeELrq8KBQWllFXA3ukmb8kpkL3ksMXNuW9q/LwHRzm1nt6AtUmSWVtfdELl4wc5keSlfhc13LO4ZDr7B+1RVcSOZSkQkYa3QZh3hW60gQu98O9hIMIOoraTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 17:16:23 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 17:16:23 +0000
Message-ID: <29f28cb8-fa48-4ccf-b0ee-2b707f122565@amd.com>
Date: Tue, 14 Jul 2026 12:16:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate-ut: fix null pointer dereference
Content-Language: en-US
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Qianheng Peng <pengqh1@chinatelecom.cn>, kprateek.nayak@amd.com
Cc: li.meng@amd.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 skhan@linuxfoundation.org, viresh.kumar@linaro.org,
 wangxb12@chinatelecom.cn, xiongl24@chinatelecom.cn, zhangar@chinatelecom.cn
References: <b2835252-409f-4188-aea7-195be3c4e69a@amd.com>
 <1784024553-16448-1-git-send-email-pengqh1@chinatelecom.cn>
 <21f0957d-a8de-4262-a353-0e19fdac5481@oss.qualcomm.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <21f0957d-a8de-4262-a353-0e19fdac5481@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a14adc-32fe-432a-7dfc-08dee1cba133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	wkhcDWiJSGmqmtX+RRQ5wSXlG/EAER6aILPpBtJnRGT4NONKy5SI8T3aDOtSX5a+odW9G4bjd0w82WFJUNh0kZqGqKx/RVCWoJfgsaXp9wwyt/6thNj+lzQM9riGfp2UoPZ1wFC9E72FFCa+EMesGcT+gouRa8HRh+CvgfyzJGbhWUrtn/jnyQKAXVCdZVkSGA6msjxu1Voz8o0LoUbh/L8ShUljx99bKWvRKbtFQusOa9hDqn5ERcdkycfGpaCmmnARANS9jyZxUvfCDBz5+rPs8dU4+ZFTKFIteGD+SlmNDv1ZATnVSFKvbm0F2M3BuyhAUhyYNn+qq1mrcRN18ko+tJSyOXr9yUvSBt9hs6CgZHSqTfmCo3qIYfWKE928FcnQYHgbLNNZ5/ZKyieQIjGZhEt9PZaY6OAab4SrA6U5cyyNuei69QswZFMIEFeCfGs0Em26v1TEZAHqDS2/NRj79/VxJtp2jZyo1ZbRTBT98z91LI1HYlSbzekGJPLidrX5JNkOZydQxMgRM3k0ZqIKKwOWsJv7bYh4zmXW5mtTIMUGdcwjP7+QILj1wtnYC9nDJN/OaEf2rxAIF4J3t0y5MJ/+fiyN8v7hkGAAYqoDWZnQgP+CJAkqnjA9hfWIb1ManfJ69GNt3FErWq6zwWb0MjIedDQ2jd4YzRMth7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZ1ZG9qTHUxaFRkZFA0eTZ6bWNxRnVzczlrWXpSR1I1NWUzd1ZCcCtCNExH?=
 =?utf-8?B?NklQeW1YSEREaVhLWVZodGtYNG5Ld2cyYWIzeW1tc3JWajFnUEFUUk1lVUZu?=
 =?utf-8?B?R2g0VUNJOFRzY3pOU25sSjFrSXgwZG9XZXkyRkoydGtqU1FDNXJsUlQwemxH?=
 =?utf-8?B?ditxVW81OGJodGxkQ0JibElpTnV0eEZYcVkrM1I2blFEL3E0Z3pKU2JNc1Vu?=
 =?utf-8?B?NzNsUzZLWmFjQUhBekVkckpDSGQ4Z0F1TmRuNlZxQ25oUlpYdGcxTTlNc0Ju?=
 =?utf-8?B?OW02T0RYSnVob01lcG5VeERpTTNDc2ZWbGlDZVNaazdzak5iUU5lRmZHYmpP?=
 =?utf-8?B?QnRMZFhvaGUxQXRRMlNQYWtNbHVFbWFBeXNZUi9uNXdRVTE0N1JNV1Y2N2hX?=
 =?utf-8?B?V0RLWDliclRHVkJUM3FudXhJMkFyeGovMitCNEs1ZGR4bzVBSFNTcG40MmJ5?=
 =?utf-8?B?azZKTkZ1a1FyUy84RGN6aFpEVFdicFF6TXlDdFVrT3habG4xdXJVTkY4QXAz?=
 =?utf-8?B?K3JVd1RTektVbTJlc3Vhb28rZlBaRlUrR3VaZHp3VGxUckFiNW11cWs4dzhJ?=
 =?utf-8?B?b04vY0FLM05sOWo4MHhBdXMxdkxtNmFjeHNXeHl2ZXhzNzI2NkZrR1NZK1Jx?=
 =?utf-8?B?RUJhcExMaWNoNExNM2lYdS9DazhFZ0c2T1lxNXo2TnZodkpEQStjdFgvNUJF?=
 =?utf-8?B?Zmp2bmNuRHhUeWdTR3JJM3BPUkMxT2ticzk4VXdUL1pLYmtIWEV2TzhOOGo2?=
 =?utf-8?B?bzlpNXZNZ1FBUy85dnhpUWNzUEd2NTZ2bHdBeDU0ZlZxRTZzVkk2NnRRd3l4?=
 =?utf-8?B?dzdBUzlqRTIwdHhzSXFYU01jUnhzMHMzRFpIaXpFbE1LcGIwZTBCZE9IWmNR?=
 =?utf-8?B?TXh1MWtlS0t1NWJoWTFzVHlmb1Aya0xadTdUcFc1Yi85Rm1GWGNHREQzK04r?=
 =?utf-8?B?Z2lnWXcvRXNUNjVFdUdQeVRSNzRWVVdpRXBWTUtyUGd5ZWhnT2x2eVdiSXk2?=
 =?utf-8?B?MlRLeG1hV0ZTVVVRMlV1dTlUMTFqbDRLWUtraTZ0U2dEaERac0YwdVpTdHdP?=
 =?utf-8?B?YVJ5WjRxRkhrN1VKMUpacTdrK2g1Ry9lckdUL3RTMHBZWGhUNVJyOU9ncENm?=
 =?utf-8?B?VzNhWDc4d0tYeTZiek5kNVMyRXY0TXJJUTF1SFA1TG5wOVJaSUhCR1RwNjgz?=
 =?utf-8?B?T0VCL0pack5xRDEyU1ZoTzMzcEFnWVUrTWlqK2MrRFpYRjRrZ0o0aFkrM01Z?=
 =?utf-8?B?ekN6NUx0SnU3Ukh0Vk1pbXVMUlVmNmhWN01PRFdTNnFwQ0pTeXRBS2ZZdTU1?=
 =?utf-8?B?bDQrSUtBcGtVZWZVYmNBQmhBcXFYc0w2dEgzOXY5aGxaY3Uxb2czdUxFWmVL?=
 =?utf-8?B?M2pDMkdnb0dHMzZhZzh3TVAyQk5xYytpYVFWdmIvRVpZYVk2WDg0S2NQTUJI?=
 =?utf-8?B?cVczN3RxSGVTTmh3ZkVwWWFxa1B3OFllcERwbURYK0Q1R0E4dmFiT0hRTjNu?=
 =?utf-8?B?ZGZ1YThnbDhleTA5eVA2SFdmQ1I0TEV4ZUE0N0E0SkRESWlIWWtSeWt5a0ZY?=
 =?utf-8?B?SDdqR2J6aDBZSm4xMTBWSVZwZkhNQ1RGVU4xNmpIVGhNVXAwejdkSVdrdTRQ?=
 =?utf-8?B?bDdjMm9RbjFUVlR4dXNvZ3hxSS9vaVdTdHdwUU5tRGNHRm1RMnlLSFQ1R3Qw?=
 =?utf-8?B?cE5lUGhndFVQMDZqbG5iNkxOOXZmZmRuTEJvdEQ5N3NETVVhZXRsNHRaK0pq?=
 =?utf-8?B?a0IzR1UzL205dU85ZHp1cWU2WThBSDJnMmduc3NmN3FoUHozT2dpa25xYkh3?=
 =?utf-8?B?cW5ITEJSWlp6WHpsSlAyMlRYQUVBYngxaUhoYWRFTWNUT2w0Y1pqbFZHMlZ4?=
 =?utf-8?B?Y0N3b2FqcGJBSGlpbWtVckZDQ3cxV1NVYjVOUXZzSnFuWllkS1FVQWpNUURF?=
 =?utf-8?B?eVQ2U2ZXMUtJZDg5UFZJamhjRmxZWi8zd1VyV24ycWI1VmNWV0hkZjRhQU85?=
 =?utf-8?B?WXNrWWEzVTFPaUNLcUpKNU85NEl0MjBwdjREaVVzTWkzNlNudnNLbENRWFlX?=
 =?utf-8?B?TkZQM1pRWnVWa0Jrc1JjcmkyTThQaWxKUlUyN2JCUGZlZ1dRWHJ2aEhTaW1H?=
 =?utf-8?B?ZXFpNExiS2xXREt6VGVRd01YdWUxbmMybHJ6cGw5YWkzRk5zTStjMnBXSDc1?=
 =?utf-8?B?NUNia3JIY01PMVZydmoyVEIreEhxQkY2SlhMOFBibGFGR3hKaVpMWlVnZU5q?=
 =?utf-8?B?djdDb1cvVGxQcDl5d0pXYTc3cExERTQ1Yk9rMm1hU1h4UWtYbnBBM0JyWjVr?=
 =?utf-8?Q?jYv89EIBHJwfIB2Yab?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a14adc-32fe-432a-7dfc-08dee1cba133
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 17:16:23.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE02iIPsn3VGSD8Td0Gm/QGU25QJ4X+5c4E74a6K7atnHVAz+6gvGyy5boJQsmkMmlwLbMJoawQMA8xm3kCxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937



On 7/14/26 06:08, Zhongqiu Han wrote:
> Hi Qianheng,
> 
> On 7/14/2026 6:22 PM, Qianheng Peng wrote:
>> Hello K Prateek,
>> Thanks for questions.
>>
>> On 7/14/2026 14:39, K Prateek Nayak wrote:
>>> On 7/14/2026 1:29 PM, Qianheng Peng wrote:
>>>> The crash issue may occur when insmod amd_pstate_ut modules.
>>>>
>>>>     amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
>>>>     amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
>>>>     BUG: kernel NULL pointer dereference, address: 0000000000000080
>>>>     #PF: supervisor read access in kernel mode
>>>>     #PF: error_code(0x0000) - not-present page
>>>>     PGD 0 P4D 0
>>>>     Oops: 0000 [#1] SMP NOPTI
>>>>     CPU: 0 PID: 20300 Comm: modprobe
>>>>     Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
>>>>     Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020
>>>
>>> Is this an AMD platform?
>> No, it's Intel(R) Xeon(R) Gold 5128.
>>
>>>>     RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
>>>>     Call Trace:
>>>>      <TASK>
>>>>      amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
>>>>      ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
>>>>      do_one_initcall+0x42/0x2e0
>>>>      ? kmalloc_trace+0x26/0x90
>>>>      do_init_module+0x60/0x240
>>>>      __se_sys_init_module+0x185/0x1c0
>>>>      do_syscall_64+0x62/0x190
>>>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>      </TASK>
>>>>
>>>> Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
>>>> amd_pstate_ut_check_freq() to avoid unpredicated null pointer 
>>>> dereference.
>>>>
>>>> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd- 
>>>> pstate driver")
>>>> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
>>>> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
>>>> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
>>>> ---
>>>>   drivers/cpufreq/amd-pstate-ut.c | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd- 
>>>> pstate-ut.c
>>>> index 735b29f..3b24260 100644
>>>> --- a/drivers/cpufreq/amd-pstate-ut.c
>>>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>>>> @@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>>>>                  if (!policy)
>>>>                          continue;
>>>>                  cpudata = policy->driver_data;
>>>> +               if (!cpudata) {
>>>> +                       pr_err("%s driver_data of %s is empty!\n", 
>>>> __func__, policy->kobj.name);
>>>> +                       return -EINVAL;
>>>> +               }
>>>>
>>>>                  if (get_shared_mem()) {
>>>>                          ret = cppc_get_perf_caps(cpu, &cppc_perf);
>>>> @@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
>>>>                  if (!policy)
>>>>                          continue;
>>>>                  cpudata = policy->driver_data;
>>>> +               if (!cpudata) {
>>>> +                       pr_err("%s driver_data of %s is empty!\n", 
>>>> __func__, policy->kobj.name);
>>>> +                       return -EINVAL;
>>>> +               }
>>>
>>> The only time I think this can happen is when the amd-pstate-ut races 
>>> with a
>>> the amd_pstate.*_cpu_exit() (probably as a result of concurrent mode 
>>> switch)
>>> or if you are running this without running amd-pstate as the cpufreq 
>>> driver
>>> (which the ut doesn't check for beforehand)
>>>
>>> My setup fails at this exact same point when I have the driver unloaded.
>>> What is the output of following before you run into this issue:
>>>
>>>     cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>>>     cat /sys/devices/system/cpu/amd_pstate/status
>>>
>>> Are you doing any concurrent hotplug / mode switch?
>>>
>>>>
>>>>                  if (!((policy->cpuinfo.max_freq >= cpudata- 
>>>> >nominal_freq) &&
>>>>                          (cpudata->nominal_freq > cpudata- 
>>>> >lowest_nonlinear_freq) &&
>> In this machine, I got output as follow:
>> ======================================================================================
>> [root@ ~]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>> intel_cpufreq
>> [root@ ~]# cat /sys/devices/system/cpu/amd_pstate/status
>> cat: /sys/devices/system/cpu/amd_pstate/status: No such file or 
>> directory (os error 2)
>> ======================================================================================
>> Otherwise,I didn't do any concurrent hotplug / mode switch, just 
>> modprobe amd_pstate_ut.
>>
> 
> It may be worth adding driver name detection to this ut driver, for
> example via cpufreq_get_current_driver().
> 
> 

Yeah I agree with this direction.

