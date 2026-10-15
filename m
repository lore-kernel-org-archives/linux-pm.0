Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132549DBBF
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096456; cv=fail; b=DJlJtH+0bbql3Evvg0/JrtQdT6+hve9Q/JIbYJgdXPUVHMcaLVRtas7yYW2ICmHEfMQv+0xD1PIfZoT/CMkNQypyPbS3N6rJzDs2En+6fp8t+gvepHBErnnM7EPadT/UrL2WklA5Oilb0UTcM0+oGYf08T2ZygJ6l1ZfSfW+W+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096456; c=relaxed/simple;
	bh=W0MPKO3BBi86n4LvjkkUOvvMnoE6U1FfTjhW02QdiVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rKZwg6vVoa1d1HNWyXn/5KO7rvIMQOmk2lFtj6fm0vV71wHvaczcl5KFrlZiRlwzImqxp8E1gUKGl8b0+truSdN5DJY+0c7fZUx9SahfkHYsRcLnztcONWFrFeHGBTr+VjJ7yc4GMYJA3DlgaNiTSyS3ZJ75vw1uwV9WuvvTl+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T6SuHWOY; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T6SuHWOY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGndZ8EdzQjvvOHMo+xCm3Hb0Kln/BEQ6GrQnfuDG5bnflXLu1aV4kJ+uqEMUSh928MptCl1ZXyrbyH5BNmBxq0Vcx5D09XdVEzgy9IRw/U08JAoLEZZ+QUUXsx/FJp5rQPMfpgKeHCoFVM/m/twhk8UYywOrmLJXbDLYUreRToYzxShBXcUFnEYhBy4PCacmjtRnUeZw62g+4gAT8O42J1okGqqlBvTGP3kTcgYt+vJP9MYrFykW8OjfK8stRH6GADcXvpwymD5QZ9JvU3b6eC8JHVjlKliiTf/j22dyjB66faD38Wg30qjzS2dq5aA3QQBsp0MxG1yTXfV8BhW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzIkgaV4oFxU26nDGSSkic61AAXu5plCQHs+vnCx3JE=;
 b=pbwfgrYGvrszoEf8x9P+sq83xGG5Ra6DoNBizckXaVvwltFGum4s8Gd00HSEQhdf9xjTIoWbbXEOEh7TTxfcYRU0FZGPXXJzdhM0wXOUmEKhQmWL98Rxsygt6O0n9lyWX+/H/YUaGOaIe9Ccuv+ta+flVbwZrxadYfEag7HoyIlRAQSGSPv0lnhlqYHQX4faoRCqHsJMHHjcRPk5d9D4Id8NiKN3K1vP17X+2jL/yqNUSZCA+d3XUPHCDQqCgws9kcGMgLgVEuNj1aF5RX6LIvBQvbQkyRd8fak/mJvfIAbGFlWn5pLQ6wVBL6YP44JXvRaKkn+Hk1c3dPCZ/q8Ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzIkgaV4oFxU26nDGSSkic61AAXu5plCQHs+vnCx3JE=;
 b=T6SuHWOYrkByQtRswF1H0ktzfftyxNtUo8WsN8BW6bsvDW/kWBigeOqOzilAStRsxUVGsV9Yy4dcc5XJajx/FJC0Us/jtfvvj09AWJCNVEvxYPq/Jk8eyVfUcT6N51rsN0ifPJg/G9VNd6XgDylLxRArRmvElsYP4kd3p+GxSEg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by AT6PR12MB255547.namprd12.prod.outlook.com (2603:10b6:170:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 20:34:12 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 20:34:12 +0000
Message-ID: <8e2a51c0-4d4d-40fc-a651-766767a8ecbd@amd.com>
Date: Thu, 15 Oct 2026 15:34:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [amd-pstate] HP 890E / Ryzen 3 5300U: auto_sel fails with
 -EOPNOTSUPP
Content-Language: en-US
To: sufankin <sufankin@proton.me>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "ray.huang@amd.com" <ray.huang@amd.com>
References: <0eGldHTiH4PcGuw7Z5vlVY7ZV4HngxVKObqR1dHU-eqYvtKA7r-o5Aqu5POrULfzmcV8sXMRruEd33goxbimOcdHINnTaJ0lZpviB3x-luc=@proton.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0eGldHTiH4PcGuw7Z5vlVY7ZV4HngxVKObqR1dHU-eqYvtKA7r-o5Aqu5POrULfzmcV8sXMRruEd33goxbimOcdHINnTaJ0lZpviB3x-luc=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0113.namprd11.prod.outlook.com
 (2603:10b6:806:d1::28) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|AT6PR12MB255547:EE_
X-MS-Office365-Filtering-Correlation-Id: e90377c4-9b9d-451c-4678-08df2afbabe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|18002099003|13003099007|22082099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NVRNcxxduewSba/hSEluZwAqxWcjfg7Uqp2l+6taqjJ4Lz5rfafmJGOazZfywJhY+Weu3DlRLCzNh1WeRv5UU+RHsG6PzT1wL/37RqvDcb/JKp7VktEO9JSqxDKQC0zdJs/qbNIx5EB4d0ieFJzlENJI91jMDYdnZd/f8kqZCAtaV3dhobFSWRz/ZyCCrtHMHnxf3FwZ1esLOw1yo2087TZUvx8IFXpkIbbUfhgBY06879gzgcR6C5P5rbTqBGaFk1zL6E/+TTjR7T8H9gLSGP6GwTxAV+Rj1FJ+Lz5I4YHCcbSl4Ngxrhi4rQM6rAEufLpiQGCsVvahdwqcVdXBTGVWVX5ExcgT+boVx6WT/XqyJvP3x/ZT+9eprsKJPLWAyJ+XmeXBrInAAUZ0bQbEvGlwiI4aVAPfi7SbgLq/O0HNmMUZlf0OyqMi8FnM2yYDj9sBr0FhQXZKCxH11o99Mm7RkOoJ4muOs4gPLBBzwAR8u9N2OEQHi5104F/5tpY/NXgHnZJ364HTOKaqOtFCsuH2QtgP7MzBo+j3u7FklXR5/yT3OPe2TtmmDA4A2iqVz/yFk4yVPu5WjVSX1vgp5p2w5LOW9OZM3m2/b1EoPKjmi9WOrRKiMBinjcJ/xZBo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(13003099007)(22082099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldwREVWTUJYeWRDMmxhR0syd2VzL1AzSDBiTjliajNYekRRbnhlVlg1TUZY?=
 =?utf-8?B?NW9aQU1MUkVQUVBVSGFoaVVUSUhRZzZEYm9lRktRbm0zQ2Fpc2pqT3E5ZEk3?=
 =?utf-8?B?VGN6aW5rc0ZuOHNUajR4NGt1VzNlODRGcmR0eGMzS3duczlmSnNLYkhtZVBa?=
 =?utf-8?B?VWt5ZS8xNWZDM1NjWWNxRHdBM0REYVpyYTR0dUx1bTVDVGRRVHkvWVpaV1Fx?=
 =?utf-8?B?bUg1VFMwUHp0Z2dMWkMzUGsxdnFzbGV6MHlaZk5xSGRJWlFwSithNW91Nkhr?=
 =?utf-8?B?MGtEZEZCVE0xYjR0MmRTRVQyM3lBZXF2ekltaVRtZDdjR3FuTStTYWRJeGo5?=
 =?utf-8?B?Qmp5QURtYzFSdk5aaTQ0dlhmeG9Vc2F4ODF4MWhqVXRKbjFHd2lqdHFWemlN?=
 =?utf-8?B?UEZCR3hKNXVkdjZ6b3piY21ObEc5TkhXT3MrbVhsR3gzQlNnbEdLWGtWUCt4?=
 =?utf-8?B?dEJlQ3ZYc2t5YkttdUdyWFdpaUhlREVzSEg5MGU2eHRZOWhHbk9EaVRveWJx?=
 =?utf-8?B?aWZYTUVIREk3TUp5TGxsRG54Y3Yxc0E0TnRhUDg0dFp6dzdnbDJmUlVFcnhL?=
 =?utf-8?B?R2VOMXlwcnlLSzNEL0FmMWZmYlFocjd2WUN2bmtNZCtKd0JvNkNwQUErU09l?=
 =?utf-8?B?UGpWaDkrQ3p6cHhCcVRXY3hvZHNtYkROUzJTNng2aXVscUI3QVVVdTAxZi82?=
 =?utf-8?B?U1FqMHdDMDlpREU1djhtZ3AyQldSckJrYTZ2S1FGcmI2c3Q5SHpoT01zdUtU?=
 =?utf-8?B?ZGtnRTFqcEt6cXBPSjN6R3BsUjBjc3lQem1CTlJBaFBSK2R6ZXE1YVpQR3BK?=
 =?utf-8?B?alBsSlg3ZkRGZGxjSWpWaVlpNzUxWE8vOWRrZDlnUGVJQzRWTDBUd0lzc1NN?=
 =?utf-8?B?Q0lxN0tmeEc0RXdlT1JaWG9tSStRTG5MTVM4bG9HemJXZ1VHSmpJT0tFRDdt?=
 =?utf-8?B?OW1KUU5KQ1gzNFkrZ0NjOTkyNWdGWkR0UytpNjk0aTFzZ01NYnR6c1Nhd3NT?=
 =?utf-8?B?VDd6V0MyUzdHV0hDMFBwd0hJdldXU0RCMkE4c3hBUDU3NFdqNUJkc0duQUhs?=
 =?utf-8?B?ZFU1TDAzQXgwTkpib0pLb2RRaDBmaHFMRlJ1SGtJeHhXeTMzSG1sak9LbklB?=
 =?utf-8?B?T2h3QUIwTm9wU2RsSU1POEZoeTVxbHZZdEhBZEh4SjR2QzV3b01TUllJWS8x?=
 =?utf-8?B?NW9SYitzTHN1azdRUDRMcWo1Y2duYVVvNmlLVzdTVFFIeHBkeTd5VCtJdkZw?=
 =?utf-8?B?Ui9ucjBvNGF3Unl1Vm9XVlA4aGlvRFlWU01jZkNkM0VTdkt5Q21PbjdaYXlx?=
 =?utf-8?B?czVidXJrMXgxMGFYeldlQnNzb1EvdUJub0l3OTlaN1VydlBPQTZwa1RoUm8z?=
 =?utf-8?B?VHRWTnZITFozcGVjUitGcUtYTFVySUxuTk9vOWZLS3dwQlc1TS9na2Y3NGp5?=
 =?utf-8?B?TVl2bzBDOFVGdUJqSjM3aHVHK00vb2lqNmFkaFRqV3ovMEQ2VlVyK1Vpb204?=
 =?utf-8?B?d1VycFE5azBQUXZIK0hyN1Q0cmVQSndCdUhFcnN1bkJUQmo5Rk9lblNWOWJ5?=
 =?utf-8?B?ODZ5NDg4dFpXOTFPYVhjTjl0QXV3c0RUVFhYUzlVckdHNHcrd0RaSWFwM2JS?=
 =?utf-8?B?QitnMHNLN2xDMm9EVFNnck9TNno3TWtJSS9qNTkxR2t5RTA2am9VeGFUUkZt?=
 =?utf-8?B?cEN1bm0wSG4wQVN0U05GbGkrWEI0TXZaYjl3SUNTSWVUTGR2S3JCZTJDcVND?=
 =?utf-8?B?dkw0QlZycTNudWtGZGwxaUtmZGVmMzhaMFdwVTFxM09HOWZ4QmtoZTcwTTFN?=
 =?utf-8?B?RlhLam5RR09MbWhMbGt5a2pHTW5BVHROdDFpckh3aFovc0Z1MWVRbXhBa2dV?=
 =?utf-8?B?K3JhUkR5YTJKNUlvUWFtTmZRWHBzWlhhdFdNL3lvZzFnVktSK2tyTTNUbEtq?=
 =?utf-8?B?T1FVeEFSMDFRK1JSZHE2dUVTWFRwM1R1RE8vT3c2SG5DT21DK2pEQWtRbE95?=
 =?utf-8?B?Y3BFem5FVzl3blBEamltS3ZsU1ZqeklQUVFpOVp0NllCM0ljM09TUlRIaHVO?=
 =?utf-8?B?dU0vN3JvTDU4ME1FSlNBT3Q2N3lUQTc2MEtUVGYwUzU4cDR4S2JYeFFlSmdX?=
 =?utf-8?B?NjhDcWhjZUlzbndSamJHdjhZN3hZcHdGWmltZlV1bmRmTFlLTWNOUFVDZ3A0?=
 =?utf-8?B?a0FubXVnZUN3NlJQL0pDaWwyWWkzeUJlMWpKUmlQRXVickorRUN6aE9ZMjUx?=
 =?utf-8?B?WHBYVk1HcUtrZWNpaDZ0akxXU1VsRVN1MHpQZDB2bi9xMWtVZDI1dzJac292?=
 =?utf-8?B?allTOTdkbDlGWDEyMHJqU1dzK0VYTzRKdm95eUtBN3dHN0JaU0JrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90377c4-9b9d-451c-4678-08df2afbabe7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 20:34:12.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6FYlgC8Eq0uB/F0BSbEyhlX6RUpB6HPJEZsuBaXitofhT4EH0kzxBl6qSge9hVHvHLQyoq7A6rPVskby4WKKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB255547



On 10/15/26 15:22, sufankin wrote:
> Hello,
> 
> I am reporting an amd-pstate initialization failure on an HP 255 G8 with 
> an AMD Ryzen 3 5300U (Cezanne), running openSUSE Tumbleweed kernel 
> 7.2.9-1-default. The BIOS is Insyde F.45 (SMBIOS date 2025-12-09), with 
> EC firmware 83.23.
> 
> The relevant boot messages are:
> 
> |amd_pstate: The CPPC feature is supported but currently disabled by the 
> BIOS. amd_pstate: failed to set auto_sel, ret: -95 amd_pstate: Failed to 
> initialize CPU 0: -95 ... equivalent failures for CPUs 1 through 7 ... 
> amd_pstate: failed to register with return -19|
> 
> The active CPUFreq driver is |acpi-cpufreq|. The kernel configuration 
> has |CONFIG_ACPI_CPPC_LIB=y|and |CONFIG_X86_AMD_PSTATE=y|, and there is 
> no explicit |amd_pstate=|parameter on the kernel command line.
> 
> I collected and disassembled the ACPI tables. There are eight |_CPC| 
> definitions in |ssdt10.dsl|. In the first inspected package, Autonomous 
> Selection Enable is represented as integer |1|. ACPI permits this 
> representation on platforms that exclusively support autonomous 
> selection, so I am not assuming that this value is invalid by itself. I 
> have not yet individually verified the corresponding field in all eight 
> |_CPC|packages.
> 
> This may be related to the following discussion:
> 
> https://lists.openwall.net/linux-kernel/2026/10/08/302 <https:// 
> lists.openwall.net/linux-kernel/2026/10/08/302>
> 
> The ASUS follow-up says a BIOS update fixed that system on an unpatched 
> kernel:
> 
> https://lists.openwall.net/linux-kernel/2026/10/09/10 <https:// 
> lists.openwall.net/linux-kernel/2026/10/09/10>
> 
> I understand that this does not establish the cause on this HP laptop. I 
> have not documented a device-specific BIOS update test. Could you advise 
> which firmware/kernel checks or additional evidence would be most useful 
> to identify whether this is a firmware issue or an amd-pstate issue?
> 
> I have attached a concise report with system details, the observed log 
> sequence, ACPI findings, and reproduction commands. The full ACPI dump 
> and complete boot log can be made available as linked files if needed.
> 

This is most likely a BIOS bug.  But to confirm; please try latest 
kernel 7.3-rc7.  If updated kernel and BIOS can still reproduce it 
please open a kernel bugzilla attaching your kenrel log and acpidump to 
review there.

The agent analysis is fine too, but I want raw artifacts for myself to 
review.
