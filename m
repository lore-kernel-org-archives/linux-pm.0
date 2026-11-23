Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795434368;
	b=ul2A4R9SHkQdtwP9rdRCyDwMiVW3vpqBVpuzCFQ5EGFGJLH2MYWRxF6hii2PH0pCY9Fa
	 2vLY5Ktdh7yuR3L0ZUGxe53bASXuQngcHUQ94Z+YJtk8ABwnMxSjTx5k15Gv1xGu01yn0
	 qrx+DxSG85WusxLUlZCDZLZC6/2EiXXeYaOhBMJy5/CZPb9KqJ18HoVSyiBjKnSddoX9M
	 QhazMCGsjdNx1RDrTzQE4fWfoQLLzCm2x4hT6s1EskS888yoBf8ep18af/PUyKM4l07pY
	 CxGksokKGsvW7XZy4RTWAgQUcYFKdjHsALedNk51M8LluoRh5Fh4PPrIzqMK++MjJlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434368;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Q1te5ILhAkt7KmbA/OVO9LB31hg8hpVycW+WZ46GkeQ=;
	b=ihfZslq3rUwFmijQ0GIEGp2OReoH0dBcnncQ1mf4wOB8doBpgvXgKRTUscZ5ytskK6Bz
	 ptfxK+2kOVYggBAnbzph4OFU3ev9YtjJ6ZDQDJC0jLpq+fahB3DkKINoYk9Vp4EjjXcFC
	 OX9efH0xTCGv4mecsKh65seHQXeyfx1t1mEvhJQn02dgcNC9lBfDjo+rtjjRyzz7MyAJk
	 CvGk/HDQUlqfJLzO4UAneLkYiUj7z2nD1QvNTT8Tkhy5s7JWozu5tcGghKmXF5Qskmls4
	 n7fcmc+BVH4cWMGr0d7RIICVRs6BjAKADzuCCCH0abCvm3wtbNBxRkJIlA06qG4h4hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s+PbIEWm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.65
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4E9606A31A;
	Mon, 23 Nov 2026 11:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D4E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s+PbIEWm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq6fL1aB8MBO1/r9ndpDqYpeVPMqQSFpV6v8y2j0htdKSXPP62B/3DXrT8nTEqD3TvII0JWoLPAtbUT/uuEDZGYfuO1cHM4bNr4DgqEBwTwsX3zBbOnQ93yFfBJSeI6tQTF51siJIfO/Lykk4PbphAQh/kCu4a6J/WBv96BHqhfNvHaUPz7c9LgAd96epYB4hgX8F9sU47SuNhuBB0zSTO2EL1dFvaFbOvtVhwqXsEZGEoZxOK92zNoUXCqr7EVTPeeukgRS6CRpYXbpT4pL2jlvUg8R51QRpVvPCqIcik890JXA0WmIjeT5YURs0YZWIChaKSXDuAQ7fW4Ec7zepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1te5ILhAkt7KmbA/OVO9LB31hg8hpVycW+WZ46GkeQ=;
 b=e80r4zLIeF8MNVk4LHM8u+TEd2o8R8CKMtq7FtgQGqLgRxxgcLgw/XCo+4cRRiPhe9BO3cyPOyz6srsynecn5qS8Zm8MvCUlmvUn0Iwqg1KtJyJ4/OrzD8eLuaqlDejc7xmizinlRuLQBzaZHKYpxn5EdSjQsINKJVDlBP2AvPbiSDPxXV8wburNrud8sTmtsNvZcLoXWMuE/QYH0g2YWQPgKm2mAtocLV88+gsnBhe/+btJy67p3btOrX+zg2154nkDS23h3278S1HflwnC5E7PhcvdS0PCyPCVFVAaqGJRKNvD+6Kg6hmaQPPEfSUZ0pvfuNfYkcbMQerFpC0Y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1te5ILhAkt7KmbA/OVO9LB31hg8hpVycW+WZ46GkeQ=;
 b=s+PbIEWmoQ5SWw7MAuBs1ah62tySXnUxW3tyeJ0sI0ROHvPHlg3uhHzvGLLO0K9dihJ2PVUe4Qx4kLko2BuA7pII7j9qr5QG/nzDitejNTikoYBs1bnCB6pFMAH49ypjnMh2UqLQ9owfLL3e/A5NqPtawDsJ/fW8JJPyxHQ8nPM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21) by SJ1PR12MB6098.namprd12.prod.outlook.com
 (2603:10b6:a03:45f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 11:46:04 +0000
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1]) by IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 11:46:04 +0000
Message-ID: <11f84525-20c1-43eb-a918-eaaee03c504a@amd.com>
Date: Mon, 23 Nov 2026 17:15:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: amd-pstate: Set asymmetric CPU capacity on
 hybrid platforms
To: K Prateek Nayak <kprateek.nayak@amd.com>, ray.huang@amd.com,
 mario.limonciello@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
 perry.yuan@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
 <20261114150310.1377654-2-Vishal.Badole@amd.com>
 <69aee432-502b-4013-83c6-dde70cb59629@amd.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <69aee432-502b-4013-83c6-dde70cb59629@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::11) To IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB292992:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8b1237-1486-40a9-7ea0-08df49575a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261022075727099003|261028144727099003|261022113327099003|261021121427099003|261022105027099003|261102130727099003|261026121527099003|261026140227099003|261102123227099003|921020|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	glosSp1S+etDn9Y+n2Y4ZAAChYvilKvqZe3JLr/ynLQFiSq6nkowjDc7go9P5mYqHOEb8pMCPokwEgt9GNH7qARTP26jbNEqhkx/tTlX1HiyjPihn7c7JVAVvdc/NxjozIVkALx6W5H8EUMLlkO95dhr/VAOPrTNBCEYfk1HUVsFRiN24fA3VR8VDvFNlsr3jej9G3x3yQ+tNxied4JkCS3/Ns5VgjJ8AfjQXYjvVsoxginPsLvavvwHSvrfn6Z/FrIdKWi1cVMp8dXGe7fc4MCCNUmtW3Dwtd6x4/JXY8+dd04vZSgjYFnazcRmOuTbqc7xtDNvNE5+VzWhOS6/GdTxMPXf8oHdAwmf5HD2SQhljxptI2X3VShDwI4GDSDUfLaUKiBga6qZN68ZnQ/1OJwE37U0/9QCvrsfrV041zLcB3bO4w3wMmBHpmQYtW8PWMy94JXex611Qx4g52Z9905t/T9AkEaZysXE0Kr5h7KWLLMfEzxgdpeKApjaoad8tdL4QXTokNt+YP3eoKX5zaesAynvEhc23x5FYzgMFmcx9klBhMdTqCfKdQHuRtbY8ss8a7On314m6NFp7UqOr+RLDDmhGvkQ3mna/8OSxSHo4ImePDKHuyfeXiGT6J7CIwAOzzRNBl8KVt7OODfyYeFUpXVdLP8IvXwut+OBlCnx46B+oMUNFC2XtyXCF47PI7yjvioK+2ZfMTKRLgRRzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB292992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261022075727099003)(261028144727099003)(261022113327099003)(261021121427099003)(261022105027099003)(261102130727099003)(261026121527099003)(261026140227099003)(261102123227099003)(921020)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHVONWtWd0o2SU9qNEZibEx5b3ppQ2R1ZU15SVhBSGdMSHJ5M2JCVStVOWs5?=
 =?utf-8?B?VjNXMXBlUnROYjB4V0lNNzRrV0lhYmRjcmw2ZEp6ZmY5ODhxZ0Q5Z0FwdTNE?=
 =?utf-8?B?V2VuR0lBVHJNWktFOENyNzlhaFRSbUQ1WG1JUVhzOXhPWmNUTlNtNlhnK1dK?=
 =?utf-8?B?K0xGQkNJdDVibFB4cnZiSzFsMW0xQm1NOHZXcUFkVUhRYnVGTjZBUW1xRmFT?=
 =?utf-8?B?bDhkaTVDeis2a3FzYjd6ZjNoWXZ1aGt1N1Zqb1RnVkZoSzFNcjlmUzRseExr?=
 =?utf-8?B?MnNDOXovUTN2NDN6TWJka0lKaXVlR3BucTNMNkc3T0FBN0pwVlJSdTAxa2U3?=
 =?utf-8?B?b1FlT3RBMU51aUk4V3RXeXQwNVBwcFNpb3N4aGRQLzhhUEUrOHhzeU41dnNN?=
 =?utf-8?B?UTVqMzd1UllmdmtxQmF2QW1oSnp2S3ZqMlFWMlNiNlBUSVJ5SUNiaDhudUtY?=
 =?utf-8?B?SkRySVl5a0N5eVNpYmpVTWhuVkF1S3BURkRHd3RDQzk5ZHVxU2ptZ0ZWNU43?=
 =?utf-8?B?bHZoN1pFS1lyajh0TE8rWWs1NVdYODZyNWFMcndpRXh2eWQ3cVJHMU9ObGRU?=
 =?utf-8?B?ZlkvNFNEVTc0MmlOZVZGdXl6RUc3dFgyUWlRNmRPcDZnWTRGVUhTY1hJRmZN?=
 =?utf-8?B?QnNlbUIrVGQ5aXFKUFQyVzRKenUvNTVtYkdrdmNlTngrNFlJSVBPa2UwNG4x?=
 =?utf-8?B?T2Z6SXQ2RThRR21MdXFVTFFkbkw2MVdHeVhoRkJ0OXREdGxNeWxtSmtnVXFN?=
 =?utf-8?B?aVZwUEpFbW42NU1hbVhhT09uR2JkUWYwTUpZSGVERU1rUHAxUGJlbHNNS1lD?=
 =?utf-8?B?OStFYndGMGNPbUxZallKK3RZTUFLVGk4UkhEazBUSUZGd3JQNDRjMTNFRTcw?=
 =?utf-8?B?WGRqY01LaVNpMmhESG4vMWx6TlRjblhqbVR6SUJ3RWNhdTBQenEra01uOE5R?=
 =?utf-8?B?NlpUczd5S2lrT050UXBUSHlXeGk0d1J3WldUZVNoNkdFY3h4TkJtbXFZOFND?=
 =?utf-8?B?RU5kalNzSFU3cGdqWGhVSWgxZlFHN2xnK0JVVTdXR2h4U21Gd2VocTdDUzN5?=
 =?utf-8?B?TzdtVXhDd09YQzNkNWxDck5CRWRLQVFWMU1oaHd4M2F5MU5TNzVqZytUbHpY?=
 =?utf-8?B?ekFteXJLeHhKV2RhbEhDVjBZZFhiU09oeVpOQU51NnpUWVdpeVNOckgxY1Zx?=
 =?utf-8?B?QlVZdm9nUk40WThXSlBsS0xWckUxak92bTRiM1FSZmV0WFJSZXZIMDNBTHhV?=
 =?utf-8?B?N3VRdTNwOENxR3g1SWxybEM1cjhHZlN2N2phcTI3amY5NEdZTEJhWU56VCtH?=
 =?utf-8?B?WnM3RC9tVmZDd1doclZTTCtHMnlXK2JXODBzOFgxMlBBeVQwMGhZOS9uaGMv?=
 =?utf-8?B?L1JXcDVpUkNxRGM2UEdqeHYyU25zeko1M2NaeDF0aEF3cHJvUzFxeko2dDBZ?=
 =?utf-8?B?RS9RTFh1MXlwMWw2MHRjZ2JsMU13REptVTJYUHBiZFM1dmdaY01ITVM0UWt2?=
 =?utf-8?B?UnAvd0VMR0Z3YzNQM1pPWHRlRWJqRzFqbUMwUWpHUVBqcGdhMHpQK0N2NHEv?=
 =?utf-8?B?ekpGOUlnckR2d0ZmcFFqRFp5VU9ZbmZZWFhmdzQ3U0crM3UzcUtlYm9xeTJM?=
 =?utf-8?B?enN5UytKT3ZoRlAyV0FKT2FOZk5Tb0k2bUpOSDFDTWh5c1p6T1preldjNmo3?=
 =?utf-8?B?VHMzdzM3ZEFWSUJUSENpeHk1RUY5c1RKYXVZYWFBNC90eDV1M1h4VXN0TUFt?=
 =?utf-8?B?ZWkvU255cXJ3WEMxRUJ2Q2FMUS9hVUw3Q2FzMGRWOWxtUFF4dmRkdyt4Q1JB?=
 =?utf-8?B?ZlhXL1EwemdjMXdnSXpUVUhUNU5uT0Jqbm9jaThES1QwSWNWcEx0NXh1bnE5?=
 =?utf-8?B?UU5Sc3ArY2cyQlJPVVZSamF4c3RjZXFhUkR6Q1JqRGd3LzhVNndodEl6cTM0?=
 =?utf-8?B?OUNuT1ZnMjlpVGZTaW1lajZlQ0pYV3BXWUZWemRWTDBsSWtSR2ZmcjlzTzFs?=
 =?utf-8?B?aEgrZVhWWlVEazZ6WFcycHB2dHZ1QWIxb2xheUM2N2JjcS9NZTJuNC9pdmtL?=
 =?utf-8?B?SVh4cmZyNSt4Q1RxOVpocERkSks4SEJieGJrTnBCM3hNRkhmNDlQMnd1THpM?=
 =?utf-8?B?eFk3QlhXSnU4R0I1WDhmUEJoa3B5a3V1WTFxeWFHNHQySWw5U3lxT25OZmtM?=
 =?utf-8?B?MjdhU1R6ZFpwVDkrcWpiR1gzdTJaUldITFp2ekNid2ZHa0hlNWhIanU3WVVO?=
 =?utf-8?B?WVpDa2pEdzdEVk9QZWI1a0hGU0lUWStwNXF2TVYrR2s5QjZrbUxKaW9yTEZC?=
 =?utf-8?Q?1+Zgpqfa2/a/mB3m4A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8b1237-1486-40a9-7ea0-08df49575a7b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB292992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 11:46:03.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpsXkzkBJnc+FApAi9BAs4gPMBPTYhkiWAeKHjGB62/vUq27Nj9huVIOVpQCzT/CVHd8OtpiCB6AbUfpMXJzHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098

Hello Prateek,
Thanks for reviewing this patch.

On 11/17/2026 11:49 AM, K Prateek Nayak wrote:
> Hello Vishal,
> 
> On 11/14/2026 8:33 PM, Vishal Badole wrote:
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 4bedfbfc18b6..59eb2c4c7867 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/smp.h>
>>   #include <linux/sched.h>
>>   #include <linux/cpufreq.h>
>> +#include <linux/sched/smt.h>
>>   #include <linux/compiler.h>
>>   #include <linux/dmi.h>
>>   #include <linux/slab.h>
>> @@ -39,6 +40,8 @@
>>   #include <linux/power_supply.h>
>>   #include <linux/static_call.h>
>>   #include <linux/topology.h>
>> +#include <linux/cpuset.h>
>> +#include <linux/amd-pstate.h>
>>   
>>   #include <acpi/processor.h>
>>   #include <acpi/cppc_acpi.h>
>> @@ -86,6 +89,10 @@ static struct cpufreq_driver amd_pstate_driver;
>>   static struct cpufreq_driver amd_pstate_epp_driver;
>>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>>   static bool amd_pstate_prefcore = true;
>> +static bool amd_pstate_cas = true;
>> +static bool amd_pstate_cas_initialized;
>> +static u32 amd_pstate_ref_freq_khz;
>> +static u32 amd_pstate_ref_highest_perf;
>>   static struct quirk_entry *quirks;
>>   
>>   /*
>> @@ -957,8 +964,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>>   		return;
>>   
>>   	/* should use amd-hfi instead */
>> -	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
>> -	    IS_ENABLED(CONFIG_AMD_HFI)) {
>> +	if ((cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
>> +	     IS_ENABLED(CONFIG_AMD_HFI)) || amd_pstate_cas) {
> 
> This keeps getting uglier. I think you should have a preperatory patch to
> negotiate this and maybe a late initcall like Mario suggested to actually
> toggle the itmt support.
> 
> I was thinking something like folows to negotiate the who / what gets
> the owenership:
> 
> diff --git a/arch/x86/include/asm/amd/hfi.h b/arch/x86/include/asm/amd/hfi.h
> new file mode 100644
> index 000000000000..2a86d0049b8f
> --- /dev/null
> +++ b/arch/x86/include/asm/amd/hfi.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_X86_AMD_HFI_H__
> +#define __ASM_X86_AMD_HFI_H__
> +
> +enum amd_hfi_mode {
> +	AMD_HFI_UNDEFINED,
> +	AMD_HFI_PREFCORE,	/* amd-pstate defined preferred core. */
> +	AMD_HFI_ACPI,		/* amd_hfi defined from ACPI PCCT. */
> +	AMD_HFI_ASYM_CAPACITY,	/* Amd-pstate defined asymmetric capacity. */
> +};
> +
> +static enum amd_hfi_mode amd_hfi_current_mode = AMD_HFI_UNDEFINED;
> +
> +static void amd_hfi_set_mode(enum amd_hfi_mode mode)
> +{
> +	if (mode <= amd_hfi_current_mode)
> +		return;
> +
> +	amd_hfi_current_mode = mode;
> +}
> +
> +static enum amd_hfi_mode amd_hfi_get_mode(enum amd_hfi_mode mode)
> +{
> +	return amd_hfi_current_mode;
> +}
> +
> +#endif /* __ASM_X86_AMD_HFI_H__ */
> ---
>
Thanks for the suggestion. Given our future plans for the HFI driver, I 
would prefer to keep this CAS series independent of a broader HFI 
ownership rework.

For this series, I would like to follow your earlier suggestion and move 
the global amd_pstate_prefcore decision into amd_pstate_init(), rather 
than the per-CPU initialization paths, as a preparatory patch.

>>   		amd_pstate_prefcore = false;
>>   		return;
>>   	}
>> @@ -969,6 +976,64 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>>   	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
>>   }
>>   
>> +bool amd_pstate_cas_active(void)
>> +{
>> +	return READ_ONCE(amd_pstate_cas_initialized);
>> +}
>> +EXPORT_SYMBOL_GPL(amd_pstate_cas_active);
> 
> You can then just use amd_hfi_get_mode() instead of this.
> 
>> +
>> +static bool __init amd_pstate_init_cas(void)
>> +{
>> +	int highest_perf, max_freq;
>> +
>> +	highest_perf = amd_get_effective_highest_perf(0);
> 
> Didn't you mention an efficiency core / LP core could also be
> the boot CPU? How are you considering it as your highest
> reference then?
> 
> I think we can tak a page from how intel_pstate does a
> hybrid_set_cpu_capacity() which iterates all online CPUs after driver
> registration / if onlining changes the hybrid_max_perf_cpu.
> 
Prateek, my point was that CPU 0 is not always the highest-performance 
CPU on newer hardware. I used CPU 0 considering highest perf CPU with 
Mario’s patches in mind, where Fmax is hardcoded per core type and 
shared by cores of that type. That handling does not apply to older 
hardware.

However, sharing Fmax within a core type does not guarantee that CPU 0 
belongs to the highest-performance type. I will update the series to 
select the highest-performance online CPU and recalculate capacities if 
a stronger CPU first comes online later.

>> +	if (highest_perf <= 0) {
>> +		pr_warn("Invalid reference highest performance (%d)\n", highest_perf);
>> +		return false;
>> +	}
>> +
>> +	max_freq = amd_get_max_frequency(0);
>> +	if (max_freq < 0 || (u32)max_freq > U32_MAX / 1000) {
>> +		pr_warn("Invalid reference maximum frequency (%d)\n", max_freq);
>> +		return false;
>> +	}
>> +
>> +	amd_pstate_ref_highest_perf = highest_perf;
>> +	amd_pstate_ref_freq_khz = max_freq * 1000U;
>> +
>> +	return arch_enable_hybrid_capacity_scale();
>> +}
>> +
>> +static void amd_pstate_set_cpu_capacity(struct amd_cpudata *cpudata,
>> +					bool highest_freq_available)
>> +{
>> +	unsigned long capacity, max_capacity, capacity_freq, base_freq;
>> +
>> +	if (!IS_ENABLED(CONFIG_SMP))
>> +		return;
> 
> What is the CONFIG_SMP dependnecy for?
> 
The x86 hybrid-capacity implementation requires CONFIG_SMP && 
CONFIG_X86_64. Otherwise, arch_enable_hybrid_capacity_scale() is a stub 
returning false: topology.h:299 and x86_topology_update is defined in 
smpboot.c:127, which is built only with SMP.

Without this check when CONFIG_SMP is set to 'n', build will fail with 
following error:
amd-pstate.c:(.text+0xf23c09): undefined reference to `x86_topology_update'
>> +
>> +	if (highest_freq_available && amd_pstate_ref_freq_khz) {
>> +		capacity = cpudata->max_freq;
>> +		max_capacity = amd_pstate_ref_freq_khz;
>> +		capacity_freq = capacity;
>> +		base_freq = max_capacity;
>> +	} else {
>> +		union perf_cached perf = READ_ONCE(cpudata->perf);
>> +
>> +		capacity = perf.highest_perf;
>> +		max_capacity = amd_pstate_ref_highest_perf;
> 
> You can just cache the freq corresponding to
> amd_pstate_ref_highest_perf and not need two seperate global
> variables.
> 
On newer-generation hardware, the performance-value ranges have changed 
across all core types, and the differences between core types are 
smaller than on older hardware.

Inferring and caching a reference frequency solely from 
amd_pstate_ref_highest_perf can therefore misrepresent the actual 
frequency differences and produce incorrect capacity scaling. We should 
use the actual maximum frequency when available and keep 
performance-based scaling as a separate fallback.

>> +		capacity_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
>> +		base_freq = perf_to_freq(perf, cpudata->nominal_freq, max_capacity);
>> +	}
>> +
>> +	guard(mutex)(&sched_domains_mutex);
> 
> Why "sched_domains_mutex"? Probably means you are setting
> x86_topology_update at the wrong time.
> 
The mutex was intended to serialize capacity publication and the 
x86_topology_update write with the scheduler’s read-and-clear of that 
flag during domain rebuilding.

Normal CPU hotplug provides serialization, but .init() also runs during 
driver re-registration under cpus_read_lock(), which does not exclude 
concurrent cpuset-triggered rebuilds. That was the reason for using the 
same mutex.

I’ll revisit the notification timing to see whether we can avoid taking 
a scheduler-global mutex in this path.

>> +	arch_set_cpu_capacity(cpudata->cpu, capacity, max_capacity,
>> +			      capacity_freq, base_freq);
>> +	topology_set_cpu_scale(cpudata->cpu, arch_scale_cpu_capacity(cpudata->cpu));
>> +	x86_topology_update = true;
>> +	WRITE_ONCE(amd_pstate_cas_initialized, true);
>> +}
>> +
>>   static void amd_pstate_update_limits(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata;
>> @@ -1043,6 +1108,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   	u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
>>   	struct cppc_perf_caps cppc_perf;
>>   	union perf_cached perf;
>> +	bool highest_freq_available;
>>   	int ret;
>>   
>>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>> @@ -1069,6 +1135,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   
>>   	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
>>   	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
>> +	highest_freq_available = !!max_freq;
>>   	if (!max_freq)
>>   		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
>>   	WRITE_ONCE(cpudata->max_freq, max_freq);
>> @@ -1100,6 +1167,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>   			 bios_min_freq, cpudata->cpu);
>>   	}
>>   
>> +	if (amd_pstate_cas)
>> +		amd_pstate_set_cpu_capacity(cpudata, highest_freq_available);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1923,12 +1993,20 @@ static ssize_t prefcore_show(struct device *dev,
>>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>>   }
>>   
>> +static ssize_t cas_show(struct device *dev,
>> +			struct device_attribute *attr, char *buf)
>> +{
>> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_cas_active()));
>> +}
>> +
>>   static DEVICE_ATTR_RW(status);
>>   static DEVICE_ATTR_RO(prefcore);
>> +static DEVICE_ATTR_RO(cas);
>>   
>>   static struct attribute *pstate_global_attributes[] = {
>>   	&dev_attr_status.attr,
>>   	&dev_attr_prefcore.attr,
>> +	&dev_attr_cas.attr,
>>   	NULL
>>   };
>>   
>> @@ -2438,12 +2516,23 @@ static int __init amd_pstate_init(void)
>>   			return ret;
>>   	}
>>   
>> +	amd_pstate_cas = amd_pstate_cas && IS_ENABLED(CONFIG_SMP) &&
>> +			cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES);
>> +
>> +	/* Enable CAS for processors with heterogeneous cores. */
>> +	if (amd_pstate_cas)
>> +		amd_pstate_cas = amd_pstate_init_cas();
> 
> That two step disable is pretty ugly. Why couldn't you push the
> feature checks into amd_pstate_init_cas()?
> 
Ack. Mario also suggested this, along with a few additional changes. 
I’ll incorporate them in the next revision of the patch.

>> +
>>   	ret = amd_pstate_register_driver(cppc_state);
>>   	if (ret) {
>>   		pr_err("failed to register with return %d\n", ret);
>>   		return ret;
>>   	}
>>   
>> +	/* Per-CPU capacities are set during registration; rebuild domains once. */
>> +	if (amd_pstate_cas)
>> +		rebuild_sched_domains();
>> +
> 
> Isn't this super early into the boot? You don't need to rebuild sched
> domains here since they will be done later (I'm having a deja vu moment
> from a previous review)
> 
I used intel_pstate as a reference here, following your earlier 
suggestion. The intention is to rebuild domains once after publishing 
the asymmetric capacities. Since amd-pstate initializes via 
device_initcall(), the initial scheduler domains have already been built 
by that point.

>>   	dev_root = bus_get_dev_root(&cpu_subsys);
>>   	if (dev_root) {
>>   		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
>> @@ -2484,8 +2573,17 @@ static int __init amd_prefcore_param(char *str)
>>   	return 0;
>>   }
>>   
>> +static int __init amd_cas_param(char *str)
>> +{
>> +	if (!strcmp(str, "disable"))
>> +		amd_pstate_cas = false;
>> +
>> +	return 0;
>> +}
>> +
>>   early_param("amd_pstate", amd_pstate_param);
>>   early_param("amd_prefcore", amd_prefcore_param);
>> +early_param("amd_cas", amd_cas_param);
>>   
>>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
>> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> 
> Why not arch/x86/include/asm/amd/amd-pstate.h since all of this is
> AMd related?
> 
Ack!
>> new file mode 100644
>> index 000000000000..eb750abd20f7
>> --- /dev/null
>> +++ b/include/linux/amd-pstate.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Public interface for the AMD P-state driver.
>> + */
>> +#ifndef __LINUX_AMD_PSTATE_H__
>> +#define __LINUX_AMD_PSTATE_H__
>> +
>> +#if IS_ENABLED(CONFIG_X86_AMD_PSTATE)
>> +bool amd_pstate_cas_active(void);
>> +#else
>> +static inline bool amd_pstate_cas_active(void) { return false; }
>> +#endif
>> +
>> +#endif /* __LINUX_AMD_PSTATE_H__ */
> 

