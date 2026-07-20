Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384424252A6;
	Mon, 20 Jul 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561858; cv=fail; b=Mh0O/NMO6FFE+qSB2ppABADXZvxnOT9S80Wm+p/sM8Av8N/P6qjSnCXrA//76vvaEVbZ9uaMQpQ50dGC91wqDMdAOSfnTAyFUiYJc/Td2blOERH7jr0BUdzFcEYffERjfIobFJKCYBov1gNlrlHZAPHa/si9WfhwcmDXQgfD2hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561858; c=relaxed/simple;
	bh=PzFqsqRQm9yy/MTzNF/Mik0HH/Daqo3MU9M3QE6wkZ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QQ4wJJPkJJCSKBsVSch/8vh9CP1v5PVVQIxAuJfHo4USw+6226P2zozHDoyYpVtMiTDucM5T96jJV6gHAgADVgepIIYupyTKy8k5xPm+MrR5w3k0jx1PNF6dBIPLjOMumjQyJ+gXywo3nSdfe7/O2u8FxY0B5nrte2NFjYKZCkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lCpDyQQx; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lCpDyQQx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGGsBkBdl8H8vpV7x7cOomZmDL6OWjLGlgw6wEqAwYxjwR1tyQbTi/4aJHISO5O9NHLqzLX/QOfhdmvmEL4x41MOxmx4AY7lILIoiqUzb1zo+ousZN6VuTDsgSLIlAK7Sdo0HvDBw2uP82Brbk7cWsrBcerYw0HtWZC5rKalLnn1pSNBvtd7q0cSklGT4QAMtsq4T+KvP14EH7dLbhif6Y0t+g95KMMjDBn4ZCR1CooyYmYg8anhStE9uPBhiVBv/s5udKS4+vMEw+/lLaLvyCmhG19HkfRz2IPRxtwoJQPxfzyJHDw9aC9bPwhaWED86elj1ox5X5+khSU9Ie9gcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7tT7SbPkLOmYq0R2S1pfPaHnJPcJY8BlS/3oer4Lhg=;
 b=xEm24Jt6vW2wA1bMVTF6dz0WmzVmYWmPiEwcf6ghIppb6DE47Ole9Ae3JcF3wQuRVhlhPodN2aNb0D2xkJN3wpAS5348hkyrXF9X6YVskyFEMZPWP5ykMg68JwkKlXhDIfAsKlAIq69nfAN2JaHCo930uJ9czlfrr2WZ9nd0qQAiIraCSpxII8Ervl8pylOhObR0UYiYS1u2nA1av8INYJtsTGgjweNNCC0bTADj8b9kFgStcoSlEpg6LqEo55syCz9lWk/nBP7Q8C51dgxQxwHCE3ehDsF6x3WzaGzlCPNgtU4qjgJ0iWQUzG8sCXAHg5/e3CW9TdiXY3gitmNbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7tT7SbPkLOmYq0R2S1pfPaHnJPcJY8BlS/3oer4Lhg=;
 b=lCpDyQQxny79xXajlCdIrrobqBh+0zmQlVNE6nQPAcMEYTH6ATpAxZcWgnyYhN4oYZ2prnMbBj7wEXijajDUr8PoPQj+LlEPPjLgwsar66QsfZMfQCjmfOyUAS+vqBfo52VtmQ69WFC0LzYHhv/D251fzBmXItue65B61dEMKIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:37:33 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:37:33 +0000
Message-ID: <976a9fbc-7313-4c14-91c4-56618876f1f5@amd.com>
Date: Mon, 20 Jul 2026 10:37:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Bail out early if
 !X86_FEATURE_HW_PSTATE
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Rong Zhang <i@rong.moe>,
 Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>,
 Jason Andryuk <jason.andryuk@amd.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260718-amd-pstate-vm-v2-1-6ed5f3b2c89e@rong.moe>
 <09c77f74-bde1-42e1-acaf-77afd32c7379@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <09c77f74-bde1-42e1-acaf-77afd32c7379@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:408:eb::30) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 25363302-6674-4d4f-5d6f-08dee674d0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	yocisCrDiaDIpuI6avKL+WzXRJ1Tb6f3tlU9Cty/O2IFbKo3hElVTIY21dM2QihJlD+dbgf68kuSDKl7oNuMpem/WMTGvXO4gn5B0bWEoRXaVPBwH92VJavUJLkpuvpjWQlUL6Iv/Vlvzd+YpSgXw4xZNX803Lzdd5AJpuoNbG+Cf/LP7LvEOEvdTNzpGItPzs606gl79vJjNcBjP7gRqu7RMfqZa8z97Sq/VnFt6LlHSEEFEug/IWEyIG2uft4MERgNMphgpTMcejBHzFTjFwWDCPvWBjNWaDE+VYRd1U1ryLZwAaRX6NSIW274nyufe1poF6IHwGO8kvE7TSD1GiKnkLAG3hcoD61XG7I3Kfc6TRvGBzRYXJUMhg9rCdlJW1KXWhG5ThtStT0s4N/JISwdlMLUnBTvW5jnO8kQj96tOAtWQzLvG8mPd6+fYijdgcKF1IcGojul+cGvRe+GJbcolPJZNHxwGQXj4C1q1xtj5UaxzqVb88IhApI2yOOJGMU7DeXM5ZEqTMU7pl+ImIrnnvF/YlJH4zxtHrFIbLb9K+WXgIqlGy4em3UQ0pHMf/bGN7d+3s8GwDJa/pNDhzu5//5tOpgSZJY8/2+t6r459t5wG5FyYk68/6Kj2HycruHUyS4Sbpe0w1CZeI89v8QuxXxa5eI/6nbYCy4mxF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmtqN2xyMnVxV3RTb2FjVVFTeklnQmNkZXN1UkdJbHJQYkt0bVExY2t3RlhX?=
 =?utf-8?B?L29OMGVyL2hTdmJmVTlTS25CYVozL2V6clhDTVJRQno1Zm5hcDlEQTFGY1hy?=
 =?utf-8?B?MGE5Nm52U1VodEFTTGtOemhpQzNEZXF2SldGSXlYTU1EeHY4RDQzMEx3YlV6?=
 =?utf-8?B?Sko2L1Y0anFwK2NvRUNJc3diOTU2bzBjdE90cUVGeTk0OEhRSG8yU3NmSzFq?=
 =?utf-8?B?cE53YnhnZkUxcXA0alZpNlgxV1UxMlBnZXIxaWU4eUdTS2E2SUxOaWE0QVZB?=
 =?utf-8?B?ZE1HVXh0T0kyUnB6OFliMERvN1pWVlZvK3BXckR1c3kwNXNycFFNZ1lIdXZz?=
 =?utf-8?B?eVR2blptU2NmQkgvQ0FWQWU5WDZOS2ZVTGxmMDBhSGtLSTdMZWpBdE45eWNS?=
 =?utf-8?B?MEdZWXQyOXlXK3FSYWxoek1Ma3JIZFlPbzZubXBRbFFuRys2dm84NzhzaVlS?=
 =?utf-8?B?V1pOSGJaVDRMelVJVW5Ya2tueHZrNUlaSk10VzdjRjZud2lNUWdadGdCc0Nt?=
 =?utf-8?B?YXhaWEIvNVNQSTFjd3pnbEQxL24wTjg5YkN0RFRsRVB3R21FSE5ER2hRdnNR?=
 =?utf-8?B?RDh1eEc3Zk1RTEJVc3VMdm9ldk50T1RnNEZTdW1vZlRZMkZlSVlyeC9oSXpm?=
 =?utf-8?B?R1Q0cDhMUTdpYnF0eTh6VVBmcDczcHZacTRnZ2J0WkQ2QnlFeVRlV2kxMHc3?=
 =?utf-8?B?NytEcXNaYTF0OThnMHc2ZWdES1dpODZhSGpZREdRSnZJdWJ1UmFjdTFqQTRi?=
 =?utf-8?B?Z2ltWkl6OW5CRnZFNTlTNURpcWFkR1JHWk5iYTB3bFg0TXp4cForSGo1MjJp?=
 =?utf-8?B?ekZacXZIRWdoRXhMRStndzVqdnVZcDhWMmpqeWMyamI1cG0xdjhKR2Q3Yk5t?=
 =?utf-8?B?d1ZGMEVPMDJTdHRuTTY4UytjTXR0K29OakIzR3ZRYU5LR0hvKzVqako2ODFZ?=
 =?utf-8?B?MFVtZXRNQ3QrSGpYRXZjOXNLWUNxRWJxQ2NUM1BselBMcjRYWkVJSXZISlJP?=
 =?utf-8?B?MnliTHBzUWdQQ3JpdHNMVmo0a1dUSFVxWEFVbnhmVDNYeVYxMG8xeW95enkw?=
 =?utf-8?B?bXU1MEJqaWhicnRYOVZUZy9jK1I2ZGpXM1dnK2ZoMFBGS0kwdGgrRlo0V2Zx?=
 =?utf-8?B?N0RlREFjWWp5NlJ0UU9Kb1NqNjJrWW1xOUJXMUVISk5zOWhWUGRUWlY5UlBI?=
 =?utf-8?B?WnRPZ1pqNTRnY0pTNUVYa2t5NGdTT1Y4Z3RiOUl4Tm4rMVNrcDVZVEhxc0hp?=
 =?utf-8?B?SHBnNkpZUjNwRVRucEJqT0VldWc2a2E2dWtPeXd1Zkk5RXc0Mk1RZUtZcDc2?=
 =?utf-8?B?QWovZFRtSW1EQXVBamJYWFluYWRQclBoSHV4SldOMjVTelFJNXpuRTdheE9B?=
 =?utf-8?B?WDBJd1A3WTJBREdGWlNxakYwWldlYTdRUzhlNFQzRHhwcndNY3RwbGY4NXo3?=
 =?utf-8?B?N2lhcEtGL01EaGNsOWtzYTZFQ2tVZ24xNEVpdG94K3JvNk5XT1pnTERRZ2h5?=
 =?utf-8?B?NzBtM1dIa1VyNkh6ZnRmeE9hV05hd0s5ZXRwc1FQbGppNHF0WGpNMTJGekhj?=
 =?utf-8?B?WVNEN2xjMWxNYUt0YnhuSitkYWFEa3ZnVmNzQ053d3Z4Q1czbUVaSkpBN1Fk?=
 =?utf-8?B?WE4wSlhXdGtMSjlLQ1o5cjhTcWF5UTJHQ0hjYjd2emRpdUdPbGt4ejZGMXVR?=
 =?utf-8?B?b0JEaUVpZ0FaUUhqODBBUTRPd2x0eExsTU5Ua1RyWWFsZHFsOVNiSFFHZEdz?=
 =?utf-8?B?MmhnOVYwRGpnaGMrdlNqWnJJL0EwK3hNU3AxMTUwRWt5YWtxcW9YR3RNOVpk?=
 =?utf-8?B?NEhwSkoyRUZFR0JtR2dxaFpkbXJ3SHFyWUFReWZML1VaVUNBbjlFVUE3S1k1?=
 =?utf-8?B?Q0VJN3JFYlpZTVdYUGVuaE5wWHN6T0V3eE85SHhoeGNiUThXNDdyZ0NPcmxX?=
 =?utf-8?B?TmgybGQ1ek1ZZ2RiVHVZUWxVNlFUSERzNkVJRkVhbldINnNwRTFRSHBTdksz?=
 =?utf-8?B?OWRxVU5YNThucHpDUmZLUTFhM3BYZ01HTHg5b00xZmszZEVoQXdNSG9BT3lm?=
 =?utf-8?B?RXBuSGcrWWdta2tsalphTzlOYVdRWi95amdhVUFjdzJaMzlySjZlTVBmdnJX?=
 =?utf-8?B?L1RTaml2ZEdvSmVHNXppMmFWckFTZlZRRVpibHl1WGZ0dUlKNWZNd0hsekd4?=
 =?utf-8?B?V0tiUkY0SmY5V1ZmeDJwSlFyQVkzbGdoM1l4Z1YxSnlTK0xRWkhUNVBQc3dr?=
 =?utf-8?B?cGk5SGdaNjR2OUJwVTRCdWx6WGFtcDRWZkJwWWp0NjIzcEdZVlFPMno4WmNP?=
 =?utf-8?Q?wc+CUqKSXcJEPol5wt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25363302-6674-4d4f-5d6f-08dee674d0f0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:37:33.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YmRgf88cmygBr74uce9ot8FlYC/h0c7hkYQ7no4o/peC/MyxH1qXSpRtcv0WCUXLFdd8pB6BmDGSH3WywLQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240



On 7/20/26 00:14, K Prateek Nayak wrote:
> Hello Rong,
> 
> On 7/18/2026 8:45 PM, Rong Zhang wrote:
>> When booting a VM that simulates or passes-through a relatively new CPU
>> model, these warning messages are printed to kmsg:
>>
>>      amd_pstate: The CPPC feature is supported but currently disabled by the BIOS.
>>      Please enable it if your BIOS has the CPPC option.
> 
> This is message is printed from amd_cppc_supported() ...
> 
>>      amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
>>
> 
> [..snip..]
> 
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index a74a4cf99d22..877b4b30ecd0 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -2228,6 +2228,13 @@ static int __init amd_pstate_init(void)
>>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>>   		return -ENODEV;
>>   
>> +	/*
>> +	 * Do not continue on the following checks and emit bogus warning
>> +	 * messages if the platform doesn't support frequency scaling at all.
>> +	 */
>> +	if (!cpu_feature_enabled(X86_FEATURE_HW_PSTATE))
>> +		return -ENODEV;
> 
> ... so why add this check in amd_pstate_init()?
> 
> I personally prefer having the check in amd_cppc_supported() and
> returning false from there with a pr_debug_once() saying processor does
> not support frequency scaling.
> 

FWIW I agree with Prateek here.

>> +
>>   	/* show debug message only if CPPC is not supported */
>>   	if (!amd_cppc_supported())
>>   		return -EOPNOTSUPP;
>>
>> ---
>> base-commit: 94515f3a7d4256a5062176b7d6ed0471938cd51a
>> change-id: 1cc24037-amd-pstate-vm-d6ab4c959bd3
>>
>> Thanks,
>> Rong
>>
> 

