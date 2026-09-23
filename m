Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57040544D4B;
	Wed, 23 Sep 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181741; cv=fail; b=ty+0gObE46/Xvcmm90flFEBQ+NyBJac+Ap2Rl61alP5Q01R/ms+r+3qO/gjRUcfx62p1lzQosa7tXazfPEdzT+MxjggjT3El8HMMUcR8ZEKpYK7Xh9p8a/yzFlZiPn/Xj6LT6kl/rR8k2xwBYCeWg48LShk6LEUx1oKLkoT9mlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181741; c=relaxed/simple;
	bh=w4/DZcK/64KxK07D5QMgwXG8KhocPf8rsFzkhI4q4OM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pGp//hxmeIP90z+N239MTD9S1zJdttdjXzw+erVDTenI5HHLAYIv3v0JzJAiQY2kVo69LrXnHo2STDHHI6E51mzi4hNfLCUxCj2nS8g4ncIy2aaTx3BkW3nrK31cH6tyvy4+ivwe9WO2KpTiPvkCrpiIy4WDuRAf+clII5xQ35E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tnHRuv52; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tnHRuv52"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7ES4+VZmeIvyQDNzy+d/nmmUNCQWDKzFZNNvz9EtYru3uQAZ2odQgDJuuQyp2drNYuI7I6IAAAX84pCff897IE+ugj/lelYsAmy7NilhPlw/DMF+oHABs65MeCOhbKNZtLAN4r33Wy6EkDJOfGWUHJRfoctqNX5ga0RK2cA0JBP+TKaNmtkVYVNjYTOjYxFI5OxFrPeKQ7HaddayDR4SbZHJDJV56hsOhmEuBwwBoC4YhHfncjC25cJT/YlzF0WSUD97EdyKVgNPaq4XkNI3Y718f9qlq9EpNYCmDAJV67XFvL4dmIhcFmV8NalMkE8M4Zp0BZQ5ZpvKFjA7GfQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgLdPobm6fwaZrBQPoP9CIaM69QNq6VTgLfMVbwQbok=;
 b=QBDTCIh/A8ibiXO8+1xeSHdCjQGgv+kWVSCyM3O/TrkoQ3duLWEaXnBrau/zEZ9KnS/7GWtRYEqHTEPyotvu/ofCQuKlAxeOxe4ThRycOrNPJqNPOBfTGhbNk280ZIjlLEozL5GuS6pLnlec3IKvVwnoZrzwmXGMxlHfQ3B+J6L3iZGCr9vIqBuXRb5XmE7MdIDwBOmWVSsBGOJp10hK6/cD1GABPlNAuvw+2JAYdd0YmDGBwjTu1rikTW41XBxlpPgjUjcEY5GaTQtNj+sUaFGlzZnzbt3i0Z34sdXeP1yCatDye2WoMPFI4XtBVamcP+eJ63dI37Yh9a3vqvu9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgLdPobm6fwaZrBQPoP9CIaM69QNq6VTgLfMVbwQbok=;
 b=tnHRuv52ea4eZNyOoMB8BTqjdl3YczPCKsnD577CdJvcS/p9UXPGcOrJWs9hoFSSAxp2XCMq0sC76OxPEYc6bz652Lt4wiGbT3x2kaUX/oqzfNKnjBiWG33Qs8qKB4HgWCi5VHI6b7jy8leGtzCQQcU2CFO3JG0gw3EP5f+SgV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 16:41:57 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:41:57 +0000
Message-ID: <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
Date: Wed, 23 Sep 2026 11:41:55 -0500
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:610:e6::29) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 3528b5c7-10e7-455d-c484-08df1991953e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dZXseZDm+V6Jpe7cSx8xkEoVG5PsPLtOXwHOgx0Q2pzGrSTj7+AeNHsCvvE7zNzB+vQZ2l0NFDSLRUI6tgCpRNQJnt7anwcrCrvnxitFc71/P5Ed8GkDaS7/OJnWFRzOkMXspqGmth/Al7XdD7Vq/uZjzzUPNXhsfyx+HzmqxY2n9ywVwGXj+OJqFXUjboEZE62nJqdbA9qlIF5iFYZST7cxOMX1bHcd28lWtsLF0epFu3r5Iqal/CIiEd0AcK3hPvL9CTuvqq7JdozHk54CnZVdAdcrDC/27l4n1mBp/URUblfvF/4TO51e3cU9A56EklGmsGlrj8ro+TGKX2Lbl7M62w6K7rqxOnd4LLWQskxQyNxRM77TYjvf551aBsicDS35Ky3iUoZHAxFK6y+6yQsy2Y9n13l/nE9ebbObBHWz0g1fEsMC8s2HGUox09CveFgg9n3XW6QkIEoGGWW7pxAJYTNt9a7v9eiKH2TxaCLvWPVnUjL6vibZoyLIuBevoWWJNKn9wxOjjHVOuXlBtdt+1Rp/sDbuxs90GlmiAg40SsACROuPKs3F5VPoYyd5mhI+hakdXf52Wb50sQkCgAfIsOc2lp9+WVDIdj/ftIZc8rsrNBGdGRJLf38PJobNN+5bOgSqro3RERDs1cLEReXvOi5M42FvdeaycRDtpXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3lma3psWU1PMldyOWlGaXpXVGM4REpBaWFZbVdHbzdhOU4vb0lsUDVvV2xV?=
 =?utf-8?B?TWwvQTFPYjhScHJqTW9lUk1kOWxnU3lrVVJPWXlROVR6OVZjOEE2K0tvellD?=
 =?utf-8?B?SmVnN2ZTYS9tQXI3SzIzbG1jYjYxcHQvbThDeXU5ajlHV2ZpcGRQU2JyeGN2?=
 =?utf-8?B?cFlMK1Jxd1ZOS0FlYnA2V1NoOGNPbCsxc1o1NVY4ZXBwSk9yR1ptcGNqUzk1?=
 =?utf-8?B?a0Q1Z1l0VnorZUhIQU84anAvODc5eTl3dUNxM3NVSFZVMEF2ZXdOVXNvSE1j?=
 =?utf-8?B?S2pzSFBObWFSMUFyMDlQODdpS0pZUTE1M3FXbVhTWDZjdENrcHU2R29NS3BL?=
 =?utf-8?B?a3l6aDl4RXdIanJ6djlQaERydmZidFd1M2hTdkw4TjJib0NIRmo0QlhxNndY?=
 =?utf-8?B?cWlLaFZUa3d2V2tFOGRPekZIc2hoOTViaGthbnl1MlVKQy9JQ1NTYlQySWFZ?=
 =?utf-8?B?dGhlRUxSaU9ocXhTN3pmNlRrbGk2YWlwYU1sYjJic0M2c3lSblFHYitBQ2N4?=
 =?utf-8?B?Q01uVjJ4TUZNczdHZitmdllzRit0ejJhTXJ0REVGUk9TSlltT0E4dVQ0MHVu?=
 =?utf-8?B?bFJNWmFmQTRwR1JXOUJkMWxQWHJJOWdiMGNYQnJWcjRnL3ltbE9Od1RYTVlU?=
 =?utf-8?B?QWZKYzdnU2ZlSVM2OFlQbndMTURxdVAwM0thSEdsSEk2ZzZCc2pXS1B6VHEx?=
 =?utf-8?B?b2VLU09Lb0xSVFFyb00wMUcwbHZhempaanpRU3JkbmVIeml4aU9EMzE3Q2xq?=
 =?utf-8?B?Z0wyR1EzczRkU053VlIxc2ZJRkV5N1dvSlZrNWVxSk5JYWV4YWNMQ2NJZGpl?=
 =?utf-8?B?bllsZHNQOUNIRHNDeFh6Z1I3dEtjN2ZjOEhuVnhhNGwzTnErdTBqWkkva1BV?=
 =?utf-8?B?T2wwNUFROEZhS2ladGF3bFJuL3pXRzJpTVhNM09Vd0tpRlIvdXBmZDdvdmF0?=
 =?utf-8?B?eUNWMVVqVkovRi9sSnFoNHMvUzU0bGhxb0hIRjN2SkExSEhwSG9lazIwTTQz?=
 =?utf-8?B?VjBKQm45TXhsWUxTVVpvSm9Fd1ljMzV4M3JLWVg0T0NDWU9iT1FCQmFzNncx?=
 =?utf-8?B?RGxRbGFFeEdabkMzSUdpRXZ2VjFOVU5EckZVK1NteFlTZGk5bnJoYWpZTi9o?=
 =?utf-8?B?Qi94cGI3UWdKVlUwdEhCdS9KTjlvNUExRG1PRlZpUEhucE9EQ1FKSkIzY3ln?=
 =?utf-8?B?MWxkRGthZS9JSmMxOWRUN1c0dkhxWGh6SWQ1NnlnVEdSRm1IbFlzNjZieElj?=
 =?utf-8?B?bjh4cFpML1FWcFNlOVNEWTBzbStLRmhGSk55RVVyMk1CUU1mMTAxSUZMNytH?=
 =?utf-8?B?K3dDSzd2MTJrckx2Z1AvSHcxUVlueVBFY3BLS3hnK2xXVnB5SEVybXI0YkFV?=
 =?utf-8?B?Tm9QRjFxVzJBOTlEN1BoSnBTWXVpUlBtWE82Q2t2blp6TGE2NEhjY1pTTVVQ?=
 =?utf-8?B?U3R2ZFBkWGgySjEwT3FTSzBaNUVjSU5YNU5BVXVWZGZ3ZXFtRVV2UHA3Q2tu?=
 =?utf-8?B?aVlyMk1Pak1SZVVMMUw2U2pvZ2RHOU5abUhZWTk4ZzJkRXJaUTAxOTJ1T3RF?=
 =?utf-8?B?MUJHQmZja2FLL2dHUGoraW5DcFVYY0dLVzN1ai9XMTI0YUtkS1R1RGQ3TlJK?=
 =?utf-8?B?NTdjNFJzUXhjaFoyaGtMVG9xb2FOZXZvZklaUHAra21ZVTJ6ZEVPRm8yNXcr?=
 =?utf-8?B?Z0lmWDZBeE1zTzZzZkowVStkdjJkNlJQQUxIWmFJd2NhQVFoNjhKQ1hUT1l3?=
 =?utf-8?B?ZXNZTHdCUW9SN2JPb1V1a0xNdVB5RnZmQXgzSlIrdVExMis2cW1OWE5WOENH?=
 =?utf-8?B?R3N5ZGZZR29oMFZIT1l5aU51TThaRWFHWGpPajYyeWp0SDFWV2Z2OTl6Ynhm?=
 =?utf-8?B?WmEvUlRqdmE1Zk04bDFqbFQ5aG5Ld2F0T21YbHZDK2VLUW5WNldRVU1BVG9G?=
 =?utf-8?B?MGI3bXRVS2pmMUZpdWtMNlhidDZUM1o1N2ZMSzNOM0d2QUFqWDF4OVpna1ZR?=
 =?utf-8?B?OU9Na1M3Zkt4aGhsUU9KKzNPN0lwZHpsTGZvdkpGOTRQNlJjZDZPWmo1c292?=
 =?utf-8?B?Nlo1b1Exa1Awb1M1OXBuc29ZdGJyM1RPa2xtcWlxZHZnVDZRUlN5a2hIQXpr?=
 =?utf-8?B?aWEvUGhQMEVadWVBY1FWR2V6UjRidTB5V3BKTmtzeVlHcUdSaEprdG5KMTJ2?=
 =?utf-8?B?ek9zdFRaOGl0d1FTYm50V042K1o3SWxxV05oM0U5TEtNTll3VjBVc3NHaGpZ?=
 =?utf-8?B?THNPcXBYckJvK09BQzRBWTFqTnNaRG9FajlNUXUxUDhjcG5OOW1GZGpFZy9V?=
 =?utf-8?Q?/0afdtHm5FCF+e8ist?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3528b5c7-10e7-455d-c484-08df1991953e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:41:57.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaldQQMmZyHWWp3Ztq7GVrlt5jYDvGC10HpZ8wj/Zt2gOPjIawsr3zwiP0S5p0V7mqEu4aq/as3btU+9ru5vBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058



On 9/23/26 11:37, Fourhundred Thecat wrote:
> On 2026-09-23 18:20, Mario Limonciello wrote:
>>
>>
>> On 9/23/26 11:15, Mario Limonciello wrote:
>>>
>>>
>>> On 9/23/26 11:12, Fourhundred Thecat wrote:
>>>> On 2026-09-23 16:36, Mario Limonciello wrote:
>>>>>
>>>>>
>>>>> Some other thoughts that might be the root cause based on other 
>>>>> historical issues.
>>>>>
>>>>> 1) Have you changed TPM policy or Pluton policy in BIOS setup?  
>>>>> What did you change it from and to.
>>>>> 2) Have you enabled a storage security password?  If you disable it 
>>>>> does it help this issue?
>>>>> 3) Do you have WWAN in your device?  If you disable it does it help?
>>>>> 4) Does booting with `amd_iommu=off` help?
>>>>
>>>> 4) amd_iommu=off
>>>>
>>>> Yes, that fixes it. With amd_iommu=off and all 24 CPUs online, 
>>>> suspend/ resume works reliably.
>>>>
>>>> So this is not really a CPU count problem. nr_cpus=16 was only 
>>>> masking an IOMMU interaction. But narrowing it further was 
>>>> surprising: neither of the IOMMU's two functions is responsible on 
>>>> its own. All of the following were run with all 24 CPUs online, and 
>>>> I verified in each case that the parameter actually took effect:
>>>>
>>>>    amd_iommu=off            IOMMU off entirely                     
>>>> WAKES
>>>>    intremap=off             IR off, DMA remapping on               
>>>> no wake
>>>>    iommu=pt                 DMA passthrough, IR on                 
>>>> no wake
>>>>    amd_iommu_intr=legacy    legacy GA mode, IR on, DMA on          
>>>> no wake
>>>>
>>>> Verification for each:
>>>>
>>>>    intremap=off           /proc/interrupts went from 58 IR- lines to 0,
>>>>                           and irq 1 (i8042) is no longer IR-IO-APIC.
>>>>                           iommu still enabled, domain type Translated.
>>>>    iommu=pt               "iommu: Default domain type: Passthrough 
>>>> (set via
>>>>                           kernel command line)", all 40 PCI devices in
>>>>                           identity domains, IR still on (58 IR- lines).
>>>>    amd_iommu_intr=legacy  "AMD-Vi: Virtual APIC enabled" no longer 
>>>> printed,
>>>>                           only "AMD-Vi: Interrupt remapping enabled".
>>>>
>>>> So only disabling the IOMMU outright helps. Turning off interrupt 
>>>> remapping alone, bypassing DMA translation alone, or dropping out of 
>>>> vAPIC/GA mode all still hang.
>>>>
>>>> The CPU dependency is still there on top of that. With the IOMMU 
>>>> enabled, nr_cpus=16 works and 24 CPUs hangs. Offlining cpu16-23 by 
>>>> hotplug after booting with all 24 does not help; the CPUs have to 
>>>> never be brought up. cpu16-23 here are the second SMT thread of the 
>>>> eight Zen5c cores (APIC ids 17,19..31).
>>>>
>>>> Both conditions appear to be required: the IOMMU enabled, and more 
>>>> than 16 CPUs brought up at boot. Either one alone is fine.
>>>>
>>>>
>>>> 1) TPM / Pluton policy
>>>>
>>>> Current values:
>>>>
>>>>    TpmSelection            = DiscreteTPM2.0   (possible: 
>>>> DiscreteTPM2.0;PlutonTPM2.0)
>>>>    PlutonSecurityProcessor = Disable
>>>>    SecurityChip            = Enable
>>>>
>>>> The TPM that binds is a discrete STMicro part, tpm0 -> STM0925:00.
>>>>
>>>> I did change this. As I recall I disabled Microsoft Pluton, which 
>>>> moves the TPM selection off the PlutonTPM2.0 default onto the 
>>>> discrete part, so Enable -> Disable for Pluton and PlutonTPM2.0 -> 
>>>> DiscreteTPM2.0 for the selection. I will confirm the exact original 
>>>> values in setup. I have not yet tested whether restoring the Pluton 
>>>> default changes the behaviour, since the IOMMU result looked more 
>>>> promising.
>>>>
>>>>
>>>> 2) Storage security password
>>>>
>>>> None enrolled. HardDiskPasswordControl=Disable, and the HDD, NVMe, 
>>>> Admin, System and Power-on authentication slots all report 
>>>> is_enabled=0. BlockSIDAuthentication=Enable is the only non-default 
>>>> setting in that area. Nothing to disable, so nothing to test.
>>>>
>>>>
>>>> 3) WWAN
>>>>
>>>> Yes: Quectel [1eac:1007] at 0000:c4:00.0, attached over MHI, 
>>>> exposing wwan0. Its power/wakeup is enabled. Not yet tested with 
>>>> WirelessWANAccess disabled in BIOS.
>>>>
>>>>
>>>> so please suggest which test I should do next, now that we have more 
>>>> info
>>>
>>> Of your above the most likely cause is PlutonSecurityProcessor = 
>>> Disable.  Please try to re-enable that and then try with IOMMU enabled.
>>
>> BTW - what version of amd-s2idle didn't flag this?  I am surprised, we 
>> had a check for this that /should/ have failed prerequisites.
> 
> Tested, and it does not help.
> 
>    PlutonSecurityProcessor  Disable -> Enable
>    TpmSelection             DiscreteTPM2.0 -> PlutonTPM2.0
>    SecurityChip             Enable -> Active
> 
> With those set, IOMMU enabled, no IOMMU boot parameters and all 24 CPUs 
> online, the machine still does not wake.

That's interesting.  We'll have to see what the report shows if it's not 
the Pluton setting.

> 
> Worth noting what that test also covers: with Pluton selected the TPM 
> presents through the CRB interface (MSFT0101:00, status=15), and this 
> kernel has CONFIG_TCG_CRB=n. So during that suspend Linux had no TPM 
> driver bound at all -- no /sys/class/tpm, no /dev/tpm0, and the discrete 
> STM0925 was gone from the platform bus. Previously tpm_tis was bound to 
> STM0925:00. So this rules out the tpm_tis driver as a factor as well as 
> the Pluton policy.
> 
> Current state of what is ruled out, all with the IOMMU enabled and 24 
> CPUs online:
> 
>    amd_pmf                  initcall_blacklist=amd_pmf_driver_init no wake
>    amdxdna (NPU)            initcall_blacklist=amdxdna_pci_driver_init 
> no wake
>    TPM driver               no driver bound at all (Pluton/CRB, no 
> CONFIG_TCG_CRB)  no wake
>    Pluton policy            Pluton enabled, PlutonTPM2.0 no wake
>    interrupt remapping      intremap=off (verified: 0 IR- lines) no wake
>    DMA remapping            iommu=pt (verified: Passthrough, identity) 
> no wake
>    vAPIC / GA mode          amd_iommu_intr=legacy (verified) no wake
> 
> The only two things that let it wake are amd_iommu=off with all 24 CPUs, 
> or the IOMMU enabled with nr_cpus=16. 
> Offlining cpu16-23 by hotplug 
> after booting with all 24 does not work; they have to never be brought up.

No.  nr_cpus=16 wasn't a pass.  Don't treat it as such.  You didn't get 
to HW sleep.  Let's please not conflate changing NR CPUs.  Let's figure 
out what's wrong with all CPUs enabled and IOMMU enabled, and then peel 
it back if you need to turn off CPUs.

> 
> I am rebuilding now with CONFIG_DEBUG_FS, CONFIG_PM_DEBUG, 
> CONFIG_DYNAMIC_DEBUG and CONFIG_AMD_MP2_STB so I can run amd-s2idle and 
> send you the report from the working nr_cpus=16 configuration.

So you didn't run it yet?  I thought you said it failed.

