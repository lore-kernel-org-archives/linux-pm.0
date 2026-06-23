Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E9E36C0AB;
	Tue, 23 Jun 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209840; cv=fail; b=qRYxE1mht5xGNVrOfaK/eNEnw/86JDivM1Gep5aatLE+Wo8oBLCdDKogM5r6gBd1Q2xJt9NK0ioT8O+jITiZ1xc+c0bB104jLYa4RpPLyPcvuA/X2yODD4+r2bgy3BRzBc/gZoxtsKuMWw+yJptL1vBkAHJuDiTywB//2NxpprI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209840; c=relaxed/simple;
	bh=M/4PpeJNwRKzB/zU9e9ieO82utIqSaBxc3zqfTCFELo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bSqT930tzDykJiz5RPkuUL/BkOctwwokyQ7PX12PS0lLr1ng7hAksAY79916560T0W7X/wNMs95i6ApqwcOkrBUf2li7TqQrri45qg5gPRG4FvcuvuoEE1v61WOh8RH5OxSSg8JGCWehXdfRNSsI1ldB0OSj7pN+H6ReCrcw1ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iROtEzRt; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iROtEzRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouFmJWBlOygu2rwr0dG6HkPTiQnr+TEQxGoo10PjisYoD1/k02Pe/CnI+4841hyC85U0Z94JRJ4PVBJDHk2puLCL5Kj6TT4GlGscC/c0j9MIMcwsovDep03iBwlxKKYLIuURiz88lf3MU6Sas0s6jnhK7azlweilmoV/elBXAfHz1/i3Yw+OyTsi/s8BgJm+0qraW7XeBbiI7DKRNbqr5SdwRgIB9eJn23fY1GynfFu7Q2tM4n4lK9b/TPhXj4WLXIP5ClfB1kA7nKkiorkzSYvK16JmWNcjfbYluZe4RC8AY3rUpACG5JMB79SFWWSGNhyMZZ2wK+iL6+xev9RACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQPwO+pXyxkXEhZqEmtW31GeCmg+71ZHx0XU8xQK3OE=;
 b=JzNXgbv96949TjGVsoBNF+CiFCTxQTaWHL3q2ZQsUZ82ePpVZMdKudKy/Gi7CVjFvAob4L2xxyqR/AD0RGnkU09AtkMt3/YJt+ywgCcpHmlXO4Ssf5Wm+x1S82H7QHJQkf3hAk0HHIENqZSG+cBRlGz8RRXYBiypq8W9gWt+FfZiM8kzXhPxxgvx9sSvhw0xIcVsA1xK3U81JpTHxI/1ipklH/NBNOcc/3mZY6MmZ2KDLVr+La+kutCfKkpwodE7GMsyakXjcouSSaSw9QlnzksuWvOgLNatVwViE0/4UMK9h0XyQa1aMVQlW3ot/lsCU/8nDJoXSKEXnWXK2HBKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQPwO+pXyxkXEhZqEmtW31GeCmg+71ZHx0XU8xQK3OE=;
 b=iROtEzRtuQAdlv+qAFGV/tBVD81N3MdokDGvj7OSn6JyqFAGGEro5LkcvqQ87ldJL2ZUylnWIRjHhfDuJAO/2Sged10RJFaTFmsskjzwgX+50fo/IVT9Dh+X+ZHK26Yq+9cusGzT7wqt4GqjWpgP9aTrI6ZfqpyrnwuudXTXcLO6FzaBBL01AeziaI0VFmKEJeLBoYNg9lQa3Qn3feA5oy5pPz5y+1uazLYrh4Kkr8kmPRIoj1k3rUg1zPjnHMFraoctPUndxP2wCjM11VCvwwJphQMs+9ObSK8BRjtwfWAU/2xAK+2D5Z5Utm00pf6Lpmn9i96HW7ZlSFQbhZ23Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 10:17:13 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 10:17:13 +0000
Message-ID: <5fca3d69-602a-4c55-a6d7-d22be82c9728@nvidia.com>
Date: Tue, 23 Jun 2026 15:47:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Pierre Gondois <pierre.gondois@arm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, mario.limonciello@amd.com, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260527202550.206828-1-sumitg@nvidia.com>
 <eacc76aa-318c-4b41-b507-e91e322561de@nvidia.com>
 <oxw5k2wad4vorehgmrduoxblequy3ynqufwy4sruclnh5d5wrb@awzmfafoucnn>
 <35458c15-73b3-45f1-91fe-aa81d85a3efd@arm.com>
 <f269fbc4-8b8f-4829-97bc-cf4cc9246aec@nvidia.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <f269fbc4-8b8f-4829-97bc-cf4cc9246aec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0028.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::34) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a07711f-7d56-46e5-a5f1-08ded1109794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|3023799007|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4592uPXQE7j6CZauxir1DZSXaJe5Oj3ov/wNYSF1qZ4zHoWwOyMA7BssWMrK/cGAorXasRsT/XKJAYrLaP6e1nH1+vY+xg43GB78EBzBbdcZzEX42SK1nbyh08f6ffqZMPZIuqlnU01Xx2k3RPQrKvA9MEb1Zs2jtIrP3dalXNjJfgQ7m8S+IHYS77EjhqUaUmfE5F9dHJUihJkwimM4GFMsSfk0AQAP+3iqFBfBNgpOJJGKPp9x6cRv58Lt0lBqVI3q8KIrAe3j+BHv03UmKMJ/BGYHSLBoMgzps3aPiVKNz/3CfZ5kqEEsSMA9Wta3HDi1+oFgZU5bQzwtXQwhZRT/zO+wPHXRLxY6DZM6TT/H711Rk6pZfZTlJJkDIL5s8Zk365LdU0unC9bqn8hwULg8p4fanxDSpgoTrzhnmV7QwUHNnNkxlXWFB/cdcBGCBImRclGorIx7e3cpwh71Zx0Y7zAIbYV7pjFuFhdm8GRBgHIcOtWurXus6ZR8sFZj+TC15NjiYzhQ56QCNq2Y5T5QDAFAjVjTj03WM6qcGbBq34qbNp9HB0MYeIP6tUrtd/Pg9OhQ9ihxr+5G8uYJ+yQrneWgDpIEw5y+eeLwt+r2hiw85XkQOdBF/TvSL0E3BfDFRXLoKc5Y9hbFS1yEMYrPvgdX67v4x6j7r8UsseY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(3023799007)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHp4dFB4NFEzNE1QSUJjVmdNQWt2SWQzdUlOb1M1RFp1TjlkMkRkUXRWUmhy?=
 =?utf-8?B?ZERUMFhxc1BLOHZiWSs5UWtKczB3aHFabFkrVVVWc1N2dk9NRnF4akRzSlJS?=
 =?utf-8?B?U2c3K2ZGWEV4ZGx0bGJqT3NiVll4YzFFdE42UlVjdklEUkczbDIxYmJSMktu?=
 =?utf-8?B?ZW5QQTVqcTQzQ0l6cE5VQjUzeUtlWFFnZHdNcXBYMDJML2Z3QWpLSDdLaDRo?=
 =?utf-8?B?Wms0SVMvTURXb2ZuZEtUZ0FMR3dtTUJvSThiWUR5SEtUS3AxSzJQcDFGNG5X?=
 =?utf-8?B?YkJmT2lNYU1KbDQ3WExGMXNSdzhmYzFEMUdpWmNFd0VZdGY2ZUYyeTlUNVA3?=
 =?utf-8?B?bmRvM0VQZjlBVEFqVU9XbDdtRmN6MFgwTFEzU3B6REFUbERvRWVraXkyK0cv?=
 =?utf-8?B?ZXdGdDV0RkphTk9WUFMzZjRudzN2dGlLdGlZUXdjd29lME5jNHQ5OGNGandT?=
 =?utf-8?B?ZkQ4dm1ITDRXMUF6U3V2clJibkUwOGovbWloNVhsZlNtSnFuMmVMcVNiVzQv?=
 =?utf-8?B?SzJoVXVNaXBtblYwVVg5RW9ET1lEbzNFaXF4eHBOai9wNWxzMlRtQ0ZtMWdD?=
 =?utf-8?B?dmhXN1VrTUNIcEZoOTlleEZFODFEcmkwa085TnJqdlJvMTROeHErR2lLV3Fl?=
 =?utf-8?B?dkxWbkdrQ05UcW85UlJZRjlqSHVrMklQS3dpK3NUZHBDNVUvdlJhcEJWaDE5?=
 =?utf-8?B?eTJPdGhTOFJZbGhYemNqNUorMjRMNC9kVGFLeDlHNDJLS2lKL2JaNy9YSXZi?=
 =?utf-8?B?S09rRGZsWWpFSUt0Q1ZZZ0hUVkhCM1dncEV1dDlxVHdvZzJkY2RvcnEvZDZX?=
 =?utf-8?B?N3l5dDFTTmVVa2ZsOTBLRXZERDM3NVVPWGpnM0p1dVovY1drVTVFYUlxclVR?=
 =?utf-8?B?ZHRudWNsMWF2cWJMVVN6aEM0cTQwNkFUWXNHSnB6aXcrUG4xNzc5VHh1eUw3?=
 =?utf-8?B?dExVMnhtNmZlaURCeHdlMEs3bndwc00wdEZRdW81UmlrR2pVMWlaRzdFOW13?=
 =?utf-8?B?VlJpU2JqaW5lVTBoRGN6NzNncVNiaHRTWGdaZWtWbllFTTNDZG15blBYVW5Q?=
 =?utf-8?B?eFhMQmtTZnBCU2xrSHJEYkpCcFgwdzM1elBYK2N3N2toTzRERHpUMkMxOXo2?=
 =?utf-8?B?U0lqQmdZaG5UM1JvK0VEZXhSbkx0WEg0aGpnZHhyTTVCYW9Ic0llWVdUQUVS?=
 =?utf-8?B?UW15eFMyelIrYWNWaWkwQUppajhHejNEeXRUTWRYLzc5S2ZLbkxoZ2luZFFz?=
 =?utf-8?B?RUN6bVhQS0grZXVHbmpCUUE2NUhDWHRYOExtTmVSYjFobW1LOCs4UE1Pd3Ar?=
 =?utf-8?B?TzdycXRPUjRNbjRublRSVlZlWDA2cUMvdHQ5TE5YaG5JNXJTMWlSd3JPWHZZ?=
 =?utf-8?B?STdtc3c5cERnZ3YzNU41ekU0UTJGUTJTbnY1L1JFellQamJQdFY1SUVrUy9k?=
 =?utf-8?B?TEkxWUVLcmJZSENzM1lacGFSRWVZWkxaOStqZTg4azFpeURwa29oampXRmVa?=
 =?utf-8?B?T0plQ0QrUXJQcGdycmMvY1VtdmRzaDQwQkxtQVVGN1oybmlGYnhyY3F1dUZV?=
 =?utf-8?B?Q2lsM3c5TVViNXJmc1ZGMDFteTBQcVI0STlXOU1CMFJhWExtS05aejdyZS9j?=
 =?utf-8?B?REJMcHp2T2JSMW1vNHdxNGMyNy83S1JRT2ZWMG5UbWFvSnovdkgrK21ERlg0?=
 =?utf-8?B?SE1yc01XV1FhK1NpZzAzRkszR1ZKZk5kd3R5OWo3VDJmcTVHUFMxL0tqemls?=
 =?utf-8?B?YVhTS1pHNFFlVENzNFNxdkV2ZWZTa1ZLYmRhdUpXek8xRE1obXlDSnBuR0dn?=
 =?utf-8?B?bWM3ZFRrbzVMOG1xMnpCdTJ0cnExNzZJc2JHQkdMSVdNV29kaGYzWFg4WitY?=
 =?utf-8?B?bW8rd3lCWld3eEVBODFzVy9QZlA5eDREZjdrd2srL0pZZUxnWlNKSC9pRnJE?=
 =?utf-8?B?Vmt2WVFKNUdBa0N2ZEdxN1lKLzFjZHpuL2hlR2Z2YktaWldiUjBRd21IRTZ1?=
 =?utf-8?B?R2tublk0QVlWUytwSHBjVmdHVi9QSjlmbldMNzFCanZhQm14NzZWZldrZTMy?=
 =?utf-8?B?T2wzMGdTVmo2SzFoVE9WVVUxZGRoYnpLZkhXTkgvOTRBb1R4aW1NaFRETzdY?=
 =?utf-8?B?TTFuWVZYQlBETUFPYkpSbzd4ekgyMnBZbm5mZHIxRWJwRVBwUmdKOUJMdFd5?=
 =?utf-8?B?UWZTeFM2SzczOVE4aDYxOWkxN2I2c1dEbUN3UzNPSTAzKyt0K1dSVUFuK0Vn?=
 =?utf-8?B?YzJpdXZlbmJFWCswbXZzeXMxSEpPemxocHY5Z0pvdExwWmJoZGExOE5UaVl5?=
 =?utf-8?Q?CsrmK4ZBb38INGIyVZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a07711f-7d56-46e5-a5f1-08ded1109794
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 10:17:13.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFhiy5sonxq04KpL0MVkZhGzKwLUxnLQHZoIlzeZHvcwRAk2bw5qJToLID8ASsCahvLz3NepoVcreLYLrsKW0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684


On 22/06/26 14:58, Sumit Gupta wrote:
>
> On 19/06/26 14:59, Pierre Gondois wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 6/18/26 07:28, Viresh Kumar wrote:
>>> On 16-06-26, 18:22, Sumit Gupta wrote:
>>>> The dependency it was waiting on, the "cpufreq: Set policy->min and
>>>> max as real QoS constraints" series, is now in linux-pm (linux-next).
>>>> I rebased on top and verified autonomous mode works as expected, and
>>>> it applies cleanly on the current linux-next.
>>>>
>>>> The [1] reference in patch 2/2 points to v2 of that series; the merged
>>>> version is v3 [2].
>>>>
>>>> If there are no further comments, please consider acking and queuing
>>>> this for the next cycle.
>>> I was waiting for CPPC reviewers to provide some feedback.i
>>>
>>> Jie / Lifeng / Pierre ?
>>>
>> I think the patchset has the same issue described at:
>>
>> https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/ 
>>
>>
>> I don't know if this is important to other persons,
>> but IMO it would be preferable to have a solution to this issue
>> before adding more functionalities relying on registers that are left
>> in an unknown state.
>>
>> If there are any other opinion ?
>>
>
> The concern is valid, but this isn't a new gap. The registers the boot
> parameter programs are already writable via existing sysfs:
>  - auto_sel via auto_select
>  - EPP via energy_performance_preference_val
> So userspace can already leave these in a non-default state across
> unload / CPU hotplug in mainline. The boot parameter just sets the
> same registers at boot via the same paths.
>
> I am already working on the save/restore change we discussed on
> the ospm_nominal_perf thread, as a dedicated follow-up grouping
> all OSPM-set registers (ospm_nominal_perf, auto_sel, EPP) together.
> I think doing it once uniformly is cleaner.
>
> Both features are already under review, so my preference is to take
> them first and add the save/restore on top, rather than merging it
> first and respinning both features under it. Either order works for me
> if you and the maintainers prefer infra-first.
>
> Thanks,
> Sumit
>
>

I have sent v5 of the autonomous mode series [1] with a small fix.

Also posted patch [3] to preserve OSPM set regs across hotplug/unload.
It applies on top of [1] & [2] (both not yet merged).

[1]
   [PATCH v5 0/2] cpufreq: CPPC: add autonomous mode boot parameter support
https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/

[2]
   [PATCH v5] ACPI: CPPC: Add ospm_nominal_perf support
https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/

[3]
   [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and 
unload
https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/

Thanks,
Sumit


