Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011016.outbound.protection.outlook.com [40.93.194.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE92DF6E6;
	Wed, 15 Jul 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137596; cv=fail; b=JJZlnS/u841ykGxRGNL+xUjPqRjCuqIwWHCTGZeZxdCeHv7Kipalri4aQKo/0mC43esaolYUZD2G0x/+td7QaoJRbHo5qGgw14oEbNXOnskYgt/MUnNOq7mYiCoEs0x0vxNQITurdd6ATbx3FFfYmq+tMw07zc+KL0EERZHuIeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137596; c=relaxed/simple;
	bh=Ftw5PSqB6qdidHg96CjaJFCTtKWCE6YD0Asxxt4vPQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UtxrvNKv7Sfh4518P1QctO1j+f0Ciq7+UanIvW6+PN9jvwNpb4bvL07izg+MjFJt0UB6oXcOZYp57yK/5JaV+StfXjdaP/shju6xgl2M6Dyzn71+d1KYw8WktbzCUIxO8/IVacZZHLnUFDkPXwAsDYhE4vIduG4FL2dQByOxLVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PJH4Ucys; arc=fail smtp.client-ip=40.93.194.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PJH4Ucys"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOuxAK+J8Eq+lFf9cHrp+Q/heFlOSePnrrBrGLzQCC5IPdrIj0X42HbholnvMgYsK1Nlg2WX2l/KiM63vjW4zNqit/KAT81F/+M5zHfeyVRFUeH8u+oksG9wBbVc6H4uhC/hCW5FfE6XL+jqrk+8Vrxv9e1cbXcfHaYQGaKVncGSoKH79tkDmy+LnD2s5iP36idz8IWtStTZ7zDXcdubOpuAsgLzI0g3W120A3Y0/blj30hcA0Vg2DkNImqKpySVVHfjoiHb2KjzD3EyVV72j/v8tv1d408VN5IDMxn4n4WsrSm10bJEPQqvHEpMwYq7FIlvL6ompnjPE0O1GNJjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVPmI7oi6H8l6jbaBrMsNdW8m1enNukwof6FQPLXePM=;
 b=BAA2j/QZF21vvJGJpyUfWnfp6FXnJ10jmS42ML+KfN7Z8oppheLSDq3SgJd15K03A7UsVUSwnjx10bpoQqTcHc4bN7q4rS37MKsKNsKEFM851kXH1PyIto8KvCpRoO/bfk/wkmMzF8mV+u3rrRkAROIOZKxrm6bLDwXiTlpv1488TKG9aohL4O7sG7gu57DJ4D31ZOaVWe6qVR7VzauIwZdOLlLK1WOGKoUvkU/TmZ4XStVHdf5GCaeed/knAsbPHZl6Cv9uwA+pkLSCq9QYmouKQ0D/IeKWiaFqR9Won6HRp6LNGhjEY3dlG/+F+lQMOMt0UiUpoK5GYFOzCBnXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVPmI7oi6H8l6jbaBrMsNdW8m1enNukwof6FQPLXePM=;
 b=PJH4UcyshtYXhOyrHBQBKbb38lTb0u5+Ct9ZuDFMtEs9I2XWt5lJ+cz2BVDaAmnE9fRf7IfDbmd6jPupB2svuW7VOp9qkR5/gawt/w5naWJSgLjXC9oRbb+BL8AH4Pw6a6j0lq/mk2g0FXgYUpPLPj6xKiVKzI9DA+fWVmYQ0is=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 17:46:27 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 17:46:27 +0000
Message-ID: <0c55d331-bf98-4e6e-9de5-35803ead3c0a@amd.com>
Date: Wed, 15 Jul 2026 12:46:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Andryuk, Jason" <Jason.Andryuk@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:610:4d::38) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd76d97-db21-46b8-912c-08dee298feae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	QHuo6MC+H2e3UN6TdYfy8Lea7uVDMpzIvx1ceNIv4XNwxICsoAIxmuyY0up3yhjD1ZfqxG6Y/aSbeBlFDIqbdA3J8SCAfrN0wdSlX4Vs9++qj1BCyNUUCtTfAavUzF4jeEmgVL9Vfj01xR1LS2fCkpUgMDaApy0n7FpnPD5nOEt4djII0jSYTMIAdER4HzR/vsFxeJgrVbYADi67hob/XmKu8iIRiJ09XLgSGp0B9U0ulKi6rdz3CROoInwEqr6W91GgT3wFzC/rbjZLQF/6Ao8pGAkwa4kUYh4FsLV9+cxti9KK5srqzKTPuzWlGkcZKWRpuC7zrKhuMLiNSpzBVeV88p4HmGZEHAXt4X2X4+fr2U+2b7C8fhtwLwCqELPNZK2ahItHCAbALrjrOGrEA8u3n+MIbCKX23s2sTvbAokiA/h/Rj6G4noSTW2Whh5cibbYVE54ocRznbHO9sKVqbDAagEnlUx1g9imI9Dq36lPcUQMiA2CV18enBrYgIVH5/6ikDf93Z5mxU668H7TWboky7oHuu76pr2ExwFWVodu3TRR7T/qq7EBv0M1BTUKFk8O4mX0+kla/6ea+TCrSmzleo+XNL4z6LHyXRKN6/cJrTfnN0eOvKi0nbgHz4i6AowD19JIwZMk4WhmhwBBJEE9OTm65ksBaoSTc9LzUfU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zkx4UDlKVWUyUC9lTHhSck9IamUvMW4zcGYyNkRjaysxN2dSUnlVc3B0YVU2?=
 =?utf-8?B?citabVNRRnVLZGlxM1dqVkdxY0l3UkJaeGoyM3UvRVVlTTZXdEp3NFdPVXNq?=
 =?utf-8?B?b1JXYWxzQmZCOW5MOFM4T1VIRklVY1lucjVTbm01d0hGMWEwUVBVWVJaNDJD?=
 =?utf-8?B?UkRsQjdxdkJnb1l0eWNWWnpWUVZaNC95QTBpT05UOTN3RDFkd1E4MUNtUUpS?=
 =?utf-8?B?T1Y3L21GWnQ5Wk1qOU1RSXZtZkxwTVdIOE9wTDQ0K0VMdjBuQ2N1UUdLTmdu?=
 =?utf-8?B?VzlkQkkzdlB0blo1bkdCd01jKzA4Mml5VnE2Z1BEMkMxbGE4NDZ2aVNudjhk?=
 =?utf-8?B?WUs1bCsrQnpuUWZiUk9TU0FYZy9BakR2OTEzei8xUnZYdDNPRE9wM0R5alZi?=
 =?utf-8?B?Zmg5NHppYi9iZ1g0eXJ4bFFmaXJCZlNRd3JUWmZUWGg4M3M4MU5rRjRRSlhW?=
 =?utf-8?B?eGNxcFpkTEpqNk9qUkZwU2Jha28rOCt4TURrWWhWOVFKMjJUZUZob2RScEdY?=
 =?utf-8?B?TEhJVEdHem9TOHVySXBzWmFuTnhhaDQxaGZ4cVBkVXRqRWJKN3RPVUIxU29a?=
 =?utf-8?B?cVM2OVY5KzBMdTY3ZGZLSDFORGNKa0RnWjEvWXpacWMwOWNXYS9SbFFDTk15?=
 =?utf-8?B?OG5vNzhCaGJRTHhYTW9GVG96RktMRWszN3VWK1JaVkx1N3FBQkMxY3prOUN4?=
 =?utf-8?B?dVdFeTUvZ2h2SmpMOG9JWXVUdmxGTW5wZXg2MnR0ck54WGNETHlBc283UnpJ?=
 =?utf-8?B?T2NWeWdUbW1zeFcydXFnY0ZTMXkxd2hpTHBtb2tvU2R1anl5RThVczFWVzg3?=
 =?utf-8?B?SmF4U2FuYW81cm44VVYrSkI2MXJNN1EzdGhyUXh1eWhKUzB2QVlyN3V2TVcx?=
 =?utf-8?B?NTlCQkFOVUxOMmlEd1c1VEp5S0g5SHViSGloM2dOVnhpcitaNlc1aEpFNXE2?=
 =?utf-8?B?dGwxZDZjYWpzM0VHMEJwZERHcXBQMGd3dGtkanRFUDZwdXJHa3lCUjNsYW45?=
 =?utf-8?B?RGw1YVpqRGRJeS80Nkw0VFB2aHcxbkV1OHp3QUhNNlRxSWEzeXFzb3JDN1FE?=
 =?utf-8?B?OGFtRmk3bE9PMUNJYk5haXZJTUNkVFlWSU1jcUtCcmVFZ3FQQ3NIWTNDNVo3?=
 =?utf-8?B?U1dtWm5kNENoeFU4V3ZmWmdKMWFXL3V4SmoxREllTWZkbCtKV2hjUjI4QUxV?=
 =?utf-8?B?NXlGQXc3ay9sZXlERXRLMTQza29oWlE5OEhIZG5sRys0TXkzRGM1NFZOT2hx?=
 =?utf-8?B?UWw2SmlYdnNEaEFxUmV1V0xhUTF1OTdOS3NjSndMaWNxazlvd1ZpRGp0RWxP?=
 =?utf-8?B?OGNDRTJqb2t1a1VyWEhpeUt3MEluUVRHcDVWa1RwZzlIZGZkTFVvUEx3MHlO?=
 =?utf-8?B?TEpIbE9EcDZLVUJkdU9vRXVsVUN3TW82ZXlLSGNhemFOWHovaHRuUWxyREk5?=
 =?utf-8?B?SkJ5SndtOFpiTkx2K3BFZ01sVlprUHFUVVEvNk9NYzBleENxeXlSRWlUSnRZ?=
 =?utf-8?B?YzRmQmU1NnN3M0FsU0l6a1VaMUpHYitSMXhLVXR2UDlOVDNZVms1Q3VldUhD?=
 =?utf-8?B?TXNzSkJGbnJpSFVVRW4zZnA5VkpsZTkyTzZYdWZXOExXdmo4WFkxUlBUeFZN?=
 =?utf-8?B?V3RRYjI4RUgxaGxrb01kd2ZBVHVIdVd4eDZ3VktVQ0dwZnQ2RVZLVDZDaWFB?=
 =?utf-8?B?VmZxVTdFY3ZZWUNCRS9uOWZLSVBXUDhIU2djU1R1MzNUMGdGM2pUb2lSdFFI?=
 =?utf-8?B?amxtSnhMV3hRL3l5SXlXdGpxbTdpM3NSV1BNa3ptSTVVTVpJN1dkRnh3eUhx?=
 =?utf-8?B?NVA0YWM0VzVnNWVEYldkbWI2b21nSGozMGhybXZ4ZXQ4Q1JVaHJDZ2N4UHJM?=
 =?utf-8?B?UGZYZUtESWNEdkNpSFFyZkpyaXJvSUlBRHhJcVRMUTg2eVZxZXJhU3lwaFpB?=
 =?utf-8?B?VXhvYmc4bW9zb2xHVHdpdnZhVGJBUCsyUG1uWWxKNnl3VHlzdy9ZNnNsMm1N?=
 =?utf-8?B?STAyRTcwZ0hTVDI5emd0OHZXRzVma3p5ZHpVWlhScFcrOFVlVUhhSWVodlho?=
 =?utf-8?B?VlVSZTVYd0VsNEhsSzQ2V0hRSUpxeTBkUmlUUkQyZVZLUEx1QjRWMU1qLzA3?=
 =?utf-8?B?U0tPZnZSVXI1TTMzU3N4eXNaWk0vSzFKVFBFQlkxTzRKU245aFdWVzh4Zk1T?=
 =?utf-8?B?NTJNUitSZ3EzRDk5NE5wYS9RM3B2WnRXTldSR2szU3plb3RrYXNvbU5UVlFU?=
 =?utf-8?B?bHZaNXBnMjFiS2tLcTBRL0NUalBxaHVhcDJicUFIc3FxSmVpZlZtNDR6c1Q2?=
 =?utf-8?B?OFNKQjkvdU1aV1dyVkxxbVJQQ3ZoTnJHU0lESXlaTWVMZmJKK0NjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd76d97-db21-46b8-912c-08dee298feae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 17:46:27.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znHcbrMIzzdVNUKZb6oyl73Wp5gtXY9g83/QjCidqGph3uOzYGes08WWXYBUuKMoYhLzwDtInkvcH60rfEnrjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821

+Jason
+Boris

On 7/15/26 12:41, Rong Zhang wrote:
> When booting a virtual machine that simulates or passes-through a
> relatively new CPUID, one or two warning messages are printed to kmsg:
> 
>      amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
>      Please enable it if your BIOS has the CPPC option.
>      amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> 
> Technically the check is not wrong and acts as a safetynet that prevents
> the driver from being registered incorrectly, but the warning messages
> are noisy and not really helpful, as virtual machines cannot adjust the
> CPU frequency from the very beginning. Moreover, mentioning BIOS here
> makes the messages even more confusing.
> 
> Fix it by bailing out early when running in virtual machines (excluding
> Xen Dom0).

Conceptually this makes sense to me, but I would like some comments from 
others if this is the right way forward.

Jason, Boris,

comments please?

> 
> Fixes: cb817ec6673b ("cpufreq: amd-pstate: show CPPC debug message if CPPC is not supported")
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>   drivers/cpufreq/amd-pstate.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a74a4cf99d22..f2115f935318 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2228,6 +2228,9 @@ static int __init amd_pstate_init(void)
>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>   		return -ENODEV;
>   
> +	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !xen_initial_domain())
> +		return -ENODEV;
> +
>   	/* show debug message only if CPPC is not supported */
>   	if (!amd_cppc_supported())
>   		return -EOPNOTSUPP;
> 
> ---
> base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
> change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3
> 
> Thanks,
> Rong
> 

