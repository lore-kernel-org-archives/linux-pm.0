Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F1369D6E;
	Tue, 16 Jun 2026 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614346; cv=fail; b=RxlbmzvS28X1jh7UKfitFf+Ro3srlTxqRbPBBtURIGU7fM93ja6BuYLmsbTUGteAsYzk00ELgB94mRCYFlP/5W/8Ye8C+BiOfQE+hsLs/iXrdsRSEZURNPYJcXgZN9ONt3bTujVXxqXzOXgZ+360EztwzNDWWdFOFXSWVCrqtsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614346; c=relaxed/simple;
	bh=c6KjHR0whcH4i9iZg6wiP0QPT+pp2M11YefODdIBzug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p7xDltwYs4g0GQluXzstB0vJFTFJgGhXKVJFaHVpRktP9CYfnlHqLsi957kOfEt74DWfEHGEJbiuaMz50KIP8h5SzSE6b0MzCTs5j3KWCqZNnQPcZqwU79hi1pVo1Ncwu0jVGBXaNFc59J1OUDPT9OSsfH9D3jA5+2i/EIBSW/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzacJZi3; arc=fail smtp.client-ip=52.101.52.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzacJZi3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxwemadAtmfXOgAGwmIM9Bvzqg0G+Lb4xT6KIsV3LH0jszR35cMGiTzt/BjGTWn1kN59EmoTYzou/cNnaYEP/fVL4QSHrq0ujP2blR6r+JXb411EjWpfBFRgbS278NLcHtv/Or8VyCOby0SgGaRDWBSaxkneUPQdo6b98oo6s7hZm7sFtElhBhlTfY3OmBkeeXP7AcLYCRmhDRNy8RYpyCOXgK2xKVaa1l2xbWJ8TpQ3xKF7GxXrJDMX4JKKcmx3RGN11J2xkKnze6kzaCN63em4bA/cCBiw4GjA0fyGe8VU3oO22hEuaEXqt6D7jUMP4PatGIYDgaJZW2PuGRyHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGNPGRImIZpVzeb6zO5UKjlh69EUHOY2SuqWfILnPg0=;
 b=CDdYVLjjB1xlQ66H/bVkG9yJrdkUMQTmM/A4gU5Dc0rEhgCSVwja4FrsbxfT3Dw/EPPw5mNk5DEh3hdUR1dHwhn/q/01sjcYT4LvCgcDjScfzVwPkKAxlnEBH3Muk/fWoPgKYcMK3NOHPFkiX4Sx38cht+irnWT2odP2STDBnisnuDWq1tN8J2R5+Ny83i0sL9eWzbJPzPku+cgkmALSM8JgzXniC6FeT5wkEdzfjeMzZDN4yBg8WOa4EcpfAz0f00L4VwgCzuPNJR8O8NCdpbK96qhvTh4W511JQ3GjiD15zz82kUZGig+9FR9h+QKfgOI0bdVg3v1gmdAzHfRhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGNPGRImIZpVzeb6zO5UKjlh69EUHOY2SuqWfILnPg0=;
 b=fzacJZi3MDzfld/G+UxToueJYKThcx5Ysaqn4cyXX99geQb2OlRuT76RHAc27Civ6GUjC+Ow+G5QxFy//zhRnIERs9cuHN7XqaHAbS27+lPRxlmFMH/eK9E2S0IXy/GE18+YWB6ANL7Y+y0DdH2tcat1WGGGxULlgcudYKi0caIcWRQjcsklm8BMQDVVLs4CN7sTcFNfbjPuGgthWoRSh+I55Ww4ehOLCslVCC4YavyUPMfAcEv1F7Rvet7W1pIrs9c0vns8rEZ+AJtZPx6wBINIXkrPh2fy4BSAkkIwOtHDPk3zPLKuVx8NCmiU85ZtJY5GNkjIi/yPL/R5n8mJJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:52:16 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 12:52:16 +0000
Message-ID: <eacc76aa-318c-4b41-b507-e91e322561de@nvidia.com>
Date: Tue, 16 Jun 2026 18:22:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 mario.limonciello@amd.com, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260527202550.206828-1-sumitg@nvidia.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260527202550.206828-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0086.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f967dc-f569-4460-8d95-08decba61805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|56012099006|11063799006|3023799007|13003099007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	0Izz/jqnR/gfPxx5PAyENefZDe1toZ7uxfoe8FR2daaY0Bkq4Px3xW/+hezVfeqyc1j/gKvqOyMtCUDuM/W85oMFM5HTUpwPilgDFS5mmKSRbf0pfMrVdBzsx7yMPTTcgoB03Dciw1oMH2hhSJBAvxkDojtZxk51OY3XBqm1Fkarf9P7FMzbNXmVPP8nz/zWzZ0QRJ6FMwbckzUprSDC8qRpZSWzx+//oRNRFCRTFvKdHI+VSntNaWzRHu+/eS8YvlcUoL4Fh49GOz925Yq2o/g9kgxSClGKAdFEbwcJtsgNZDQDD2J8rGYBEz5mbbhhnttLDAkXZV3+bdlh0P/mIgdP4ClSEG7yqYgjvpsFA8yDqF4PnEm2qB8sxLhDuj5X5VuXcAfglpTOggcMV3Obb582cFTssFvX4CUYmiox/ytCOC1cHE6oIBw2yM7m3bf7mKVRZqtcycvQuBJH8pXJqYxFAQn9jpot7ygrLdVX3bTedmk/+fozc0g4/ulBrlAnMeVscMmfN09fFnv9RaYFgbprl50gghtfH1G5W8rY/XUngKLsvJwHWTQm0AkM3FD0Z56z8fpG4PbVirDKpSor3WUc4bNC2kbkfMVAEjIEXqpT6rynCEDTFL75YdZirYrYJqofFKW5medyFeajX0OoFx3JL2SmARLkQwlRzWafxdkW9Xqtvor8Cf2IFpN61hDELmdMOzx3rB7pwCHjN+4E68eezkjQPfT0a06bq/3iRXQ2SffPsB8IYGHE2UhXA4Bu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(11063799006)(3023799007)(13003099007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEhwRXJQRGlCaUEyem9wNjQ4Q2tnaEtYajNqZE5ubURqVzR3V2lKa25vYUlF?=
 =?utf-8?B?WU1rL2NoeFJBSTRaZmZabnErbTQvNGMzSkJDSmVhbWp1cVBEQ1FtZzdMZDg4?=
 =?utf-8?B?NysvNm9jbnlWQUJ2dGozL2ZuWjlidkRzc2pRQkw4OHRpNkVHMFB0T1pnTCtW?=
 =?utf-8?B?UUN6TFZ2bEZEU1hsUWowRTNzVVZSVHdlV3JzVmdpSEFSOGZVNEtqZnU3SE9H?=
 =?utf-8?B?cEg1UGlMYVhNeEJKWlAvaGg1OGNBMkV4VGROK1liMU9XQzJ0UUtNcDB0TStz?=
 =?utf-8?B?bEo2bGM1Q0g5MHptaEJIWjRGQ2pHQWIveHprbVl0R0ZPRjByZ1l2KzNCRmQ1?=
 =?utf-8?B?enFwNVVLNWQ0UUdKdEMyRW54RkZVOHdHNzFlVkZnS0N3VkZwY0pEeThVUS96?=
 =?utf-8?B?dVBoOWhWSk4xR2VPdlNSK2lORHEyV3V2elZKbmZ0MXRBekd4NXV5VEYybmkw?=
 =?utf-8?B?dFAxaFJpRVJwaC9lS0d2NExhU1hTakFjeUw2SmVYMHdxWDBwb096SVZYam5Y?=
 =?utf-8?B?QnROZk1uQ3VDMFpoWmZrY2ZQZ1dCN3VhaHRDdXJWYThsZDdWOW1tWlhkT3Av?=
 =?utf-8?B?Wk5seGRGZUtSa1V6UzJPSmlWNGRBQThjSU5JTzlBZUoydWt1ZHp0M0l4ZGNI?=
 =?utf-8?B?NkxQOWZ3YkVjVlJTUzlFa0tVSXNEa3pTQ2YzSm45Vkp4WjhqMlNaMGZYK0hF?=
 =?utf-8?B?bUE0eHRWTjJJSjZHM1JQa0NvRDBNRnNiS0EvZXpwOEIwb1NBZkhEMnB3NkVa?=
 =?utf-8?B?T0dSb2tFaXpUUTBsM0s4RXFZZmJJeTdmVCszejNrUVVJVkVxZkU4MWVSNjlr?=
 =?utf-8?B?SFk2cjBSUnA4SE9pSUFEL09ueXVQRzhPTURWcXc2QnowcnJDT21EZmNPZVcv?=
 =?utf-8?B?Y29XRUN1NEZlRFFNSm8xR1o5YktpQVJ5bnhyVUxXbERtZDlMakk0L3RCdzJ4?=
 =?utf-8?B?Zm1CMGR2Q0cyUFM5VUt2eHBJbnhyQ0ROS3BqT2Z3b3FLRlRDWFI3dTNrRWNv?=
 =?utf-8?B?Z2xMUGt2SEJEVUtsYURnaGJVdWZFNGhRSDhxb3lybWpwRHk4MVdmbzMvenpB?=
 =?utf-8?B?WTVYbUx0dlF2ZERIenRFZ1BYYTVCRlJzbXNRVG9HY240T3R1WFBDS29Tai9K?=
 =?utf-8?B?ZmNMV1djWm8yYjhoTEplejJiUm8vTmxRdENpY2JqTjduL2Z6SHRnUkpyaGtW?=
 =?utf-8?B?VFFTeU9BMEVmdWEyODJPcFd4ZFJ3eU10d1l2blBOZ2kzZUEwSTc1TzlLd1dD?=
 =?utf-8?B?Ui9GRFIzOHVzVWlxenNkaDFFRC9ZeWJwRDArVVFyS0FTN0NUM21lSTlKeFRJ?=
 =?utf-8?B?VXl4L3RxWEZEUG5FRWtQdmVqa3Uza0VMSm91ZlpyYThTMWtFNU1zTkRYNU9x?=
 =?utf-8?B?OTVoNDJvYy9jM3NNRUhnUzFpSHcvU0FIVG9kejI2dmk3eW1hRW1FTmpQZTJG?=
 =?utf-8?B?UzBzTVVPVWVGaTJiREQrYlk3VWxSM3pQRW1QOWtmNENKdGVteGx2NTlHVjVV?=
 =?utf-8?B?K096OGFIbloybkFGYWM3eDI5TXA3OW5nUWM0TGF3M2xkVXUyOCtKQncwQy9T?=
 =?utf-8?B?OXIrWWpnWi9lUkRscDRqWC8rU1A4eWVEYk04a3dzaDBaRGtQeStsek5jNWcr?=
 =?utf-8?B?OWRHSDNFU3N3dHM4dEtNTkhYSFRNbDUyanhseXZjVVErQ2VoNDdBcnVrVVdn?=
 =?utf-8?B?TUxXWkx1UTNMSi93bi9ma1RoL2lUaXU5SHlqcUFGb3FtdUl1d2hsRE9UK3ls?=
 =?utf-8?B?dkhTMnBwSDQxZjh1bkFQZGZUL0sxa2dIZlNaaUk5dm9WYU9PU0tmQnZEOFZj?=
 =?utf-8?B?R0lXZWtjOC9WL3NyZ0d3VklMSGpvejV2Z000OGFkNDFzRlNLRjNFTWR3N0FW?=
 =?utf-8?B?dmVkRmFBNlVGOTlneFM4cGVmM1luYS9aUmgyaS85cWtuVlNxa1k4SXdvQ2NM?=
 =?utf-8?B?SUdCSGpLOW9zenlNKzBMaFV2M1QxNmZHZ3BSc2hzeDZZWFgxV3E1VUtjTkpP?=
 =?utf-8?B?SjhGZThZdktFUllyUS9CSjlBQzE4WGR4aHVqblZhZHFYL1JtTHNlTkJibFg1?=
 =?utf-8?B?RWIzR2NPRlpOWkUzUkdZRjZRVldXZitJT0M2ZjJySjJQU2xtMkhSUmZsN2do?=
 =?utf-8?B?cUJrTUJNMWdFQnU4VTBnc2VYQzA1ck9mVE5NTFVqMFF0NmRFOEZHOUFmdlIz?=
 =?utf-8?B?cHkyek1MeXlpOXRNaTZZUEJMY3BWM3BHTEp2bWdZOUpRNm91ZEp1a3dyYTBM?=
 =?utf-8?B?RytsR3dYcldnZVlyVzJjMTk0bjZ2dXh6ajYweXFJbFVpR1ZpOXl3K083bUZP?=
 =?utf-8?B?b1BlTjdFRGRqcEZIQ2hpR3k5TWFUc3FRNFZ5dHdsdG5PMjY3cFBvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f967dc-f569-4460-8d95-08decba61805
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:52:16.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTctVtbuQxIAICle6jprcRwEYg28h4+4RSzat0cJHVW0qdMBXBYP+do2C0wtkqhIzcOjUh55QxNZchsmV46bpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546


On 28/05/26 01:55, Sumit Gupta wrote:
> This series adds a kernel boot parameter 'cppc_cpufreq.auto_sel_mode'
> to enable CPPC autonomous performance selection on all CPUs at system
> startup, avoiding per-CPU sysfs scripting at every boot.
>
> When autonomous mode is enabled, the hardware automatically adjusts
> CPU performance based on workload demands using Energy Performance
> Preference (EPP) hints.
>
> Patch 1: Sets CPPC Enable Register for both OS-driven and autonomous
> CPPC control modes. It can be applied independently of patch 2.
>
> Patch 2: Adds the auto_sel_mode boot parameter with three modes:
>    - performance (or 1):         override EPP to performance (0x0)
>    - balance_performance (or 2): override EPP to balance_performance (0x80)
>    - default_epp (or 3):         preserve EPP value programmed by
>                                  BIOS/firmware
>
> Patch 2 depends on Pierre's series [4] ("cpufreq: Set policy->min and
> max as real QoS constraints") so that policy->min/max set during
> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy().
>
> v3[3] -> v4:
> - Add 'balance_performance' mode which sets EPP to 0x80.
> - Add CPPC_EPP_BALANCE_PERFORMANCE_PREF (0x80) constant in cppc_acpi.h.
> - Clean up EPP mode selection with switch + boolean flag in cpu_init.
> - Use local variable for kp->arg in auto_sel_mode_set/get to avoid
>    repeated casts.
>
> Sumit Gupta (2):
>    cpufreq: CPPC: Set CPPC Enable register in cpu_init
>    cpufreq: CPPC: add autonomous mode boot parameter support
>
>   .../admin-guide/kernel-parameters.txt         |  20 +++
>   drivers/cpufreq/cppc_cpufreq.c                | 154 +++++++++++++++++-
>   include/acpi/cppc_acpi.h                      |   1 +
>   3 files changed, 170 insertions(+), 5 deletions(-)
>
> [1] v1: https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
> [2] v2: https://lore.kernel.org/lkml/20260424201814.230071-1-sumitg@nvidia.com/
> [3] v3: https://lore.kernel.org/lkml/20260515122624.1920637-1-sumitg@nvidia.com/
> [4] https://lore.kernel.org/lkml/20260511135538.522653-1-pierre.gondois@arm.com/
>

Gentle ping on this series.

The dependency it was waiting on, the "cpufreq: Set policy->min and
max as real QoS constraints" series, is now in linux-pm (linux-next).
I rebased on top and verified autonomous mode works as expected, and
it applies cleanly on the current linux-next.

The [1] reference in patch 2/2 points to v2 of that series; the merged
version is v3 [2].

If there are no further comments, please consider acking and queuing
this for the next cycle.

Thanks for your time.

[1] 
https://lore.kernel.org/lkml/20260511135538.522653-1-pierre.gondois@arm.com/
[2] 
https://lore.kernel.org/lkml/20260528090913.2759118-1-pierre.gondois@arm.com/

Regards,
Sumit


