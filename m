Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE094746DB;
	Tue,  4 Aug 2026 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859653; cv=fail; b=le08rFwNuO9zBPy9/5m0QoHBmfVivMSQX6pp+T79XAwRBXYrW35XUF8XXPShBYav2PxAzYhNYXMuTBqMy5wlsd9OECdeHrIg7o9e0YXhCxOArFAh5uP8wo7XFjeCfDFMWa/djYeRCzG6ksvFJTiWN41VIJXRbga8YFNkErqjbUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859653; c=relaxed/simple;
	bh=+flu2lag7ZM9dwN2Pdr8CTu43kAZhjQniONqwCeJWrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O6tPPnCBXISJRH7FdYR9jktmkuheyPk5sX8vLr3EK27UA2rcL5fUTgtEyWs4xqLRjfiQdk7QV58usol9+BSWkLcW1Abr6Qe6GN7UNi9bSUUrPP3vLCT5t2jYrhQNPPSZ8e1vpGsgCz6fapSHQ1IOKmn3BXmex4lhXxj72B6BIYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aymopY2y; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aymopY2y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4eOc7hBFYQEThuEKk4/1CCRinZExzk8as7WOsZUG1MlIdhKsjMvEuWr65ap1FJOGeT/VjgLQ6L56Gjrrded31ooHR/fW03ePcs/QeUmwQGiLFhVoUeadQQ3dOkyse7nbcNiSNaflm3jf2bG/BvO83jp2Y2wkuFLgFrKNtS0lJewdW4fpc9RCQ6XncYNXlSp6s9c0TlSLlEUfkiIsmlUiPjJcJ2ups3elCfh5fP+5dV1CvPd64DOMKdPNoCWv0KTDbBFliNqFDDqU61aPzrJkxUv6MfQ87reCjhjcx6tMmJ4LfL52iogw1jqtO41Mfh/Paq1H7TUI4rC66HBIoTVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD4ys4559eA6qtQraR6o4D8iyZq2o2NVnCYQORgUytI=;
 b=jc11l9OGv6rhTUhGV0H4W2aVKkEpF9YapWlPjxCquG+J6m1WKS0Bb1vGYR1ch1dIeA+uUTSkjDEfqw5/n0Mwj8eD4EN7oP5UaFrLDYPQ9bRjEFCKYSy3rnEOtpzgoCODaplplAvYVcQ4b+mF9VtlOMXvOrV0OarfXbzVgGFXn1NlvcPYuAlI+dr/SwrI9ep4GcFv+9IQbOOX/USn5Pt2QboC+a0y98MOZqxXBWMI2LtL3V+3sqbwIhsAAkQvuRyiNPqnLAd2+J+H48GbR9FlwTcZlyGEF73MlsIq/oW92OD9A4p2/5uWWjmR+lG7yIHdyPogi8oW1SBYMtc3tAPGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD4ys4559eA6qtQraR6o4D8iyZq2o2NVnCYQORgUytI=;
 b=aymopY2ynteCWKBeVB2ASrYo12AoM4rLjxx9cLqOORuhYm6H9dfTM3qfyN4wUQiyCCu6pPMt0zl6qVvOvH7JdXdJ/FZSUTvirk/Sn+uchuOhGTBx2qyHDuGYYNrpKL4nCdiyH1tCW7eHGeoMco7vHhimj2UfUzQpmQ+7mGyg5mRD1DZDlQ7vAqYQHEfn980Na/AZ6teq6RNNeOyNhYSA4Cn3+4o+Yazl4uqxwFlk3TSaeWacqo8p7oazfJWPQ6I3rQf9XQbIKw3PknytbCnMdPWnCq+8hbp1evWNCdEN9P5/c8mizI0siPwdo8UOdMiu0044lEaKUsDzSIdul3A3AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 16:07:21 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 16:07:21 +0000
Message-ID: <d0869a24-55c3-41bf-af04-dadb6a86c666@nvidia.com>
Date: Tue, 4 Aug 2026 21:37:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] cpufreq: CPPC: Preserve OSPM-set registers across
 suspend/resume
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260724215937.3368276-1-sumitg@nvidia.com>
 <20260724215937.3368276-5-sumitg@nvidia.com>
 <443cae7f-bd01-4022-9703-7a1e6ae883bb@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <443cae7f-bd01-4022-9703-7a1e6ae883bb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba40246-8bbe-41ad-0f05-08def24276bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	2Cqys1eliKEgg0sxz9Ku/HZvVBmNwECMyGZtQ8A/F21L2eMHK41okUJjKfV0atS5OfF5/A43G918YU4hjDVrJ9HDOd1CnINoDxmO0UnbegzeZia3Y7WwxwTgO9b6J3r68CeCsP5EdozXGbV9kQZjDlcP/uHJ0TvzQNRxTuI3TgU5cXgG3WApIgYsZWIXWc97QypN5jdIC7iXpFaqQMq2YYSC5aEkfl/NHcWfeO0b1Ow/HZwjtHXGX1ka/GnWGSaOC7mBuWfUtjsFJ3x/eWdFBY0bg5j4JPmf9j7mGe4ZJTQJeoL3FCHu4poD3A31vBdz5uRbXteoDUDl0Z2VRzbV+JgZzu5fg7wOo0huXv466sOs7GrKMy3SoO3VZjGNqlc5PvF6Zk4mDwFubTmyrTYfLKTWqFNn+9tAhl9etFXR2ehyM5fxYqElTB/AUTxQYkZElxXphNcyQ9rNR/PvOxzoJHbVG4ooJlnH/wKmjBGxBrzKRRgfNPfuoPnzQkOoH9H/RdhbNsiKiP/2NbShFsQvl0fQyOrmuD6tva+3jQ1gnisVTVnPXhTq3WCjomkconaxeSOecemDy2H/dnNmztXFYRVtM96PDLaKo1OUYv4jRFvBSbmJjAKo60OuBuCm+9A2NlbGNtZCrjr7QgxO/74FCXjfoWeQ40Qz5rJKFXYLcsGsIvBb6+UNgObUSF8Cuo24qdvddyuR/OQZaqEh/H2VIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTY5Um4xRkpkOWU2UldKR3BEMURRZW15Z2hmUmljaG1WYWNzYzRpaHpIRDlO?=
 =?utf-8?B?ZStFSks0MnN2eEx1eWx1bHhkQmlWZWZnckJVQ0JiTm5BSTd5MjFKWTB5U0JP?=
 =?utf-8?B?aVR5ejgzUDFwWkFOZTRmd0hRZWhFdEkwcG1qamVaUkE1OVAvMm84Qk0ycndQ?=
 =?utf-8?B?Nm9DZFYrcm9kMlF1R3JMWHZYdWViby82SWZxa2ZpbUtuYjRWTWpQWS9wZDdE?=
 =?utf-8?B?R1BwaDZMUi9GYmRzbVlzRWd6ZGFzU1NqdnlMRDU5QmpCcDlOQkdsWjE0dUM0?=
 =?utf-8?B?cjgveldxWFlucDM2VWFpc2pwZFZhS1k5ejEyNk5XVWRTblRGZ1p5VElIRnlJ?=
 =?utf-8?B?RTNScGJBV05OZXBUQWNwVFoyWU5TeVI5S1BrNzFoU0RFRWtnVGRrVklRNDZU?=
 =?utf-8?B?alNER2dKTzhieU1iR2dkNVFvV3hYWVRtZlBpZVRFeXB0d3pVTld4ZlhxbVlR?=
 =?utf-8?B?QmxZbjJDVmpZUW1JczViUVlHcFNYWnA5Y0JQcm1TOFQvMFB1YU5GeFFiRGZI?=
 =?utf-8?B?NmsyWE8yWkRTWFBrSnJqTWRaLy9FR0c0VDlUamJhZDFRSnlYZ29hL21uOXJM?=
 =?utf-8?B?N0g5MEMzVThSYzZDdFdGQlpuUXNncXg5LzQxSHBwV3ZJMnJjRjNPRXBWcjEr?=
 =?utf-8?B?SXdwV1BPdWhPSWw0ZTl2L2NsZFI5N3YrMzVOa3FGSHlzb3ZVcS9GUkR5dFhX?=
 =?utf-8?B?QjllMmhtMndSUFU2UGFoeDNKQkJKN2p3MGFUTE0vN2czSkdLVFNHYjJWaHNz?=
 =?utf-8?B?T2NCRXF2T0ozVW1UQ0cvcE1JMmMveUc1NmVnNHNCQ1V5WVptTlRoZm0vUFoy?=
 =?utf-8?B?ZFNvelZBclN5b28vbGo3MXhCNUR5R1FLdFJHK3BVdFFBVVNGVWJlRVM1cFF2?=
 =?utf-8?B?TVAzRncxVWZrbU1uWnltRGQ2TVRMd2pyVHVUcnNSa3hVaXpibkRvMVRaY0Jz?=
 =?utf-8?B?V2x2ZzhNOVVVU25vK3ZzNmJ5S25iS1VGRUxqOW5ubkZHNG9XKytBL2dmaVlt?=
 =?utf-8?B?OG03QnhBRWFHOWNqUTk3aGxQOVd1b3lYT2Job1pkYzBoc0Y5WGQ3R2RJL2c1?=
 =?utf-8?B?aFRKQ0U0YkpucnJadGE3VkZyczBzRkcrU2VGWWViTzFvUDFYY3o4R0d5enRs?=
 =?utf-8?B?OW1vWVB0MkZaVlVOSUFRUTdzMjVZNVU2MkZaTlIzdnVmV3BSc3ErT1pPdnBn?=
 =?utf-8?B?VjhNVVJUVUFOaGlOd3pjenlQVUw3RFlvTHBSeng4WFlkOWN5bFIwWkhUMUU4?=
 =?utf-8?B?STFPUGFickx1cFpiVmlLRlphcHZvL25nVU5Nb1Q1clc2eHdBbGoyZjhOT2ZH?=
 =?utf-8?B?VVZXS1pDa3RkSjhJU1hJRDV5VzdqZVdxUjcxejB0UERPTzVMWDhCb1hvejJB?=
 =?utf-8?B?MFJwM1ZjdmxJaWpNYW9SeVhRTmxLRmdoZTg3bHBCSm5Tak55RXpMSklBOEgw?=
 =?utf-8?B?dEF4WCtBWFhXK3VaQ01pSFFrSVhSb29PdytyUS9XbkpqVnoySUJyRFpGMUE0?=
 =?utf-8?B?UEQ2K0JvRVZFQnNoem1WMTZlS0dLWHlIaVZ5U1FHQi9RQ0xVUDJFdWpIVThw?=
 =?utf-8?B?UmlacjcyWVg2V0lacWFaOHBmd1h2d0xSSVVqK0lxRDFWMnRlNDFwT3ArTURx?=
 =?utf-8?B?Vm9QTUQ1Q1lFRUVPODJ2Y2NrNEttMUEvQmlDUDhOMG9XQjlnS21PSzJ1dTRj?=
 =?utf-8?B?N3JJY1YwNUZ6cmdlSTR2RUdpYTYrdVl6UWZwL3BDUnRuckFaQW1JNjdWYWZ6?=
 =?utf-8?B?UU5zMDR0SmpmOGZqOG1WS3lzQzR0WjlyWWZGZjVZMkVOOWNsZ3FMYnJ4RGRt?=
 =?utf-8?B?b01yN3BYV1pMbDBNSG5iWlFuVVB4dEw0Tk4rNHdzay9Lc2h0Ri85ZGxiU3Ja?=
 =?utf-8?B?Y1psS3R0MjlieEhnRTVzcTlyd3VwaE1aalBtZDczS2htYTdDTnNHY0NTV0di?=
 =?utf-8?B?d2FXSWNoM05FcG8xTU5hbU0xODl1QVJxbFltdDVxb0NNUWtqUHBCMThEUjkr?=
 =?utf-8?B?Nk1EWEM4eDRyRHQ4WmJuWkVUZmRNUzFzTTJ2M1Nob3FvcmtQY1AvSUgyZlo5?=
 =?utf-8?B?aXhsMmRwL3lEbjh3c2RkVGtacGZnRnRhbGlTNEpNbjJGQmxhV1hvSW9ldUdI?=
 =?utf-8?B?N0RaQUNZYzhVQXNLR2hibFJ0eFJYdGZ0YnZ3bW9qeDQzc3o4Y0FZbXNWNUJk?=
 =?utf-8?B?dHpWL2daVXNlZWdsVnVBNlppY0ZXZDZqWkoyZWZXOUNsQ0cydnZDa0Vzd3k0?=
 =?utf-8?B?VTkzVXFsaHY5a0pwaTByY3NKQzlxMlZVTThQWHdlUmdpMWRycWVzUDF3T2xB?=
 =?utf-8?B?SXVoSFJXRTJCNlVydDFQZy96L3dMZ0lDYkhWcnM2TmFXQ2g4V0wyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba40246-8bbe-41ad-0f05-08def24276bd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:07:21.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lm9FyQOuGQaBWOzoKhxn9DoOE7uQFzCZEgAbu4KzGjDYmxmlRQHKuh3+7r7YJY15kDAQSM7tPj025NF2Yft/cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558


On 27/07/26 19:15, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/24/26 22:59, Sumit Gupta wrote:
>> The previous patch preserves the OSPM-set registers across CPU hotplug,
>> but system suspend/resume is a separate path. On platforms that reset
>> those registers or the performance controls across suspend, the values
>> are lost.
>>
>> Reuse the same save/restore mechanism for suspend/resume:
>>
>>    - suspend() only saves the current OSPM-set values. It does not revert
>>      them to firmware, since a later offline() already does that when
>>      system suspend offlines the secondary CPUs.
>>    - resume() needs the same steps as online(), so .resume points at
>>      online() directly.
>>
>> Suggested-by: Christian Loehle <christian.loehle@arm.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 8a13ec49eb9d..be2d873ccd84 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -921,6 +921,22 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>        return 0;
>>   }
>>
>> +/*
>> + * suspend() only saves the OSPM-set values. It does not revert them to the
>> + * firmware values.
>> + *
>> + * This is because system suspend may later offline the secondary CPUs.
>> + * That runs offline(), which saves the values and then reverts to firmware.
>> + * If suspend() had already reverted, offline() would save the firmware value
>> + * instead of the user's request, and the request would be lost.
>> + */
>> +static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
>> +{
>> +     cppc_cpufreq_save_requested_regs(policy);
>> +
>> +     return 0;
>> +}
>> +
> Wouldn't it be safer to commit everything here and not rely on the later
> offline() to still need a fully usable CPPC platform (in particular for
> PCC), as at this stage all but 2 CPUs might already be offline()d?
> Also either the later offline() saves registers successfully, and overwrites
> this snapshot, or it fails and overwrites them with U64, right?
>

Agreed.
I will save the requested values and restore the firmware values in
suspend(), while the CPPC is still fully usable.
offline() will skip these steps when suspend() has already performed them.

Thanks,
Sumit

>>   static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>>   {
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>> @@ -1235,6 +1251,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>        .exit = cppc_cpufreq_cpu_exit,
>>        .online = cppc_cpufreq_cpu_online,
>>        .offline = cppc_cpufreq_cpu_offline,
>> +     .suspend = cppc_cpufreq_cpu_suspend,
>> +     .resume = cppc_cpufreq_cpu_online,
>>        .set_boost = cppc_cpufreq_set_boost,
>>        .attr = cppc_cpufreq_attr,
>>        .name = "cppc_cpufreq",
