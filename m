Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F33E5A19;
	Wed,  7 Oct 2026 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397968; cv=fail; b=U10eFL+QvJ1knQ1Zhx+Y6cox2bk6E7srx2L/17ocscOGH0U3TWmlbe+mNSa42xoxAMNvUmXBO4wRSSnlwhE5CmSLg9WzKJ8MoZIpkxSg1rMBLiPl17m+q43bxIOMDv7JsUpRQIuj28yb47KzLNNcGX8bYb5bO5el8xVHOpaufB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397968; c=relaxed/simple;
	bh=UsxShJG8GX5rIVxbjw4VGzXI8DL1r2edZJag1otS+Zo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WCZvu9oZHZ6liXcvQgZzvV3Fv/x1uJZyaqe7EUNBic8AQ+TJpCUBrsmxcckkycfeYV/5X6algg5/3viJs/skkNKyAGb53Fit/QZrirZR3JQuWl5LZj6ujgGW3f+YDwgnaOdBB6WMWQ8RflEoDTQyrjnPQAxIj5HSbV+LWDjR2pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1HnZiVjC; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1HnZiVjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nuj9aZlsqTnVxdqGLDf+bwkKOcH3AYC5U9jw7/X4C/nOV2elYKtLR9yYsGtIrLwg7OLoc9c8whXxF5VFOLc3X4ULaI6ukTl/8GGAAZjexnFTIzSNP2aCmvTkD5Jm3BS3UY2udsRDqZV0IkTa/9S2omZkep7na5WnekdgCjYF7x33wpIDLYnR/jS/i4ChjwPIP2bUS6Yb15TRQntrPLYBvdy4NFriLEntPsg2axkxAa2+18jXUmJrhGdFM9ZxfrLnHmDiF0hGm4TbHLhR9uFIRpCAqz1F5/kl34i2KNW80Rl/MUygTVkFn3QzriapK9ksCAhGZ0dYs2HDNqpOvSyIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkA9T/Si53poZgp9TTESH+cIWfnYKO0d+nozAKbKG1k=;
 b=y4LYR6jDw4EKEu4j8S2EV+owgHHXEz4HLA5YVJ3zGc1jVVpUlNmQ1IyL6dQuHZbIKrIcjU3YeG2U9UmhyLQmxovU7m3szNyClbK5+dmmx6+fwYzOdZWUg50NKJ7dm9iLunJh8otREcqqAKyr0vAwztVYMtqAxWsLIcWoRYrJx5kd0mKKa4dCR2RH4BIOjjdksyx1c1rKAtnz0EKVgr8I94aas87NZ6Ipi7aSBoQy62jQT941NBL7JB2HRLfXL5+o4jKbePACJPWuBd38cBuiovgNeG2MBtyQyjWt0YmFcB0KDDTvDof+NzQHpGZcIbpsGmyTkpni/ZOdQg+uugmXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkA9T/Si53poZgp9TTESH+cIWfnYKO0d+nozAKbKG1k=;
 b=1HnZiVjCs56ZGnI1R5Mwyd/yaIVL6lWUuBk15CbRcg8YPUbfaie/ZaJC2raCf/5a8Nj5UxyfdbNqPesomMQQ4kknMCKtBlF2TCUqCIB/cIiL7VCLSBEt/OIhP92KBCAicxcnYdQZ+vEYjwyIpS14VRTusY1sm91NGCMHnYfcgGI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::994) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 18:32:41 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 18:32:38 +0000
Message-ID: <c9c92c6e-4f2b-48c3-a2da-d3f3ed320b20@amd.com>
Date: Wed, 7 Oct 2026 13:32:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for
 TRX40-based motherboards
Content-Language: en-US
To: Kyle Gospodnetich <me@kylegospodneti.ch>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007144150.15113-1-ggherdovich@suse.cz>
 <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
 <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch>
 <a387ee24-ef09-4983-865c-47ef43fa0964@amd.com>
 <N6r-1w2v2oSkh5ABRHMoj9_YQ7F7eICWqD2rdyL7M1SmbVzhiK0plLXBCzZbDmO8M6w28qHy--pue6kfl1k8B-j03x5f6VYC2DlQ_spmIpc=@kylegospodneti.ch>
 <DC1J2LrrQ6hdyQJ_ThQRfGrnzKLI5qCCQYGA5I2LhASN8j8MLcpfvJ2T4Qn_8xmO2TB4MW9Sl6LyQKkuANWwowWXafKbEqJ8pXEBEnmE2yA=@kylegospodneti.ch>
 <1c6ba221-a73c-4793-aac6-b38d6e573295@amd.com>
 <bK7n7j4SGpNNcHzUh7I63T_Ozbd5u6wVHdVlpa3Ym76UQs2PhQDtaREPYuFsHMKZku0B9v2-d8A9PdeBRx_0l0xUZ9gt--wxwyI4-sTKfyM=@kylegospodneti.ch>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <bK7n7j4SGpNNcHzUh7I63T_Ozbd5u6wVHdVlpa3Ym76UQs2PhQDtaREPYuFsHMKZku0B9v2-d8A9PdeBRx_0l0xUZ9gt--wxwyI4-sTKfyM=@kylegospodneti.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0767.namprd03.prod.outlook.com
 (2603:10b6:408:13a::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfdb832-1838-4da8-250c-08df24a15d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	v1boiZBbq3naYk/utLcxQhONTJOeE7njfeDX8PEaFlzh/FGchFk2ZhETArn0W9jSb9DfCg+zZXFWrddTWogGiQWkhd/BCBJcMc0Q4ectya0E2jBhcs0+v8jlklEL/ijPwvF4UkJ+AAMd/gxgSrnPq+akhARDHqGLZfqIE8l55S8zyw8+TRhj2E9HmG8iojgebRW5qh+7micctyKcNlxQakrNLsasSi4ocx+30ny4kD5lJ8/lZsNiytVLQZ/w/1r8/fRrb4rDsgMV3WoxyaVdgH7Pqe3HsUl2vDr7nbR91PxBaPbSAtDO8NYmg/KodvQehRmQLuiGWd1F/zzJ4adFMnmAOY2uLc0xUvQgiLQexuK/yC0u8TnwH8xBkNEQzfGfSB4O/ZbVwC95p2b/ufYkW/22qibfTQdt+M8vH9vcXu/RkwuBIvv49s5qI9i9YoZvzjteLHMwsyhJSDZ7EYhkaLIhUMuRAwFE/N6Bf/8lmWAoqE0nAw7vm+85p3xsPY40p1arJxUcNsjm6Ency9xxU+HEOyxdjc40d2BbkOHgiS8SE3jjdpeC6XxDiAmUh6yVM/Rq+thjcbeN8GOPAOP3kh2PoOTmr5iihPVpM12NhFajeBrr+BOtbMSXya2nJWfBr2eM7S82EAJC0+reWHoAebbCZd5zohNS2mDWJfYHnSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEgyZ1piTU95YitwdlkwaTg1U3RSZlUyaTFEUFJVT3lqT291VkVwa3IwWVQz?=
 =?utf-8?B?OWxjWEJINnQ0YnJveUt2bnI5bGR5dGMwUDNrNHJkeHVJUzVmdU1majl4SXJJ?=
 =?utf-8?B?SFZUTDh6WHVqaDFkVVBheXhRa1pURzlCOEVEbTBVNUh1bFpkUFkweHpCbUhX?=
 =?utf-8?B?bmVMT2VZMXByRHJKNzRHcEg5WEY4bFdNbktFUGNOU0hkY0ZoWDE1K29Idlo2?=
 =?utf-8?B?Y21wZ1l0ZmR2aUFUcmhkZzF5TzhNVUdib0RGSU9RcWJ1Mmw4b2FFeXR1Qjhk?=
 =?utf-8?B?K1greGdUQkZTaFJoSEFtZG5jUmM3NWt5ZE5lMjl5TVMvMXFLZlpqeEppVFhj?=
 =?utf-8?B?Q2tvZ2xIbU10TUFkQWYzWnN5MEcrU1dmUm5GcHpTclVlekhENmxZR0VrcVhN?=
 =?utf-8?B?RkN0Wm1MSHRqeE1hS1NLWDlCTnhUY2kvL25rMGViUUh0bFdJY1N5SDRHRHgy?=
 =?utf-8?B?b3BiZmU3OGJaOXNIUVdwdldRSW85UkdaUDFhV1JWVlk0WHFacGJzTEc3alQw?=
 =?utf-8?B?ZWdsa0pBVmR2YUhHUUNkUzJIdXM0dUVIRnE1cTE2Q2d2QjVWQ2hJZnEybW13?=
 =?utf-8?B?cjFVNitONGRkSlA5VDR0M2NCZlNINHlCc0hMTDBtRHZVRWw2VDRoQ3owU3Qw?=
 =?utf-8?B?OFVOZVQxbks2aXdHalhjempHZTRQUmhKL2ROU3hnY3hQK3N6eWxaNHNValRm?=
 =?utf-8?B?UUFtblJ5eGNTRzd3T0F2THF1R210UEVvcTVlcnJZTXB2Zkc0OGVYLzNLM1Fu?=
 =?utf-8?B?SlZkdTJCR3JGNFcwRkJLR0t6TW81bElPMjBGR1hsandSNzNvM0x6ODV5bXNV?=
 =?utf-8?B?ZWxoTGt1MGZTb3I1TU5iR202d004MG5KeGJGcWtmcUtMSjBzak5BWHQvVUtq?=
 =?utf-8?B?UXM4WURYaUhOQTJIZlVVa2s4UFZUQjNBZE5QL3cveHdCeXllYVBjUW5QOXU4?=
 =?utf-8?B?ckhQY21uSGozSkVmRVp6V01WYkhyYUo3QXJrNGo5NU9JR0U1QzFkRXFkUzJr?=
 =?utf-8?B?VEs5eFBmNXFFRnVDdGVHeCtwNmtOQ1hIa0FnWkJic2MwTUJqNHVENXIydDZH?=
 =?utf-8?B?Zzd4WHd1RThISTlBRkxtUk9FZ2tUV2VuZkVjS0hSd2EwZmdibTA3WFNCdkJ4?=
 =?utf-8?B?bDJOMDJwYU51eGdLcXZ5MUFuWHVyczRoWHlFRUN1RWp0Q1UzU29wVUZNcTlt?=
 =?utf-8?B?WGVoeldHRmsyVHdab09iUDVOVnA5VFZGTmk4WlBkQk0xU2ZZR3hHcThZdGRN?=
 =?utf-8?B?L1B3OWFCN3ovbFRqSFZBaVJOVDZPSGdDczNvcFlFR082MStNcS9zZWIxZi9u?=
 =?utf-8?B?V1FwUTk1ZHFQSzg1NHdNRlp2NlZIQTJUVThaei9wM3NJWEhza0laanlvRExR?=
 =?utf-8?B?NW1PMDRzcGh2K09zWFBTZ1M1QnpSU3M5RkFlemdQQkk4bzNCZTdNRGZrbUJI?=
 =?utf-8?B?Qkl4bUFEMUhNY09rVXVqVHltbHI5YVZ4VzU4WEN4bTN6cGVlbzRhcWozV1pw?=
 =?utf-8?B?MmYwbmtWSlhVQi95QWloeTZuZVQ5TURqYVpyaFF2ODRKd3Z6TEtDS2dMMVlE?=
 =?utf-8?B?bXhETksvQjlvYjFXa1Flcm5XSE1oVjRONGIxbEVNRXFkaTBWNk9UczQ3c2ll?=
 =?utf-8?B?M09vVGxOcWhPakJkdkpZZC9mTWZ5Rk1rRXdBcWFoME83WU5HWHd5eEJ5T1Fj?=
 =?utf-8?B?Si90Ky9UZTRqRW1jZnVpZEVXUEtCVElVVDZFdnVlKzdBRlg5T3Z1R0x6amZ4?=
 =?utf-8?B?ZGFudVh6eW9UVlVQNVBrY3cwUjU1ZlptWWZYbmxOQ0VrRlUyRVgzL2dxWFJi?=
 =?utf-8?B?QlR6dGpjVng0UERpdHIrTUhtQlV2WklQNGFJTHZBM2VUYkdnMWd3NEtGd3hM?=
 =?utf-8?B?cTNVcTF4R3dFS1lab0xtVk9NU0RTWmcxOVB6OGNReGlXWU0wcXFWdlRDN0d6?=
 =?utf-8?B?K3ZhVXJEYTBUamxoUU1xZjlaNUlRdld4TlpBNUIzWjBJbzlpazY4bmhDYUU4?=
 =?utf-8?B?MEJLSHdvcGFjNm5vOC9BZ01EdVJ3VVdnZGw2U3BzaGg3MXpYYkF0azlsZkdx?=
 =?utf-8?B?dlN5V0hhMmRlRFRBcjgxcUhVdlpQNU42akVqTnVqQktDMWN1OVVwTmd1aUxV?=
 =?utf-8?B?cjlMdHQrYVBvTUNUZVcxTU04M2lSNXJ6eThOZVpzc0c5REN4QzM1dlRRRC9p?=
 =?utf-8?B?dnhsd2VPOWxHZ1hZS2RuQVZkcmZnTW00d3RXNHJNeEE3VVIvSWVaR2xtVVhs?=
 =?utf-8?B?dFJ6aUJhdmJYWGhiMDViMmtWSEUzcW5xUUl2YWhaUHVSODdBYkFzczFJeVht?=
 =?utf-8?B?Q1pBMlZobHpoOG1Wb0NhMFRLNWJRSis4dWNVQ0tyejVLMG1sNEdyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfdb832-1838-4da8-250c-08df24a15d6d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:32:38.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU6k7FJBffzEPeL9o71Wf2ziip95xK1fiNvtUcJvSol/1lVNiNks3eu5h5MYVwgSBN/ARbwqV5r11Q7Fn/+3PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D

Well that's great news.

Giorvanni - are you sure you don't have a BIOS update available from 
your vendor?

I would much rather not carry a quirk like this if it has been fixed in 
latest BIOS.

On 10/7/26 13:30, Kyle Gospodnetich wrote:
> Looks like it's finally fixed with that last BIOS release, it's been years!
> 
> Platform Firmware Information
> 	Vendor: American Megatrends International, LLC.
> 	Version: 1.A4
> 	Release Date: 06/15/2026
> 
> cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
> amd-pstate-epp
> 
> And no performance issues. Thanks!
> 
> 
> On Wednesday, October 7th, 2026 at 11:08 AM, Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
>> OK, let's wait and see what happens after you upgrade.  New versions of
>> FW and the behavior please.
>>
>> On 10/7/26 12:43, Kyle Gospodnetich wrote:
>>> Missed one,
>>>
>>> Release Date: 05/17/2022
>>>
>>>
>>> On Wednesday, October 7th, 2026 at 10:36 AM, Kyle Gospodnetich <me@kylegospodneti.ch> wrote:
>>>
>>>> AMD Ryzen Threadripper 3960X
>>>> MSI TRX40-PRO-10G
>>>> https://www.msi.com/Motherboard/TRX40-PRO-10G/support
>>>> I am using 7C60v1A3(Beta version), I will update to the latest today -- just learning that exists.
>>>> dmidecode reports that as:
>>>> Vendor: American Megatrends International, LLC.
>>>> Version: 1.80
>>>>
>>>> I've had to disable pstate with:
>>>> amd_pstate.enable=0 initcall_blacklist=amd-pstate
>>>>
>>>> Without that my system grinds to a hault, takes upwards of 15 minutes just to hit the desktop.
>>>>
>>>> Thanks, let me know if anything else is needed.
>>>> -Kyle Gospodnetich
>>>>
>>>>
>>>> On Wednesday, October 7th, 2026 at 8:06 AM, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>>
>>>>> Kyle,
>>>>>
>>>>> Can you please confirm more about your system?  System Model, vendor,
>>>>> BIOS version, BIOS vendor, CPU model.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> On 10/7/26 10:04, Kyle Gospodnetich wrote:
>>>>>> Yes this does appear to be the same problem, thank you!
>>>>>>
>>>>>> -------- Original Message --------
>>>>>> On Wednesday, 10/07/26 at 07:56 Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>>>> + Kyle
>>>>>>
>>>>>> Kyle,
>>>>>>
>>>>>> By chance is this the same system that you were talking to me about offline?
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/7/26 09:41, Giovanni Gherdovich wrote:
>>>>>>> Some motherboard based on the TRX40 chipset has been reported to ship
>>>>>>> firmware lacking lowest and nominal frequency values in the
>>>>>>> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
>>>>>>> Firmware updates aren't available.
>>>>>>
>>>>>> Can you please add more information about the vendor/model of the MB, etc?
>>>>>>>
>>>>>>> amd-pstate requires explicit knowledge of nominal frequency, so it
>>>>>>> can't load on this hardware. The driver already has a mechanism (the
>>>>>>> so-called "quirks") to accommodate for missing nominal freq in ACPI
>>>>>>> tables, so here we use it to match against CPU family, model, core
>>>>>>> count, and BIOS version.
>>>>>>
>>>>>> Yeah; it's intended for this specific case of really old hardware that
>>>>>> the BIOS isn't going to fix it.
>>>>>>
>>>>>> I don't understand why core count matters though.
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>>>>>>> ---
>>>>>>>      drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
>>>>>>>      1 file changed, 31 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>>>>> index 8bfd46d60843..532ff16dd076 100644
>>>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>>>> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 = {
>>>>>>>      	.lowest_freq = 550,
>>>>>>>      };
>>>>>>>
>>>>>>> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c = {
>>>>>>> +	.nominal_freq = 3800,
>>>>>>> +	.lowest_freq = 550,
>>>>>>> +};
>>>>>>> +
>>>>>>>      static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
>>>>>>>      {
>>>>>>>      	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
>>>>>>> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>>>>>>>      	return 0;
>>>>>>>      }
>>>>>>>
>>>>>>> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_id *dmi)
>>>>>>> +{
>>>>>>> +	/**
>>>>>>> +	 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 socket / TRX40 chipset.
>>>>>>> +	 */
>>>>>>> +	if (boot_cpu_data.x86 == 0x17 &&
>>>>>>> +	    boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x3F &&
>>>>>>> +	    topology_num_cores_per_package() == 24) {
>>>>>>
>>>>>> Does the number of cores actually matter?  Do you mean to say if you
>>>>>> swap the CPU to another part CPPC works?
>>>>>>
>>>>>>> +		quirks = dmi->driver_data;
>>>>>>> +		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
>>>>>>
>>>>>> The BIOS bug specifically is lack of values, not invalid values, right?
>>>>>> Just want to make sure I'm following this right.
>>>>>>
>>>>>>> +		return 1;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>>      static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>>>>>>>      	{
>>>>>>>      		.callback = dmi_matched_7k62_bios_bug,
>>>>>>> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>>>>>>>      		},
>>>>>>>      		.driver_data = &quirk_amd_7k62,
>>>>>>>      	},
>>>>>>> +	{
>>>>>>> +		.callback = dmi_matched_trx40_bios_bug,
>>>>>>> +		.ident = "AMD Ryzen Threadripper 3000",
>>>>>>> +		.matches = {
>>>>>>> +			DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends International"),
>>>>>>> +			DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
>>>>>>> +			DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
>>>>>>> +		},
>>>>>>> +		.driver_data = &quirk_amd_ryzen_threadripper_3000_24c,
>>>>>>> +	},
>>>>>>>      	{}
>>>>>>>      };
>>>>>>>      MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
>>>>>>
>>>>>
>>>>>
>>
>>

