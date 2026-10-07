Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B6374A0F;
	Wed,  7 Oct 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384973; cv=fail; b=isCobpFvgp7o+m0gfv9SZc8ZDOcbPOI4wc7yigBJbKz6A/tyNYOu9R+V9JLdYmDdPNuPeoNyfrQyZP04NlUL3A4T7fnA0CkBo7wRqzmpTnQVHG3RyEab7ZpU+U7V53dvnL83TO6rDUXP3NrCNqo3HDeHJKfx7uegeNqDWSP6BGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384973; c=relaxed/simple;
	bh=JgH5nGHDmybuQmZEtyR9Nf/tVOXkDSfDJaxga6rcdO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzlROnNyZTlkKaX/a1tsoJuqInvGsV+4i63tdUjBqaWyAthaNqQaooxtLAHoxqlag8xwXd/dL9PRf0YsWT/qfqXOJayFr2NpIjNymS0RepSPp9Re4pWwh4r+O+1VLsWxOGUF8IqBfETwL8qtGd46gfK03W0QgMicaPHthzpFmsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BUAntVRt; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BUAntVRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6uOMt59m5XfMKbtmThiBs6Yn+TGT78Jb1lDAR0h68QuomNjhCydZtHn0PnQjXXZRVsxQykW11URSVYzaX36890lszyZ4rLgdjNwcnpztI1qEFKMIMtk66uqrbMYUnVcj3s62EbAGq4TdFeAUBMkVDkMX+2zYcKXX1lyVObQcq3Av3XWssuNeQ+hMsjaFwDDoYt5LkFfH/2ant5qfcp3ERB9IgaxErYko31IU5KRIvZV7YbE4qPVVwbpP6VWblLjBm1cC+fDuP+xhhbMM8bxsKQTCFVfCtngBoHm74qe+0jgSKBzBoDTLAWjA+KUNQtb6/7eZh9U9dUG62CzTP2AqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn7ZLtaN8kQXD38f0uQRDVPPbe2/xumDlakVq/3ugmw=;
 b=ygPql5IvBmIbRSH3+GyPYG8rbFsaIAfZ39e+Nx/PJDCmXvMjTMZhrqbJHSchzrBHwGGgwMvZdrtTgffz5waSAveqmQ6D2WKppElyApQMJmNsJClfQmXPghJxOycMrA9wV0OOVXyO1HgYUCd0j87TImVIWOooTn+k4q6SPmCIxiDL9DLK7poHvrp28dMcqDeGEjws5aU+RoafDWhaF+do2uSLEq5u+2VC3J0MWiJvsZLw3noXTh+oK0F78nvRr6eZf3ReEXeisDkL+sKe5GnQHT7GZ7PyKateoL9WeHc/kqfHaLYGeSietCqEJnv+pGqbFdRTQl8tsc6jQhnbnX647g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn7ZLtaN8kQXD38f0uQRDVPPbe2/xumDlakVq/3ugmw=;
 b=BUAntVRtAKQDfIQlTdSuUhsmVpbOTXt2tlNrUgCptuSTB34YLBgniO7aeDv8o9Nk+eHBYMS3B5QSgDa5NLnZPuLZKvo4HOLpVyPxoCaCPGZ9DPIHul1oTg5hZTdvAyoeXQuuJxMN5Z0Ukw0Zxh2eWgRrWhvuB89oGcKmu7tBkTU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 14:56:04 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 14:56:04 +0000
Message-ID: <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
Date: Wed, 7 Oct 2026 09:56:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for
 TRX40-based motherboards
Content-Language: en-US
To: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 me@kylegospodneti.ch
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007144150.15113-1-ggherdovich@suse.cz>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261007144150.15113-1-ggherdovich@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0060.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::10) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d5c5cd-048b-4042-d044-08df24831c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	aOWbfZEWrV/opyY9tTLcMtbJqGoBRqLw/eczAjuQ/wxjYMVi6F4hqwjSXU79EnAjjYtMCPC8tbFBHwiYrW6qMaaxM8iThJBG6Cx7m+7uQQxD4PByEznaaRCcq/MSbzsLw1DDTXpSAGxj4yndmVsbiqPi1STPfj0k8+khvkRMDUQr2OKz++n07dn5AXfJOe/22jt3xncrCi4fPQ6Iia9qBhyM/VhNMkoYDNXvi3l6DhHmd3gGRJZn1t6CevMen9cGEmLJvp5r/MA+10H7Ezbjyga1Ax7+oKs+muM/5p05h/3rktiMFQjEy4Rrh1oQbIlmccvBAIKC03EnfCi2W3UFTh2+rS7uYB4vDFZjEOMUm6w+hxCnL65qss/hxqvcedyI/x+0htlyahFmTxavnLmTZDPjTupoigqSFA1w1gntdSNYxcyjM7PcgZeOI9K/8543zy9QliFot7VDnEplCXpu4K0pjxB/3iuhy007mvia12Iu5nxp6Se2lStss1mGZkEmWVMJp6/P6QHlehlQxJV0xziA9wE4pQaPEva/svDxRlD1VK1zphxtOXunRUBl8+LCYZCX/fPczejUCmd7TsITO3ZdmnAsi0gXR2/6+7bSplvRR7pirSrVC4FDLs6os/VD3d80w/N6qrk3SbdQ1TcWPfsByazf7SFU2rVCJRhOMeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2hHSjY3ZEFqS0JpU0JrZ3pqMGJjdlRUemxuQnZQdkVhWkFrTElZOFlBNjNu?=
 =?utf-8?B?a2xrRUNjenh6QkVuL3AxY1B6Y2VXanlLT0JhcXRMdFdoQ1AwajQxa1FEbnpG?=
 =?utf-8?B?WmlZUjRwRkhQWFVCV2hwSHZqNkNQbVNYQUY2eUdIT3A4RG14b092OS8zcHNC?=
 =?utf-8?B?VkdXRm9NRGcvQ1ArREg1Q1ppbnEwMUd2Wmo1WTgrbmRMd2VHZjVtMTNOSTNL?=
 =?utf-8?B?dkVxcFR0UjROWHFuOVBPT0d5ams3S2UrTnk3VmFjbWdZcEtmODlycnU0ZXZQ?=
 =?utf-8?B?d28yS1ZtbUxqMUMvUTlZUzdETmx0Qk4xTHJ3Ny9qYzhoN2crYk12c3hDS21O?=
 =?utf-8?B?cmNESkk2eGpTSzRsVlpjNG1wdGtyM3dlam5EaDhaUFgyZElGQXlab3B6c3pa?=
 =?utf-8?B?UXd2eU1hdkZNN2NzZmcxODh4UldoSVlHTDYzcFRHL0lVMlBuZm1xVkVKUmR1?=
 =?utf-8?B?TkNZU0NxbitCWWtmRWxMWjliWnVJMlZFa0loUTdIZnBEVWpyRUlxZzkrNngv?=
 =?utf-8?B?VWIyTWtIU2p4SzFyZE1XMXFLSlFieWFmMXpEcFRmQ1ExeFpzNFFJWnhjOXJB?=
 =?utf-8?B?Mk40SGFPanE0cTVGSVNBcDZQNVppV3BDVXk3MXdEK2Ztck13RTYyLzl6aG5n?=
 =?utf-8?B?bkhBVDNNcExkdCtzUzRObGMrby9sSkdLMkVHSzU2c0JJSnhTMXQ0QzNublQv?=
 =?utf-8?B?Q1ZvcWJ2VjF4YnpJdU9DRkdIWTk5eWQvd1FxOHVIUVlhbmptYUplSkdNREhJ?=
 =?utf-8?B?bVN0eTJTYS9uVmtBWWkrc29mUWtTS3lkRjNuZC9FV05TK2JLbTZPaTRoNTZQ?=
 =?utf-8?B?SmZSakxXZnBaLzZvL1ViQlBQWjVjZTBPTVB6MmE4eXMyQWRlTHFpNnRvZDhi?=
 =?utf-8?B?bGIzTGNqd3NiOFBGZ0tDc1lJbEhWWGl4eUE3SndNUjkvZkFyN25kT09hYUFs?=
 =?utf-8?B?Vy9GMUg0R0k0eklGcE15VFl3T1RuSTIwUERYZktZMXNLSzdTMm1tb0tuOTVR?=
 =?utf-8?B?SmgxdVVDRmY4UWMrcmdFWEhacFNJSkNxVng2YWlZdVNsUnYrY2xRQ25ZTFFj?=
 =?utf-8?B?SjNocUt3cWFyTkh3T09NQksvTlRJVDI3UXk0d1hiVXNxRGc4TTFNK0hGc0x5?=
 =?utf-8?B?MEZkbUlmSFFwWVI2VEJ6bngxTVZnMy9Bcmt1SjNSM2VRNGJvNnNDOUxXZFVx?=
 =?utf-8?B?d3RWbWRCNEhLbTJYRVNCaENWb3BFUXN1eVcyaE1mVTN3U3Q0eFhvdlpBQ09y?=
 =?utf-8?B?akd2RGRNRmZEMGpxNUpsZjJWazRPRHB0TTJoQ3hlZmU3L0lzVTdiak5SZmtI?=
 =?utf-8?B?Q29iSVgvMGNzTHdOYzVOb2NhWTJxeXBaWHR4RFg4SG1GVnVhdHlvVEpXbkE5?=
 =?utf-8?B?djNMaHJXbG9kTDc5V09uVlgxakppV2V6c0hKa1gzKzJ6Z1g1R0JOL2ZlL3Mv?=
 =?utf-8?B?S3ByRUFjYWdqSjRxRE5qN21BVzF4aVFOcTI3Z0lEeTIzayt6WUFDdGpHY3Jm?=
 =?utf-8?B?Vk5Xc0VBRnNXQUphd3lFNzJNTkhvd1BSREFHK0dKSWhaUFJJWGlXQVFjZHJ4?=
 =?utf-8?B?Y0x5K1JNOVRTUXhKbHRpWVp1d3JmbDVLbTN1eDNVaTByRmhCMVp4OEFVV3BS?=
 =?utf-8?B?MzZRd0taUFMyNnRrd1RkZUozS29CZXFzVXlranBTWUdlN1E1NzgxNWIvZlUv?=
 =?utf-8?B?aFU2dCtYWUZCTHBFajIwQlpUS3RpR2F6MVdQSHZESVFieXI0d3NiLzZ0UjZI?=
 =?utf-8?B?RmgyWXlsMWZ6dW14RkFDUFJXQnNqV2ZkNm1HL3MvTWp5bDdqa0FQc1l1L3V4?=
 =?utf-8?B?b21CRktyc3o4SUhhK2NQaXlmRloyRHdaNWlaMDBpd0I4OTdtdmhDalNiK0s5?=
 =?utf-8?B?ME1TU2VjTnViQkovMWdPK20zdldDSmVWQlc1TCtQbGtQMDFPeE9iTXA1OEVZ?=
 =?utf-8?B?ZVBudkRBRzl5ZE5wdEkwZVFIbm0rdms0RWgzQ0Z1SWlEdjFseGtJbGhVb0tW?=
 =?utf-8?B?NnhhU0dyZWlyT29Ta3dDSTJGbjlLMi8rR3hjQnNIcjB1WTd6ZGdwSWU3dGlG?=
 =?utf-8?B?R2gxQ0FydkVjcXJSTm9lcDNOY3JJZjU2SjU3OXdQekl4amNNUVBTZVBOTmJT?=
 =?utf-8?B?MEsxKzk1TjdubkMrZ2dkT05zSnJhNHNRRC8yNDcydkEwL3dMZzlpcG1lUDdX?=
 =?utf-8?B?bGc3Wk02bXB1S21xQ3VqdEtjMUtVTTJoUDY0SXpBNGJsaEs5WDlDSEF3RFZK?=
 =?utf-8?B?UWN2a09kL2JMaEd0NWw2VmFqSnlYMUZDRUVHR1F1SVQvcmZZcDRtdGphRE1O?=
 =?utf-8?B?TE14eUFNOFQ2SFJBekxhZUlZTWxKUklXREJ1S3RMYlg2UlhJNVpkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d5c5cd-048b-4042-d044-08df24831c11
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 14:56:04.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4k8OB6xSBYNtFMA1jarFgmLgiFV5xNQNYrP5R2/hwiZqlNQIvKt2utePkvXVmMjMVDghVAohqEJpkFrZ213xYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820

+ Kyle

Kyle,

By chance is this the same system that you were talking to me about offline?



On 10/7/26 09:41, Giovanni Gherdovich wrote:
> Some motherboard based on the TRX40 chipset has been reported to ship
> firmware lacking lowest and nominal frequency values in the
> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
> Firmware updates aren't available.

Can you please add more information about the vendor/model of the MB, etc?
> 
> amd-pstate requires explicit knowledge of nominal frequency, so it
> can't load on this hardware. The driver already has a mechanism (the
> so-called "quirks") to accommodate for missing nominal freq in ACPI
> tables, so here we use it to match against CPU family, model, core
> count, and BIOS version.

Yeah; it's intended for this specific case of really old hardware that 
the BIOS isn't going to fix it.

I don't understand why core count matters though.

> 
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
>   drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8bfd46d60843..532ff16dd076 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 = {
>   	.lowest_freq = 550,
>   };
>   
> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c = {
> +	.nominal_freq = 3800,
> +	.lowest_freq = 550,
> +};
> +
>   static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
>   {
>   	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>   	return 0;
>   }
>   
> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_id *dmi)
> +{
> +	/**
> +	 * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 socket / TRX40 chipset.
> +	 */
> +	if (boot_cpu_data.x86 == 0x17 &&
> +	    boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x3F &&
> +	    topology_num_cores_per_package() == 24) {

Does the number of cores actually matter?  Do you mean to say if you 
swap the CPU to another part CPPC works?

> +		quirks = dmi->driver_data;
> +		pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);

The BIOS bug specifically is lack of values, not invalid values, right? 
Just want to make sure I'm following this right.

> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>   	{
>   		.callback = dmi_matched_7k62_bios_bug,
> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>   		},
>   		.driver_data = &quirk_amd_7k62,
>   	},
> +	{
> +		.callback = dmi_matched_trx40_bios_bug,
> +		.ident = "AMD Ryzen Threadripper 3000",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends International"),
> +			DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
> +			DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
> +		},
> +		.driver_data = &quirk_amd_ryzen_threadripper_3000_24c,
> +	},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);

