Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139F3BCD21;
	Thu, 10 Sep 2026 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074127; cv=fail; b=VEJnXh3kLvpny3DN5dlWBbr/Pe6cHSo2aAtmXU907clUPAtDw/lDXMnt20aIEDNUh78c83wD+5tuK36CnIB1Qq0Ic/pjSj9o9a9v0LCInlByroGSUHL93L+PujK2LK9MCeoDEhFI92lHBTYn3uilDJ6SsUr2Y3XSPJtU9G7h85o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074127; c=relaxed/simple;
	bh=91KtR6Yp8NxCSYiHXwjyjInvfioAfqcGNbjXrF6TFk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fX7roQ8DTnMZLe8O6B6QFBEkq8StJivv7c97c/mVF0Y2zmfIPELo1OylhNSUW3U0Z84Ej3K6hO1jU7cP1k1VcvkIj02zB/8qT/B7+TR3MxZbIYR+23WeBoi4zusM+tuSfsxo6JTEaMQVMknnQRvT1cgx5Qsus14EQwRlZ8lM79A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jA8/jvtN; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jA8/jvtN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgiPPgFyHPTrIUvvlfpG7AvwjD/EmYE6nJQqAHdlk37015HYuXorl2Znke5V1aPRUurVr0BemwJDYw/z2GuDvc5DD2RKodTJpD3wZ7YrZkPn92Y/dMTdlWhe5aaFar96kqf2KVdmcOtil3kN2073RnZi2tKF+HRCsITS5HM/jS3hPds+LcPSUll4ndd81KW8u+qm25K03UCNtiWCBb0xL7/HbHBFgqPQ37JKlg/pn3Pj8NwdhTqQHqBOhNRA9R/tlQPSWbHGSDCuI/Fu1CPdJ42iKY9tgAjnOl4E972VRnlPhpWLwHaV8VQ/cyAnsRkIrdQcBvFeHY33he4sVAYQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90L5xT37SaSuCYi+NEU/wJxomKJHGCh9O/8T8RZmjXg=;
 b=qdTFPAQLw2iQb5SNdjtzJZ83Dpm6qEalIYsiKlkVYqmhQ8usdkiVmZIOIVvaRiK+vSLRRiRn6JCZ59espihMH1T4k+4RSQcusECyL7xBCsvprl57NzRo7B1sRtDC4AtryAsk5GEsNtBbVStyvV8pDesCnLO2e7DvIafkge2aZxjAbQQEJTFusdtPAui8fgdvTXXNKa2ePiff1M0kKhiM+FHzQrmJmVHTIsoINtxjVvIllL0hxO5ioF2EqyKNFbkCJ1isHmVdsYJ2PCA6u3zpLheNkhioDwMIx1WQLQCq5ZiSZSv0Bb2k7XLip1UDZFcC+rQyoasB6qZfe0aje9dLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90L5xT37SaSuCYi+NEU/wJxomKJHGCh9O/8T8RZmjXg=;
 b=jA8/jvtNRJkAyUubmQmN5HcgIYMVHIVnzR0B+6cH1IIHJv/WrzpBjmJCJdgmkxoyEpUq3qruqnZcCsKmYipBDDZyNxca8aOyL56Vugxc+8lq4djhsi/tkhCsn62OJtd+U+yXd0KbZHXseq+Wlt4z/Y8eCvNJvP8Ylb2czG/suT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 21:02:02 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 21:02:01 +0000
Message-ID: <bcd04df1-193b-4cc0-a72c-c46dff4b5736@amd.com>
Date: Thu, 10 Sep 2026 16:01:58 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp
 documentation
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Karl Mehltretter <kmehltretter@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260905010706.57380-1-kmehltretter@gmail.com>
 <4a577dcb-3fa2-4d28-8b86-757dd67cd6cb@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4a577dcb-3fa2-4d28-8b86-757dd67cd6cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:610:60::20) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: abfcc7c9-23ff-48f4-55d5-08df0f7ec29c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|3023799007|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YkgfYMkjYf0I0ZMueCOZ110EMVZXHyAXsclQOa6z9vaQpyirel6aSyk9gvBxByMSspBiP5N5qXwGI7wOKqihoxZuHttkKE3IoRoGIPhKYDiUjgMcxl7VGGkAwCqlhz4/gnc3chPlP/BixkAkNquMbHpnGEaWjl6wKVz+Fx/v/uJVg2X+vRbjspRZU8FqoKCZ4phdbkFqBXSykY+Ck7P/HCHAwjzvZ5ZRytyiTVXKLqIx+rrnY/c8bLI+6TK9C6xqS+gZkyOpeyVVg/w25Ohf6iz0FB6YXF8EMCj4S0Dwod+/fgIgOYNItcNFKgJQu7JzvN0QglL3b//a9+ZdKE8kbz0IkRLtZoRzB4uOrtTByD+mbGHfdhFjohBPCYXmssamizV45h43elSg/Htr65hYZ4MvjrVKXE1/kkaL6rIlPV4CVttzcrQ1cDg8Q58YFzRvJh2OvqrY5iPnFY2GhwiUDqMYKtW8jH6ulNYQJ8XVS/48rcz8tKMqJAeuVUxba6H8ffdZFFb+JY59ernm2nCYEeopYVnvNkgKSgV8fG4NtqL44qVXldijtJ9RlOBpPsgUHhqrdWMB2XlmpGCTV7IEOZQyk+wp3HoS7lBKOM4WvBB2B/yIUF1uHuQWvPI0fKofIIlryjqIn2JF0pDDes84iw3cFNG8rkqMGpaWh0kWtQU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFZWY3pPSmNsVEdCT1FaNnlBSmZMYjJEUm5KK0MydzJob2VHekVFMnRqWDZY?=
 =?utf-8?B?T3dwc0V6OUd6TWhJd29wYXhLT2gwUUdQS1VOSHk4ZGppbVNmMlVGaXJKL3c1?=
 =?utf-8?B?ZWJpak5yUC9hM2RBa0hTV24rSEQyVEMrR0dDK2F4Z1hzQmlTYS9QdWh6amZo?=
 =?utf-8?B?NFFKOGYvemZHYUYwNVdwbElXc202dlJ4Mzc1VUEvVjBERHhlbzFNRWIzZkV2?=
 =?utf-8?B?UE52WTVGbldNcWQ3NGJJVHZaOGZXSXkwQyt5UnF1Nk55R05rajhLRHJ0UTRR?=
 =?utf-8?B?L1M0MkVVWUhSU1h4NFJhZ0p4ZDJOOGg5ZnBQdzRNNEdWRnV2YVhTenJxWmNT?=
 =?utf-8?B?VVVXV0RPd3R6YUVRU0VKUFNNRG0xY2wySlNuYXAyRk5kWnJDN1RmZFZZaDZ3?=
 =?utf-8?B?MzA3REhYazNwYTFIT2FabmVlc1UzMDlhWG00Nmh1eEZNbzl0YlFsL1pZbit5?=
 =?utf-8?B?OHBnQ29idVY4WXN4WDVZN2h2cVBEYjlvdDEzVDBBeVNLbUZFMVJmQy9qNGdw?=
 =?utf-8?B?a0JJZisvV2hhRlRoaDk5SDVwdGRnTXR3Q2NLaWZCOE1DcFNVVjNtcVRGQ1FT?=
 =?utf-8?B?ZVoxWjdyaXBBcHljQ0RiMEJ4Rkh6U0MyRURNdDIrZ1E3ME9XRG0zcHE4UXJR?=
 =?utf-8?B?aDJRUWFmOGtTVGNiMTVkQzRCbmw0ZnAzT1d1cXhuQlVqZDFZblBvM1lwTElp?=
 =?utf-8?B?V2E4endKb21WQzNQaHlJT3ZPZFFXc1hpbStLRjBPUDZROE16TUFOVzNQVkx3?=
 =?utf-8?B?Qm1OZmFoMmNtbHVVY3ZkbStZek5wR2VFeW04UVdHbWNvMHhSakhxRTcwd1k3?=
 =?utf-8?B?WTkwbmo1QmN1ZXhveklyUjlxVlBtc0FBbjFQTjNXK3RTcU9zeXBIR2w2TmR5?=
 =?utf-8?B?UUJrazBPWHdHamJxTHV1d0IwV3IvbFRDM2JPYXdiLzZiZ0NXV04vUWVGdVk0?=
 =?utf-8?B?QlExV25nQnVUUjQveUljbUIyS21CblV5UU82MXJ3bWJ0b2JxSU5zODJKY0Nq?=
 =?utf-8?B?TWdSSnM0NDFhOGREVENPUmhHeXR6T3hMZDV4WVpvc2tiTDhLc3RJS0FpdVpx?=
 =?utf-8?B?WGpLUUszeTZtbEV3UzZSeGNRdDJzZGt2eXVrNW1zUlFGRkhiUlRXYStCTm1F?=
 =?utf-8?B?Zm82WUZXNENwU0JXVC9jRmk4L3Fzc1JSQVpteEJkYm1DVXdhUWtMN295aU1o?=
 =?utf-8?B?QktnaXIvbXIwdGhPRlMyWWlteG1rVklLSFZTS3ZOTDV6a2pYNTByVHhmM0N6?=
 =?utf-8?B?NnhhU3ExNExjQjArSFhzVmNoVGJQc1pyVDdUYmtVaTNBM2JqbVVNamd4QjV4?=
 =?utf-8?B?Y0tPS3VKNFFPaFRDKzFFSk01WHBtTE1PbmRXay9ob3Jva2pDejd1RkhKaStJ?=
 =?utf-8?B?NzU2TDFLdXlFZkNKZVo3M2NORHdYNElaNjh5UFBKU0FEd3NaOXhLYlk0eTdF?=
 =?utf-8?B?Q2VjMUI2SWxQUUs4UDEzY2pwN0lqNWFMSW9HbUFMeVB5VEo1bzRyVndxNGEr?=
 =?utf-8?B?TVRuWUpTc0d3VWdPNTY3dkdmT2VTMG1pbWlWNFRkS1Vwc1dxeEtmbm13Y1hR?=
 =?utf-8?B?TGkwUXBRczZSUE44dWNuTjFSL0IvQStHeU5JQlVqWUM1MVpHdXpiaFJqbHpW?=
 =?utf-8?B?Y2wvSlpnMGFHSGN4U1lVTEQwTmVlbFlQOTN4d0F1RHlxYm5hTVUvK1BYUzVv?=
 =?utf-8?B?djI1MWtpODNYSDJZNjBtMTYxYW1MbWJCa1VmM2dSL0QwdFhjU2xpNFBXbHNn?=
 =?utf-8?B?OTBTdWFhWGxMbDFBeE51NVVacEtjY3lIbzFMNkhPejV6eEZ0dFlEOXVCeW96?=
 =?utf-8?B?ejV0cThWbzUwU2FvT2lCWEZlYjB3djlwaUNrYUk5bEpLWkpuMUNRc3htTDdx?=
 =?utf-8?B?ZUtJWWR2elMzeVJ0ZjRWajdZdm4wZ0N6NmRUVlNiQUNlS3pqc0QxUmNGaC9X?=
 =?utf-8?B?cHhNUWUxRjhncTVVZWV6anhiMGsxMUp2VzZ0dE1IUU9pU25WZCtlRXlnVmNY?=
 =?utf-8?B?b3lVL2R2bjYyOGdNTjdYaFFzaUFCcWRxaE1lVFQyZVRhZVhHWU83UVZCQzFV?=
 =?utf-8?B?cEozNmc0a0RVYVlOYVZpZWMxcUh1QnB2WEN0aTJJUjR0QnhNV3pNWndGdTdp?=
 =?utf-8?B?T00vMFZvRmYvc2pqNjBVUzgxc1BOdG5zd3RYaFRqWnpTYTFkSXhKU0tDVFZa?=
 =?utf-8?B?aFIvTEZPMXNReUo1SDkycjZFQ21sRFVYNlFtbFFCUWVkOHpKckxxbUx1UFBw?=
 =?utf-8?B?THllT3ZqVVNLSGN6RFhUbWR0OGJqdTZyQkhNK3FvOG10d2tkZ2w3WFNTdUZG?=
 =?utf-8?B?T1NWNExtaUZ4QnFZTHVlSXdYQXRVVlRPZWdMdDBGRFNFL1dvRG9tUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfcc7c9-23ff-48f4-55d5-08df0f7ec29c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 21:02:01.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIDCaoEut8ct8KVWsrn4k8XODnIBJ08ABABLXzKLKXev0fd9hsBnSeHV86eYkWnLv5F1gLtgFVZj+ef1rMUJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348



On 9/6/26 22:58, K Prateek Nayak wrote:
> Hello Karl,
> 
> On 9/5/2026 6:37 AM, Karl Mehltretter wrote:
>> The amd_dynamic_epp command-line parameter was removed. Dynamic EPP
>> is now selected through the per-policy energy_performance_preference
>> attribute, which is already documented.
>>
>> Fixes: 32692fcf61ed ("cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and "dynamic_epp" sysfs")
>> Assisted-by: LLM
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> Thank you for catching this. Feel free to include:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 

Thanks, applied to my amd-pstate bleeding-edge branch.

>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 7 -------
>>   Documentation/admin-guide/pm/amd-pstate.rst     | 6 ------
>>   2 files changed, 13 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 4a12805a50ba5..1fa37bce5bb3a 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -499,13 +499,6 @@ Kernel parameters
>>   			disable
>>   			  Disable amd-pstate preferred core.
>>   
>> -	amd_dynamic_epp=
>> -			[X86]
>> -			disable
>> -			  Disable amd-pstate dynamic EPP.
>> -			enable
>> -			  Enable amd-pstate dynamic EPP.
>> -
>>   	amijoy.map=	[HW,JOY] Amiga joystick support
>>   			Map of devices attached to JOY0DAT and JOY1DAT
>>   			Format: <a>,<b>
>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
>> index 6fd72ba52df20..4c5d3d8acf645 100644
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -481,12 +481,6 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
>>   always be advertised by the platform. But OS can choose to ignore that via the
>>   kernel parameter ``amd_prefcore=disable``.
>>   
>> -``amd_dynamic_epp``
>> -
>> -When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
>> -autonomously changes the EPP mode. The default is disabled. It can be enabled
>> -with the kernel parameter ``amd_dynamic_epp=enable``.
>> -
>>   User Space Interface in ``sysfs`` - General
>>   ===========================================
>>   
> 

