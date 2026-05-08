Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8336F433;
	Fri,  8 May 2026 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263477; cv=fail; b=KsaI2PbppaW3Iy6KWavlwqR8o2GHD/nsVfxDopqsrY7xf0V7m/0uaFoBF9OfO5eWpThMb4G7Envdyhcmj9eKXZWawjo3FtxJiqxZeF3/4TDNeAmtKoGGk8pDFNp5wuwB8hBrBdLtmSY1lbtq+MsR7gDzlFi7UKy/DC6EsVCHuxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263477; c=relaxed/simple;
	bh=MQNL+PJdMIomgpiWNGn96BzNztrURMW5jOrzytpTcTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KBN1ELSLq/iG+LD0mCHdQww4vTc4rHdrz/nXi126e80T7zGAEKmZYPFoziHwyoi1LPdG6VGtTwNIDhliayS3lq62kfnQYuPZig48Jl3YmsSsRzh4cQZFUcqE+3YNo5+WTtC0z6SwJA/BQLmhcrU5XE0O4vi/0UVQ+ZX0xnfTeII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gXMXtc3O; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gXMXtc3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toPJ3touclSWxfVjcHB0BDY/1k04lMyd34aVeA+OJ7RUq5UGhmkE2k5X7Vp5HtQlXIjbpkRVo4ZKxGtNfmdkFcrwr14dN7LiUpg/AcItu8bPQNR4yY/do+JYJDnw4FCT33RJkjHIaf+ieNL9taq+wLXVwZ+6AMNiSXgrrGVoSP9hz2dGtt1ir11LeJytKcmaMPrso9nn5vjE+h7WE3+4flnnsFn3Q1P/9M7DcLotTNXyQsieZKoXY1IiNxsLczTD8hFIHC1P/W20nXU3mnZwk1A0+aQR7gShK9U7xNVJcl7yFxmlYFjCuc/M9oZ+9OHfFvD90GiQPy8Yrs3XLhy4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YevJw9DB8gS3oP3goDG2hCjFIg2/9zP5DxjAlLLM01g=;
 b=vZoCkiGd2JwAevfge86hGsuP+cp/TGDZ+1N54+DiIi1SdlUsd5VvqaPhVFKenRSbunlyuiQiTc4T53mlcM2NFFQbdYucoIpZHj2fduHHyHnRIh7NZU4qGyVhNSEPU5+Q8e5vVbmh6HIH6aUYaDmLZfDF0g8nHAr5Oih8mD5Fdm2B0QDbaqT3XR/5GaP8O+p70pV1TnklFsibXqqrzfN4Ozvo7Hgb6xNTXszRaWD375rCWo50uo2iidtL+ETZC0WSH8yhsSrap/OYTrHEkz2CxTfUsa2EibfHFLTgAqpHVgbRTAkBdS9QTPPOFy1Gub1pxaTNC8OQna6H7tXkHq/ixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YevJw9DB8gS3oP3goDG2hCjFIg2/9zP5DxjAlLLM01g=;
 b=gXMXtc3OICi3xo7rXBxgOTakyBXyoAljp1LEqN2y0NuJIJ+G5MMLnTQw3Va/EhfDucO1vYsMFYtz/KuDY4EyMvvx6eooKXoII5vFCdz/aww3zxsVI/TwiEyQufUqnY1adqGqPlj2VW42m3i4kztZD9my5r7+VA6UKmvPs+klhjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 18:04:31 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:04:31 +0000
Message-ID: <e8214ac1-4c88-44d7-a4e4-038873c6539b@amd.com>
Date: Fri, 8 May 2026 13:04:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] cpufreq/amd-pstate: Dynamic EPP fixes
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, Kalpana Shetty <kalpana.shetty@amd.com>,
 Huang Rui <ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260508051748.10484-1-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260508051748.10484-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:610:119::30) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: b19d9335-6c65-4f08-4508-08dead2c40bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r8zRJhc0vtYeUhJm+34QhE14HOVWmKSkLt97B0qXdKBjKXdMSLmrmroyOe4h1D+hUjBN9vygi4Tfn8sbSIE1iRWKkQUilM4LP6KSFbFgpN5UTozCEAI1PVIqIz9x78V1f8fxiVeStxVizKFNMvXL6IV3Opa2M5CTWA32e2sSz9lK6C/R5/Hp60pEziIWM6Hmnd6gEXl1rlmOpuFRj3pRiLc2+9fAb6EAijqDGYGGY/WqA+nM27YCqurfqw8cBgYFAPlafEfey/v7XQXJ9uXpcVHo6bpJypyoeMo3BeuO3okA0B0ZHrnNzOTMMiucXBUsG0r58oRGyGwBw5MAKrMAyNJNoBz3ATWj2j9TrFGjNDtBtoHNZB4eCIWBnSWWW4f3I2COJSMsER+xrr4pxDnl0tD8k5fRRnOzUI059LY7QYldNph2AyGe8Q5kk801KkA1NwVxA9T95C6NhUMdVbhIVB72aZ2S4zCWW7DR5j30SHqhWoDpK1osDD0SWGVJPCxe095wkMQFF1VoS7C8qB6kJ6D5hlgyRmYkZC3TWRxQieBKUgavEPoVoqSrrFKimrkhOsNgDVXjzQmjCmXpgjjwBlcuX2LS5y/gtC0PCL3OOHnGwOn6xpBytng4fUeUhAxdzXcu8t08HHs9u7lun3vJl5lISLfbFH00cogGQxD3LeEKUsbYdmVma1lon6NdzNKY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlZGVy9BVk1sN1dvM0VkM0l6YWZsVE1BZ3JFdjhSNWFJNGMxYzRNZE1vYlV0?=
 =?utf-8?B?VkJHTkxHRlluTWJFbXFWVjlNZ2VoekNYYnNsZFdWMHRTYlU3WS8vN2pZVyt6?=
 =?utf-8?B?SVZ4V0N1eVptWnFSSG1FYUFGOW95OWl6aXRBcWpTMGpyQnliTVV2N05iemto?=
 =?utf-8?B?Z3NqZ2J5YytjcUg3YkNtOHpTNEhSWGN1WlNrYXBPU3VuVjNwbGpEMmRjb0Fp?=
 =?utf-8?B?TzJGM2w0Ty9yVWE1RmViU3AvUVRNdlFOSDVBY2R1NkV6WlE0OTZxZW8yYi83?=
 =?utf-8?B?RUNqMDdWWUFRTzNjRXFzZE1KcWFCVGhhOThjQXNiajgra2FBeUlnbFplbWV5?=
 =?utf-8?B?OGxsbEErUDFOTnNJME9ydXpjTkVVcGtsbldwOHY1blE3T1RMZUY0UUpHczRV?=
 =?utf-8?B?NWxSMXlVMEhkclRGVUZsOXpwUmNUUytJWWhwTHJGbHJlN3QyNm5DMVVpRmRk?=
 =?utf-8?B?QzZJZXA5RmRsT3B4eHM3Q1BRblF6OWozRURiT0FhclgyZUNNa3BpcGZNOUNN?=
 =?utf-8?B?M2t3bkVRQ0JNK1VoRlA4dEJEZk53OUF5Sm81OVlKamlLWnVCM1RMN1lNRDFt?=
 =?utf-8?B?WFN3akZSKzUrOTR3cVBtRllGd01qcXhBWmFPdGxzM0M3VUFPdmx0cGhYeE5S?=
 =?utf-8?B?cVlMUnRRNVByZ2tQOUxKOEVNeXRyWGZ5U2daQUt6bEpXdjNjdExWdE1KekQ0?=
 =?utf-8?B?TEw0VE43d0tvYUJUb3pPTTZITEEvZFR4M2NGSVBiWnB6QWVzR0VQMkt0WG5R?=
 =?utf-8?B?MnRHNXZneGgxWXV4L0FabERQd3dkL2RMaTFVL3RvZy9tK25MU0t0NHBDeFhp?=
 =?utf-8?B?Um5YT1BlMUUvZnpSWXRoNTBXWUpBbThtNTNFR2R2VnMxU2FSeGplNEp0TFhT?=
 =?utf-8?B?NGxOMTBDd3IzZVdpd2VrUWtiOERkaXdvaW1wWEJFVllVZmhGQTJNaTRvWXNu?=
 =?utf-8?B?empWdXdYZ0RGMmxIOGNtQ0t6alFZV1Y1em0reTNWMVI2MWxKYzJGQ0FUeE5w?=
 =?utf-8?B?d3d6WDRZVUhWZk50Y2MwdTJ5aW5WRmxud01PeFYvWHBseFZyMHlrUVRMcWJN?=
 =?utf-8?B?c0wrZThPYkJNZy95WFpOR2FWMW5BMkFyYldjSVhsSERzL3E0S3N4VGRXbUg3?=
 =?utf-8?B?UWI3MHZDRzhoMFVEYkVFeFFiU2ZnZjRBSEkrQjBnM2hvWlVVUjYxTTFZTjky?=
 =?utf-8?B?bHZYTVRYWExyRGNwN2c3ZU4xMVJ4Y2NMeTIxSjd2N0FDbENoZ0Z2TjZLVWcx?=
 =?utf-8?B?VEJua0VEbC82ZTBlaWZ0dGVPRzFBMW5EeWwydEhKaWF1SkpkNzlDVTVnN0ZM?=
 =?utf-8?B?eWtSRnFWMWxaejRZaFV2YTA1R3JERVhSWENZSmQ5elE3T3BBejBNMU41QVhJ?=
 =?utf-8?B?Q3kzRENXN1cvTlk2Qm1kNWthK25nQjlsL2ZnZVNuSlVFcUJKdlplSjJ3ck52?=
 =?utf-8?B?SDVmbis3Z216ZnRsSUNRWTY3WGV6Q04wd1E3eC9zT0E0VEo3Vm9XU0ZicXFH?=
 =?utf-8?B?MFplYUFsRStCZ204ek1uWXU0YWtzMmdJcVZIaDVRSVIwRTVySGFWS3N5QWFJ?=
 =?utf-8?B?S3E2cVRmMWpaS3NwSzN5dGpUdVkrTDY0WjlrMk4vMkVYcDljdVFjdFU5REV4?=
 =?utf-8?B?ai9Ia25Id1ZUaENKYWRrWnVJOXZYR1ZHYWl0TERZWkZqUmlVblJ0OEtpNlJE?=
 =?utf-8?B?ZjczNndpZHlEbTRuVW5LekpuYUVnS21HQW10OWk5MDZTeHlROFdndElPRkRp?=
 =?utf-8?B?cmxCL3UzalBORmNLYk05L09yYmEwR1dabVpQL1VGTHNhUS9IS2M4MENJTnpx?=
 =?utf-8?B?MjZNanduSmR2T1Roc0QxRFhneFNVdXV0N3RLUVQxczNLYkk4MG9nR0pxa3BH?=
 =?utf-8?B?VXRQS0Q1VzVnOHEvVFBBU2l3aTFKTEdaYzhuV1BoV3FycGVhWGE0THZoTEZV?=
 =?utf-8?B?a2V4ZnpIVlMrOUFWNTBIYUorbkNqNTVyYlZMSy9YS3Z0VlArcitPQlBwQno3?=
 =?utf-8?B?WndLVThRdUhabUtvcFNqRi9PT0h5SEZOczdBbmdjV045OUNRRitoWStOdVlG?=
 =?utf-8?B?OXlqQUQ3blkyK3R5aDhyb3FNMnV4ZXpHMk5wMFFiWHF3VjcrOGhYMlM2Q2pI?=
 =?utf-8?B?YzVXbzNlMVpBOUdJSWxhaU1jMncxZGV1WlNHdXgxWDRuamdtcHFNeGVKME9K?=
 =?utf-8?B?OG81UUVOSFZORkhpbXlNUWl4RVJ3Rkl5ZWdRZG9ubFZWSmJIVzFBZ1lsbFEx?=
 =?utf-8?B?YXVxc1FwTlM5VlNwUXdseVZEbkR6andKa2FXQUErU0t1RExQK2pIMTB4WXkw?=
 =?utf-8?B?dml6cHp3dE1teHNRSTBBS1k1RklWVzNzc2RHYnR1emVhUnpCWUFWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19d9335-6c65-4f08-4508-08dead2c40bc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:04:31.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxcUqNav+zLgv1Ja1K81SWxzVXaMBE1shoCeD3khfa10X2LIsmI06vJsN0KorCssKIJug/CxDKIZKP7SCkH4tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666



On 5/8/26 00:17, K Prateek Nayak wrote:
> Few rare race conditions were found when testing the Dynamic EPP feature
> on EPYC platforms:
> 
> o Toggling dynamic EPP is essentially a driver switch into the same mode
>    and can race with an admin-initiated driver switch which can cause the
>    system to hang.
> 
> o If a profile change / power supply status change races with the driver
>    unloading, it can overwrite the Floor Perf restored in the CPPC_REQ
>    register that was meant to be left untouched until the next driver
>    load.
> 
> o When dynamic mode is disabled, the default EPP hint is set based on
>    the power supply mode at the time of driver load which can cause the
>    battery to drain faster when starting off from AC supply and then
>    switching to battery.
> 
> When fixing and testing the above, a couple of incorrect error codes
> were noted which is also fixed in the series along with the unit test.
> 
> Series is based on mainline at v7.1-rc2 release tag. Thanks to Mario for
> initial review. Feedback is greatly appreciated.
> ---
> K Prateek Nayak (6):
>    cpufreq/amd-pstate: Grab "amd_pstate_driver_lock" when toggling
>      dynamic_epp
>    cpufreq/amd-pstate: Return -ENOMEM on failure to allocate profile_name
>    cpufreq/amd-pstate: Allow writes to dynamic_epp when state isn't
>      modified
>    cpufreq/amd-pstate: Reorder notifier unregistration and floor perf
>      reset
>    cpufreq/amd-pstate: Use "epp_default_dc" as default when dynamic_epp
>      is disabled
>    cpufreq/amd-pstate-ut: Drop policy reference before driver switch
> 
>   drivers/cpufreq/amd-pstate-ut.c | 36 ++++++++++++++++++++++++++-------
>   drivers/cpufreq/amd-pstate.c    | 23 ++++++++++++++++-----
>   2 files changed, 47 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32

Much appreciated.  I've staged these in amd-pstate-fixes and will send 
out the PR next week after more testing.

