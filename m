Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8E47F780;
	Mon,  5 Oct 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211365; cv=fail; b=Mwn9bmtKpqKK8jBX5mitC8aAm376xh1Jjt+eeSzKchglTG3BWrNnWHfS53f0Y2jFYA8NoBhBeL++Bvj/+nQZwY6JN5OUJt4CuNq0xeoyJIGorI3nU5TLXzqMjLdSpp5RAoyWKz2wPvGzpA/9wg02jU8tUrWPowKQJDpJrcMkdbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211365; c=relaxed/simple;
	bh=+aaGoQ7mhyRgreauocxu0xHwsz2JfRei27CVDmlBCdE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0QLPL1QGICoeJ6Lmbqpn4OLKAKoKzcQU5lL0sAa+GoGZCA6kBDTqLHgYXJnWOI8ZgLyQRyHZMnw9sp731dBQdhVoAx2N1BGAX9448lEZSqw62Yrp+QZEt/V6AmCluir1vEI1GVrZiY9FOfhBSwWQehRurxL4W4Uy3MW2ubN+vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2lSzo96M; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2lSzo96M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMPQCQn++bgS/aJVVzHxAHKO2q94Xmn9ivE1y4dAC5hHjYhEkhNjoXRvuTK1XlmlUYq2Hj+DfvzCM30EddlBgVhbLPTG0TqLAuNMnibcquQzz7KFQffheyQWFFl5ftKlFeseSJyuWmsvIg77CFeDNK8tFom2nwji8sdF1z97vmIoSDhaaOs0BrJ1RDDTV16eqUyx+GAtiWD6k169rC+DNVP7XPw9oymTr4gj/8XG/woWROD2AalKg44tz+4jEOSOGFPLtwrCodJAYBldfwqsIYtl32kYF+7MnYqd/JLun5CrytytoQGP4I4uvJlS3iRRDJ7YFJpKdQ95RckP2AKw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozQapIaRPORXIiw8IWXMvRieVpdxkiKKXAPmXlZYK20=;
 b=drUmKS0h32T+bdStouGYL7vn5j+7BMvGPWldGxP7l2fsrb8mdoBPBDAw2kLIkqMMRgBdM4g8R8Vsy2bwBKG25Y6ZKCZdaTSXbTi9b3pdKUiHv+NWNj0WZN4AztwrEtpPJTE4e7TmKjlHTdwAcF1ZEjBQj8glktSsOQH0WcFUsyy4SNiCURr0VaBHC1OMlSA+eILoXvcoTeQNNe7UrCCA+UfDs5l2r6umy9DGRQxErziPyuSMgjhQ/L5R/34hptSBOfQros484KxBJGEDeRKvj9+140tt/K0KECjCxOyiNKMNBA1vOioTW9C0azy+Q/0ISOTHX76HG8TxLjNmaajN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozQapIaRPORXIiw8IWXMvRieVpdxkiKKXAPmXlZYK20=;
 b=2lSzo96MauIi5dfeNTqGw+GDIPiClhY7kkjUB+WXbN2LjKuvDWaXvDg9m91PBoSm1l6xfQEFbVuzVJBbxpMVX8krsQBdcUpREpqZNeIWwwhESJNMzoQOuGJ4rNWwZl1+0o7UB1X1aglnRjUjDxr/GaNGnswvSGA/xJk8RoVUIFU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 14:42:30 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 14:42:29 +0000
Message-ID: <9159cb48-9b32-4db7-b876-85a48a3bb2a7@amd.com>
Date: Mon, 5 Oct 2026 09:42:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Lunar Lake: 400 MHz after s2idle; PL1 Tau affects
 reproduction and recovery
Content-Language: en-US
To: Scrimas <isma.ph@proton.me>, Sandor Nagy <sannnagy@icloud.com>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 rafael@kernel.org, srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com
References: <20261005071610.885801-1-isma.ph@proton.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261005071610.885801-1-isma.ph@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0889.namprd03.prod.outlook.com
 (2603:10b6:408:13c::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: d6beb49a-6f4d-471c-a7b2-08df22eee1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tZwZqvSvPxT7my5wFTGr6jRbqiT8qUCFG/2U2QE1yIwyodrZa/v6GCEnwidCrUOUXGkRGHfxpp84CXXqSj8icNhsKqE+gLXwdRzr+tZ6WdKfpTT3SM5KO2k+y6ZueRQcWWxpxipLGvL310mQhGjqPxmXx3Kwn1lr7ggZRvGVgLyiHXMlU5f6r3WnvnjP259RnZ8kdQ+NPoPWssOeJ9M2gDXx7tDO8/L67fowurIctWT+55KsZBIiDbym2mBfw2lQgG1gsqS/9aZpjX70z8vKmHKJ6va2i8Kp/74SVkglUXSxcwZKrUEYV63ouwdXgjUlPb22H34LmpoklCUqtc/LWA6fU0AZoGklsqQqsdNPo3RmY4UQO2uRu8xqBk/f06SDwWiaW7Xw2YLPVQf9H48AwEBTgPW/L3SNWlkX/YLIXErrUqCn//Su3kqGJxRvlcoAy561VrXt5oQmqs81wiiOqAN1MbFTfGt6xX0CsecO5GoJ6psn0U5Ar1qqvxtsKeetEHF4if4quilQKAZswEyiWi814c9rvvRBB6QCfoQqqxvUfEp+hzorlj+H0PxdslxdeYVHKTHsr4rOQ0Bh5E04m1tlOYDwcMQZy3hwM7KQAY131mcZQznnNbZBZfvqCOLYjKBtcsl04+crNfKy4ndsOXxRFIq/qxFZeYrliQFke74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG9WYy80QllEd2ZhRG1xalFBN3IvUGR6R3VxTFljSTJzMmZqSWFzT01PVDAx?=
 =?utf-8?B?eEhEU3p5TW1GekNiRFdpNUhDRWQ1UTBKS3UyZzcrZUdLOUxNNFErR3ZuY0t1?=
 =?utf-8?B?b0pjZ3pRR0FmMUNNNkVlMnExV1NsUTE4azlmQ3R2dExXTGFKM1FqZWc4WEdF?=
 =?utf-8?B?SkhUeGdrVFl3K3lLUzVESHJxbUQvTU10Y3BJbVdTRzVuczQ5OEMyVEo4bnZD?=
 =?utf-8?B?TkpzTmpOdDZrRW52UnFkUDNxZ2xncmFJbG5TUWZ4OHAreWE2YXpRR1NBTlN2?=
 =?utf-8?B?SW1QalFjellOb1llTloxLzFJL0VDNmRBcjE2SW1NTnY1aFlia0Y2NjNKS3l0?=
 =?utf-8?B?NzRHWVRvdi9QRTRGbVdtVGNTZmRsc3BFdFZjNERJd1lWMS9CNEJxWFVDVWJY?=
 =?utf-8?B?Zi9jOVpyVGVocFcwSjZrL3VYYkxkWHVabS96YVU4WUE1OE5FdXhHQkRRa0V4?=
 =?utf-8?B?MGRFUGRGaXZtQS9XeEFLdy85VFZDdkdJR2xLNzlBM3h5T2VQV0ZXK0lhcDkw?=
 =?utf-8?B?WVNUazBCbUdxZ29RRVBDNjRvQlByb3NOM3NXUVZMKzdoVkczeXd0NGlVemdN?=
 =?utf-8?B?V0VCS1BHRnBhYXMvd2tPMU8vWmVBSjBDMnhMVjhsL2o2UXg4TDk0UUpxeXRx?=
 =?utf-8?B?NjlmNlEvUzVGQWhXbEVxN1RkSTJaeFVBL013UkhmU1pydFlvamdaNjhUWTJt?=
 =?utf-8?B?SWlmRVhkMDFmYWFQRnptMEwrMUltaG5lMkJJS3RvVStobUNmKzNSU1dZYnhG?=
 =?utf-8?B?ci9DS2I2dTJHRFBWQ3VPbGpibXprNGQ2RE1HQURBUVZ0eGJGR24rendWQkNy?=
 =?utf-8?B?cVZpdkR5UTJIb1JiaTBLMGJ3SEVKQTdJL2dGWGxXL3dVeUhrMmJTa25ub0tF?=
 =?utf-8?B?WDJSM2FBdVpjalhmcUt1aTh1NzJtY0VUOUxmYTNxSmRMZWR6d2ZWanhwN0t3?=
 =?utf-8?B?ZjBIZkpOdWo1TGNyclBGS0FqUk1jMEZpajJTWXZHMDM1blVEZXR6K2xqbUdy?=
 =?utf-8?B?RmVqM2h5aFhBTk9IRENwY3JCbWp3QnlvaWQ1RHYvU2VNQUV3MkFaOStxYVdO?=
 =?utf-8?B?S1cvdHA3RkhXeGVHTHV6a0xrYytiTTZSWVhydGpacEVLakJoM2tPcVdoSGN1?=
 =?utf-8?B?OFdlZzZ3b1pUZHFWNjUwSzJyeVdLdHZybTZiT29kNVlPaU4reGVWeXFxa1p0?=
 =?utf-8?B?V2FEQ096cDhrNWEyV1ZsOWtFUmlDWDFQZHdPQUVxSFdOZE54Rzh0VGtvSlMx?=
 =?utf-8?B?RVMrY2NJY3pqWGx1TE5IcXRGS3dxR0JrdWZQRlExR2tKMzVENmZrclpkdXZF?=
 =?utf-8?B?SGJLYjhkQXdNeGo5ZUtVUWh4QitFZmJtUERYSnBhR3VRWHcrcENob0xXZGwy?=
 =?utf-8?B?QlVEV1dkNnp2T0ttLy9BcGxoalZNMGJiTjdMcDNndnRja0xBTHgrc1Z6dVdk?=
 =?utf-8?B?aVQ3azZTWEFoTmV6N0RFRGhabUJyN1QweG44OU04UHVHNWxkYXBqSC9NNjRo?=
 =?utf-8?B?V2RYbkdaWEhLR3hxczBkZmNzc252aElnY1l5Q1ZlZkVHUkZwanJUYzRHOUNE?=
 =?utf-8?B?UW1Cek5xR1VYLy9aM2M2ZjU5UXNnb2NwelJhTUhLajZ2Y1E1QlVwSDg3VzVx?=
 =?utf-8?B?S3Z3MGNqN1JjbE9EU2R2Uk9nQ3BlSHY1bXk0dDBOdHNUem1wc2c4K25Pa1p6?=
 =?utf-8?B?N0F0NUpra1Q5blVwcVFDWVdXbFREV2dHOEMxeGhLMDlUNHc1STlROUg0OTdD?=
 =?utf-8?B?M1J5c0NtZkFJRFFqUGJWWjM4R1pJeGdTTWF0aVQ0enFNckpRdVFhTWNVQmRn?=
 =?utf-8?B?VDBlbVdLYXJ2RzJvVjFKK0xpcDRpWXpFV3hCaXViQ3dsV08vWTZWQkU4THk0?=
 =?utf-8?B?Szc5a0hJcEdGSTE4NENuYXo5a21md282SDNvWnUwempvdDhOT0hHT2lYSlFw?=
 =?utf-8?B?bXlrUWJtRk11UVNleURXeWkyWTZhNzl3RFA5NUNoRE04ZVhWVFRPSXZsL1lJ?=
 =?utf-8?B?RFpRMFdIeVBiM21xc2dPQmNBWTltR3ZxanZSckpuaEpSaXNoSm5aa2RVL1Bs?=
 =?utf-8?B?YmFmUmtLeXFhQU9JZnpmeS9Uem1yRFUrZmVUM3RwRGZIVEZRQndjeVR4TFY4?=
 =?utf-8?B?S2hld2tZaFZYUERsOUlsYXZ5REpua2R3MlMzR1VNNWZ1MVIzR1EwYUcwQy94?=
 =?utf-8?B?ZHBHTDZTdWtJalU0NUR6NGdOTTlWZjFiS2loaUVuMXVWL2xSNWMwb2ZoYzUx?=
 =?utf-8?B?MklMQmZ1dFdYUXpHTGNXdGFtU1l0UWpwTTlhNmtuNVF0azJFRmt6NnlUb2hk?=
 =?utf-8?B?TWxzVFBkMEN1dU1IQzlEYVN0c0FhbVZwejg2Z1NQQmFRK0QrL0MrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6beb49a-6f4d-471c-a7b2-08df22eee1d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 14:42:29.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K5/KsgPzb3gK43JY8xFdpaAbpOUaFD/l/Cw07ERkuZbjaQVyMwgpLBrJ+BqlY/sg+NrRei8NScfhruYmJ0qiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693



On 10/5/26 02:16, Scrimas wrote:
> On Mon, 7 Sep 2026 12:00:37 -0400, Sandor Nagy wrote:
>> My ThinkPad X1 Carbon Gen 13 intermittently resumes from long s2idle
>> suspends with all eight CPUs stuck around 400 MHz.
> 
> Same symptom here on a different OEM and a different SKU, so this does
> not look Lenovo-specific:
> 
>    Samsung Galaxy Book5 Pro 360 (NP960QHA)
>    Intel Core Ultra 7 256V (Lunar Lake), BIOS P17ALY.390.260616.03
>    Kernel 7.2.9 (CachyOS), intel_pstate active, HWP, s2idle only
>    platform_profile=performance, EPP=performance, on battery
>    PL1 34 W (MSR and MMIO), Tau 27983872 us (same value as your X1C13)
>    thermald not running
> 
> I log 60 s of turbostat and the xe GT throttle reasons after every
> resume. Over 2026-10-02..05: 13 resumes after sleeps of 1.5 h or less
> had no 400 MHz samples at all. The one resume after an 8.9 h s2idle
> had all cores at 400 MHz for the first ~9 s of the log (the log
> starts ~1 s after "PM: suspend exit"):
> 
>    Busy%  Bzy_MHz  PkgTmp  GFXMHz  PkgWatt
>    16.37   400     25      400     2.38
>    73.94   400     26      400     3.23
>    49.75   400     27      400     2.87
>    ...    (6 more samples at 400 MHz, 2.8-3.2 W)
>    40.94   480     28      400     3.04
>    37.83  3557     39      400    10.57
> 
> During exactly those seconds, gt0/freq0/throttle/reasons reported
> "pl1", then "none". So the package was being power-limited while
> drawing ~3 W against a 34 W PL1, at 25-28 C. That matches your
> energy-averaging hypothesis.
> 
> Ruled out on this machine:
> - ACPI _PPC: booted with processor.ignore_ppc=1, and scaling_max_freq
>    stayed at 4.7 GHz during the episode.
> - Thermal: package_throttle_count did not change during the window.
> 
> I have not captured MSR 0x19C bits 10-11 yet.
> 
> Thanks,
> Scrimas

If this is anything like the similar issue that was reported on some AMD 
systems; try unplugging and plugging back in the power adapter while in 
the bad state.

If it's already unplugged, plug it in and then unplug it again.

Does that help?
