Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF03BB119;
	Tue, 22 Sep 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088450; cv=fail; b=L46R6yyhANq52YRBB/oHRY3Zvhp2NpVZKeFxSqDaOGlpCU8hfSiZvW4UUSDMtEGOr8cx+efIlFeYi0BZImVMLZmDD//HdzohItg/w0IxPs5dyKTlZjSss5D5+QEtrCiUhsL8AFYWNEX/6PaO9UKfFzMRrwCuy5fwpShtiMK288I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088450; c=relaxed/simple;
	bh=HFsqi45e4Pm5DcCaCJLPzrPBmGQ8SBumOR81zRTFzvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GGqpFxk5pdxoqVtDc8JwpmZWzjB4H3KlurcIsSFG2dNZ9RRW5P7GdtjJBAlH+6KeR5XO87H29EMpxAqWxC3B1Ga4YQRaMik/lrpUXpcz/ftkAVpL0J75G2I8JNhpOrodMOGgqfBHq/gBxOUJM4FDj5qvEEHYlEvA8rv+jLB2kF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1biAI3cz; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1biAI3cz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnaVhTj/SvIEaR9yWgVlxnfs4/ctz6Jaw8urZFEny8LQ/8iYqNzFL8t/C7t3gzLQQ/7mBc9nIo+9w86tV5OzsbTDUfDWpTVLmRyOIE7MfWhM2aJwERP7Catgr0d5f1sdUxOfSWnhVlTNGXU3mZIE35GwGW3WebohDRzKE7CRxjuw/g0mc9t285U7CuiDJ/RsPHDRvNfioiyyMDwuOfKAIuz41GqTqnuWVk/JGlYC/xBDvD67D9PbBoYYEbd4LZC0E3YJW5UWvx8XG7zmoUy59lYJAF9LUBqnM2jkB7Rz2GYrVxHnJPsLNPKlkbi00nF00/r+Cu2qPT9HhI8VwvJYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKljoeMRsz9rkTp2Glzl/zsrTm1JGN5+WbB8IbyIGFI=;
 b=mqL1gWvW0yT8sd5PqMWU7nDr7FkAGuLaUKyl2OYAEk3Z7zGbpNhZecSn+fY9cVORMZW/uUUzU/lYY2PdbN2QIAm4gPrAG06tveTp1TR27qMdWrFZdT81bgAKJlFciBPGqukjn7OHFgdB3yreexJo0ZUEQo/Ud9+ITHo2ce50C5GTCSmf86hlKSCL0rUjPofAYfl4DvY4hsdd/U7fvnQvwsOOJFpmznRNZFfMflWZP3DWJMwhRZ4xBcVELG9SGYKdwTmShsFAtlgH4f1SkY0082Y0PC1j/a8UokpYmzIWMA4ouCEzxFPERrGxdp6G8c9e4F2CtiBXxViNhipsI1LtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKljoeMRsz9rkTp2Glzl/zsrTm1JGN5+WbB8IbyIGFI=;
 b=1biAI3czr13SGnmbiYwMjTH5wE6Ee952fWK5U/J2VHvPKTuu03Hha9FLXdSjwbfveye4CjZrRzlt7AqlOe6jKvIZRjXsJso939NKHQBZijuah3If+5zsvq3rx9Lu1cogg+3jd+kk/7Kn7I3KM3fxWVfOGfYnmDdpm75OS1CRE6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 14:47:21 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 14:47:21 +0000
Message-ID: <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
Date: Tue, 22 Sep 2026 09:47:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17)
 To PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f127f78-1d95-40f1-212f-08df18b86851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	g1RC5Uo8tJ6be/7N70QGWtPDZKvXLGIZSkPyncwc/Kylnehv8txNp+/GfaE+A+GRhEDIcfTVBu1AyNY6lyhk54RIIfXxv5qUQWsNBC4fbFYvKyE1RGmuXo+qZlRf/ElzAFIor8CJWQxvca2w5Vpf1thhbHlnymrDcK0a9wBNZrK1gKey3pVD1FcHvslnSuYTiSTC38du7cXhDPNpKSxtFcWYr6jVIMA3qYxNFWhRJowrAHcbhO7TgYci/hsITecBIhAOKqi3wpssFFC1z5HZSwIFkfACLNv1aVY4U48gb5Gew5Sj4s4MAXKz/c7La8zwBuRM8t3/IlsQdJ/tNl5jI65AEMVtcxWDXOsTQXTLcAugvEKZOgG8Nf/Mx40Bo0tPQCnlOWpbDdNFsKabkJdrAnefbrFM/Kn5O8+kkv6w8lfTSraXpsEtkdwelMw85JLgklIMXVw4lyZKDM5JJwpbmk2JDjfUYwxF4J/kG3Gu5Qa3FNSrBzEXnw14/jWObWy35WnoWH/j50v7gePCANuRfqc882I1eBOabUYLKHgnjezFkCB15tBH059YcGQE9DrfcryrR26WNIu8xxR/8N9yWaBgFtrDNB4KPXrWEtu+n6eAfQKpB+fpDhU+9W/1iI03MIbsmrtjtxGDtNHoIC88bXT5neQAQts5yNS3Q82QOsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekh1d3F0Y2xuZnd1Vk41djNDYmRIR2ZvOUU4TmhSM0JXOGpONWVJMml5ek9R?=
 =?utf-8?B?d0s5cjg4U2xzK2pwQ1NmZlh1ZUlwdDkyRExtQ0lXeHNPaEdiQ285N2RIcERO?=
 =?utf-8?B?Q0tQcUJDa1lkVFBUS21HWVF2M3FLU2l2eG1ieDJhNWJYZWhrQVpUT1pGeVMv?=
 =?utf-8?B?K09iSWRCLzlQT1dWSWxPbHQ1cUEzMEVrNWczckdJWVFqQWJRd1ZVNExQc0pD?=
 =?utf-8?B?MXpPWFM1UEVFVy9KZ0xqNkZTdnpNb1hpYWVlc1FDaTFzc08zR3NBZ3pWeUpi?=
 =?utf-8?B?YUZIbmF2VDY0V2dlWmdyNVl4bGhnSTJ0MldDK3VWTStXaU81emlBRHNsekV0?=
 =?utf-8?B?ZTNSdzhSalAzMlBxWWpBOUU2M3dWQjBDUkszYmR3TEJmMTd4OS9LMFlHMDVN?=
 =?utf-8?B?azRuVkhpTit0UUovbk1QNjVlbGRqNS9pWnNURnF2V0JURERwclZEaHNHRVQr?=
 =?utf-8?B?bkxXMWcva2ttVHhaaENwRHY3d1g3UnUycW1uNlFmd3d0OEhMVjRiY21ZVnRZ?=
 =?utf-8?B?cmdoYUtkekg2UXRwcm1aTEVDVlhQZXVIcGJuaENaRzZTVzdNMk1HLzc2cUFi?=
 =?utf-8?B?bXNDTWYwK2JnTjVUQ0EzMkVwWURZbkpiWkVLN2hEYzlIbUpWTzE0aTZCRldT?=
 =?utf-8?B?Q2o5SjYwTUU1dExFVTVzSWd0ek5WMUh1ZFVaUzYvMnRPQ2JjRkJ0SXVIOWxh?=
 =?utf-8?B?aFVUcHE1Z05nMkozMko0VU9tNHBDeGtUVzJ0KzRkNW1kNnQ4bER3aUtFNi9x?=
 =?utf-8?B?ZGJFbVJ5RVJWSWtpcFBBUS8xc0NuSUN2MGJvWFZnTnZUV1VGbjBCSzdkVDNk?=
 =?utf-8?B?UHhsd25XMDRlRy84blMxWjAzYS9JTkNrVEZJdlR2dytYUGhVMm1zWDVRaXd4?=
 =?utf-8?B?VkZYU2dLWEdlREQ2VDNLMXpjNGJTWG9iU3BmRlFvTzY0aU5xZGJOS0t5OE9W?=
 =?utf-8?B?YjF1THdhWWtMaHdHUnpZSnZYM2phcTAzYUhsL2NUYjRwT3dRRFk2S2psQ29M?=
 =?utf-8?B?a3pwVVp1b252N2VPN1FDRU53UDhtelpFM2FSZ3dXSGpBOEFNRlRUd0lPT3dT?=
 =?utf-8?B?NWlzczdlL2ttQkRGdkVUZWR2TnhLWEdtVXNQVWZ2WDdMNVk5cVB3d0dNcXNH?=
 =?utf-8?B?ZzdWYWwzU0xWVlB3YWI1RXEweEZZZ2lyZ2ZST2EvN3p5WEE5aElTd2p3R3ZC?=
 =?utf-8?B?YVFJc1g0WGozQWtqb3hlN0huVTEzVTZkTEFSSXJkZUhGRmduS245TnYrdk1S?=
 =?utf-8?B?MEQyRjVEYjMxdUxJMnRlM1UwUGx6MzVKSlEzOUdSOE8vYmRpbHZRSWdHVjNT?=
 =?utf-8?B?N2RpWGVQWEZjQnRjZDhkVGNHSGZ2TVZ4cWdPRzdvZlA2Um9KMDhWb0t6amRq?=
 =?utf-8?B?YjF5VnpHZjl0bGFrRml0c092MkRBUmx5Z3VUbTI5dlBCZGhXVVZqeW5wTzhQ?=
 =?utf-8?B?T2IvaTVnb1dCcTR6L2hXOXVWbEdMK05tblpZanBKQ0pDeTNRT3ZjVHJjeVBh?=
 =?utf-8?B?Wm0raXhyVWVLak1hcXowL2IrdjFudk52aXRkU0tueFgveitiazN5dU5CaW5D?=
 =?utf-8?B?MnFaU3F0L2JVZlQwdXB4VWhna2x6bFZReUxyQXoyc0Z2eUczbEtMQWRGaUl5?=
 =?utf-8?B?RWRZRWRpUm1nNXVDQW9LOUdDVVdWNEpwbFFzQUt3RUV6VDkydHBnYzYwa2NS?=
 =?utf-8?B?REFNaVRtMWFuNXp3Nm41N2g1SzA5MjFsNzJMZWVNUUFaQTJ0cHBneFlHN0xF?=
 =?utf-8?B?N2swdVpEaWRHL2lJY2dmQ0loRkJDczJPMERrWGRrOXNKTkRQUGZzMHdzM3Za?=
 =?utf-8?B?YlZleVg2Q2dXMjF1S3FCT1luRDNxelBLMVE2Nm1lK2pSR3hXVzVhb3E4bkxn?=
 =?utf-8?B?aUQxcDFDTllZY2Y4aTBaQTkxakhsSFFkdkxQNmZSdHNCNXd0VWticlBHajV6?=
 =?utf-8?B?OW1UazZpdlNkQnkyQ2dZWVNMUE95MWt2c0VNRGhPUWJReUs0b0o5a0JNZ3NQ?=
 =?utf-8?B?TVIwUDRTSEhQdmZBaHpOb3NFQ2twYzBLY3pQYU1KTGVFQ2RrOHplcmt3UnpP?=
 =?utf-8?B?TW0rVDZra21XRldZVVloUTk4dFhOZ2xBL2Nka3hKUXgxYkNIM3B0SUNwc21l?=
 =?utf-8?B?Nm9KbEkyYklBMHpDYkRqQkFVK2h5dkZzQzJ1ZGFRVW0zL2laOVdWTEt6VnhC?=
 =?utf-8?B?ZENEVGRzVkN3RVovanpvVVJBV2xiRU9WN3AyYXNDOTM1WS9KK2Q0M2JtZ2dG?=
 =?utf-8?B?Zm5JbFJqblg4d3pManpXREo0T0NCbk1DYW1JMWh6K0VDMnlwTXUyK3BuRHhn?=
 =?utf-8?Q?WI47gWyvLanAnCqLxV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f127f78-1d95-40f1-212f-08df18b86851
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:47:21.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6w2xl4QABZaydt7lz826YPuq5Mu/TB+q7XDHLoV9P4SEE8CUszN5gmgBh0+cLeJIu4TzSbQnr36jM0pI7SpBBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436



On 9/22/26 08:43, Fourhundred Thecat wrote:
> Hi,
> 
> On a Lenovo ThinkPad P16s Gen 4 AMD (Ryzen AI 9 HX PRO 370, Strix 
> Point), s2idle enters sleep normally but the machine can never be woken 
> again and has to be force-powered-off. The trigger is the number of 
> online logical CPUs: with all 24 threads online the failure is 100% 
> reproducible, and limiting the kernel to 16 CPUs makes suspend/resume 
> work reliably.
> 
> This platform has no S3 at all, so s2idle is the only suspend mode 
> available.
> 
> 
> Hardware
> --------
> 
>    DMI product name    21RXS07D00
>    DMI system version  ThinkPad P16s Gen 4 AMD
>    BIOS                LENOVO R2XET40W (1.20), 05/26/2026
>    CPU                 AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
>    CPU family          26, microcode 0xb204037
>    Topology            12 cores / 24 threads
>                        4x Zen5  (core_id 0-3)
>                        8x Zen5c (core_id 8-15)
> 
>    ACPI: PM: (supports S0 S5)
>    Low-power S0 idle used by default for system suspend
>    /sys/power/mem_sleep -> [s2idle]      (no "deep"; DSDT has no _S3_)
> 
> 
> Kernel
> ------
> 
>    6.18.51 x86_64, gcc (Debian 12.2.0-14+deb12u1) 12.2.0
>    Custom monolithic build, no loadable module support.
> 
>    Relevant config:
>      CONFIG_NR_CPUS=32
>      CONFIG_SUSPEND=y, CONFIG_ACPI_SLEEP=y
>      CONFIG_AMD_PMC=y, CONFIG_AMD_PMF=y, CONFIG_PINCTRL_AMD=y
>      CONFIG_DRM_AMDGPU=y, CONFIG_DRM_ACCEL_AMDXDNA=y
>      CONFIG_THINKPAD_ACPI=y, CONFIG_ACPI_EC=y
> 
> 
> Reproducer
> ----------
> 
>    # echo mem > /sys/power/state
> 
> The system suspends cleanly. The ThinkPad power LED then shows the EC's 
> slow breathing pattern, i.e. the ACPI LPS0 _DSM entry path ran and the 
> EC considers the system asleep.
> 
> It never wakes again. Tried, with no effect:
> 
>    - opening the lid
>    - any key on the internal keyboard
>    - short press of the power button
>    - clicking a USB mouse, with power/wakeup set to "enabled" on both
>      the device (3-2) and its xHCI root hub (usb3)
> 
> The machine is also not reachable over the network while in this state, 
> so it is not a case of resuming with a dead display. The only recovery 
> is a ~10 s power button hold.
> 
> Wake sources are armed. From /proc/acpi/wakeup:
> 
>    XHC1  S3  *enabled   pci:0000:c5:00.4
>    XHC0  S3  *enabled   pci:0000:c7:00.0
>    XHC3  S3  *enabled   pci:0000:c7:00.3
>    XHC4  S3  *enabled   pci:0000:c7:00.4
>    NHI0  S3  *enabled   pci:0000:c7:00.5
>    NHI1  S3  *enabled   pci:0000:c7:00.6
>    LID   S4  *enabled   platform:PNP0C0D:00
>    SLPB  S3  *enabled   platform:PNP0C0E:00
> 
> and platform/i8042/serio0 power/wakeup is "enabled".
> 
> 
> Bisect
> ------
> 
> The regression was introduced by raising CONFIG_NR_CPUS:
> 
>    CONFIG_NR_CPUS=16   suspend/resume works
>    CONFIG_NR_CPUS=32   suspend enters, never wakes    (100% reproducible)
> 
> Booting the *same* CONFIG_NR_CPUS=32 kernel with nr_cpus=16 on the 
> command line also works. So the trigger is the number of online logical 
> CPUs at suspend time, not anything else in the build.
> 
> NR_CPUS=16 is of course wrong for this CPU -- it silently leaves 8 of 
> the 24 threads unused -- so this is a workaround, not a fix.
> 
> At nr_cpus=16 the kernel brings up every core's primary thread plus only 
> the Zen5 SMT siblings:
> 
>    cpu0-3     core_id 0-3     Zen5   primary threads
>    cpu4-11    core_id 8-15    Zen5c  primary threads
>    cpu12-15   core_id 0-3     Zen5   SMT siblings
>    (absent)   core_id 8-15    Zen5c  SMT siblings
> 
> The 8 CPUs that are absent in the working configuration are exactly the 
> SMT siblings of the 8 Zen5c cores. I have not yet narrowed down whether 
> the threshold is exactly 17 CPUs or specifically the Zen5c siblings; I 
> can bisect nr_cpus= further if that is useful.
> 
> 
> Ruled out
> ---------
> 
> None of these had any effect (still hangs with all 24 CPUs online):
> 
>    initcall_blacklist=amd_pmf_driver_init
>    initcall_blacklist=amdxdna_pci_driver_init
>    runtime unbind of amdxdna, amd-pmf and tpm_tis before suspending
> 
> 
> Possibly relevant
> -----------------
> 
> After a *successful* suspend/resume at nr_cpus=16:
> 
>    /sys/power/suspend_stats/success         1
>    /sys/power/suspend_stats/total_hw_sleep  0
>    /sys/power/suspend_stats/last_hw_sleep   0
>    /sys/power/suspend_stats/max_hw_sleep    18446744073709551615
> 
> so no hardware sleep residency is recorded even in the configuration 
> that works. It may be that the working case simply never reaches 
> hardware s0i3, and that the failure appears only once the SoC does enter 
> it. I could not confirm this: this build has CONFIG_DEBUG_FS=n and 
> CONFIG_PM_DEBUG=n, so I have no /sys/kernel/debug/amd_pmc/s0ix_stats and 
> no /sys/power/pm_test. I can rebuild with those enabled and re-run 
> whatever you would like to see.
> 
> Also, the 21RX series has no entry in the fwbug_list DMI table in 
> drivers/platform/x86/amd/pmc/pmc-quirks.c; the Lenovo entries there stop 
> at the 2021-era ThinkPads and some 2023 IdeaPads.
> 
> Happy to run further tests, bisect nr_cpus= to the exact threshold, or 
> provide full dmesg, ACPI tables or the kernel config.
> 
> Thanks,

Try this patch.

https://lore.kernel.org/all/20260826171537.4167367-1-Vishal.Badole@amd.com/
