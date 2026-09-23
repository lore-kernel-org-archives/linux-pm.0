Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22532544D4B;
	Wed, 23 Sep 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180468; cv=fail; b=BWRtioryu3CDf+RgFiUImfbBi8Y9KpQ4yLeIIFCQAOcf+hdMmU0RaFyaqj3145UmdXiQM8XfcVC8rny3BtgMYiOilx1/7dglmJyeE8aR0jt9AB7wP8HzFvUW1v7PdfMFGuoOtsIRg9RndMM4dAx8x9gcGlY0zEb/Ff60+Hevmq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180468; c=relaxed/simple;
	bh=aLiIM9ZdiPO2wd7ZymW6OCTQ+b6U+m+my2Oqkt68MV4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RBKOAbdKBCNy7LsqCFF/+I0JKb14X3U9teFTYNq4BYPHceq8H7OwEbSXBP4W2/SVIeh2vNrwRivwjvPjW/bLygQZRqrqOZECzWHusP7FpiOeocYHo9IC4SIOLLmJqhuGty/5trYVH30bKtppfVmQi45qapYnkXgbk88a3mPEQHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FHbabFqn; arc=fail smtp.client-ip=40.107.209.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FHbabFqn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9ZlHeOJiq6d5SZSXPyluYOtWtoliArVRsb7R/Kuz/1A6W6KJ6D1aE6qvG7yGnj/aE7OqmX7dHBxAblvKDhI/ThJvaio/lEB+uxwukyF/E0ohcCN4N9gbI8ARiXh65j6PVk6/aNTq98R9lO8vuHrqIfkmjkA3TXiYqf+87/T7D5Jz/B/8TbARO0UfrnXy/ZSrT4sf1XLzzzag35uS9pM8pK7aD+vW8nz05K6LTUfMH5Y/6e8HtL18v959UkcmcUl+xR6l/XbkxbhiDkP1dCGUYFOLA3uh8oJr1JRHTD6c+ap0iCGWCffIBqPCaoorzCOnbQ0fXKHFC8tHQ+lFC0zYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzo3y9zMHmlDdSnJo9paRB8y1ROhyCDhasN9YooBKuE=;
 b=Rf6txkPhS+U2pBORlLIHdRntgvZAglWw2BFC0HX6D/s10xCfnDNuQbgYzHnXUDF1Q7Nxsd9/Qadp3HWWF+rgLe4mjvjlxBJG01I7X2I+wzA7S/w+RHAFhOm5MMZ+byhl02B7lwoOFWquaa54P/u43yHKtkD+zSakUn/Tv6apvsOKgHYxdNQX6H0dXj9bcDFSrxzR3eg+DN3vlIfTorR9U32B2m2upUcsoHPAK/N3r2fEcqZgv5P8VGMCWtFIpTxiL/ItpDNrM3JuibDuutm82o+O7H1iQLlnREXchMEv18Z9fSSOdsxmIM3UPu9THK4fnMjfGeQ/HBQjY0wLY+xIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzo3y9zMHmlDdSnJo9paRB8y1ROhyCDhasN9YooBKuE=;
 b=FHbabFqn+m/6gREDt8WaYOkmncSibY45rU+W7xstixdB8il7XhpG3dPEzNsANqexYLsX5zILz3n7j4hm1sv9bUj51dApzo5jwpbcKDzEyL7uiEK2li+ROSPBitUB5srqbVpP82mITJ8OyxprRuJcy/2e2IQEpx8c8J5wC0EY1dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 16:21:03 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:21:02 +0000
Message-ID: <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
Date: Wed, 23 Sep 2026 11:20:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
 <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
 <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
In-Reply-To: <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0235.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::23) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bf3073-5028-47f3-c3cf-08df198ea92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|5023799004|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	R6Jd8jjLtWMXfoko9wCmTufwXkcXVNsmjZnVr9H4udwzxol9lT+CG/bgWoBY/O7iI/Hw6yCBlFiKmT31uD5nHRJT9PGlszp5k6TGZsPrCuUlxdBaKlHMHjawn3/52w+y1xiLbG5+G9BCY9yHpToPGkHydV8XA1jHQU3/+t3Ru5RmyJs7KnfQmij+ow+pdj33+5NuTMTx3zB9skbQvV1UJPE4xe7Sq0Z8UqKJVErGi/Lx8h0qGpmzme4FbShzacO32ljB3cPi29IzJ2WZHyB0/LDy4N6r6AeZWpWLuybszyzOVkfN//N3fDk+IQHhnDj86ylKysXq8eCCn2vqN7PBQkUp7ihHUF5T92f8vhJ59BGNlsyazZeytxLH4d3LaLN2U6aP04pdaNxI+Max0pJ0XKRnJcSJ6fQ0Ef1EM6bWga8PhUlk23sJx0HIeDaPZ3EkSLo4azYdN6yJhPCIYoTemy8eRPGUhH6cVp2eypH0VSecJtq4YifTAppH7KeZxYPeRCUEWrvU2FUzYZIQGesalNHFf8M/A3qz1H6v6utsujxr6Qpwvsr1tHGNlS6TuPrWE1TbQLj96NdiLQ/+nDpwA05YKvsMUTcW0mPXf8fTn23Lz3k5QlAHpYAccVDs6+du+WTkH/HZ/kpyQ4JomQK+KoHPWXm4hJWIHKCRFxMD29g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STBGd0hTVElaN0RpQUsvaUdOV2lKSXIzWk1JWUQzRnBlNUdGVGg1dDNoS3Vt?=
 =?utf-8?B?VlN4YWFPaUtURFJpSW5tQ0tMYWdaNjFpczZ1Y28wSnJ4RVlGQkc4ZjBhcHdS?=
 =?utf-8?B?SEhTc1F6Vzd1WXMydU5vRHhqa052ZDVDWk5zR24vcGZ5R1ZqaG4rV25mRlFI?=
 =?utf-8?B?eDJqZW4wOGRCdVZOSi9tZWVPK2JUeHNYM1kyYnpsR3NqNzl3L2ZNUm5iNTE0?=
 =?utf-8?B?ZmMvYUMvTjZwdHZZb2RSM1ZuWnBBRENiOG93NmVQTFlxcXI0V1BhU1NhOTc2?=
 =?utf-8?B?b01Td0kwSWRKUEZDcFhyWkFHVyt2M2dJY050SU9MYityT3RmYlc4VjR4U1ZQ?=
 =?utf-8?B?MlM2N0l6NWxZVlphenM0RDJsaHl5eFhVUThxSlV0bXRkYlhqUVJTNWtoTTli?=
 =?utf-8?B?cTRRdVFXNXdHa3pGdTRidVRGZUFGc2ZyYW41eklHMHJvQno2WUZMcnRlM3NN?=
 =?utf-8?B?aDJodlJ3MVVpMFZ4Rm5iM1BpbTdEem9VKzNLaGNUVUExV3VsZEJGWHlSTGZv?=
 =?utf-8?B?OW5jQkMwNDh2eWlNdE1jU0NnMTdpMUNMeGZFbkdsYzFxcDNvNjYrY3h2Qklh?=
 =?utf-8?B?T0FoaHFtUTE1R2hxeTFyemIwSUhlandJYzdIMUVYaFZKa1ZQbHNtU1lPWXpY?=
 =?utf-8?B?Mm8yRnhqVkpCVzF0RGFZWVlhUmN2MjlpZzZmNEZRSkh4eXpDdTVGTnVacnE5?=
 =?utf-8?B?WEExbEJuc1FNWW9PNHlxQUxsd3NJTUdra0FJc0NPTklxTVlKK3FTMFdhQ1hG?=
 =?utf-8?B?Uytmd004Q2ZVM0Uza2tYb24rVmxERlh4UEgzTTkzeEhwS3JHWlVpRVdlM3hv?=
 =?utf-8?B?bXgyR0JMU3FpWGI2aWlmdStONkMwUW1TaElIVGU4TklmNmoxb1FKT0Z5UU5j?=
 =?utf-8?B?TFVRZmxvYjZNQndaVjF4VUlqUmQwMkVmeHpIUlFqMlp2MzdQdUNrNDN6QUVP?=
 =?utf-8?B?VHBFTG15djdUMmFnS0gxZEtraGZ2V05YbTJndU1GUVRMY3NjV3lWazFpRnRj?=
 =?utf-8?B?VmxUMmk2MXh1SytyL05MSzM4ZFVEeG1yRWp0K1BsU1JsNEEvTXNUdnpJVC9L?=
 =?utf-8?B?RzgzclBmNmJHSjFhYUJFekdzTGtmaU1ZejNZelMrbGpMY1lLTlo5RlE2ZWUr?=
 =?utf-8?B?aUU5VUlEMWU3SWFiTFBwTXVUemdLaDFZWVRwTDQ4N0lpcUVoSFhBRVRFZlBj?=
 =?utf-8?B?YmphS0VrcjRrU3A3TXNZOFVOZms5ZDFPYWdMYklCYmtHcWpzMURWU0V6QzlQ?=
 =?utf-8?B?aTB4LzZ1L2hxOFZRc2Qxc2FzaFZPV1dXUHBFcEUvellFYWgzS2FYVjRzVHNY?=
 =?utf-8?B?QVQwNXBQU1FFVTl3QXJlWnk1ZzNIc3FBcnFsZlJjcVdTNWJqc3V0UXV5eGE3?=
 =?utf-8?B?Uy9Ra1pGWUdNM3Q3ZEtpK2N6cVVPL0tIZ1R1ai9YTjJBcEt2SkhrUWpxeUU0?=
 =?utf-8?B?OXJxU010N2FPU0FsK1RVY1ZKREZBRlBzOURyZDNIRDdTamQrQmR2VERGdjVH?=
 =?utf-8?B?dUN3RWhaemxwK3grT2JnNUYvS013YzRlT2pJWm1mV0Z0U3FQRFZlK2hvcDZ4?=
 =?utf-8?B?YUx1eWNTS0FnY2R4QnZVRUp1SWJQMDNqZnJKbk83a3lYb0JwOHdqODByNUJp?=
 =?utf-8?B?QUlJZllQREhXaWZKbkFMbE9PUlRHMUQ3ZFpiQy84cUExRVdvc1hxYXd4QWsv?=
 =?utf-8?B?cTR3a2tDdmE3Umx6QXlteGtQb1V3Q3FRdDQvUUlNQ0FXcU5oUjJQREFpRWsw?=
 =?utf-8?B?SjR5MXNVdi8rNUxFNUNGWmRDbTlrMG1oL3BKTzVLNHpUaHJBZUxxdFVGaHhw?=
 =?utf-8?B?TnpNUTg1bFRpcUo5d1lnTG9xcjUyK1NFdlFhN3dhakFpQzVOMlN1Ym9zZFZy?=
 =?utf-8?B?NDI5UjJxSEJMREdUbStwMCtaT2RUMDFxL1VKK0Q4a3pvcnVDZWdrMEVHbGJD?=
 =?utf-8?B?Wmc1T0hMWFV4SktMTTV0ck5kTytGL1VWZy8vOXFnUDRrd2JEUVlPeW43VUMy?=
 =?utf-8?B?a0hkOXFvWTVJeTNqUFl2ck5DRGRUZDhzeG44dnlkQ2lSdkQwQ09xNnFTcVl5?=
 =?utf-8?B?S0RMdjFJMEVxd0ljRTdWT1FwWFJ5RGJzdm53eks4RHRRaWZJbEdOWWZCMzc0?=
 =?utf-8?B?S3VqbE9DOE1VQWtzcTR3REpLSGJFMTNFOFdKWm9MU3I3RnJ2Q0NLT3NyTWtM?=
 =?utf-8?B?MEVDelNSNlk0dG9Qa1cvSjd6SU5vYUtZczIwd3pmbFNkOWpZOVc5Z3l1b1hw?=
 =?utf-8?B?YUJWZnh1N1hLamQ1cldwWDhEVFg4WXBBdnFiM3YwOW5uLy9vcVF2c3pwTnU3?=
 =?utf-8?B?UTQyZUJaemMyWlIrQWI0RmVldzgrVGJmbTRISXcwWFl1MUJGNlZoUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bf3073-5028-47f3-c3cf-08df198ea92b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:21:02.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVhABgNjtqV2af2RvXGomyrXsTn6g7DVXJ9uF6YQ7tYuOtOkGayEcxZPc2OhS3xP7pXb95HmnWen1Oe1H834jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817



On 9/23/26 11:15, Mario Limonciello wrote:
> 
> 
> On 9/23/26 11:12, Fourhundred Thecat wrote:
>> On 2026-09-23 16:36, Mario Limonciello wrote:
>>>
>>>
>>> Some other thoughts that might be the root cause based on other 
>>> historical issues.
>>>
>>> 1) Have you changed TPM policy or Pluton policy in BIOS setup?  What 
>>> did you change it from and to.
>>> 2) Have you enabled a storage security password?  If you disable it 
>>> does it help this issue?
>>> 3) Do you have WWAN in your device?  If you disable it does it help?
>>> 4) Does booting with `amd_iommu=off` help?
>>
>> 4) amd_iommu=off
>>
>> Yes, that fixes it. With amd_iommu=off and all 24 CPUs online, 
>> suspend/ resume works reliably.
>>
>> So this is not really a CPU count problem. nr_cpus=16 was only masking 
>> an IOMMU interaction. But narrowing it further was surprising: neither 
>> of the IOMMU's two functions is responsible on its own. All of the 
>> following were run with all 24 CPUs online, and I verified in each 
>> case that the parameter actually took effect:
>>
>>    amd_iommu=off            IOMMU off entirely                     WAKES
>>    intremap=off             IR off, DMA remapping on               no 
>> wake
>>    iommu=pt                 DMA passthrough, IR on                 no 
>> wake
>>    amd_iommu_intr=legacy    legacy GA mode, IR on, DMA on          no 
>> wake
>>
>> Verification for each:
>>
>>    intremap=off           /proc/interrupts went from 58 IR- lines to 0,
>>                           and irq 1 (i8042) is no longer IR-IO-APIC.
>>                           iommu still enabled, domain type Translated.
>>    iommu=pt               "iommu: Default domain type: Passthrough 
>> (set via
>>                           kernel command line)", all 40 PCI devices in
>>                           identity domains, IR still on (58 IR- lines).
>>    amd_iommu_intr=legacy  "AMD-Vi: Virtual APIC enabled" no longer 
>> printed,
>>                           only "AMD-Vi: Interrupt remapping enabled".
>>
>> So only disabling the IOMMU outright helps. Turning off interrupt 
>> remapping alone, bypassing DMA translation alone, or dropping out of 
>> vAPIC/GA mode all still hang.
>>
>> The CPU dependency is still there on top of that. With the IOMMU 
>> enabled, nr_cpus=16 works and 24 CPUs hangs. Offlining cpu16-23 by 
>> hotplug after booting with all 24 does not help; the CPUs have to 
>> never be brought up. cpu16-23 here are the second SMT thread of the 
>> eight Zen5c cores (APIC ids 17,19..31).
>>
>> Both conditions appear to be required: the IOMMU enabled, and more 
>> than 16 CPUs brought up at boot. Either one alone is fine.
>>
>>
>> 1) TPM / Pluton policy
>>
>> Current values:
>>
>>    TpmSelection            = DiscreteTPM2.0   (possible: 
>> DiscreteTPM2.0;PlutonTPM2.0)
>>    PlutonSecurityProcessor = Disable
>>    SecurityChip            = Enable
>>
>> The TPM that binds is a discrete STMicro part, tpm0 -> STM0925:00.
>>
>> I did change this. As I recall I disabled Microsoft Pluton, which 
>> moves the TPM selection off the PlutonTPM2.0 default onto the discrete 
>> part, so Enable -> Disable for Pluton and PlutonTPM2.0 -> 
>> DiscreteTPM2.0 for the selection. I will confirm the exact original 
>> values in setup. I have not yet tested whether restoring the Pluton 
>> default changes the behaviour, since the IOMMU result looked more 
>> promising.
>>
>>
>> 2) Storage security password
>>
>> None enrolled. HardDiskPasswordControl=Disable, and the HDD, NVMe, 
>> Admin, System and Power-on authentication slots all report 
>> is_enabled=0. BlockSIDAuthentication=Enable is the only non-default 
>> setting in that area. Nothing to disable, so nothing to test.
>>
>>
>> 3) WWAN
>>
>> Yes: Quectel [1eac:1007] at 0000:c4:00.0, attached over MHI, exposing 
>> wwan0. Its power/wakeup is enabled. Not yet tested with 
>> WirelessWANAccess disabled in BIOS.
>>
>>
>> so please suggest which test I should do next, now that we have more info
> 
> Of your above the most likely cause is PlutonSecurityProcessor = 
> Disable.  Please try to re-enable that and then try with IOMMU enabled.

BTW - what version of amd-s2idle didn't flag this?  I am surprised, we 
had a check for this that /should/ have failed prerequisites.

