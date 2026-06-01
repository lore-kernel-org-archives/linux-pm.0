Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4B3E171F;
	Mon,  1 Jun 2026 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336919; cv=fail; b=t71ZHse5arsmhK+LISeBo5LrLmC2XX4xhxfGHiuhReHulyJnoGPTkJqdPyqcFgAe2WNouTxCaNRDbVlOiLH9AGSK39avRg4pBixmH76KhM925dWvwNab0+682X4oanKh7oUTZl2YY4/frA1kkRU12ezkhRYrYky7J/X7BIGl8oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336919; c=relaxed/simple;
	bh=ZBmJcot8QlUBOtpC16BzBKcQz5vxyDEYWCXdcVZe3X8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJgSGWtiQ3WmXAZGq7vf9iSWa/gjGn9NFYP08yZsv8M0pxj4br/CHxoYoSHAYqak4a9Flzq9EoEqVVksIus36isdfUb00snVwWg52WhGzM1AawFgrJw6tM4qu/YIfV69Ld/k1W2ANDsJdpBEX7LjnqseVSWJSdLrPqKEZmf/2ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=javT9oRt; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="javT9oRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdYE9r2yipEAC7mJRH/U0KtRA+iZoFdNI6P2DeVZu24/X2TJkN6Z9fg6iJnglVatuOQpS7Rk1eB9xlQ2QQaLHbFg+YYg71rCHEyrcgPAZEO8KzoNNwLZxBiA0hYN6gzTcOzahnWYuB0cBP1rGGwlhTH6S1D1jwgi4AZKmaCwMc9VPziruXKA5Oy42UB1xGMeqLTurAfGNpuJWVx7QIQwwKbo34/FBeklmZ4OUULig0IudKgZW54CIFFx47vWpeugOPW13rCh3znr83wxVya0niK2Xp3qMU9R2r3ajy6qiVXQcBB6XYlLHTY0kXd117f9uhEzpaMU3TSIfhHDTYamNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRIG5P6TAq1ey018jcojjqdtd/KLMSXrbwUP1413j+M=;
 b=nYtvh1boHpgUkV/NYZKALTt+B9U6HZE4txGG+GLDDuYdTxZuaK1EUGE95SsSUrYikeyBCFkZE0ZALs40kK+Pt3BlRij65RY24VFjYap4tSFs/+ORQ9zTMFDeD2XH2bw5blRRh54cDlnfCYWIWPKKc/ggHLCm8U7g5GG3Ccu9qpMG4S11eAsgf2Py0vdsPVKVg3+x/WAIRd+Pmk7gjAE7RQlFtIEzfTaGPcIrHO+Ukttm1QCL+2OWK35ejQLN9L3J+07MWJeA7jC7BlUbEVC+e85gLXYXx5YKgLSpLaYdoeC9JvRGWE3J87dgMP/CpDypdXmgTWrtm86oKb1KMediqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRIG5P6TAq1ey018jcojjqdtd/KLMSXrbwUP1413j+M=;
 b=javT9oRtF9NFU9+YQVQylRgHw46356XAOm9CoJ9g8jwqvlgjgkLR3n/nZ3/2+AvFaguB+rddcdIn0evVd9hDvCkkw+k6zWrj4/j19h7o3MohilVQ4qI03RL3M3mka1+uuYvioBRkDxwFJ9sHpiuM7eS7Id9g8calUs4rgAA4Jd6gcmdzkKX3Z9TdwtTzty/699WrYTxe76LI4MmKy6RMBM8TzuCyq77F/gyGwd8KWFkqQvG6J6RAX7IKa2gb5DgaOrBCnwDHllPztbbk2fa4CJ2vAf3tvSrahBUpPalgcve9eXjwjpAplqOVG134oTZjPp836MLS1DeD2k9aB/nqgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 1 Jun 2026
 18:01:48 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 18:01:48 +0000
Message-ID: <88932964-4148-4846-a872-8dbeb845c967@nvidia.com>
Date: Mon, 1 Jun 2026 23:31:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] ACPI: CPPC: Add support for CPPC v4
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com,
 Mario Limonciello <superm1@kernel.org>
References: <20260527194626.185286-1-sumitg@nvidia.com>
 <20260527194626.185286-2-sumitg@nvidia.com>
 <CAJZ5v0jFpTeX0Vxt+Ut5nkmgueJFxHjoP-mdjdDd6jkCokn-VA@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jFpTeX0Vxt+Ut5nkmgueJFxHjoP-mdjdDd6jkCokn-VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::13) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9a2a86-bbf3-4f60-e09b-08dec007d989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|11063799006|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Lj4jmUgut4wiWF0qaj/VMAFFLKMvk6rEoRLsubQZMQy3VuN8zK2rJZdjOwV4jiTeHHHLsJUXrkXf42Sk5sNx6HpKcgyj3HjYyQrJ1dO9R12in/fXhyiO95hvnmnAMujFLoN4NauNw5AOqa0z/T7Gez/cbba051FGTt3N4h5+RgtR49E6RMUvmPnGMWM95FJxytXVFDm13Q9v6DqxXmtSnoyJFSvY7HC4dgruGzUWQUomjzEAVZUESFtEbjqiS5OvPovRcsZRqsiMpujQZJRLBcZmlhN3KAE3jTIe7Mc+VN93PuWtmuTu34fPEKF7R3wgPBZPyY8K2mW7rqu2XTrUE+bT5fxaxWHDjC4WakVnGkaaTAm0MvzuCMXmz/17LCM4eCMeSBtjVtCM9/SoRdohV3y9ml/uRtBU5MFVNPqojMMX86Gahi/ZWohxwd6QRfU7D2sMYXKM4qrQNbRibA+EcBKtUmzE2O+ZEKX6ARMQdmMTXA0PvNkA+XvUVF0piBAw7oO0hcLIToPi/rHB4HftKhqOY0J9XVXQkYh/6+jT1AMZ7KCJm4Oequqkav1nM3cTldaYDzZRbGw56W8k/GIXzeANpdKOPQQZVIBIzbaLMj7SBF9AugShNEhl2cxNsoG0icTV0ysxwdSKhN1K6YB8eZDYlC8n2FZ7ObZirhp2HQftl0VqB7erGubb3JqsrWAb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(11063799006)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEhKek1ueE9uMGltVWo3K3ZKd3RRb3gwMDNwQzN2QklWVThOSCtNL2QwOURp?=
 =?utf-8?B?MzRSUkxzUXRLVWFSZ1BiQVg0cEVwbnBydThpS3dFRHA3czB5T2lOUkpVd01u?=
 =?utf-8?B?WVB3anZQMjRzN1hrSzdWbW5wTVNCTHV0UHNnWG42NUxoTjBTRktwbkpOL1Vr?=
 =?utf-8?B?ZDdtVGNBMGt1N1dyNFRBRk5aSGVNM1UraUZka013K1BqdFQzNGV3c3VQdHJD?=
 =?utf-8?B?dkRXOU1hZytUTVJodFlGZG9KSnorbTYyRk5ObUcwVkJtdGNSdDVEV2VJdmRF?=
 =?utf-8?B?RUx2MTg4ZWlWNnYxdnRrTEJuaU9RL0w3ZmxvM1lYUUZ0Wk43NHc0Z0d3dTBp?=
 =?utf-8?B?UWNKSkRwdFdublFhRmgraDMwNGJ2TkcrRU9xZ09rejZvY24xNkQzc0Y5WkRm?=
 =?utf-8?B?SExRM1Faa050WjI4amRXWTRsV1hVMWI0dm0xWnhtWHF2bE9GbU1ER1FpanlQ?=
 =?utf-8?B?bjBvTWd3eEQ4b2kxZmhKQ1d6aGp4aHVWVUoySm9Hd215M0hCRWdMMEN1eEF4?=
 =?utf-8?B?U2R0bENVWTIxNG9RSmk1SWp1NHptSitKNUpFWTdEc1hrY3dwcTRUTFdGdnMv?=
 =?utf-8?B?ZDNzWjR3aFJISEM2ZTdxS3hCUWFmdjlxN3VFRm9aak0ybDBFaG5DQmVkblVO?=
 =?utf-8?B?T3VLMnFJY0Y3c1J2MTZ2WGR6dGhuSGRQMk1vdzR2b0NObjJXejNheG9iSy9Y?=
 =?utf-8?B?d0hTYzhCcG9qbTErWHdUZVpzTmpWNnRmSlRQcFFudjFsY1RMMDkwVFYxWmpY?=
 =?utf-8?B?S3R0SE9tcGppQWhsQlY2YXM5OUxDMWpYUVJHb1VaVVFPdXFod2h1RmNXamUz?=
 =?utf-8?B?aFdWNWxoUWpmMWRzdVNwaTF2S2g0L0VncGRhdUpmeVZwT2RWdERSNk9jV3JH?=
 =?utf-8?B?MG9TSGJVWmozU1d5MGZJT3JraGFOOGpoOFo1enlhVDF5RTIvbXZWWHdESndO?=
 =?utf-8?B?K0dNeWVMYmFxdGtaS2xidjFVYVJvOXpHTSsvZkwvMVJmaGR6Z2RJQzI5d2Iz?=
 =?utf-8?B?MW11RXl6U1UvbjlIL04vZ2hGTit6c1l5U2VVZE1BemowcGpKWGg4emR4NEJa?=
 =?utf-8?B?aWtoRkg3aVJvdnE0ZU1ZWEUwbWhSR1pmeUozTmFzOTg4QlRqMVNJUTZUYUQy?=
 =?utf-8?B?RVIvUnV1T3RlUnJ0OHZmbWdwdUZVVFhMZUVPa0l6QlBhV25kUlJqeVZmcXJn?=
 =?utf-8?B?alhzMFJlcUtMUTNDcC9LcUNsNHRkWDV1MVRKZU9Vb21mUG5POGFGekY4V3pi?=
 =?utf-8?B?SnVINWh6aWxGQVJJbGhVc2pyOU13UWRxZUlMMENnZTF3WXJ0OGNqM3lKRUZa?=
 =?utf-8?B?ZlNmVnN3a1JDOCt3L21hb2UzeGZudklLWDNMSlFJNFl0K1NtWGJFeFBhUjJI?=
 =?utf-8?B?KzlYRlRFT0lwTWs5YWJwaGZ0bW00Y1labWFXd2FudFRHdHFYSm1NNkt4M2Z2?=
 =?utf-8?B?NG5SMXZLWWVHWlprTVlLZnZDTzYwSVNiUnpMbUJXdUV5Sjg5a1JaMUhWQ3JN?=
 =?utf-8?B?Mlg2RW8yczhsMkpiSmhNYzhBV2RGUmJpSElrTjkvUVZXaTdjblhLNzBENUNj?=
 =?utf-8?B?UXFZS29SdG9LY0VrcXA2aUdIbnA2OWk5ZEU4cWFaa0hPU0xrZ1I4aUFzcGhV?=
 =?utf-8?B?K0NpTXNCcEpzMU1XRHRCbmU5bkZQSjJXNDI5M2lzcG5Ibmd3ZTV6UTV3eUtZ?=
 =?utf-8?B?U2ZOV3BOZXIxWEVBVkFSbGx5QkF6TlBENnE0NWdNOGdkVDNoei9XWTBJY2E1?=
 =?utf-8?B?VXJML3p1RHNzeXNkUG5DSGNxS01WaVM5TkxUNUtDdW1xNkdLMDRUbmFIU1No?=
 =?utf-8?B?Qnd1djBrazk2akIxRHVqRVlpaitxejBtQ081cGkrT1R6MTBhZ08zUDFRNEEw?=
 =?utf-8?B?VmtIUnlxMlVuL2VkRFE1NFdFMHdiVnVkVnV5QWw1eklsTUE3aThaVEY5MSsx?=
 =?utf-8?B?dDdzQitXK0RVVXZSaXdGY2ZRS3BVczFOM3BSOURVQjFMTTR3a0lBR1pVTDR2?=
 =?utf-8?B?QkE1QlYzMXloaVZMVkhGWWlDK0lMMEN2Q0I1a1VhTUdvYW1lVHBHb2xyRzQr?=
 =?utf-8?B?cTdIRmFrcVowRmhTTFBEMWtBcUlzSUZZM2dWL0pIN0dxUCtWVG9zbjFOS09U?=
 =?utf-8?B?QWUybEV5czdhb2o5ZzE0ZnB4SVVKT2pLSGVXRFJnTmFrcHhtSHFQak94dVpT?=
 =?utf-8?B?UFRkQ2tidUo3cUFaOHV4cm5zYkFuc2oyMDc1dlQwOXN4TWFWUXhOc29adTA1?=
 =?utf-8?B?cVBrU0RjanU1SUNXWXd1UlpjbjlIZUYxY3ZkK2NGUmpRR05yNkdoaHMvNkpD?=
 =?utf-8?B?SU9sWVM0ZGZLSXlZU1R6d3hLbUdvMWY2MlZXcmk0ZThKeDI5a0swdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9a2a86-bbf3-4f60-e09b-08dec007d989
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 18:01:48.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XaJOE8fbmhHYMNhWy2DzBwmg0rwtketftCaBni9evC0VpL0yXdU/EQYvSKP7zOFLklSOyrFyYHR9KZ/rsrzSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

Hi Rafael,


On 01/06/26 23:05, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, May 27, 2026 at 9:47 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
>> _CPC package:
>>
>> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
>>     lets OSPM inform the platform what it considers nominal performance.
>>     The platform classifies performance above this level as boost and
>>     below as throttle for its power/thermal decisions.
>>
>> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
>>     Register Descriptor sub-packages that allow OSPM to set relative
>>     priority among processors for shared resources (boost, throttle,
>>     L2/L3 cache, memory bandwidth). Parsing the full structure is not
>>     yet supported; such entries are marked as unsupported.
>>
>> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
>> mark the two new registers as optional.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> This patch is good to go AFAICS, while there are still comments on the
> second one in the series.
>
> Do you want me to apply this one separately?

Yes please. Patch 1 is independent of patch 2.
I will send patch 2 separately as a v5 after addressing the
review comments.

Thank you,
Sumit Gupta


>
>> ---
>>   drivers/acpi/cppc_acpi.c | 23 +++++++++++++++++------
>>   include/acpi/cppc_acpi.h |  8 ++++++--
>>   2 files changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index f370be8715ae..c76cfafa3589 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -134,7 +134,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>    * cpc_regs[] with the corresponding index. 0 means mandatory and 1
>>    * means optional.
>>    */
>> -#define REG_OPTIONAL (0x1FC7D0)
>> +#define REG_OPTIONAL (0x7FC7D0)
>>
>>   /*
>>    * Use the index of the register in per-cpu cpc_regs[] to check if
>> @@ -751,18 +751,19 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>          /*
>>           * Disregard _CPC if the number of entries in the return package is not
>>           * as expected, but support future revisions being proper supersets of
>> -        * the v3 and only causing more entries to be returned by _CPC.
>> +        * the v4 and only causing more entries to be returned by _CPC.
>>           */
>>          if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
>>              (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
>> -           (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
>> +           (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
>> +           (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
>>                  pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
>>                           num_ent, pr->id);
>>                  goto out_free;
>>          }
>> -       if (cpc_rev > CPPC_V3_REV) {
>> -               num_ent = CPPC_V3_NUM_ENT;
>> -               cpc_rev = CPPC_V3_REV;
>> +       if (cpc_rev > CPPC_V4_REV) {
>> +               num_ent = CPPC_V4_NUM_ENT;
>> +               cpc_rev = CPPC_V4_REV;
>>          }
>>
>>          cpc_ptr->num_entries = num_ent;
>> @@ -845,6 +846,16 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>
>>                          cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
>>                          memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
>> +               } else if (cpc_obj->type == ACPI_TYPE_PACKAGE && (i - 2) == RESOURCE_PRIORITY) {
>> +                       /*
>> +                        * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority as a
>> +                        * Package of Resource Priority Register Descriptor sub-packages.
>> +                        * Parsing the full structure is not yet supported.
>> +                        * Mark the register as unsupported for now.
>> +                        */
>> +                       pr_debug("CPU:%d Resource Priority not supported\n", pr->id);
>> +                       cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
>> +                       cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
>>                  } else {
>>                          pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
>>                                   i, pr->id);
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index ee8352830c32..9b18fb9aab7c 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -17,16 +17,18 @@
>>   #include <acpi/pcc.h>
>>   #include <acpi/processor.h>
>>
>> -/* CPPCv2 and CPPCv3 support */
>> +/* CPPCv2, CPPCv3 and CPPCv4 support */
>>   #define CPPC_V2_REV    2
>>   #define CPPC_V3_REV    3
>> +#define CPPC_V4_REV    4
>>   #define CPPC_V2_NUM_ENT        21
>>   #define CPPC_V3_NUM_ENT        23
>> +#define CPPC_V4_NUM_ENT        25
>>
>>   #define PCC_CMD_COMPLETE_MASK  (1 << 0)
>>   #define PCC_ERROR_MASK         (1 << 2)
>>
>> -#define MAX_CPC_REG_ENT 21
>> +#define MAX_CPC_REG_ENT 23
>>
>>   /* CPPC specific PCC commands. */
>>   #define        CMD_READ 0
>> @@ -110,6 +112,8 @@ enum cppc_regs {
>>          REFERENCE_PERF,
>>          LOWEST_FREQ,
>>          NOMINAL_FREQ,
>> +       OSPM_NOMINAL_PERF,
>> +       RESOURCE_PRIORITY,
>>   };
>>
>>   /*
>> --
>> 2.34.1
>>
