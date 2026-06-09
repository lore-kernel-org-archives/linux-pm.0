Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DC2135AD;
	Tue,  9 Jun 2026 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012944; cv=fail; b=BW5vMzp3lEOM0lp0W02OOuHWDY6HhGr7q8DSqgxRjdJWJBP0p0vhF/5U5NsISytvbtAdF9hK3XzF8X4MuQSJy7XnJ5LxkKICnwByRPvBeGXWvEGGmF6wF5lW+F+GKpUOjGUooIJ6eeg127AlJIyRIAX4sG4zpi2VExJOoYyPFVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012944; c=relaxed/simple;
	bh=jHdTtx9qkNBiLnKRgURlPmEy8DmPDMRQ/yzpIlKSptk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SMMs11+qVUlpmjx1lKWpLUuvNFEOGuEXiEMt/H/czHGYAOuc1AozkljuB+4o5BYnyMrKEnMSxaUvTo963pTHFkpQKF0P6QVhureziBJPQeYcMgK3XhC7ZTADXP5FvxzUBUpiIlsmtdvqiJY6WEakiU47IsFK+EQWDPut44XJo/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xiFuRiUb; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xiFuRiUb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2d06g0QmAqnJkV4RO5FUsykabr9oRnyOHvlCp5GdZ+s0PPijzrBH1hzRSYYP6RnTtSVTtNzZRUaBryPp2HsDyi1xi1z53QzaBX9adNG3uxrXrna9wJtGBgHOkv4BRKdGyQ2kCfhWVlKTrrfFuEkd0hEC9RV82VC5XmMqmpFKlgS3GWnYXsPTWKxOGLljQAu6Btd2MXdJpPOhT9MJE15PCge/K/sR5WRHmCpfJuuAgWfjcBUotdLtvgx7ezKtqfW5y2wD+4FLp4QMnQsSNtnMaytAqtbd8mA34mfFDHvgtW0KERv1/6FJ1lVvGS4hOZP/Z7FDMbtekBSp7u2L74V8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3GYqpwqJXFTDf7Fvz6BBavOBWakl1aTXcK+XQ4m0gk=;
 b=oWyeC+6NIIYgfyhn2ONyrRIT9ZnLuQ7+j3bYtll449cp91VrywhGwFFci4SRIu8xxAgLfOOy/8VnnoBNtl2yO5CLHAWdqsS4U4ifwe8U8eS4EGH9Wbk2/Mkc3syFO2ruuZ9qx5xjapO7JD3dFF8R1eNrxE7h36Bw11hvZV6xMK3be1MsJp82lJCg/2nIBLSdA02GccsSMlBiBmk1ZfhrT87j0a75kqSLPL3oPs/XWr8adJ2glBzfC4A6g8Tqaqd3n51ATJxDzzpMhvjThxk24Frj0iNYVT3jg76TAnOL0t1BMX3ysZ+WuMa/1lcz0cvxq4cwTFlt+OIUZXW0YhfD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3GYqpwqJXFTDf7Fvz6BBavOBWakl1aTXcK+XQ4m0gk=;
 b=xiFuRiUbni51CEyGLtAYVRGOIt+Y2wQ3UR2xYKd3GVzrvc2N18IbSOCmM4xqGJ8fp1YZd3N1AakuHgVdU+AfI7bNezheg6GWk0KBWk2CIhHBJISiafbOpnKRfD/LtNmsTdswKM5uSvAjsOYkJpIPZuDklPGqfNdYzGrREvrkKL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 13:49:00 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:49:00 +0000
Message-ID: <9345645e-8548-496a-83d6-8741cc001cca@amd.com>
Date: Tue, 9 Jun 2026 08:48:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] cpufreq/amd-pstate: Fix EPP and auto_sel
 initialization
Content-Language: en-US
To: Marco Scardovi <scardracs@disroot.org>, kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 stuartmeckle@gmail.com, viresh.kumar@linaro.org
References: <d8bc45af-d8bb-48fb-9f3e-5188c8d79c8e@amd.com>
 <20260609073042.81275-1-scardracs@disroot.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260609073042.81275-1-scardracs@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a64ce3-95ca-404f-0323-08dec62ddbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BUJtCBqQ67p/TOs33fqwd/N3pJ4JFgGScUArU4+C5BAxCT0uAzB+KyN0t943EUCcKIRz2EbksLDvTF3HOLGfOkNCmmAA6nXB36Qn71mDPk2qWLzZOQ5CHm4p94lGpMxGVTibXif8s0apQjAfoU/0BRefeMdoBhdu0wLvH7yX7HFKWknJKNoxzD0MJnvsgh1GnJZo/sHX5lul5mbW0xid4ZFMEoKzL6rRALkQKvCdqp+vcfIlcUkti2qJSMAEsF1eKuQx1z0JANnyF7b7UryghmjW/+gia/kNHyvm6GA2eNf22t0gjyNmuw+psBt0fd6aARda8JyXDGP/WVDVCirKi7KKnsYdY7CYdG/VheGV1nxrsnPKyIWhagbqHDmveD8fucYrGLGUcuq5+vyD6SI35athzx6Sj6ug9GV5R+v7egpWo53TKNghXyLweJNJ3j1F9NErLb68RFceEV6JA6imqvcXuZxVFCEmjB6kzbElGEedhHz+RtSjQt9f+P8O436aZXWxb1dCk2GzD6edlI7imtY+UPpLNi3GTXkHCJ5G6b8ebFDNn7TybgJhJ4nMQ+SblczPUK/IqyM6bbx12h1SO4gkXcz6cS6TgmIja4HXbMq1/rJemV6Z6r8eVpBZ/vH0aYxYd2HXuLxaIxrUyfYWSe3qAQO+A2tr/aIX+yqXoT2S2cfeY2nZTOH4ViSXb3re
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG44bHNCTzBIaitIdUtwM3p6R1JjK0hsUXNiZzRVajBKRWhvOTdHVlprVmNF?=
 =?utf-8?B?Z01GaTN1QjlOZ3Y1Z2FDK1E1amFoQlVIWms2UU1FbENPWmJZclVBQ3pGTnZN?=
 =?utf-8?B?b0hOV0R4bk41VUU4SHJ0WkZZTnJ5elNGMmM4NzQ3RzYzU1lpVFBQK0R3Qnl0?=
 =?utf-8?B?cVFtQ2dYbk5SZjk0dGdoa2Zna2JqYVE5ZDJqR3JXUC9FMm11TUhMZmczRE5T?=
 =?utf-8?B?OXc3QVdTdFlJUCtSWmc0bWQ0Z1NwcjhaRitUczM1MEg1SFlXck9aS1p5RkNv?=
 =?utf-8?B?UlcrSGwrL2EwWS9ycHBTVFJPWDlLMTRwb1N6cWd1RC9PSmdDQm9PMXVhN0h3?=
 =?utf-8?B?V2o4TG9XNHdpOEZjK0M3RVppL2pBRUx3WGJDZDd6THVMYlhCMzZhbWV3VVBI?=
 =?utf-8?B?djBCcVJHU09oYldpVVhlVndUMzhtWGp6RW9ZWllnaUluREhkRkJyYitYSmdV?=
 =?utf-8?B?WFAybFpxdmlYT0grMmRTWW9MOEh4eFRrclJpZWFzeTBpbU85SVZQMzc5RThR?=
 =?utf-8?B?TmRpS1gyOVpJUWdzejkrZWk0KzNyaTJ0ZFAyanJaY0JpemdaMk9VNTNCVWVv?=
 =?utf-8?B?UWRLSGtNQXp0SUNuQWt6c0dkKzFPMm0yL1JySnFlOEovKzNhYWJ1TStWK0E2?=
 =?utf-8?B?bzVtNFZaVXlmRFNpaEd6clp1dVgraGlVZFR2ZmowWTVpeFhHQzJCN3ZueWF4?=
 =?utf-8?B?Yjg5RDJpemY2anlGZG5EZjg0S1VOTk5Nb2ltRkY1dXEybGg5bVpzcWQ3Y01t?=
 =?utf-8?B?QmpOVFJURTZ1ODJEY3UzWnZWT3paS0NQbnFIcVRlSFpwNWpqQ3ExZDlvYndB?=
 =?utf-8?B?d3JsQ01lbktSdDllOC8rdWEvVmRhdEV4Y29MRkJ2Tkd1QkRqeUtVL1VSYTU1?=
 =?utf-8?B?OXYyQkhZUGdqOWFjbURvMHdxWXppU2hMS2NQejNzOWhaSmRlM0RnUlNqVlBq?=
 =?utf-8?B?UlhzR0FJc3did29Welo3TU1CamU1OXdRQS9aZ0JOd2owT0xEMDB0MHhxckdv?=
 =?utf-8?B?ZGxrcUtrd01CR0R3RHNnNkVSVUZzNlVoQnN0c21vaWZVVWd4Y1REQ1ZFeXNV?=
 =?utf-8?B?U0NJSWI4ejAvOTlBQVVQMkxNYUo3N2Z6Unp5MC9URU1mWlE4THBYMEpabG1q?=
 =?utf-8?B?SzRZeVQyYTZiQmV5UHA4QnRiQ3UvNDNDNW1JNDRtMGxnellJWHhzN0xjTnR6?=
 =?utf-8?B?dUkxZjZoR3JReVd5VzNERVhhN1hsNlNhZEJRYWszUW5YeklOOVhuT0hjdGNY?=
 =?utf-8?B?c2JZTndGVzJjd01NZ0V6RFRtRlRxU2tpSFpGREpMd1g4VTRjeDNUeWF5d0NP?=
 =?utf-8?B?S3lVcE5zd3VQT1RnMmFUR3p1TFlLR3JyZkRHRm8vRWdrajlUeXFkTGN2dnJi?=
 =?utf-8?B?cFg2TU1PK3k3cmtPdHFkSHJIcDVkcnp1N1p3aStJNGI3NTA0ZjIrNDd6aC96?=
 =?utf-8?B?K2xESmVwQng2VU9xbkE0QXFINlBQbWMyNCtvaUNkSjlScjBnU2V1engwdVFw?=
 =?utf-8?B?SmxMKzlOdUxDM0dyZVJuNWdLVFJJWEpkNlB5dGVjVEMwSzJnb3R3anBtQ1k0?=
 =?utf-8?B?aUZMc0x3WWVMcWdVMjFIUThNMXVhalR0RTZPRzJQcFZmUTJSUjZqTERrWTFr?=
 =?utf-8?B?elJyNm1tNy9UWHdVQTNNanVjZWhNOUFRVVFqcWd6eDZRMVd6dmNDVXlzYnVi?=
 =?utf-8?B?STg3UU9aVjBrOW1oSENuN3czTndmdHJiQVlnbVNRaHJleVJ5N2N6TTR4eFFK?=
 =?utf-8?B?dk9MQ3lVVlZYam1tS3Y2V0cyUkZVMDB1V0pFajV5MTg0VmQ3L2FPcno1ZHli?=
 =?utf-8?B?ZXE5RU8wSkxnemg3V2RCWFJtTjhOcFFybzBpZ096M3dZYTVSaVRoVUVSVmd6?=
 =?utf-8?B?eWR6b0wybHFVS1VBbVNLckcwdlBSRkdDdG5lL3dWRHJhUjNrLytpcUE1c3la?=
 =?utf-8?B?T1UrWEsyQnNlSHM4alpTYThsNzM5bk5xbnppSnRkemhuU0dVZ1hQZkRrbUZi?=
 =?utf-8?B?T0x5ekxaVU81dkE1THk5UXhhOHppdHhraFJDZENVYXpZb0dIOGdCenJiWVBo?=
 =?utf-8?B?N0Z5MkwwUGh5d0VJeTNIWFVGMDBDQndaeWd2cWc5TktzWFN3R0k2SEI1bUZS?=
 =?utf-8?B?eUYwZVloV0VUNmRzODdPSFlReHlza0VQU05iSGpZVmVzSmNpUHp3Q1VFU05k?=
 =?utf-8?B?OHdWR0NuMzh2b001bDh4K204STVwRlNwenRIREwxVm9rWEpNT2R4cHRlTzB4?=
 =?utf-8?B?ZVNySERDdGFSZmJQWmxqMjBLRFN0ekRCcVZNb0Z4Y2k3Z0pyWHZ5Q1Q3dFE4?=
 =?utf-8?Q?/jaUkrpqHYXhSWFRDc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a64ce3-95ca-404f-0323-08dec62ddbdb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 13:48:59.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRnM4DDo9Bi2LRZAac+buQhFEMHZEgH5X4QDyedSBovxuG/QOrTAqr+UtxQ23xF5IIDwW6jz/bDmukY9qEkHjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260



On 6/9/26 02:29, Marco Scardovi wrote:
> Hi Mario, Prateek,
> 
> no big deal making a v6 with your suggestions. I'm glad this series come to an end
> and everything works as expected.
> 
> Here is v6 of the series addressing the feedback on EPP and auto_sel initialization.
> This version updates the metadata with Reviewed-by and Tested-by tags and applies
> a small commit message cleanup.
> 
> Changes in v6:
> - Add K Prateek Nayak's Reviewed-by and Tested-by tags to all patches.
> - Drop the redundant paragraph from the commit message of Patch 3.
> 
> Changes in v5:
> - Split the single unified patch into a 3-patch series:
>    - Patch 1: Change EPP helper return types to signed int and add error handling
>      in amd_pstate_epp_cpu_init().
>    - Patch 2: Remove the active-mode early return check in shmem_init_perf() to
>      ensure auto_sel is properly toggled on shared memory systems.
>    - Patch 3: Cache the initial firmware programmed EPP value in cppc_req_cached.
> 
> Changes in v4:
> - Refactor EPP getter helper functions (msr_get_epp, shmem_get_epp, and
>    amd_pstate_get_epp) to return int, conforming to standard kernel practice
>    for value-or-negative-errno helpers.
> - Clean up commit message description to link error propagation directly to
>    EPP caching.
> - Execute the remaining shared-memory initialization path even when booting
>    in active mode, rather than bypassing it through an early return.
> 
> Changes in v3:
> - Patch 1: Cache the firmware-programmed default EPP value at CPU EPP
>    initialization (resolving the boot-time false cache hit) and explicitly
>    toggle the AUTO_SEL_ENABLE register to 1 on shared memory systems,
>    rather than utilizing a state-tracking flag as proposed in v2.
> - Patch 2: Dropped as CPPC systems universally support EPP.
> 
> Changes in v2:
> - Patch 1: Rename `epp_initialized` to `epp_hw_programmed` and add a comment
>    documenting the EPP cache guard optimization behavior.
> - Patch 2: Add comments explaining the uniform CPU capability check on x86,
>    handle EPP capability check errors robustly (only treat -EOPNOTSUPP as
>    unsupported, warn and assume supported for other errors to avoid false
>    negatives), and reject runtime active mode transitions at sysfs store time
>    (preventing the driver from being left in an unregistered state).
> 
> Changes in v1:
> - Fix the boot-time CPPC EPP/auto_sel initialization regression in
>    shmem_set_epp() using a state tracking flag while preserving runtime
>    cache optimization.
> - Add an EPP capability check helper during initialization.
> - Fall back to passive mode at boot if EPP is not supported, and reject
>    transitions to active mode at runtime if EPP is not supported.
> 
> Marco Scardovi (3):
>    cpufreq/amd-pstate: Fix EPP return type and handle errors during
>      initialization
>    cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory
>      systems
>    cpufreq/amd-pstate: Cache the firmware programmed EPP value
> 
>   drivers/cpufreq/amd-pstate.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 

Thanks, this all looks good now.  Appreciate the patience, and thanks 
for taking all the feedback into account.

I will add it to my tree and it will go for next cycle (7.3).
