Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89151CF69;
	Wed, 23 Sep 2026 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167341; cv=fail; b=uGzXR1K3ob/hFSiDA4RuI70RiFxU3HzGaMkjxNdvvW2c/urppsfWaLgYY1m/V8BoeDhdIqJRT0BglmuKVsqXnrEJ/De88ZG7NPcXMRofe/rhY3hSG8v0cewMM8v5hf9eQx3r3UGTPsthwbbosGG4vFXqxPEg81BP770w0qlV2b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167341; c=relaxed/simple;
	bh=DoMFyxMqnibiEjq++DExCOUa7e9XGzI8MdjcAtPjC5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TvUaeNowtnoEKtQEElpvbk444gdtDxpUI7CxVYNtdG9q0lxjmqvBCGrzYHuaMFQXLKrh1WhGCBjspoKuPYQhj9gSsR1NKGaeWmtHJ2bEl7T0MHBYszGaabpE2bggzzshB6xEsld5JZFnu2GnGZya/8ewiY/XHP05Lji8Y2RSTYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b5AWQJRw; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b5AWQJRw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyL4CnpJ9HaS8+YtMc3evR/Fzn85M8V5kUBjQgP455ggDNNnESbje8iLQR8KpCPIVzjIiuzkaFXEEMnLIhbqiPFuNbqLybiJh+0QgWa/vx2ug+haaH9eHKpRtbHkUblscKrU2YJOAKt24TSx/cWwGyDLrtB9aUUve1v9b1yIhqi4PnfDTz+8iGb54VZLKOtkQ7Q3Ot4uuMS9r5q893EtCB5p7GXLVq3XLTr6lrEv7lE+zcFXXc+TUUiDg8DGjLA8XL9wKcPOj2JjGS5gG7s450E9uki+HwAqwxqqqcOKc3745/YDGmmOyJuiI6ka4M89VZd3t+LgDX0mK1hPoAezUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVg6vXBv1V3Rpd36bNRXVAQ4Ug436JMLWnh6NdgOjLI=;
 b=cW71c8nnPMQfy2CLngsp+Kfprf9L3ShZbJJ4wXAeZnkq2Qio6l9flgsBkgpeAumvbDGoJqKGU8RTJZQFKKS4IMG5PPKmSkSj9Sgd0+33LMDmwv/nayZUyDSj92X4dZsivX3Ob590/zui0LXH4qhR9yTO7/ugiKP+mcuUiq9yPUjhHybbGz5Jc+t8LHa/PzOJtHtruHVHJsA1tNJ7l0CxaDgNfmXQ9136ikQdL5z1I8H+K1Eg9mfY2ICNqXZt/8LIYjilEi4U1vj75HGKzWx2vIcBvEGVuM6VactnmTo8JZFXhSt7Fz7u7n2GqSBHlwMLRsyOUmfcUf2hODDPkcz8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVg6vXBv1V3Rpd36bNRXVAQ4Ug436JMLWnh6NdgOjLI=;
 b=b5AWQJRwjX3TDH89mh6Jm/p5x6rBy4xtUWe1G1w+JRSTjP+1v8KY7yfWPZgK9wd7cGBkrYu2sRWrRYKOLn5zMusCzt0HWfhleEZuyIrX2hc7+J9pedrhh8Jdf+Y753i9T485f4DtVycWs3p3VV0Fbkqh2I3R+ZAT2KIDpTMqr4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 12:42:02 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 12:42:02 +0000
Message-ID: <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
Date: Wed, 23 Sep 2026 07:41:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
 <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::16) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 51825e5a-1963-4fa6-2645-08df197010ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|6133799003|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TJIp3GvRGEZ/5tYxi4Cmlm4zpdYuBYxqfKnA/xFSfmSrMI2kqU1f+8JphIcurPPl9eAc7kpfsJ7/oGnFwOMPn6p6Ooys8qanvcgasMUcDO/v2LugKtji42yj6SNxI/dByw5YuahhtIC07QaTl2DO83aoqEaeyoxuUDQejui4XyhPYRUb1rGHLvHat0ReoQWu7o72bjmL8HHijO7BmVlGFB7RDJATAGFoEDRo36MJPbQrLvt6o0zR7GqWS+nbeW6ptKD2FK/Yty+UQSAcEc+Y/eG2tiLad+pt2AP+kcKhhOjRBWNFPWVkS1H9Xr4yjnWMOTEzLdN1MymO8juMNzeiJfCEGIV4w64mwAf7sGNcLpnBf4CUJjl63lhIgyp9D/NzPWAMAn1cfzL8x+YjOVcs7z+IUqE7TcKyC6ZcQy9ah59TZePsYtTDwcN70LACmTHV9Fq7KMstB0ECjqGC7F0iazGyS3e94j/PADfgMvL8QDgSNz2nrbK4lQAkYzZlcOzRuk+G8LJLggdJzRBC2sHNTYRXm/tP155VTHN9SsQiSrDVku8iX510AIax/7owk3Fh43CyV2oFAIkGcWZdGhttR0vcOkOw6YY86VqqnQX82EtECERDc4k0XStmHmvlU78zQSNxUkZpYDO7FcitqGmMxGX7ndRbLmUZGjU5aFiOzcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3FyTmFyblYra3Y4aU1FREVPemtuRlFSUmsyN1k2b3ZYMlh1a01MYjhJRDU3?=
 =?utf-8?B?Tzh1NFB0dHRRcG5PbGxUcnd3OStsd2lJVzdKTVBYV0JlT2IvNzdkempMNFkr?=
 =?utf-8?B?blhsWXVBT2l3VDZYYS9UNnJzOTRaaHd3VFNyd1pzRDRmVVJPa09INGJoeU9a?=
 =?utf-8?B?a0tRb2s0WDhjQ3ozLzBiWWxnUk16bTJoN0xCUUUwMG9aS3FhRDlOZUh3bFR0?=
 =?utf-8?B?Ty94aVRicVp6QlU0bkNlWTRIbWtZOEVJUEZrVTRwYmhiellrdCt3NmVxUGlL?=
 =?utf-8?B?THl4a1p0S2VQU1ZXbFlqd1lydHhwT2E0M1poRVJQd2RKTWZJR0pxRm44bXpR?=
 =?utf-8?B?UU9xMTJyM2k4VmNxVGY2c09YaGR3SVlvTFJmYVFxNWxsZTViTS9ubDEwbzJ4?=
 =?utf-8?B?K25uWlZXRzZpUVFZcGxEMFU3dTRpOHhoMVhHVFVUaHNPTG5ITXQ0blRHbll6?=
 =?utf-8?B?YS9BVHRUV1RQMUxjelhQRk5jcUxOMWJJMnpzeTZ6V0V3UTV1N2tscTBXNlk2?=
 =?utf-8?B?Ti9LdkdvbXFnMDdnL3ZKYzYyR0hMQkNFeXJVUFBwU0dKaExEMkNsTDJReDJE?=
 =?utf-8?B?TWVXOVA5ZkI2eUxkL0R4R2VwT3ljN1hRZFV0L0Z4eUl1MmRaUnRpS0Q3aHpP?=
 =?utf-8?B?c0FYcmdPZjM4SEplL3I4NkZ2eHhvbFYrVjZKMGRMQWE1UkJ5U3hvRGdwa0Uv?=
 =?utf-8?B?eWM5dnNrRkRzcExON1BxdE9JdEswUW9ldmh2eHBvVUhFZkdqQjNQdzIvR1d5?=
 =?utf-8?B?VXRRdmtnWTI0OVYyaW92WGNSV0h4cjA0enZ4cWtMelJhT0xhQVA2MFZvM2JO?=
 =?utf-8?B?WTA4N2hobHVaeWdNY0VDOFJGQXVTV01CVjFqc0RsWWJudWprUU83aWhxQ1p6?=
 =?utf-8?B?REV0ejgvZVVmb3p5UlpUbEk4Ni92OUpPVU5WZjlKR1BTOU9LZHhocUNjR1ho?=
 =?utf-8?B?RTZjY3ZTZ0xVa1g2VFJ1R0QyK09PSDdqaWtZVzFlZnBhcWlPUFFZdUNhZys3?=
 =?utf-8?B?NlkrYXdGUUpkeU5TSjBkdzdLNHQ5QTFJR3g4UUV5MjB0V1V3dE42YUREQ01v?=
 =?utf-8?B?V0tkdjA1NXpRSHMyZEFhZTIybWtrVmZEemZHdC9VZWZFNVJacWhHR2JKQjRG?=
 =?utf-8?B?NjFNY3JCN0JMdGpOQ0RrU2tqdFEzUkJTK25QR0k2TGV3bXFWTitsaW52RlVO?=
 =?utf-8?B?bUJyWlBUQWRYMDB0aHgrN1RlS2JuNld4cDBJN0hZRytrYlNIRVk3WDdGRHZD?=
 =?utf-8?B?VUwwU0RBT2NiTTlUZnBPcVZWemxmQ0N5UkI1b0xTSmRSOHg1c2QyTkhFRSsr?=
 =?utf-8?B?ZGRkbjdybDRzQzhhOXN3QThOOGVISDZENnFnMHhhT2JEdmJra1lKRFFxTkJk?=
 =?utf-8?B?NFBuNGtEenpSbm01Tm4zWW1sVFUvQ1RjRm83dnBxNmNDMXJXb3dJL1dxUTJR?=
 =?utf-8?B?WlMvUWVIZ2J5TUdtR1pFSVJ0U0xNQ2FFWVVoNnQ1Qk12UU0vQW1kRURnTzBX?=
 =?utf-8?B?eUtQM0piYzVGUDJqL01qNVRYenlxU0dVZGgxWUwvdUJxaklTUXpqRDdpVVlu?=
 =?utf-8?B?VjdkMnRWeVdmS3ZYdGduWEx5ditzOEN2RWtVZ2hqdVNBdHpEcjlMUHFvWkdl?=
 =?utf-8?B?bXloVUhaVHAwNXpZcmY1YjVkcnZXTXk4YjJZeE9lZUVxNWhEdTA1UFBHUGNk?=
 =?utf-8?B?UlRQRjJBS1ZGRWFzVnhocjdiaStoc04rTFcrQ2E2Vk5tZkw3ZHRjMjU5elNH?=
 =?utf-8?B?bkZpS2xYZjZmZUJZOFE0bWczVU52QjJ5bi9QWUkrU3FzTlJGK2t6UjBHTG40?=
 =?utf-8?B?K3oza2tVcEhSemFtNUdJUGxsUnpnZjBLWHdKY0pkR3dvMFQ4bEVYbVl5VmxH?=
 =?utf-8?B?MXIwZVIyNllRL1ptd3JobDYxcjIrV0F5UVJJNmROUjEvWkR0bFpFK1d0MEMv?=
 =?utf-8?B?SEJBejJZN1dMUCtKdnlLWVorMjdKRUpTcCs1QXI2U1NPdTZQM2xnczJ0Skcv?=
 =?utf-8?B?NHhER3Z6UnFpM1Zubkg1VFpDQXVUZkVORzNaNVpiUVJ5a0lkekhybFpwWXVY?=
 =?utf-8?B?R1BscFdaY2xjWVo3M0FFem9CUTgvWW55N3FtcmFRdWVyZ2MwODAvQjdzNjht?=
 =?utf-8?B?TU11UjNtWDFEUHBmQlE5T1kxdTllaVROdHdaL0JkTDVTTmNoTHUrSmNKWVZ3?=
 =?utf-8?B?V2FrYkxReEttRG9CWEIwa00vNHkvME82SGJkQnhwdVZUTm9OZzhEbWRoamxT?=
 =?utf-8?B?N2NZTkprRnFURmM0YXdSaWVWSnZzUXU3MnRSRUdtQWVpY1FLWU5CRU9VejJG?=
 =?utf-8?B?WXhMMGgvWkVsdXl0SDJzTW50MXVJSVZXd21GQzNOeEM2WUhOZzBlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51825e5a-1963-4fa6-2645-08df197010ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 12:42:01.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBUzXelGk4i6Vjjbi5LKBVB/Ss9aWQj+zNq5oXRtb8evgt/98HhzBDtNSslUI1BJ8hU6Fl43+rPmXoC+ukD7Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232



On 9/23/26 00:58, Fourhundred Thecat wrote:
> On 2026-09-22 16:47, Mario Limonciello wrote:
>>
>>
>> On 9/22/26 08:43, Fourhundred Thecat wrote:
>>> Hi,
>>>
>>> On a Lenovo ThinkPad P16s Gen 4 AMD (Ryzen AI 9 HX PRO 370, Strix 
>>> Point), s2idle enters sleep normally but the machine can never be 
>>> woken again and has to be force-powered-off. The trigger is the 
>>> number of online logical CPUs: with all 24 threads online the failure 
>>> is 100% reproducible, and limiting the kernel to 16 CPUs makes 
>>> suspend/resume work reliably.
>>>
>>> This platform has no S3 at all, so s2idle is the only suspend mode 
>>> available.
>>>
>>>
>>> Hardware
>>> --------
>>>
>>>    DMI product name    21RXS07D00
>>>    DMI system version  ThinkPad P16s Gen 4 AMD
>>>    BIOS                LENOVO R2XET40W (1.20), 05/26/2026
>>>    CPU                 AMD Ryzen AI 9 HX PRO 370 w/ Radeon 890M
>>>    CPU family          26, microcode 0xb204037
>>>    Topology            12 cores / 24 threads
>>>                        4x Zen5  (core_id 0-3)
>>>                        8x Zen5c (core_id 8-15)
>>>
>>>    ACPI: PM: (supports S0 S5)
>>>    Low-power S0 idle used by default for system suspend
>>>    /sys/power/mem_sleep -> [s2idle]      (no "deep"; DSDT has no _S3_)
>>>
>>>
>>> Kernel
>>> ------
>>>
>>>    6.18.51 x86_64, gcc (Debian 12.2.0-14+deb12u1) 12.2.0
>>>    Custom monolithic build, no loadable module support.
>>>
>>>    Relevant config:
>>>      CONFIG_NR_CPUS=32
>>>      CONFIG_SUSPEND=y, CONFIG_ACPI_SLEEP=y
>>>      CONFIG_AMD_PMC=y, CONFIG_AMD_PMF=y, CONFIG_PINCTRL_AMD=y
>>>      CONFIG_DRM_AMDGPU=y, CONFIG_DRM_ACCEL_AMDXDNA=y
>>>      CONFIG_THINKPAD_ACPI=y, CONFIG_ACPI_EC=y
>>>
>>>
>>> Reproducer
>>> ----------
>>>
>>>    # echo mem > /sys/power/state
>>>
>>> The system suspends cleanly. The ThinkPad power LED then shows the 
>>> EC's slow breathing pattern, i.e. the ACPI LPS0 _DSM entry path ran 
>>> and the EC considers the system asleep.
>>>
>>> It never wakes again. Tried, with no effect:
>>>
>>>    - opening the lid
>>>    - any key on the internal keyboard
>>>    - short press of the power button
>>>    - clicking a USB mouse, with power/wakeup set to "enabled" on both
>>>      the device (3-2) and its xHCI root hub (usb3)
>>>
>>> The machine is also not reachable over the network while in this 
>>> state, so it is not a case of resuming with a dead display. The only 
>>> recovery is a ~10 s power button hold.
>>>
>>> Wake sources are armed. From /proc/acpi/wakeup:
>>>
>>>    XHC1  S3  *enabled   pci:0000:c5:00.4
>>>    XHC0  S3  *enabled   pci:0000:c7:00.0
>>>    XHC3  S3  *enabled   pci:0000:c7:00.3
>>>    XHC4  S3  *enabled   pci:0000:c7:00.4
>>>    NHI0  S3  *enabled   pci:0000:c7:00.5
>>>    NHI1  S3  *enabled   pci:0000:c7:00.6
>>>    LID   S4  *enabled   platform:PNP0C0D:00
>>>    SLPB  S3  *enabled   platform:PNP0C0E:00
>>>
>>> and platform/i8042/serio0 power/wakeup is "enabled".
>>>
>>>
>>> Bisect
>>> ------
>>>
>>> The regression was introduced by raising CONFIG_NR_CPUS:
>>>
>>>    CONFIG_NR_CPUS=16   suspend/resume works
>>>    CONFIG_NR_CPUS=32   suspend enters, never wakes    (100% 
>>> reproducible)
>>>
>>> Booting the *same* CONFIG_NR_CPUS=32 kernel with nr_cpus=16 on the 
>>> command line also works. So the trigger is the number of online 
>>> logical CPUs at suspend time, not anything else in the build.
>>>
>>> NR_CPUS=16 is of course wrong for this CPU -- it silently leaves 8 of 
>>> the 24 threads unused -- so this is a workaround, not a fix.
>>>
>>> At nr_cpus=16 the kernel brings up every core's primary thread plus 
>>> only the Zen5 SMT siblings:
>>>
>>>    cpu0-3     core_id 0-3     Zen5   primary threads
>>>    cpu4-11    core_id 8-15    Zen5c  primary threads
>>>    cpu12-15   core_id 0-3     Zen5   SMT siblings
>>>    (absent)   core_id 8-15    Zen5c  SMT siblings
>>>
>>> The 8 CPUs that are absent in the working configuration are exactly 
>>> the SMT siblings of the 8 Zen5c cores. I have not yet narrowed down 
>>> whether the threshold is exactly 17 CPUs or specifically the Zen5c 
>>> siblings; I can bisect nr_cpus= further if that is useful.
>>>
>>>
>>> Ruled out
>>> ---------
>>>
>>> None of these had any effect (still hangs with all 24 CPUs online):
>>>
>>>    initcall_blacklist=amd_pmf_driver_init
>>>    initcall_blacklist=amdxdna_pci_driver_init
>>>    runtime unbind of amdxdna, amd-pmf and tpm_tis before suspending
>>>
>>>
>>> Possibly relevant
>>> -----------------
>>>
>>> After a *successful* suspend/resume at nr_cpus=16:
>>>
>>>    /sys/power/suspend_stats/success         1
>>>    /sys/power/suspend_stats/total_hw_sleep  0
>>>    /sys/power/suspend_stats/last_hw_sleep   0
>>>    /sys/power/suspend_stats/max_hw_sleep    18446744073709551615
>>>
>>> so no hardware sleep residency is recorded even in the configuration 
>>> that works. It may be that the working case simply never reaches 
>>> hardware s0i3, and that the failure appears only once the SoC does 
>>> enter it. I could not confirm this: this build has CONFIG_DEBUG_FS=n 
>>> and CONFIG_PM_DEBUG=n, so I have no /sys/kernel/debug/amd_pmc/ 
>>> s0ix_stats and no /sys/power/pm_test. I can rebuild with those 
>>> enabled and re-run whatever you would like to see.
>>>
>>> Also, the 21RX series has no entry in the fwbug_list DMI table in 
>>> drivers/platform/x86/amd/pmc/pmc-quirks.c; the Lenovo entries there 
>>> stop at the 2021-era ThinkPads and some 2023 IdeaPads.
>>>
>>> Happy to run further tests, bisect nr_cpus= to the exact threshold, 
>>> or provide full dmesg, ACPI tables or the kernel config.
>>>
>>> Thanks,
>>
>> Try this patch.
>>
>> https://lore.kernel.org/all/20260826171537.4167367-1- 
>> Vishal.Badole@amd.com/
> 
> I don't see how that patch is relevant to my issue or my kernel version 
> 6.18. There is no cluster code in lib/group_cpus.c and the patch cannot 
> be applied.
> 
> My report is about the machine never leaving s2idle when more than 16 
> CPUs are online.

Re-reading your email I don't think it will help.

Running CONFIG_NR_CPUS less than the physical number of CPUs is 
effectively the same as booting with physical number of CPUs and then 
offlining them.  We've found some problems with offlining cores breaking 
s2idle and it being fixed by that patch.

But your issue is different I see; you don't even get to HW sleep ever.

Can you please share your amd-s2idle report?

Thanks,
