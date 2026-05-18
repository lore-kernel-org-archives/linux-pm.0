Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82772311C11;
	Mon, 18 May 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112181; cv=fail; b=GfoCRzfSUsEsU2l1toRrDAvqhJxJW9K3eZUWUQtdpSCq3T1w3QXxiYynbtlSDhuwebI/G3Q0A3M+o73cU9454Ljeilo3bHkxzqxinDFDi6BMMSlR0uIH/Zxv7UtuKvAyyXGQpE5iztCP3vmd7Dx57f7N4bGdDtwS9pwkTX3Y6fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112181; c=relaxed/simple;
	bh=AnxyAl9ruVttnicTm2iznWmFc7rjGXk2n6DQFWO3CLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QV+eznP2auKhDBOQawCRTJE5j4Wbao7mqLAHd8+LDZVdAhLwyqTQ2/24s6xmm+bvR1oKHU6FbRe25Q/F5+1IF4gM3mwmQnMh6qegDDS8fS6rFnF1YCgvTLgp7ddVDAqnhdcg9VIP+bAhHmz/ApnpxOAF1N2t/gdjZEi5PE36eWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IpazQwco; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IpazQwco"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMUEgBjm+rPyQM98xFsTmVbY9rQSwm2CuRTFTKXZfOvqayj8cICrv3bi0l46pEryHD+liDqLWdpfkpUoeaUCrJoB9hp16JX9b7bKsfJ1DSdSmfNIbNpUjgqlAJjJLv2PizYv8M60zFouf+Kz8vBzf4trr6dwyQf+8M8/0aYJXCaFiUe/KMuNcWkcgD2ahHQAv6KLgJi83cs+mFLlSCDolJgVJP1v2Eo6TmVAnFuZjglSgufUf6nrYzbdpFGo7jZTaOb2ugo2AUGnKQRqAO34lNlhPppv8eG33jm4FbGilf6JwJvmH/drivH0E8V+JcFp3BzHgRedXxEtaUCU+HVaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrLi6hSNJ0ONTrA5of3HOkKPX65r80QvdZicv7frO/Q=;
 b=AqNT2UxwyCo6vXvNgXC9ym3MgOaBfzdebeYO0eppAw0WWIDCbOa5TDJmc0DvzFb/Et/gfrun2MQwU4HTQRhNCjUheHkpHjUTRol83MvgKb3yKFrcR5+DFLtZm+xBRDUBHhIUbiHKRAyBqzzZcXwbO/8f0A9W98vD5l/pkCOel8A8bO0vZq2FwbxdkWuWvX4Y8dH4HjcdvHP1Rk30wgleZjeL1jaAq6WklodcQAhVnsQF+cvA/XByKRDOqvHXZ+BZWPeCe1Zge2Zjqthm0wyS5HQ7wf6dG8O1BTQnCQUSO+kRQGI2h8PuyJXvAve/vdEwDpbrBRZ1EB0Uury6Eu4CCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrLi6hSNJ0ONTrA5of3HOkKPX65r80QvdZicv7frO/Q=;
 b=IpazQwcosSIcF1eVCE+4bMK74cm5lTgOYEnU0p87qRUKy7z9FsNtexDdyDCfIuPWAs8h7FoqA+jLwV/TkpDQWEwLyt+usNDZgOtDNRZcNUVnhxB45+YPrGE1Fk7oOd5byKlx7tfFOGskAroWsAhTPK/xlH8Q/0DI/9wpW075Oz//cTbzrVs+P77D1c2YKniCAew3bgGr5VRee98Khpr0qleGapMXW0Av5qPQ++UIGu0T6IErk+QnT+X1glFnCGhWRmSIzV5HMAAf1EvbMPwXmRS0eYnYc7HuX/sUNV+5VEf4Mm0lQcLLE5DbCBNFsOwaD9T98poFZmGL2Crzy/AJpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 13:49:34 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 13:49:34 +0000
Message-ID: <f0a94119-478b-4118-aac9-486538b390b1@nvidia.com>
Date: Mon, 18 May 2026 19:19:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Randy Dunlap <rdunlap@infradead.org>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, corbet@lwn.net,
 skhan@linuxfoundation.org, mario.limonciello@amd.com,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260515122624.1920637-1-sumitg@nvidia.com>
 <20260515122624.1920637-3-sumitg@nvidia.com>
 <b4516579-c4bf-4ddd-843a-30d4a4992519@infradead.org>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <b4516579-c4bf-4ddd-843a-30d4a4992519@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:5:15b::34) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d4ed0a-ced9-4c00-6260-08deb4e44b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003|921020|11063799003|3023799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	R4h79SRD0S87D11RfAQCSZAtjswg6kW5q3lOaPrsFl4DPIzVbLlhRH1E2q00hnAALHLDH/rTcBtNq+sMnoKKnrh4lRzmqx6MeyFVznqH2PEHKLVy3x/Am9vWdX5hbxdQZkiL1gfxm07j5R6WAbw7xywiMjrOzg5VzzqCsbkRwuStJudRadInC4uvdHZBrV6/oAZic0YdpZ3DSHJ4XQ3Vf9obxTBm+GPdyvzSIb8XTa8tBZDGoiVfVtzm1NReDNOW8ouEKTZ/DjkSIaWNdPsUCriVtDQA50jizmHMOLSY+bI8P690vmx+JUB5uof+pMgk5cbpwvrL56U5vn/8YV/3WJeRRsiVhijg2rs9DvPfUr1LgNFGsek9ZFUb8wzUotjUEzmkxmKTQJaGMhK7u36C9PSLLCcqIsJFWMZuQJkeO1jxN4+KFs1Vr5F4k3wI2HxiQxmby1KxnhgTK6QQThJ2yRLEpBqzzU5StrtBI/jZNY1kv/4yGZYW7wmBkzwM/ZLVpYjodBgBD21wY+m4x604xz9LD884zZQ9nytwaVANFHa60CDvyEjRBNpb9rCeWdM+Q+FWzYhKmfxDJJTOxRPVlVgqCn/d+wrlKuZjBBEDaHQfmxnJjO87MjFSKCmL7oKardaVGMlk9QTbmxcisLIBBZ3/LZNhDXME+Bd5kLQdLsFjJR0EWrR6HAUAAZnaP6wTIu1OJ4mgcn2Q6jeMEZHGG43i0/1OnfuOY42lthJmZck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(921020)(11063799003)(3023799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dERLeVFCRVBoWUE3QndscTFHUXd4aklMbDBXMDlDdmRHWkpPRjUyZkpZRkVt?=
 =?utf-8?B?VUpkaWQrR3BKUUlOK3E5UGF5cTQ2OVFVNTBrM1EwcWpQT3hOTXZHdmkxNlBN?=
 =?utf-8?B?VFNrMDNUNzFOTG9GL3h5OFp0Z1JvZ1Q5bm1aTms4M3pqMkswWjJzUktuY2NP?=
 =?utf-8?B?cGJFeFBOK3ZJUTdUSDhuOE5yNkRpZ2tEdWoyaVA1allFWVVFa1BaeDlZNTQw?=
 =?utf-8?B?ckx3UHQvc2RsM2QyMkhULyt5TGhtbGR1ZHloSkJmZUtvUTZXSkF4ZjRUQmNa?=
 =?utf-8?B?MUVtbjVENnVZS0FCM0Q4dGF2L2VrMTI3ZXIzZmVwNEFYdnU2UzZyaXUycXZE?=
 =?utf-8?B?UndJcXJhZ1NONjVSdTRIVE1taE02T1dKT0U4Y0ZVb1BFaGRvdEhRYjhmR0xJ?=
 =?utf-8?B?L0U1ZDF3eGE1NHR4bTJsaWRzeHo5NFl0WWE1NXIzNElLekZZK0UyaHFLdDNJ?=
 =?utf-8?B?elNyeG5iV0QzbWtGTWZQUVQvMUt5TGJzUDRWejJVQ0hzM3JQNEdRMjd3QnRs?=
 =?utf-8?B?MUlyR2VranNHLzViVDVaUU9kb3ZQdEhVbEtQYUQ1UzdidG9Ea1FQU2plV1hT?=
 =?utf-8?B?R2laOUk3SDJwaDR3eUppTFVMbVk4dDF1MmFZZDljOUcyOFZLQ3lBb1UxT0hP?=
 =?utf-8?B?d0tjZXVXM0Uzay84dFFrc3N1amtOUDVVN3pocnNMOXRDajk2MDBoZ05WYjNT?=
 =?utf-8?B?ZURsVlF5aWRON1psVFFRWVFwOEZpT3lCdS9xRnk2cFdjd3dOeEF3TUNoMW5y?=
 =?utf-8?B?M3ZoQ1R2cnZXU205eEFTM1puT05kOUVOMDB5U0JYa0ZlZTlqOWJ0MnRON2k4?=
 =?utf-8?B?alhENlM4R09QYndVa0lqdEl4ajhWcDlQQmozL3Zkb0c3QXVOcmFLWXF1TitS?=
 =?utf-8?B?eGl5QThGaVE2OHptQ2FkcVo4M0pDNTZEOVhBVEpQQkhQaW8rR2hEN00xS01w?=
 =?utf-8?B?aW9wSE10eGVmV3Z4azJuTUN6dXdyME5MWlFGTUc2Rm9TT3FJa0ZlR0NuTUhu?=
 =?utf-8?B?bDN4ZlBnc3dub09EdEhPYVNBcXpaNWI5cjBUUUlmTDlBUmg1VFhWVUlEUnht?=
 =?utf-8?B?UnVld2N2cnoxd0kyTkgyaTJCS2d2c3htRUNiV2o2cmF1N015akFEaFFNVERL?=
 =?utf-8?B?a0ZscU9yVHE4NlJadjd1ZzdXbGRRb3hWNXZSSXhseG5PY2FsSU1tY0M4ZDg2?=
 =?utf-8?B?cDBNZjhiYytaaURZcVlXbEJzUEZWTmM5RVZSMUpoV0x0bzBmQWRBaEJuMDdF?=
 =?utf-8?B?RUJYQjlTQ3RIM2NMTnNpT3hVdXlvbXpaazFmYldXYmhZQVdtSVFEZ0VoaXQ1?=
 =?utf-8?B?aXZ6ci9hZGVaVTVnejVPWWtsL1BJNmtQUWJXanJCSFI2c2xKdStMMUVPdk9Q?=
 =?utf-8?B?V1hWQ2t3VDZiR0krM1QxRWUyYlBtaHJMZG9WODhvL2FaWnZuZ3FxeGRaWGhO?=
 =?utf-8?B?NWtuVE80YU13amJVbzdDOGVTcXJuOXZXRDhIemJpVit6a1dHaG4yZGNXNTZM?=
 =?utf-8?B?UktJRVJxWG5McUozbnI1Y013c21MSk1DbHNOM0dmVzJaU1ZUWm94cHRGTlBm?=
 =?utf-8?B?ZFdiWDJBTGVHNitoWmZvTkZGb2hBVFJ0U1dpWHVSanByajVIaUsyZFFqdDBn?=
 =?utf-8?B?TlQ1MGZaYVV4akdFWmU3d0ViWXZCUDQyQ2J4R3l6elBzVFZ4Qy9aVzhERUtr?=
 =?utf-8?B?SlRiaFFWQXdJU3E3YmR4VGU2YTRFQVNibk82VEVMZUlDN3ZtdG9ZRjhWV2FJ?=
 =?utf-8?B?aG9TZ0FRNENKak5CLzk3M0wwY1NOOXh3VmFZdVd6b1l4L2FLVFFRL3lkY2xX?=
 =?utf-8?B?cTl4Tk1pV2Nwak5MK3pCamdxalpBbjVPRy9ZcVV4eUtINnRnSjRaQWQybDBT?=
 =?utf-8?B?ZEFsaWdqcDNnL0lFVDA3TjJJOUdQOEN3dUNVWjZBNUFUY1F0TFE1UFdJeUt6?=
 =?utf-8?B?VmtGdEhUc3JVc3hTL1NMOHZCNXpoSk8rc205SUlYdVdMQW9qcHJLR2k0Q2xP?=
 =?utf-8?B?dDlkY1hpOXJIeThTbGNlSUpqeGN6OTdJZ1RiVXAvRHhPRjg3OExUZVBoaW5T?=
 =?utf-8?B?QzNKcmxhai9qSXlnelJwU1Y2OU95NDN1VGhkTzliSFhlTnVCRHFJK0VIS0VP?=
 =?utf-8?B?eVoreDFGeGJ6cnE4Vi9aRktXUkhnK0tNNEVhL2I2SW5TTFNqOHdxV3g3c2Nn?=
 =?utf-8?B?ck92RkI3NTZ4YlJQRThpN0NpVU5kZS9PYkVpLzRxSC9KOW9FMmxuZjh2OXBq?=
 =?utf-8?B?TGR5WlFDUjdUWi9VZWlYMjdJOGZjY1FGeWVSRFNkYTExMFBPMHpRYitaTlNV?=
 =?utf-8?Q?gi7uxD2vRE5kogH3Aw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d4ed0a-ced9-4c00-6260-08deb4e44b19
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 13:49:34.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gre+YJAutbExQq+e4wisW4s5NICycBFIl0cfln/BjuyP64/0ZKdVbNUy9iS54mFTx1qanYgMCOG7SY8IlLlETw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

Hi Randy,


On 16/05/26 03:44, Randy Dunlap wrote:
>
> On 5/15/26 5:26 AM, Sumit Gupta wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 0eb64aab3685..7e4b3a8fd76f 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1048,6 +1048,22 @@ Kernel parameters
>>   			policy to use. This governor must be registered in the
>>   			kernel before the cpufreq driver probes.
>>   
>> +	cppc_cpufreq.auto_sel_mode=
>> +			[CPU_FREQ] Enable ACPI CPPC autonomous performance
> I just noticed that we should have both CPU_FREQ and CPU_IDLE added to the
> legend (meanings) section at the very beginning of this file, but that
> doesn't have to be part of this patch.

Thanks.
Will send a separate patch adding CPU_FREQ and CPU_IDLE to the legend.

Thank you,
Sumit Gupta


>
>> +			selection. When enabled, hardware automatically adjusts
>> +			CPU frequency on all CPUs based on workload demands.
>> +			In Autonomous mode, Energy Performance Preference (EPP)
>> +			hints guide hardware toward performance (0x0) or energy
>> +			efficiency (0xff).
>> +			Requires ACPI CPPC autonomous selection register
>> +			support.
>> +			Accepts:
>> +			  performance, 1: enable auto_sel + set EPP to
>> +					  performance (0x0)
>> +			  default_epp, 2: enable auto_sel, preserve EPP value
>> +					  programmed by BIOS/firmware
>> +			Unset: cpufreq governors are used (auto_sel disabled).
