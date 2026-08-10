Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF4A342CBA
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389775; cv=fail; b=PRoL9z6u4xsNEapzluMOzWBgd3LOI/jWn5F2lACr2Lx5LLOVtfs7Citbdjm0c5xYByRgsG91e8Bw4TnNRw9rEcjV6r2GT87pIQ3NyeZtVGCu+dtIaJJ3qZfccI4J0jUL7azy1axnSrlTkhLDWRSfLDNhNg0k4HAfrgXOWTQy4Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389775; c=relaxed/simple;
	bh=18VJ/fbrLk8WRnAEwefu4cOKhXhMnZ5IpBXlP3gZIp0=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=FG57hyB7ukcSWp1w+MjO55ZnCL9GzjfY1S0/Vp2HDCdDe3cyPufp5KzSjPHsBRsb/gg5kwNd8TJYQNz0hX0Jlx/hV4RGunsQnhh1pFa87g3j9LO9+cbBcUb0sc+p3YCm1jjJkChNRHtzeKowUj4ZT61PtumUbZUyIe7GAENRXNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=deHptVHq; arc=fail smtp.client-ip=52.101.53.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="deHptVHq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McbHbq4fIE5xAK/ZQiz16gG/H/+i00e90vhRlQIYSsb7ggIflb53o/SZguCn+ZTdPsaU8txfDWXbYhX73+qRryT/mOICg0SZ/YinL9HYCweWcjBoOxxiT79WA4SW9NP4tcmL0horby8x42V4B1fVAZl/lmVJ/R5ovVa2FqCGZmKgCXw2LnR0khpa/yETqFkSWxLMmYjZrD9GSR35kSMiaCsztFRoEZp9t+scOft2shIy0+E5ApSAD64AjMTDmCcZ/d684KUO+3BwWmiBrzi5mg00TBfsdbeWtakgWKUNYADDoozchrJMEHlG4fUHqFPV7LWkxZv5KSqpnSFH88U62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhMAKhyWX87bGAjZkRzMJecgBC4SkskeLr85l6VBjp4=;
 b=lmulliFzxJSFu5qumbZtO28XhyjtmOXjWVKl/560VpyOkYSfshvgmb9nexdEkaLUKhFK/muSFOQIVIeDMeF9hA0g4MzxwgjIjpEKMP3mbgj3eqyrzUEMGq/zhRkvwIpMd1neW/VNZmPmkVL/WZh+q1XBq8t6TKsWKBi4oNpE/ynuS8hCvMwxYWKP2rFiYPDn/F0tWAT9v9bGaOPH4PrmgfJBZGLeaddgdjISfTMK5c1oa2ovjk+ZU3n3xP7I1L7/FSk+FvR4fP20cth/rkiC1+h4XPL4QdqfM0fq0X/+18GMLe/+k6AAPlrql8aNcc4yxSKTVnVcVcTJJHHwMP0ZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhMAKhyWX87bGAjZkRzMJecgBC4SkskeLr85l6VBjp4=;
 b=deHptVHq74BKYzV5zCsPmzdFxen8GTFucK+OOPd+XI6fbyxiUfs1dMS1tj5jeppI7c5u/Bjuew+Uh9dBUx6URmWnlDzZUaWG4Hcsv5t+6JHRImohuBg7UOPe0TfmLU7tjbqK/T3Z+MLN4+Yx9qqA/kTziIEotS6gmi1cLlEYu/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:22:39 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:22:38 +0000
Content-Type: multipart/mixed; boundary="------------T0kLPzkO5Cuq887YqmdPWLJb"
Message-ID: <d7169eeb-834d-49ff-89a9-2b4baea59528@amd.com>
Date: Mon, 10 Aug 2026 14:22:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: amd-pstate fails to initialize on HP 255 G8 (Ryzen 5 5500U)
 although ACPI CPPC works under Windows
Content-Language: en-US
To: Giusy <kurmikon@yahoo.com>, linux-pm@vger.kernel.org
Cc: ray.huang@amd.com, K Prateek Nayak <KPrateek.Nayak@amd.com>
References: <e4259474-fa4f-4ed8-8a7f-1a3a2521acd3.ref@yahoo.com>
 <e4259474-fa4f-4ed8-8a7f-1a3a2521acd3@yahoo.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e4259474-fa4f-4ed8-8a7f-1a3a2521acd3@yahoo.com>
X-ClientProxiedBy: CH0PR03CA0392.namprd03.prod.outlook.com
 (2603:10b6:610:11b::31) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: e87ccf5d-19eb-424b-5438-08def714bdad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|6049299003|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|5023799004|3023799007|4053099003|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	atHYKwa8GFVi4yqb6JT0AzVLBiTiRns98hj4bSa1VowcXPnY45JCHS79d0JU1SitDRmBlPMsntnW50H86tf4BR7q4VvTUDqA25c9TCGO68yvIOP/aiGznKw1KG+Wq7loEFFJJtv4CXkIimRoUrDDZyLlPcolB7EpBeUnxlhQmZXLLqyLOjd0awvoHxIina698GAiydVOE7Sd3N5pd5HiDlxGxBJr2x0DkFBYPlZCCy5B/uTlkpJZMrLi6m1mVpBHiRsAzPIVcBMn78DR5cn1C37WRE4YPtCQtMkyZee/oxOhYkZW2Wma+jShcXrSP2qO9wFVCkowpvgzolyuiaBs5PQh1kYzTvq1USKxnKgvJ2ZtQD5CY4kJBcec+SteKEnTJbKN8x+9H1ua/V2QtwWmA+8udKWj0at9R2SmvMxCUnrurDk27zt9425DL+xEPGXbuJp4rEl7NWbA5CTFukF/N/4jNSOprni40J8w4dXg+tWIBsI34Xa5PHLbHt3WX0Bh8KUzfGoN6YCJcnk2XrY5CQPNY1Ua9kNNLU9EGxhu23Hkxk8KpBg1lr6pK+uqa0heY5x9ERbo+W33129tXoYzsbMS/0+/b7c2bDlJk66+kZIcC3BlvOiaqJATMocUMmKMGsUEC6Rw+T7SA5YDC6b3e/3o7BuIi+JHFb+0IoHqYSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(3023799007)(4053099003)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzAyQ3R3K0crN0RlNzE3czlOclV2a3QveHpKV0M4aVB5dVpxV0hnRlRoQjA3?=
 =?utf-8?B?c2hubERFdGdlVEFaQlRzbEVXa1YzMFB4Y2pkZ3UwRGF3dkNRL2cvalpiZFFZ?=
 =?utf-8?B?am16Q0dzQlVZa1llZ2N2NVN5VHN0dFdXQkRXQnpTandHSTVCZXVNVDhXOVFs?=
 =?utf-8?B?ci96MjF1QzBlK2ZsN1ZrcVhsOTlMNDEvYVgrZkhvU1RyNTBHRm9iY3FvRk1S?=
 =?utf-8?B?NUhQY2c4WDBaOTRvMDRrZHV3SXNORThxNTJCc0xrSkt1MDNMRkIrbGhjUmor?=
 =?utf-8?B?a1VuNENscDMzdFh4Um5qQzQwZzNpY2NOQmJGYzdLOElZSTR1d2wyeXhLUlNx?=
 =?utf-8?B?dlVNSEtKUU45eEhKRm9zdkJNc2FXenZwV2JGTmFwYXZQb3ZtcEgvSGJibFV0?=
 =?utf-8?B?OEk1THlIdlk2eFdPQitHMUpkbHZob3ljSG5XaXpoR2hnYy9HSmNkN1I0cjhW?=
 =?utf-8?B?eTd1ZGkyK0daQTdlenAvRTRrWjI1a29nYmlHb1VwVXNLd3MwcDBKbHpiQ04y?=
 =?utf-8?B?OFVRVHNQOE9wY3dsOUkraGZhWk9RamNEZFk1emRsTVQzU3NpWnNnWDBiRXRD?=
 =?utf-8?B?RUp6ZCtrZW02Y05nREFFT3hUaTRpaW9GV0J2b2JIQ0VLL0hZNkVadS9MU1VF?=
 =?utf-8?B?dmZXMlVIUExQZWdiWTJ1TURERm9jT0NtVElPd2JJZGNrdDN3clZwVER1VHEw?=
 =?utf-8?B?NDdtNlE3bWhLNml0THMwdUZiL0FmejRMKzRQMk0rSTlVaHJ4OUNlWUtpaisy?=
 =?utf-8?B?alJmSStKcmM3WnNtRmw4SzdqbGh3NEpCWGZyZzdlRkxSbjlZUDdZN1NSRGlZ?=
 =?utf-8?B?VHljY3dJa1J1ZHRMTGM1ODFqdTRxeHhCa0diQUErMXRNZW1oZmZiRkxCSktO?=
 =?utf-8?B?Wjh4WE4ycnlrS00xd2VWZlRnamZXZTdvZzdDTUJSVXdqU3Z3TjBrVU44MGlv?=
 =?utf-8?B?bGgwYmI0ZTdyN3k4Z2kwQllKVW1kMG1WL1BQaWtocll6UFlVVFZSK2t6STJq?=
 =?utf-8?B?OWQxbkgyWER3SmsyRXpkMWxFVFBGSitITVd2MTFSeEdrR0Vva0ZvMWFqemRK?=
 =?utf-8?B?eVVCWWdreU96QmlxTTd4V0M2RGFEaS8rTlJPRGZBSUx3MUJ4ZjZ3NHM5cjNX?=
 =?utf-8?B?NS83dFBmc00wck1oS2QvampHU0V6RHNBTFdEVmdVMVpRSk9Lck9WL2ZHRm8y?=
 =?utf-8?B?T1pMbFdFeC8yYmNzWW5ONmxEYkRrVXNZalJBK1Biak1LRjJCNno4NkFZSGZ6?=
 =?utf-8?B?bTN6MUtrb3NsejlzTzdJMmc1RjVUTlF4YzIyMkI0SDZtUmJSa2N1TTRWWjg2?=
 =?utf-8?B?U3I1ZXY2VEoyS2JaSVVyd2lsajQ4VUJFL3BVOSszbVVNbjZnT1FQQW1Edi84?=
 =?utf-8?B?SFhWdmo4aDVVMklKMEkrSDdIclZEZE5MWGxvb1d0T2EwOHhiUU5FMmlLWWxw?=
 =?utf-8?B?WGhkSS9lRmhGTFJGdy9zRHBXU3R1TzF4Mlp1d2VUanlWeVdiU0FsR2ZMUWx5?=
 =?utf-8?B?S1lzZjZpb1ZPbEZ1S1dGVG1vVkVITE5ZV3hVeUtBNlpnWXYyN016VEFSRG1P?=
 =?utf-8?B?YUF0cXFIVU83c1IxQnoxSE5aQ04wWUwyNGx2TjJoZ1R5dHExWnJqZ0xGWFpR?=
 =?utf-8?B?UnBoSGxCREY3QmkwRFhsY3lOTVJBNVFJYlZQREtUcHB3QWZBQk1yeXpESmhD?=
 =?utf-8?B?VmdxS3UxTkFKYmpjTDBLYnJUUkFGUFdDUUl6TGxwNXozYzlGWkQrSDMvdkhK?=
 =?utf-8?B?TUZMa2xYdXVCRXJidENtOFk3Ty9pZ05UM3l2OVJJRm94RWpGNEVlaVUxYjZz?=
 =?utf-8?B?dWkrK2tkZlVKMzc0UDlxVHNHK3N0WnY2N1ppeSs1WkdYRVZwbzJpUFBDV2FP?=
 =?utf-8?B?VDZ3RzdhVVpMWnVGZ2NkUmpLSUpETmUvaGhKWXMrZHhWd215cVhGQnkvcDRF?=
 =?utf-8?B?Ukh3SkpuS0NETXpTNWRQL3lMWmcyTzZkajc0Rm9NbllzK1ZvSW5ZV2RJODVI?=
 =?utf-8?B?M0dTcjM5Ym84blBJWVlhdTZNczNyS3FPUG0zc2tZTmZpUlJRUWZjUXVwbTVk?=
 =?utf-8?B?bk1vNWZLSHZPM0t5SEdLTjZyQVFnNHdsMFdTRXRDUjE3K1U0RncxdUZHQ2RD?=
 =?utf-8?B?N0VobmVMVGk0NWxUTVhMMk8yMHUxR01KRU0waFV2SlNiRjJXSzczRjRYRUl0?=
 =?utf-8?B?TGVlYnRKejRDa1lqa2xuMjNLanBKRHZvYW9icFdHaEd2ZGpndzIwNW9SVXFj?=
 =?utf-8?B?ZFdaMzZQVWNraTJBaFFGUTg1M3JPN3F1OFlvSDdBdS9SajBtSVJNb2JuVkVQ?=
 =?utf-8?Q?iwirOFZVQOERDBtFr2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87ccf5d-19eb-424b-5438-08def714bdad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:22:38.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eBYdsAq4youiRave3+snCBdn0PS1lTLqwYluCmhHpgOoRe8n+XEvVBmcONipPAjnVnfUTPl3F5ra3/gncnbFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

--------------T0kLPzkO5Cuq887YqmdPWLJb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/31/26 09:56, Giusy wrote:
> Hello,
> 
> I would like to report what appears to be an amd-pstate initialization 
> issue on my laptop.
> 
> 
> Hardware
> ========
> 
> System: HP 255 G8 Notebook PC
> CPU: AMD Ryzen 5 5500U (Zen 2)
> BIOS: F.45 (2025-12-09)
> 
> 
> Software
> ========
> 
> Distribution: Arch Linux
> Kernel: 7.1.5-arch1-1 (same behavior also observed with linux-zen 7.1.x)
> 
> Kernel command line:
> 
>     amd_pstate=active amd_pstate.shared_mem=1
> 
> 
> Problem
> =======
> 
> Initially, the BIOS did not expose any user-accessible CPPC option. As 
> an experiment, I used Smokeless UMAF to enable the hidden CPPC setting. 
> After enabling it:
> 
>   * Windows 11 successfully exposes and uses ACPI Collaborative
>     Processor Performance Control.
>   * Linux still fails to initialize amd-pstate.
> 
> The amd_pstate driver fails to initialize with:
> 
>      amd_pstate: The CPPC feature is supported but currently disabled by 
> the BIOS.
>      amd_pstate: AMD CPPC shared memory based functionality is supported
>      amd_pstate: failed to set energy perf value (-524)
>      amd_pstate: Failed to initialize CPU X: -524
>      amd_pstate: failed to register with return -19
> 
> Despite this message:
> 
>   * ACPI _CPC objects are present in the firmware.
>   * Linux parses all _CPC objects successfully.
>   * /sys/devices/system/cpu/cpu0/acpi_cppc/ is populated and exposes
>     valid CPPC information.
> 
> As I said before, the vendor BIOS does not expose any CPPC option in 
> Setup. I enabled the hidden CPPC firmware option using Smokeless UMAF 
> for testing purposes. Windows 11 subsequently uses ACPI Collaborative 
> Processor Performance Control correctly, while Linux still reports that 
> CPPC is disabled by the BIOS and fails to initialize amd-pstate.
> 
> 
> Windows evidence
> ================
> 
> Windows Event ID 55 (Microsoft-Windows-Kernel-Processor-Power) reports 
> for every processor:
> 
>      Performance state type:
>      ACPI Collaborative Processor Performance Control
> 
> The Windows power management report also reports:
> 
>      Performance control type:
>      ACPI Collaborative Processor Performance Control
> 
> This suggests that the firmware is exposing functional CPPC interfaces 
> and Windows is able to use them correctly.
> 
> 
> Linux diagnostics
> =================
> 
> Relevant kernel messages include:
> 
>      ACPI CPPC: Parsed CPC struct for CPU: 0
>      ...
>      ACPI CPPC: Parsed CPC struct for CPU: 11
> 
> followed by
> 
>      amd_pstate: The CPPC feature is supported but currently disabled by 
> the BIOS.
> 
> and finally
> 
>      amd_pstate: failed to register with return -19
> 
> Additionally, I tested the amd-debug-tools package (amd-pstate v0.2.20). 
> Running:
> 
>      sudo amd-pstate triage
> 
> results in:
> 
>      Unable to gather CPU information
> 
> strace shows that the tool attempts to access /sys/devices/system/cpu/ 
> amd_pstate/, but those sysfs entries are absent because the amd_pstate 
> driver never successfully registers. I believe this is a consequence of 
> the initialization failure rather than a separate bug.
> 
> I have attached various files:
> 
>   * complete journal from boot
>   * filtered amd_pstate and CPPC logs
>   * ACPI tables
>   * cpuid output
>   * acpi_cppc sysfs dump
>   * cpufreq information
>   * amd-pstate triage output
>   * Windows 11 Event ID 55 output
>   * Windows 11 powercfg output
> 
> 
> Question
> ========
> 
> Since Windows successfully uses ACPI Collaborative Processor Performance 
> Control on the same firmware, is this expected behavior, or could this 
> indicate an amd-pstate compatibility issue with Linux platform?
> 
> If additional debugging information or patches would be useful, I'd be 
> happy to test them.
> 
> Thank you for your time.
> 
> 

Can you have a try with this attached patch?

--------------T0kLPzkO5Cuq887YqmdPWLJb
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-CPPC-Don-t-gate-FFH-EPP-writes-on-flexible-addr.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPI-CPPC-Don-t-gate-FFH-EPP-writes-on-flexible-addr.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzOWJkNjY5YmIwYWViMjQ5M2NhNGEwN2NlNzBkODNlZGY5MjZlOWQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4KRGF0ZTogTW9uLCAxMCBBdWcgMjAyNiAxNDoxNzozNSAtMDUwMApTdWJqZWN0OiBb
UEFUQ0hdIEFDUEk6IENQUEM6IERvbid0IGdhdGUgRkZIIEVQUCB3cml0ZXMgb24gZmxleGlibGUg
YWRkcmVzcwogc3BhY2UgX09TQwoKY3BwY19zZXRfZXBwX3BlcmYoKSByZXF1aXJlcyBvc2NfY3Bj
X2ZsZXhpYmxlX2Fkcl9zcGFjZV9jb25maXJtZWQgYmVmb3JlCndyaXRpbmcgdGhlIEVQUCBhbmQg
YXV0b25vbW91cy1zZWxlY3Rpb24gcmVnaXN0ZXJzLCBldmVuIHdoZW4gdGhleSBsaXZlCmluIEZG
SC4gIEZGSCBhY2Nlc3MgaXMgYSBkaXJlY3QgcmRtc3Ivd3Jtc3IgYW5kIGRvZXMgbm90IGRlcGVu
ZCBvbiB0aGF0Cl9PU0MgYml0LCB3aGljaCBvbmx5IGdvdmVybnMgQ1BQQyBjb250cm9scyBpbiBT
eXN0ZW1NZW1vcnkvU3lzdGVtSU8uCgpBcyBhIHJlc3VsdCBhbWQtcHN0YXRlIGFjdGl2ZSBtb2Rl
IGZhaWxzIHRvIGluaXRpYWxpemUgb24gcGxhdGZvcm1zIHdob3NlCmZpcm13YXJlIGRvZXMgbm90
IGFjayBDUFBDIGluIF9PU0MgYnV0IHdob3NlIEVQUCByZWdpc3RlciBpcyBhIHdvcmtpbmcgRkZI
Ck1TUi4gIE9uIGFuIEhQIDI1NSBHOCAoUnl6ZW4gNSA1NTAwVSkgcmVhZHMgc3VjY2VlZCB2aWEg
dGhlIF9DUEMgcGFyc2UKcGF0aCdzIGNwY19zdXBwb3J0ZWRfYnlfY3B1KCkgZmFsbGJhY2ssIGJ1
dCB0aGUgRVBQIHdyaXRlIGlzIHJlamVjdGVkOgoKICAgIGFtZF9wc3RhdGU6IGZhaWxlZCB0byBz
ZXQgZW5lcmd5IHBlcmYgdmFsdWUgKC01MjQpCiAgICBhbWRfcHN0YXRlOiBmYWlsZWQgdG8gcmVn
aXN0ZXIgd2l0aCByZXR1cm4gLTE5CgpHYXRlIG9ubHkgU3lzdGVtTWVtb3J5IG9uIG9zY19jcGNf
ZmxleGlibGVfYWRyX3NwYWNlX2NvbmZpcm1lZCBhbmQgYWxsb3cKRkZIIHVuY29uZGl0aW9uYWxs
eSwgbWF0Y2hpbmcgdGhlIF9DUEMgcGFyc2UgcGF0aCBhbmQgY3BjX2ZmaF9zdXBwb3J0ZWQoKS4K
CkZpeGVzOiBhYWYyMWFjOTM5MDkgKCJBQ1BJOiBDUFBDOiBBZGQgc3VwcG9ydCBmb3Igc2V0dGlu
ZyBFUFAgcmVnaXN0ZXIgaW4gRkZIIikKUmVwb3J0ZWQtYnk6IEdpdXN5IDxrdXJtaWtvbkB5YWhv
by5jb20+CkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vZTQyNTk0NzQt
ZmE0Zi00ZWQ4LThhN2YtMWEzYTI1MjFhY2QzQHlhaG9vLmNvbS8KQXNzaXN0ZWQtYnk6IENsYXVk
ZTpjbGF1ZGUtb3B1cy00LTgKU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlv
LmxpbW9uY2llbGxvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIHwgMTUg
KysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgYi9kcml2ZXJz
L2FjcGkvY3BwY19hY3BpLmMKaW5kZXggODQ3NDBhZDhjYTYzYS4uM2EwY2ZlMmQ5N2M1NCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jCisrKyBiL2RyaXZlcnMvYWNwaS9jcHBj
X2FjcGkuYwpAQCAtMTY0MiwxMCArMTY0MiwxOCBAQCBpbnQgY3BwY19zZXRfZXBwX3BlcmYoaW50
IGNwdSwgc3RydWN0IGNwcGNfcGVyZl9jdHJscyAqcGVyZl9jdHJscywgYm9vbCBlbmFibGUpCiAJ
YXV0b19zZWxfcmVnID0gJmNwY19kZXNjLT5jcGNfcmVnc1tBVVRPX1NFTF9FTkFCTEVdOwogCWVw
cF9zZXRfcmVnID0gJmNwY19kZXNjLT5jcGNfcmVnc1tFTkVSR1lfUEVSRl07CiAKKwkvKgorCSAq
IFRoZSBmbGV4aWJsZSBhZGRyZXNzIHNwYWNlIF9PU0MgYWNrIGlzIG9ubHkgbmVlZGVkIGZvcgor
CSAqIFN5c3RlbU1lbW9yeS9TeXN0ZW1JTzsgRkZIIGlzIGFjY2Vzc2VkIGRpcmVjdGx5IGFuZCBh
bHdheXMgYXZhaWxhYmxlLgorCSAqLwogCWVwcF9mZmhfc3lzbWVtID0gQ1BDX1NVUFBPUlRFRChl
cHBfc2V0X3JlZykgJiYKLQkJKENQQ19JTl9GRkgoZXBwX3NldF9yZWcpIHx8IENQQ19JTl9TWVNU
RU1fTUVNT1JZKGVwcF9zZXRfcmVnKSk7CisJCShDUENfSU5fRkZIKGVwcF9zZXRfcmVnKSB8fAor
CQkgKENQQ19JTl9TWVNURU1fTUVNT1JZKGVwcF9zZXRfcmVnKSAmJgorCQkgIG9zY19jcGNfZmxl
eGlibGVfYWRyX3NwYWNlX2NvbmZpcm1lZCkpOwogCWF1dG9zZWxfZmZoX3N5c21lbSA9IENQQ19T
VVBQT1JURUQoYXV0b19zZWxfcmVnKSAmJgotCQkoQ1BDX0lOX0ZGSChhdXRvX3NlbF9yZWcpIHx8
IENQQ19JTl9TWVNURU1fTUVNT1JZKGF1dG9fc2VsX3JlZykpOworCQkoQ1BDX0lOX0ZGSChhdXRv
X3NlbF9yZWcpIHx8CisJCSAoQ1BDX0lOX1NZU1RFTV9NRU1PUlkoYXV0b19zZWxfcmVnKSAmJgor
CQkgIG9zY19jcGNfZmxleGlibGVfYWRyX3NwYWNlX2NvbmZpcm1lZCkpOwogCiAJaWYgKENQQ19J
Tl9QQ0MoZXBwX3NldF9yZWcpIHx8IENQQ19JTl9QQ0MoYXV0b19zZWxfcmVnKSkgewogCQlpZiAo
cGNjX3NzX2lkIDwgMCkgewpAQCAtMTY3MSw4ICsxNjc5LDcgQEAgaW50IGNwcGNfc2V0X2VwcF9w
ZXJmKGludCBjcHUsIHN0cnVjdCBjcHBjX3BlcmZfY3RybHMgKnBlcmZfY3RybHMsIGJvb2wgZW5h
YmxlKQogCQkvKiBhZnRlciB3cml0aW5nIENQQywgdHJhbnNmZXIgdGhlIG93bmVyc2hpcCBvZiBQ
Q0MgdG8gcGxhdGZvcm0gKi8KIAkJcmV0ID0gc2VuZF9wY2NfY21kKHBjY19zc19pZCwgQ01EX1dS
SVRFKTsKIAkJdXBfd3JpdGUoJnBjY19zc19kYXRhLT5wY2NfbG9jayk7Ci0JfSBlbHNlIGlmIChv
c2NfY3BjX2ZsZXhpYmxlX2Fkcl9zcGFjZV9jb25maXJtZWQgJiYKLQkJICAgKGVwcF9mZmhfc3lz
bWVtIHx8IGF1dG9zZWxfZmZoX3N5c21lbSkpIHsKKwl9IGVsc2UgaWYgKGVwcF9mZmhfc3lzbWVt
IHx8IGF1dG9zZWxfZmZoX3N5c21lbSkgewogCQlpZiAoYXV0b3NlbF9mZmhfc3lzbWVtKSB7CiAJ
CQlyZXQgPSBjcGNfd3JpdGUoY3B1LCBhdXRvX3NlbF9yZWcsIGVuYWJsZSk7CiAJCQlpZiAocmV0
KQotLSAKMi40My4wCgo=

--------------T0kLPzkO5Cuq887YqmdPWLJb--
