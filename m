Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E303314B7;
	Thu, 16 Jul 2026 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784231450; cv=fail; b=KiEkSVWv2l47co/XVaJpTYbPtqQAolx06wazsjU4lFGn4gbUsOL8Bq9ukh8ZbK1Ar3k8gYjzv+uCmXzLrpL6VURcy0RG2TrsTHCeBeAmKdXdNDqHppOY3W1EQCTWE7SjU/d/R9p21zgTgTX8cGUxZHX2uO1jmT0rgSB6WfESQ1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784231450; c=relaxed/simple;
	bh=sEmI57RVv/cJPeOtWThJvLF2p3vLCWLxaCzkmnLY4KI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dwsyrq89lIUcC6FYek3pJ0gY88Wc7vrVl+xfZvGgZmfIwyumkMnBESspjCSV5HaryBs1Ufy16ddr0+8WZArF4yLyE7HqB5LEUd7Io/uVOgR4R8bAU+1Wpwr9p6dt2RX1mJITe4YYKtmeQx6/BFyDAiGC2ZNSfLKJgp8rnDz8OfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0mtH6Cen; arc=fail smtp.client-ip=40.107.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0mtH6Cen"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaoN8q4KwHIKkAjUmgP5HzGU0r/ULgJ/9ha2yVQDdFHi19iQeR6/fXbVYco+CzDVEo5vcJgKaOL20mtnSJP38TBqZNd1AqHUxTFQZeKmbn9VHQDiNJaXB18BAT8p4j/p5xFy1lvEG8TB4u2D/p753sFEik0VW3m5zSkgHDbpz0DfVn7msumrk0A22J1vqusGFQsHgCRbQ6ZYKa9hDI6BcxpkueuKwobJradhcDCJ1qedXqr9DcHPA1aDMz66hyU5FvMRBuB0z5sONazQiTu3JrHoqMStHJzciq6M/GmKl/JL5/GGnA4jaFa2KXW0y6f6fxH0omUw+ibAfCXkuj6PlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kxUqp0uzboEmhwb8yUROR6IhG5Rd7H8Ml+Rd8uaoD4=;
 b=GdU/vWv8XGFwlAyZluALfokpD3N2crRwHNoUUdTapCrDHeAfFe7YErz/uLwLl2PJDkYp/lq/30mvOlV8hgjwjU4eUkVzzBeK7qDj/oMdG90lXQXUV1CbgJCMwRHOIEUMoHTl/synrsVREv+FT1wh7JwL6tfaOY78P7hyXfp86dfRoOy/kki4c+V3vtdIzczmcpOhDyW3kfc7R7n3iBxKTVojhNkLkjKSfFhz1eI5kLGxZep27/RttQx/IbbkrlI1qgYjmJlXKk9++JH0FDaSEs6776Rvoe9qsMgu/qOBjncNUYDZ4Z4fM6YXx3BThGvijpm9gqLHlRMzpkIKVwcEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kxUqp0uzboEmhwb8yUROR6IhG5Rd7H8Ml+Rd8uaoD4=;
 b=0mtH6CenODAznbUxFxd8gSsFhya7y7QYqUxzaXjfo5L64sTOaQS0zkfFlUXQ1MqNWTHGcNXWujEpydrxIWRrnyFNGva1rRx3HJdWo3ASkCTAaXcr6OWKipYMi8orQqaHldC9yikZVnufim04/h62rrC7KwcARKIzjYRtwOXSd6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 19:50:46 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 19:50:46 +0000
Message-ID: <63b26408-d75b-4de9-b3f2-eed5687a8b09@amd.com>
Date: Thu, 16 Jul 2026 14:50:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] cpufreq/amd-pstate: Fixes for "Requested CPU Min
 frequency" support
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260715074822.16324-1-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260715074822.16324-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0207.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::32) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 30082cc3-b802-49f8-8d12-08dee373871c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	FyvZx/RbrKDEf2DsJE82nRT/BpzU6KW5YJQQuSbdHpzdvZrkIMHrRraRZCtI8+8Rl8InqE8O4g1x2HNSt1HbjEh4JR17CWFXc93BQpvPwxakHI9EH1XkPyoDSBXk6J2BJuU43R5SR1M9xSLW/eZMttzL1KhIfbGxZttYIhsgvsxvqcC5CnlBjmgVMt97idJWf62Zos/GrZcCoW5a45sqgiCjOk4/DHzqQUICzjD1z/Dqsy1szXaZt7L//1vhInR2wvTFyPCZjVUf2LBNnk6JqmQvubeoWcjB1ZF+LNtjLh8oC8GUvMEbIHvjwaKPSasKJeqUQm8RonCXBgBIS07zptLzlejNaH7A8W8wMv5GmPB+UPwOdJg0fvEb1a98JXF+I6qi6wcH69py3H8qvSv6TESIJkH81LpR7bDBq9C64zfpdHGfwoI1MJxYMzsWcv7FAh/rM94B+Kx5MXyxmLPQlgEspqmY9aG1rFkE/RRgInz73QbTIz8MIp+eLdD0mf5F3ac55jq1dmwDJS9HZVIslPXfdWwwKRkbIjvcicIuXXtklZKCGdRHc7cGOmouUEAv8b59qgRUPaT5CmpE1/D07WLG41OyrADlETP5ojMGKkWr/OHBFu0h2aP+H+S2VAZdbSE8so+VsNQq/ycwgC4Ocdvs8ufYgs3S6IOeObk3S0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWlPekdCOFZJbGxuUmE0bGVNYXhGQWxzNm91T2xrSkwzbEVBN3ZxV1Q4UTh5?=
 =?utf-8?B?Vk1RWDBGNlhrZm1tL01NV0dBNGkycndSS1pPb29ZazVGYnZwZ1ptK1R2TUlj?=
 =?utf-8?B?K09GekZqcUtSVWpaZHdOYlFUanVuNCs2M0VrWVZoUmRDU1VWS0xrQUhTSllK?=
 =?utf-8?B?d0pqRWhwN095NHd4UlE3QWtXNGxjYm4wUGgzNFBsSHh5MXU3QnQ2ay9Pdm15?=
 =?utf-8?B?SEYya1ZUdkZkaDJ0YmxRMkdMZG9kdDhWL2RpTTV4NERCQTcyWDM0aCtzRVh1?=
 =?utf-8?B?NERrM3BuKythck5tL3Q1Zk1GbXBUcUtOem9nTW1HWVlGZzVsd3NSdDNBNGNi?=
 =?utf-8?B?aFNlL2w0RmU5enc0WWRHb2FsSlV3QUxHM3FBSWlXYXZEUFhScFZnWDZSeCtJ?=
 =?utf-8?B?M2tWNm9rdlNlbFhVR0JsdWU3YmZCN0kwZ1R2SFBQUVlCa1Z0Qk5GaEFhS2pE?=
 =?utf-8?B?OTdEbHJVN3NwczlpbmdMcWkvOWVPYjB2Tysva2ZzWHlTVnJsajRnNStqSDZn?=
 =?utf-8?B?UEFhMzArNFNCQkFFVmEvV2Zva2l2ZHhLN3NWNWl3VUMzcS82NjZKSG42aWlW?=
 =?utf-8?B?dnQzcVRJU3VIaU1YN2ZmdGptQ2JSbThmWUtKd05lVU1IUmhONURvQVRxNnYv?=
 =?utf-8?B?cmE3M3l6Mlo1OVhIUkNxaUlHTGJydmNJZlBpTm1CamFIcTNXcDk0eVoybjk0?=
 =?utf-8?B?YVRGM0t4bnI1Wm1oTEQ0R1J3SGtZVUJKZUNUaktFM3NReldCM0FOTkNpM1dw?=
 =?utf-8?B?NW04TTNjWEdmMzNoeFNUemJUaWl6VEwyeS9vdm1obzkwKzcxdk95UmpRbEFH?=
 =?utf-8?B?WTdPNHRnT2huU3Y3T0pGV253aGcyUFh6U2ZuVVFCdmlWR3FvenozR3Q3OWxL?=
 =?utf-8?B?TW4wNS9hckNVOUF2alJGaGl3WTlFTlBLUXBFUGhkb1h0VmVTVkNPVkcvL1NT?=
 =?utf-8?B?MVZCc1FyTEo4N2FmNUcxVnl0TFZndWRveDlUYThLZjVFSko1VldKMy9vZnR2?=
 =?utf-8?B?TTFpWXhwaGdwVHZjNWYzeTZaakdvUlNYNWphaDhXS2dqRGpEaGJrMzhpTlJF?=
 =?utf-8?B?dDdZbExkOHRqODU4VW9YdSsranUrVmk5bnVpY3FwbGpQRFdHcWlza0JHYVhu?=
 =?utf-8?B?TE11OWNicVhWNUJlejFrSXlzNVZnSHRpZ3MrSEFMSlh3R0VTT201TGFPTlRw?=
 =?utf-8?B?b0tPaXZVLzM0T3lUUXlrWDJVREN1K0FUTnQ2bWFHNVhDeUJMaitsWCt6TTEr?=
 =?utf-8?B?anpKRW0yYk11N29kYmhhTVNxU2V0S3dkTC9pdUpja3diVWJLR1dpQXUyY0g3?=
 =?utf-8?B?MGY2bWhtV1BkQW93NG5lU0x4L2lpTjlvdmYwTmd6cm5GNm9vNFhvNXdOK2Jt?=
 =?utf-8?B?WHMrUjJ2QWNJSEJ1LzF0dGxwSTJqMmFnMXFkU3FLM3FuOFE5ZWcwU0NNand2?=
 =?utf-8?B?TVBYT2NmM0ZUeW8yTTFHWlhHbFNXdm1NTXFFVWl5Tm50VWNDYkFlRk1NWWVT?=
 =?utf-8?B?TTJkenZzU3FoNUhYbUZFWWpHV0ZDaCt4UVluRmZWUXg1S0VjQUp5Q0MwTEJS?=
 =?utf-8?B?Y1MxeFc2N1ZzNVVRUWNMVmQybHhqRWFPeVIzYWEweUJnajNEcVZTL0tZMi8z?=
 =?utf-8?B?Mkw4Qnp0WENXOVpmblgvNVdQc2Z3VE5FQ0JHUElFSno0c1MyUVNOdHdEc0ho?=
 =?utf-8?B?Q3ZHcnhLSjltYlcrbmlsenFkN0NsYnl1RGZ3cjNBdVFMVjh0dEkwMFM1bURJ?=
 =?utf-8?B?Q3hoWTBnUVdjTGhKY2VoOXV1SjJVUlBpbDZnOG8yUVYrV3VQbDgyRUZDdVd3?=
 =?utf-8?B?bXJGZ0RMTDF1ejVtRmFHbHUrQnpaSm41L1FEcEQ5SmJmY09UckZKaUJabkZt?=
 =?utf-8?B?Ym4wWUZlSWJMeDQrSEszYURyVGduZTdoQ3dGaTUwaVNUdGFyTVBrSlR1T0lT?=
 =?utf-8?B?MjVBbUhTbEhTT2NsUGRUWWRxVkJSZnZva2NHTWVFQ3crSFFwNFZ0L3lPZXlh?=
 =?utf-8?B?cGJBT3NGYUNZdzBEUjlzcW5TTDRCUk4wWHNZUGJ0bFlnajYrTkNRSmlXS3RO?=
 =?utf-8?B?ZmNHK3h4VC9McGFsOXRvUGxQRUVpaXZoRHlxZzZmOFV1VDVRR0s4UVNuMEc3?=
 =?utf-8?B?WFZrOUllcWhqSU9MeUM2QVFnUDZQNkU5YTNNYWNrQitkamxvNDJtVFo1dTVk?=
 =?utf-8?B?Qm5sSzdBY0lSSXgreE1pT0JGZEJVTDNJZEdrSGd0WlM1dWhuNFhEWU83ZjRI?=
 =?utf-8?B?RHBqK0g5T05BVndDeXpaNGZkM3hLc0lvUkttWnRDenUvWklvQXQzZFVhM0sx?=
 =?utf-8?B?bWtrVUxiQjVqZXVzTGtSQytoSmJkb0t1MTBJR3BkenZrR3RZVm5Vdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30082cc3-b802-49f8-8d12-08dee373871c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 19:50:46.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A3KAj4H4Mdopoiwo568oofBnVMPpNK7OQUMzazClWylshFe4h97sU9H7GK/SB+DwGTOjg3rwEfpFtdyWKL23w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6



On 7/15/26 02:48, K Prateek Nayak wrote:
> It was noted during internal testing that amd-pstate active mode with
> performance governor always sets the min_perf to nominal_perf despite
> BIOS having supplied bios_min_perf as the preferred idling perf.
> 
> Users who set the "Requested CPU Min frequency" from BIOS are known to
> have profiled their workload at different operating frequency to know
> the best configuration and amd-pstate should use the same as the lower
> limit when configured.
> 
> While testing the fix for above, it was noted that kexec fails to
> persist bios_min_freq even when both, the old and new kernel are aware
> of bios_min_perf.
> 
> The suspend, offlining paths switched to persisting the CPPC_REQ MSR
> state at the time of suspend / offlining with only min_perf being reset
> to bios_min_perf.
> 
> msr_init() path only accepts the configured min_perf as bios_min_perf
> when it finds rest of the bits in CPPC_REQ MSR to be 0. This is
> intentional to prevent stale value of last CPPC_REQ from kernels that
> are not aware of bios_min_perf to be mistakenly interpreted as the
> bios_min_perf during kexec boot.

Is it a real valid case we need to worry about for someone kexec'ing 
between kernels that are aware of this vs not aware of it?

During kernel development; sure this might happen.  But I would think 
once this is available in mainline any of the distro kernels will have 
picked this up and people will start with a distro kernel with support, 
or they'll start with a distro kernel without and upgrade to one with.

I can't imagine a case people will go the other way.

> 
> Work around this limitation by stashing the state of CPPC_REQ during
> suspend / offlining in cpudata and then only programming the
> bios_min_perf into CPPC_REQ while keeping the rest of the bits as 0.
> 
> Resume / onlining callbacks use the stashed state to restore the
> CPPC_REQ before the CPU resumes normal operation.
> 
> Patches are prepared on top of linux-pm:bleeding-edge at commit
> 0e4eef86f0f4d ("Merge branch 'thermal-intel' into bleeding-edge").
> 

