Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE75484254;
	Wed, 23 Sep 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182755; cv=fail; b=ip0V6lOyLXBg+S8vVXFMYElYTmEiXlhIYZAlPQNDidqVezORqyILzfQ2hNaitTjiDtg9LP0/oXDKQzsNQxd7T1ueecbl5PwT2d8kFnnxB9fpBFyOeTmOy0paRGrbDzMcI7ehZRbFJ9+vQzmKDZF6FmU462hrI1iJneItXZI00Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182755; c=relaxed/simple;
	bh=InHNNAsu60aScPiwUas2mRg+KxhYhblhq6q0meoHT10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s30JY52f+yFgsFuM4mqu9h9Qp5pfnv3cWWFUz8J+V3BHLF5ih2NjoTdFy+IrW2Tp5ZPWHTy8iLbyFS6GqoIjiAkZUFTOKmyDUdKUqxSSl94jg/q+Ezw0UWfpjTI/KrYEnRXkzrvf4P2gVFF+HCiGQaXMnSabll/ZI2Oab6ydDxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2xwTlFD2; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2xwTlFD2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyyY8xYcH7epHMFzbw1p/p+/p+jcc9uUPnhXNUF8pbKl6Uyx0+qhQb9FitjUqKhZ9zWohIAZ15EIWTh/LK2HQV1Vhcdr8U+d1xTksGMwhQGnzGBLw7AnkgG7x1tDWS/BA/gv2A29FtJbvtXmonzljq3k53BpSibCIq8CWtOrhXIgSsv8z0F7utFYLgqrNoDVGUEghskn4htG79vMROpqsnPWun0pmPDB11qVdF1f3oPIZwV1mR4GKjMi2eD0YM1zuIVpIQvHSJhGHFp+1FUJLU3TTvnyPtcUfDBRa4lfhv9VMFcav1urXsRpJ2bQPgfgMhqk14Vgby8xFUzLpL3q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tB9xfPxVQPxQeahf+giJ2euEZLWhnio++i0pwDcBxo=;
 b=uy42f9L9+tMtbyvE3v8XLCgqi4tyau0EHX2XkFyOpEYww8NixW81LJ1nq/uAyRxdx0AhmApn/ODl6WP84F8saC++ZJxMIRdrvkSyACJhjo36vP2evLwmEHTBKfKITG3+Z5KbyeGJdyqtMqgizHs+Ilc7QZm+Ug4CbupeQUnHAGJ47p+bJ4NRvGTYERL4EAXJHKmGiEjPT2M7tTqCXyEW2FmVrc1QY9yiVZIwMt5p8ujDwIZO/i0gBRayJBLZ2A49njesKFuWK0yK6prMGgR0GzAbLSJTdXyAgj8NUJqsTdLalwMxI/NhB+AvdrEsZl3cD4cQvyWwkNtVYNy0gx5WRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tB9xfPxVQPxQeahf+giJ2euEZLWhnio++i0pwDcBxo=;
 b=2xwTlFD2AyChGntw8rBLWoivHmx4e5IFTVYQhMgmU7OvAKL4vtQAmhaI9PWpJewfdCOjRbVKmOWH7VIJFql4N+sGkCsSkFEoJIKJehOeb7ldmTEMjj4Yfd133jDp3/WTCOBVZkQRGX14Rgjxmk1gCe+1+O4EzCBQAKYXacnj+V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:59:10 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:59:09 +0000
Message-ID: <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
Date: Wed, 23 Sep 2026 11:59:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
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
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
 <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
 <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:610:5a::12) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf4fdd6-9c6f-435e-1f97-08df1993fc25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|6133799003|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UFU8dkYRfqeF2ylbVol/xSKa/JE/girSVJACRgRcJB7/fRi5N8WvIMt2JIdFt3o7lLpI+TKHF7AsuMzW3cSD84idrYNSwTKXaub2/1v08OeK+d41oVfRaRIw9a14PK+0ejfLNA1D/Z5m+CA9kZlTai2hrA0qgkkfocJzsPtXWVmWv//Bj+OyKVLj6p2FFxFFtpgMbf8pcRgnyl14CMXgC73nP0DGIaOVsQC8YK3OI2gltATYsRNT4BzHWFDfgYOZszjDm44eOAYUIn/siCtZtQaPo+am+sc/PbaZOCv1/neWjV4/wqTdImWI+eyKBs3V4aHewtylHrNVVhhdcw5btWup8lPICgdXCwSLlwphwuNM3EMatnj7fmRCg37OQqBZwWsDtVrc8C6QQyxDSCZUYRGW/rcYyLI8Y8QkEZ8o2yLaxqsJw4yxC/tCTzYmD1mCEdqrwpHlDRaSE1tRnO279UPzBFd1bTx8wRoZYJSD/5dXCQ+jUZuLNFhwKyy1dS0JI0LiH8TtUmeAQXFM6RP8BxTMbNZyxCFaqYMmeeg2xFkknUHXLOEQOj3w/Eb3h5yxjUUCfcXebeTRsprNYiBx+nKUXAT7TO0KimOj4Ui/x8f2ugqxxFQmJ2F9cdqKR36gAHyuhjfZbvwNN8jNFguezz5bpMhFZaNnGYAsGuQKrZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXJQQ0VPbEpNUTRFSWViRkVOOGFDQWxHL3NNQ3E3V1liQk5ZODVXMTd1cnVV?=
 =?utf-8?B?OHRDY0gzelNzcGttV2tnUFkvNVBQSzJwRjRwRTdHU1BscHBrSnNyTE1kWk5i?=
 =?utf-8?B?RFlDdG5PR2VlUUR0VndVeTVIcXJPLzExR0JhdlNkeW1RUzZ0c0NXUFpFWGtS?=
 =?utf-8?B?dzRtRjVndndVOG5HRy9kcTl2VEE1aVIwdzI3Z3JjdEtvRko4WVR5YjFPK3pu?=
 =?utf-8?B?TktxQW02cHUyVVl3dUovWDE2ZlNnYXhPY21QeEVuRW9UQUFCZk5yUUN6Mlp0?=
 =?utf-8?B?QlFXOUs4dGhhamdDR0VERVcyY01ONXJPUVRFZzBkM1JMZGF3UnAxVmdKaHFo?=
 =?utf-8?B?K3hJbHFyYWp5aTdpdytia3ovTFVHVlhUQzN6OWVVdXc3Ly9ZMW85OXRrRzVy?=
 =?utf-8?B?Q25vUGFsN0M5R29ncHFETUU4RXNhaE1sOGk1eXhYLytNKzFDVzdBN21xSUQ3?=
 =?utf-8?B?Q21TYk9aNFFnYjN1eUY4Ukx2ZUpPUkxoRERULzg3NGlwRHdJRzA0Mmt5UWIv?=
 =?utf-8?B?cVYxeVVITjBvcUsybncvRzJ3VXBSdWJxNVF6bGw5MGpRc3pReU1hOGlKdnJQ?=
 =?utf-8?B?WC83S3dLM0VFZFBmMHVFTEVXaDZNTGJyRjVYdTZEL3VyVmxPa0JSL04xUm16?=
 =?utf-8?B?SFR4eEJsYjVRU21kSTFzdDBYaDUxOHUyUjdPV2lJRGVqZUdoWVRyREtyODNu?=
 =?utf-8?B?SGRmMFZZUnpVQ1oyTVMrT0dxYllZNzNWWkg5Yk5nc3MvM0lLcWZQU01sd2Js?=
 =?utf-8?B?WHF0U3ZBNGZwZzE3bWtDTFJhUWpmVDBIN1ZZTmVlU2ZqS2JRZzBlSlBhKzZG?=
 =?utf-8?B?VTFQaUhpNkQvK0NFN0JMekRYVnVLVURDaHJDWkludW9UanhrQUVpaUhuaVdS?=
 =?utf-8?B?dUhtWjB1QmplMVBvd3FKcnVybjJlNGhDTkpQNkNTUXpMNGhCcGZvT0V5WW5N?=
 =?utf-8?B?RmxyZXhrdmYxQVRXRVF2SnpWR3Zja0tFL1hORVpHaUJGV2tJRUFaTVh3ak9I?=
 =?utf-8?B?QUh1ekFZZGFGRWlqN0pYOFpncWpsRWt3U0tTTzFnelBUdlVDMTV1N3RnYTBv?=
 =?utf-8?B?VHZZK0ZJZVVTbWswTVFibzBKNGZVVG03VHdxM2UvSG1oWDRBU09IL2pHYTNK?=
 =?utf-8?B?WS93RHVGS1NSUE5pRVF3WDM0cTJhUkE2NGtLR0lBd2pCVjJTNzdJZElCMC9p?=
 =?utf-8?B?anp4NGtNYmlsaSt3MjJ1dlJrNkVwUWVUdm9qdVEvZTI0R09WQmY4bmQvcmdY?=
 =?utf-8?B?dUpIckkxRHYrWmUwK2xzdHFzd3Z4Z1J3Ny9YaW5pWHh5Q0YrRnd3MFZEU1g5?=
 =?utf-8?B?S2RnVDIrVHppSkg4bHpSN1N4QjdUUmNmVHNHT3gwZ2lqd2tUTXhYTFg5WDhz?=
 =?utf-8?B?TG5tSkdPWjg4TEFhVEs2enRtSXJrdjF6Rko2WTNyTENnM0hNc3M1UXlneXdX?=
 =?utf-8?B?dmlRaHZOdUJ5akp6RXBNM0NlaHJaZjU4Y0RYalJLM0taN3dXTnRYNWlBN0Vt?=
 =?utf-8?B?WCtWTk5DYklUYUxCYnBuNnNCNm5OVUVyeGpIN1kzMWo0WkNLWDd5Z3AzWHFF?=
 =?utf-8?B?MXRqam84cUg1cUNkelZMdDN5aWNtTHFqUUx1cmdBd1ZRRmNSRC9lbWtvdm1w?=
 =?utf-8?B?RUdTNC80SENCUGlJM3IvQjRORzdNSWU4bjNCcXVaaHFwZFVFS21MRWhsNGNw?=
 =?utf-8?B?TFJXRVZLcmd5WGNwV3RXeWt3OUo4bmFPVjRUbXBZQU9Edmx2TmhUQmVHVWsx?=
 =?utf-8?B?KzdXMHZwRGdJaTlaSFBhVlE1YWtPK3crQjcyNnV6ZTBtUnFpOWhVYjcrMkM0?=
 =?utf-8?B?ekRDMW9pdCt3dGV5YWYrYlRhK1VhQ2QwZTFyVEpvR2R3NDRNNkE1aHd0T3Vn?=
 =?utf-8?B?WHlqSzdvRXoyUkJ0UHAyNUo4b1ZvSTZyQXY0ak4zSjRRWlhBWllYVWVaeThN?=
 =?utf-8?B?Q21vbEpHS2R3T2JKYVlzUFp2K2F6VVRmUVB3dEtJVUVoOHdQWFNLeTJFYmpj?=
 =?utf-8?B?cVRTTmRwQTBtcU04cmJESmk4QlhGR1VHK1dpcWlWbWcrUFh1RGd0ZXNUTkRk?=
 =?utf-8?B?YXlyVHhBTHYydERWVlhFU1NPM1BPQXh0bWNVajFGUXpObVRxTVoxdXpiMGtM?=
 =?utf-8?B?TVM4NGxNakRCWnFwVFVYYy9HZVVPTzlBd3k4R05zQUJ5L2lhRmJ6WW5MQmNs?=
 =?utf-8?B?T3VtS0ZhL211NGppemtFbTA2OTlMK052N0ZqMy9XZ3V6ay9DNFZXQ1R1dGpY?=
 =?utf-8?B?ajJuWkNXSjRNRWUzQjdRUDUvWkhrTWpiRlV2V2FLL3N5VVhENVJYL1ErTmY5?=
 =?utf-8?B?ekVMKytndTRObXhJdkpIVGdBWkswenB4QjlYMVFnMjNmeXlHdEtwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf4fdd6-9c6f-435e-1f97-08df1993fc25
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:59:09.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A8PkihiMh8MS8AUW0Bs0TDmfeBx7sJrj6aEDJAgwCxEAhXiq+/jgy63E0cgU+KUrUSYfCCGBDqjaqugajipHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830



On 9/23/26 11:54, Fourhundred Thecat wrote:
> On 2026-09-23 18:41, Mario Limonciello wrote:
>>
>>
>> On 9/23/26 11:37, Fourhundred Thecat wrote:
>>> On 2026-09-23 18:20, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 9/23/26 11:15, Mario Limonciello wrote:
>>>>>
>>>>>
>>>>> On 9/23/26 11:12, Fourhundred Thecat wrote:
>>>>>> On 2026-09-23 16:36, Mario Limonciello wrote:
>>>>>>>
>>>>>>>
>>>>>>> Some other thoughts that might be the root cause based on other 
>>>>>>> historical issues.
>>>>>>>
>>>>>>> 1) Have you changed TPM policy or Pluton policy in BIOS setup? 
>>>>>>> What did you change it from and to.
>>>>>>> 2) Have you enabled a storage security password?  If you disable 
>>>>>>> it does it help this issue?
>>>>>>> 3) Do you have WWAN in your device?  If you disable it does it help?
>>>>>>> 4) Does booting with `amd_iommu=off` help?
>>>>>>
>>>>>> 4) amd_iommu=off
>>>>>>
>>>>>> Yes, that fixes it. With amd_iommu=off and all 24 CPUs online, 
>>>>>> suspend/ resume works reliably.
>>>>>>
>>>>>> So this is not really a CPU count problem. nr_cpus=16 was only 
>>>>>> masking an IOMMU interaction. But narrowing it further was 
>>>>>> surprising: neither of the IOMMU's two functions is responsible on 
>>>>>> its own. All of the following were run with all 24 CPUs online, 
>>>>>> and I verified in each case that the parameter actually took effect:
>>>>>>
>>>>>>    amd_iommu=off            IOMMU off entirely WAKES
>>>>>>    intremap=off             IR off, DMA remapping on no wake
>>>>>>    iommu=pt                 DMA passthrough, IR on no wake
>>>>>>    amd_iommu_intr=legacy    legacy GA mode, IR on, DMA on no wake
>>>>>>
>>>>>> Verification for each:
>>>>>>
>>>>>>    intremap=off           /proc/interrupts went from 58 IR- lines 
>>>>>> to 0,
>>>>>>                           and irq 1 (i8042) is no longer IR-IO-APIC.
>>>>>>                           iommu still enabled, domain type 
>>>>>> Translated.
>>>>>>    iommu=pt               "iommu: Default domain type: Passthrough 
>>>>>> (set via
>>>>>>                           kernel command line)", all 40 PCI 
>>>>>> devices in
>>>>>>                           identity domains, IR still on (58 IR- 
>>>>>> lines).
>>>>>>    amd_iommu_intr=legacy  "AMD-Vi: Virtual APIC enabled" no longer 
>>>>>> printed,
>>>>>>                           only "AMD-Vi: Interrupt remapping enabled".
>>>>>>
>>>>>> So only disabling the IOMMU outright helps. Turning off interrupt 
>>>>>> remapping alone, bypassing DMA translation alone, or dropping out 
>>>>>> of vAPIC/GA mode all still hang.
>>>>>>
>>>>>> The CPU dependency is still there on top of that. With the IOMMU 
>>>>>> enabled, nr_cpus=16 works and 24 CPUs hangs. Offlining cpu16-23 by 
>>>>>> hotplug after booting with all 24 does not help; the CPUs have to 
>>>>>> never be brought up. cpu16-23 here are the second SMT thread of 
>>>>>> the eight Zen5c cores (APIC ids 17,19..31).
>>>>>>
>>>>>> Both conditions appear to be required: the IOMMU enabled, and more 
>>>>>> than 16 CPUs brought up at boot. Either one alone is fine.
>>>>>>
>>>>>>
>>>>>> 1) TPM / Pluton policy
>>>>>>
>>>>>> Current values:
>>>>>>
>>>>>>    TpmSelection            = DiscreteTPM2.0   (possible: 
>>>>>> DiscreteTPM2.0;PlutonTPM2.0)
>>>>>>    PlutonSecurityProcessor = Disable
>>>>>>    SecurityChip            = Enable
>>>>>>
>>>>>> The TPM that binds is a discrete STMicro part, tpm0 -> STM0925:00.
>>>>>>
>>>>>> I did change this. As I recall I disabled Microsoft Pluton, which 
>>>>>> moves the TPM selection off the PlutonTPM2.0 default onto the 
>>>>>> discrete part, so Enable -> Disable for Pluton and PlutonTPM2.0 -> 
>>>>>> DiscreteTPM2.0 for the selection. I will confirm the exact 
>>>>>> original values in setup. I have not yet tested whether restoring 
>>>>>> the Pluton default changes the behaviour, since the IOMMU result 
>>>>>> looked more promising.
>>>>>>
>>>>>>
>>>>>> 2) Storage security password
>>>>>>
>>>>>> None enrolled. HardDiskPasswordControl=Disable, and the HDD, NVMe, 
>>>>>> Admin, System and Power-on authentication slots all report 
>>>>>> is_enabled=0. BlockSIDAuthentication=Enable is the only non- 
>>>>>> default setting in that area. Nothing to disable, so nothing to test.
>>>>>>
>>>>>>
>>>>>> 3) WWAN
>>>>>>
>>>>>> Yes: Quectel [1eac:1007] at 0000:c4:00.0, attached over MHI, 
>>>>>> exposing wwan0. Its power/wakeup is enabled. Not yet tested with 
>>>>>> WirelessWANAccess disabled in BIOS.
>>>>>>
>>>>>>
>>>>>> so please suggest which test I should do next, now that we have 
>>>>>> more info
>>>>>
>>>>> Of your above the most likely cause is PlutonSecurityProcessor = 
>>>>> Disable.  Please try to re-enable that and then try with IOMMU 
>>>>> enabled.
>>>>
>>>> BTW - what version of amd-s2idle didn't flag this?  I am surprised, 
>>>> we had a check for this that /should/ have failed prerequisites.
>>>
>>> Tested, and it does not help.
>>>
>>>    PlutonSecurityProcessor  Disable -> Enable
>>>    TpmSelection             DiscreteTPM2.0 -> PlutonTPM2.0
>>>    SecurityChip             Enable -> Active
>>>
>>> With those set, IOMMU enabled, no IOMMU boot parameters and all 24 
>>> CPUs online, the machine still does not wake.
>>
>> That's interesting.  We'll have to see what the report shows if it's 
>> not the Pluton setting.
>>
>>>
>>> Worth noting what that test also covers: with Pluton selected the TPM 
>>> presents through the CRB interface (MSFT0101:00, status=15), and this 
>>> kernel has CONFIG_TCG_CRB=n. So during that suspend Linux had no TPM 
>>> driver bound at all -- no /sys/class/tpm, no /dev/tpm0, and the 
>>> discrete STM0925 was gone from the platform bus. Previously tpm_tis 
>>> was bound to STM0925:00. So this rules out the tpm_tis driver as a 
>>> factor as well as the Pluton policy.
>>>
>>> Current state of what is ruled out, all with the IOMMU enabled and 24 
>>> CPUs online:
>>>
>>>    amd_pmf                  initcall_blacklist=amd_pmf_driver_init no 
>>> wake
>>>    amdxdna (NPU)            
>>> initcall_blacklist=amdxdna_pci_driver_init no wake
>>>    TPM driver               no driver bound at all (Pluton/CRB, no 
>>> CONFIG_TCG_CRB)  no wake
>>>    Pluton policy            Pluton enabled, PlutonTPM2.0 no wake
>>>    interrupt remapping      intremap=off (verified: 0 IR- lines) no wake
>>>    DMA remapping            iommu=pt (verified: Passthrough, 
>>> identity) no wake
>>>    vAPIC / GA mode          amd_iommu_intr=legacy (verified) no wake
>>>
>>> The only two things that let it wake are amd_iommu=off with all 24 
>>> CPUs, or the IOMMU enabled with nr_cpus=16. Offlining cpu16-23 by 
>>> hotplug after booting with all 24 does not work; they have to never 
>>> be brought up.
>>
>> No.  nr_cpus=16 wasn't a pass.  Don't treat it as such.  You didn't 
>> get to HW sleep.  Let's please not conflate changing NR CPUs.  Let's 
>> figure out what's wrong with all CPUs enabled and IOMMU enabled, and 
>> then peel it back if you need to turn off CPUs.
>>
>>>
>>> I am rebuilding now with CONFIG_DEBUG_FS, CONFIG_PM_DEBUG, 
>>> CONFIG_DYNAMIC_DEBUG and CONFIG_AMD_MP2_STB so I can run amd-s2idle 
>>> and send you the report from the working nr_cpus=16 configuration.
>>
>> So you didn't run it yet?  I thought you said it failed.
>>
> 
>  > No.  nr_cpus=16 wasn't a pass.  Don't treat it as such.  You didn't get
>  > to HW sleep.  Let's please not conflate changing NR CPUs.
> 
> Agreed, I will drop it from the framing.
> 
> That does leave a gap in my own data which I should close: I never 
> measured whether amd_iommu=off reaches hardware sleep either. I only 
> recorded total_hw_sleep=0 for the nr_cpus=16 case and did not check the 
> counter after an amd_iommu=off resume. If that is also 0 then nothing on 
> this machine has ever reached s0i3, and the wake failure is a second- 
> order effect rather than the thing to chase. I will measure it.
> 
> I would also like to confirm the counter is meaningful here before 
> drawing conclusions from it. max_hw_sleep reads 18446744073709551615, 
> which looks like an unpopulated value, so total_hw_sleep=0 may be a 
> reporting gap rather than a real zero. With CONFIG_DEBUG_FS and 
> CONFIG_AMD_MP2_STB in the new build I can read /sys/kernel/debug/ 
> amd_pmc/s0ix_stats directly instead of inferring it from suspend_stats.

I don't care about max_hw_sleep.  It's a hardcoded value.

https://docs.kernel.org/admin-guide/abi-testing.html#abi-sys-power-suspend-stats-max-hw-sleep

> 
>  > So you didn't run it yet?  I thought you said it failed.
> 
> Correct, I have not run amd-s2idle yet. 


That should have been your first debugging step.
