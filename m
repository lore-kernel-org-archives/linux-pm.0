Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A43909A9;
	Tue, 21 Jul 2026 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658236; cv=fail; b=Uus2ucVwFjKkyoAb4gVT7ap21umtOPTk/UVsPENw0w5MWZNZHrCAoqVcR06XAZFGxZZunp2qg+6rGbZE7v40EWuhvKoDZiMbW81EAVTtDBYXerglJsxxIzK4wj8QRgK+bgW8eLXAyMqD9KmhFfk5L/D34jsshLT3oNl+Mi8Bins=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658236; c=relaxed/simple;
	bh=VjQelI86lKnX/6tnzZPeDGwEchXpkWsHowOQYw9KxpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmoZTrkvT8EtoEl5uspwfKhzz1cL7RKW6Lbt/+JQOJbeWeulOSKd7Hbf4WLLwaGZ6bVJBRO4vdLNcZ3V5vYDQ9MEOaND7H/EQe5nBL18gKGO913SOxmLzMiJyt40Crnx99tHk2XSzZdYvOaFYuIwu9PSHnrrrX9DSn5dhw08NkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rKraiLDH; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rKraiLDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkkNj1h8CqMJjdNQ+2PM5JZEX00C9JXuVQYsOpT9YK592ZGta7YoRxRvlv5cnr31MwjW5Cbc1MH+doruJPubuhi30xl/2WFDg6x6lc2R3beWN38ataRRn+xAf08knymrAJ34jzgf4auLffdlnG7+oKuxphTAKG0Te82aGsRuiloi//lmz/Vfw3dk0HT4H9psZ7nlCX9IQW+uSp2cZERhkOmf75xNDdunL0KiksmxcbWWnLVuQOd2pf1d/3N5YEE1ewNsRJj6QrVIhre+J4RMcvCAbiBf9lYZ0Kh0vooFzGaRGz2ilDvvYJQwttiHzF117me9XboZZ0vBR8Dduva4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o84N2pQ9HMNw/NotfjzrNDMSSy5ZLUjba8U5VgwoQn8=;
 b=QKiI3VFB3zWlOW7J0HmCeQJ2aJ14E+BL+t19pYg5IvzoymZwlLKWbeXnsFf0lAPAoeTbcCUltTQBhIo2PSFwQoHeErmZJDGDwme9OmVHMxFFtM1HITXNEEktEhVHfMtbs5YqoTXSy+vJIdHqE1nfQC+TJsp1C3xlBlr8ieEVMm9VMDpDJDp35BdnQ4IFNUaZqHt23bRS6/Nu2ktKZspDyEfgpYYfbel0F/mhgAXmEaFo5cQHIPDPFVJMj9ifxUtJOhBHKtnOhyr0jgRoNEz6kemG1Z/ewzVVdudn6Wd+DcetXWzFlg2Yesu9aqLSkvWgETkszsBEN5gkku680S7Ppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o84N2pQ9HMNw/NotfjzrNDMSSy5ZLUjba8U5VgwoQn8=;
 b=rKraiLDHM/9EtFt71ZJ05qlSkQmdgfqraw5CODd161gHDJRaQP77vFCSX4pGhCK1gsCZSRipbrlLqFqQG8NnArbj0RJsOW5XvwLcCpKuwQw8LZZoC/Ll4bBtlQY9rwBs2iv1VLy78RFOQr+dG7Ei/BR3FZREG/davdwSf8IA8+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 18:23:44 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 18:23:43 +0000
Message-ID: <8f815ed4-9349-47e5-92aa-4cf474d009b8@amd.com>
Date: Tue, 21 Jul 2026 13:23:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cpufreq/amd-pstate: Prevent the driver from loading on
 unsupported hardware
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>,
 Jason Andryuk <jason.andryuk@amd.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
 Michael Kelley <mhklkml@zohomail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Mario Limonciello (AMD)" <superm1@kernel.org>
References: <20260722-amd-pstate-vm-v4-1-d6607d9e9d9a@rong.moe>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260722-amd-pstate-vm-v4-1-d6607d9e9d9a@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:806:28::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c92eb7c-7069-47a3-358c-08dee755323e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ASeefXbZXk0fSod+sC/5aOxmdw8a64J9chpXx/sjMAcmCeBE//4GBC2fJJLPDFX7cz/EG4y/+pNZNqEQFyFKnp7sM5Ed9EbUWeR8qqGlLgHLK6GvuGecv4r0c87Nq0LLfo/CA0oPiC4eYE1kk56IIdIA/8gBZFGD0fLRXvNQaPwntMCg+0huLs1tTwJzRiWtny0Ca97vlDrUVLid1SkuOGZTFT5n1g723n6+Y+MRXq//fnxt+6TTalioOcca9v/RtTttqj7eGGt8919WyM48XgfkPDF+o+k4nze4H8gH7KlRNCpXChReXWWmoBxZXagqJChhPlJmTvvj8PxFc4p/iFrqQIsLmXPrvCO6LmcJIaUZP8efcVnRhuX5QdQ0XKl8GtlP0aEu0OCf1UgFbTg3r6ghDgnLxfKRzCfETOtY0IUMr4mOMOUeHdhGWvkCtMDmq5FZTlCX3Jz9rJsRYUAzoz2Ktav/e1BBihccO5gh35UtUgmubMsqtVGMdXRsfnwY50OKeSj/zqtXd/a4r6pmTFPtWBGtLZ9U10hFj0jtY59Vd4GiUzuxS6zPKUhxtw6cIX9iGNyGUurFJJA1cKdY5oOT6SKUGmHEbFlMGgSEUq9ZKVFQ31O4rPIW5R49aNmc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEF1Q1NkNi9qTXZQZ0R3QzJhYTdrUDNYT0lhRDJ6ZjJNSmo5amt2VzgyTXlG?=
 =?utf-8?B?aFFCdVFRRlZUN3RNaHJyOXcrc3doUlVFZTJXNGlIMWNGamo3ZVZyQm9zTFB2?=
 =?utf-8?B?Z3ZvQVgvS05OTi9rb1Q2NXhCWXZ3eFZiR29sa3dGekNiZXNGRWdNaUFSeHdN?=
 =?utf-8?B?UzNpV05xeXJTMHYxQ3VZbDNDZExoQlQ2UDRvR2Rld1d2STF2dC92OE9qMVFO?=
 =?utf-8?B?RkJ3M0lVZUxuT1h3TzBXZTlDaWZBcSthSE16WmFHRWZkcFMxcWwyYUJ1R1RK?=
 =?utf-8?B?bCsyTXBLQjR3eEhHVmNibDBTdWw1SUZuTWNsekF2ZUJudkZScHpHTno1T0N2?=
 =?utf-8?B?QVlVend2bVhHWTl0SHFYZmxabmZ4UFRWM1pIYWdCQ2xzemVPWmtRUUl4Z0NG?=
 =?utf-8?B?UTQyRXdQME55ZHdhcUJ1SkhiajNzVkNKS285S29KMjFtSTRxbXpEc1g3QWV1?=
 =?utf-8?B?OXJnSkl1ZlpZdGlqMEgzdDBhR2lHOCt3cDF3ZFBsQW16ckRqZFYvMk9vM3Z1?=
 =?utf-8?B?NnFCQldodVF0OVhuT1N0WnZvT284Ry9ZZmFLdUlXcVJGa0tHV28yM3dHdHVM?=
 =?utf-8?B?eFFtdUdndGoxdWs2QlMyVnNPSDJlajRHb2Y3ZHMzWEhSVUN2NzRNT2xpZFZ4?=
 =?utf-8?B?Uk5nbFNvWjcyZy9XbmZnY3RoM1BleWExOG5uLy9ZRG52RnFCaFpWNmJ1VXg1?=
 =?utf-8?B?dzVXbGVmVFYwZ09GVDBFcTU1TnFEYVN6eUdEd2NPeGtiNi9URmYrL3JpeE12?=
 =?utf-8?B?SGtFQXlPZWgyNXZacnZQTlJQNGNTK3BjRDlOQm9Lc25NdTNkME9qd2hJVnRJ?=
 =?utf-8?B?UzN6TGJub1YzR0NrRGdGQm5YbjNqWHRMcnhTWXR6K1RSQVcxTlcvc0xtOUpR?=
 =?utf-8?B?Z3VOVEgrbkgvUUY5RTNxeno0Q2YyVnNmem8vdnJIKzl0Ui84S3JPT2NlcmxJ?=
 =?utf-8?B?RVBQdzlGMm1nVVNQTDcxaWlpNjZ6SUx0WFJzY1dMVmZiSHVtV3h6aENLbGhv?=
 =?utf-8?B?bWVHMUlqYnFhbGhQeHduYXNocmFJdVIyS3NxT3g5QnVGY0tTaGZ6MjJZR0ZU?=
 =?utf-8?B?Zk85bUNIUXhkRzduQllLU0pXZXpmQ1d5Y25sY0YxeUlXdVpHcm52c3BzSkNx?=
 =?utf-8?B?SnJmL3BVTm9mVERUdlpxQVBtcGdEQTlnWVAraGRrZVZ5WlB3c0hZVEJ2aklO?=
 =?utf-8?B?aTVuQ3JzbkNFQ2VxYnpQcTc5ZVlSL2RoSjVuLzBZTGg2VGZOWDhvZXRZMUtE?=
 =?utf-8?B?QW9SRXJyTFh2aUtLdXF0K3pjTmtaUlpGWDhQNWFpSHFOWG4xLzhTdFg2ZkZo?=
 =?utf-8?B?ZXByd2JFVmZSRFlqeFkwaGJ5MzVhYnVna3J2a1dtRzF5b2YzT0lyeURxRWcw?=
 =?utf-8?B?ZjlHR1E1dTIrZVN6YmtJd2luUk5KQUtaay9USjBlMjFUN2R4eThROU9XbGlt?=
 =?utf-8?B?Z0lkUVY3YWxxQzJwVVRTTStGMU1tZlZqK0NQOVdONERSeTJNWTZLV0N3R2hE?=
 =?utf-8?B?UWtCUEY2OVhHbmViL1RKQzB5ZFFHQjB1L29zZ2phM0RLelV4aE9vb3Y4enpW?=
 =?utf-8?B?VjhOcjdveVRYQWdxcVhuOXRmTk9leU1LZlNSaWdBTlFSd29oV2pCSWdPRTBn?=
 =?utf-8?B?S1hXSjlNZ1lrVWdiK2FmN0IvYWl6eTVFVjhGZUUzS3NLckVOaGdmN2s4amZ4?=
 =?utf-8?B?azgwRm4zaHpZK3J3U0NNNmpOdysrOXEyVVc1YkFJcGVVYzNDeHQwbmRySVJw?=
 =?utf-8?B?QlUrWEF6allwSFozNGl2NFFyelBkUUxCeFc5enZBaUxJOTZvYzVqZ1FGZGdu?=
 =?utf-8?B?TkFPc0oxRkZyVXYycm5BUUpxa1JUWFB3Q1ZRc2hxSEp1TG91Z0QvaXJyczBr?=
 =?utf-8?B?R2JYb0VGSjc4ZUlFK1VrVW5aK2RXUDVXeUFMWU9SYWxpSW8yTFArV1BDS09K?=
 =?utf-8?B?dDlabFE2MGF2NS8reFZyWEllc0J3S1B5ZE1jVVZQcjFiN3h5VEI3eWhrZ3M0?=
 =?utf-8?B?eHozcVY4TXhWejUrREdaZDhSWVJKa1hYY1lCeFBsQ2hRUE9BdC9kTTMzZGxQ?=
 =?utf-8?B?WGRyemhQL2UxUXcxUVp3TTNkdEU0T2NucUhSdnIxT0FBYWptdUYzc09vU1BQ?=
 =?utf-8?B?RkcyY2ZsdUl1T0JZVVNrMGkyZkZQb0ZvcWh2VjF4SGROWnB6VHI4TnRHUCtK?=
 =?utf-8?B?YTNOZDIxWnQ3YVkwQitjSDlBeXRNbml3TEdYMHorNG5lL3MraVc5Y25FZm1V?=
 =?utf-8?B?VkRTTjZGN2xPL2JSTkNTZ1RaWHluVGV6T3hYa0xtNi9tay9ZTkp0VUhrVkNl?=
 =?utf-8?B?Y2dBKzVNOHdQdXZVMzBSVnQ3NjhtSW01S3VCUVRoU3YwNXNWMUNydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c92eb7c-7069-47a3-358c-08dee755323e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:23:43.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td8sjkwv4+a8RvgZ4Byoz7T6XOSjMl9iv1gQHUicBs9ZtkhPOzSB7CNxJk1fU9KHroeg9wUR4KMm279z5qEanw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388



On 7/21/26 13:13, Rong Zhang wrote:
> X86_FEATURE_HW_PSTATE indicates if the processor supports frequency
> scaling or not. Without it, the driver is unusable and thus will not
> load. This check also prevents the driver from loading in guests and
> thus not confuse users with misleading prints.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
Thanks, will include it in a PR this week.

> Changes in v4:
> - Clean up the commit message (thanks Borislav Petkov)
> - Drop the Fixes: tag (ditto)
> - Link to v3: https://patch.msgid.link/20260721-amd-pstate-vm-v3-1-8b59574fb714@rong.moe
> 
> Changes in v3:
> - Move the check into amd_cppc_supported() and add a pr_debug_once()
>    message (thanks K Prateek Nayak and Mario Limonciello)
>    - The check is added before the existing family 17h model 0h-2Fh one,
>      as print_cpu_info() already shows family, model, and stepping, and
>      will help debugging even if the new check overrides the existing
>      one, but not vice versa
> - Link to v2: https://patch.msgid.link/20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe
> 
> Changes in v2:
> - Check for X86_FEATURE_HW_PSTATE instead of X86_FEATURE_HYPERVISOR
>    (thanks K Prateek Nayak)
> - Remove the check against Xen dom0, as it doesn't need the amd-pstate
>    driver (thanks Jason Andryuk)
> - Reword comments and the commit message
> - Remove Gautham R. Shenoy from the To list due to email bounces
> - Link to v1: https://patch.msgid.link/20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe
> ---
>   drivers/cpufreq/amd-pstate.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a74a4cf99d22..b0b651380732 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -2167,6 +2167,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>   };
>   
>   /*
> + * Processors without frequency scaling support can't do CPPC.
>    * CPPC function is not supported for family ID 17H with model_ID ranging from 0x10 to 0x2F.
>    * show the debug message that helps to check if the CPU has CPPC support for loading issue.
>    */
> @@ -2175,6 +2176,11 @@ static bool amd_cppc_supported(void)
>   	struct cpuinfo_x86 *c = &cpu_data(0);
>   	bool warn = false;
>   
> +	if (!cpu_feature_enabled(X86_FEATURE_HW_PSTATE)) {
> +		pr_debug_once("frequency scaling is not supported by the processor\n");
> +		return false;
> +	}
> +
>   	if ((boot_cpu_data.x86 == 0x17) && (boot_cpu_data.x86_model < 0x30)) {
>   		pr_debug_once("CPPC feature is not supported by the processor\n");
>   		return false;
> 
> ---
> base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
> change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3
> 
> Thanks,
> Rong
> 

