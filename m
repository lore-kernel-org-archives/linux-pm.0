Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8F379993;
	Wed, 23 Sep 2026 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180113; cv=fail; b=cHiUyUnqAOjuOya/HbhTqJeRJU58wKBNpkWmfIgsVd6YU9lBSbde9V5Dh8PyIuQez4f3vbdls0J76gI1bwh0pRdJy7yN5d139oPlKu9vWB/bJGVMnEgWexSDiedj8eSapUU0XJI/GEteomk+l3dl/ePHhfOUn6GCebuMGFTqQOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180113; c=relaxed/simple;
	bh=eTzTlDZ/NKaBc5zcnfKfSOKoxOYrGwxe4M3YRlqQZfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AiTwAdSgRF52hc9I4hwKHN5lhb3+dV8b4BHlSoSo/8vZ1aWvTsMyTCSNbrp+u0GuKhIwQMzoemGSsCp2D087WB4dIAnh/FM8W7Bxh1MILDkI6BKanLxk5i/YU9BWsAsdEkuR2PIe1wQRIiwtPeZouXrPN3ln9agfj03pf0pUakQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h0Rt6raH; arc=fail smtp.client-ip=52.101.56.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h0Rt6raH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEpmWYhJTRoYnnf7VAaTF0qp6cSglMRS7hU21IwrL6A10y9oNJowW6Kor7099+G6PcbB6W862paDiW2pLDrpcfma1EACsdHZ02IVHwN+CGYFMXTiDpknlCe6fuF/VE2D2dr3iGBcNXMIo8pVoBoWHdTe5UB4B8PM4Mesyv9iivCkF1Q2ZorQtgZSKbB16VS58eI7Itm+4zwi5jegjAqlxV6M2ZEfTgvPyRPRXuOLcEWOLoJJxm62q6fpfGw6k0rg/bFLeY+pcePRsOwb4fvksp0moBTY/t9TZBfdvVRpTGoT+UW6az2j9I20njlnkwdNwXwqX6ZN4qf6E4FxBDueNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsEnGN25X1G8IDaXBISiqoMp4LYYPBFRqpcYR/oV2yw=;
 b=exgAsWUn4cTz7zAzk3flm2MMkW8BrDdTSA7OfSEZoZBRhV/0BKujpXF0E4uVG5KJMUFgicgmlwSCNnmZM1+8d3gO/NZNebbLENz7cBqE1wv8m1VUJ/uJdIeSb6N3OCoRJxiWttU2dsM3mYA0d1vmw0h5nYn++WgesDhb0iBOk4SdnTZK7imuPN8IlpdAckfvT4Jrp54wTDc0BoSK2UKhFlBOdO0xX3X6HtOUtpu1gW68/sl7YKUf6b2PsnESrEesSRVKXVZ8jPOBDn2udGgkG9KfQGya7kq6GMJfAictrVzJySDTSm9NFLoXYM0a03t763LW4Q2iqdRP0KVChJoQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsEnGN25X1G8IDaXBISiqoMp4LYYPBFRqpcYR/oV2yw=;
 b=h0Rt6raHa7GzTxzPk5P0b8MeTne3xKefrAtItk1L+hyYiU9BrqVeHd83wUsaRvmkLtgQ8/2y7lTdRiOSciZVrO/bftUr+6l53yLGUftRlVkCU+Xg28fBFGg4dFS+vn8s4yd9JlfvKwVikhkliGUVH3OxOV6daX0Q4i2imXTP3z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:15:07 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:15:05 +0000
Message-ID: <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
Date: Wed, 23 Sep 2026 11:15:02 -0500
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0237.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::29) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 082f95b5-2050-4d9e-2906-08df198dd456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FdvvhudC2prFtokZj+a6PzGXpr4mjgV1odCbQoEgI4Qna+0g/1xJqVvyDZl+SyACODwopqFbzonqUvxA+crTCRKePJE7pA6SXGwADeam43QYFRjx8cAIFyMohhCdXs6emYl8iyc3CxzRoewdp8tQmYDBwOiquIwWge8u1G/4XR84HquzeVFolcfjs7vlgbTc8UMSrMHI+PwU9jdp+0TI0jJMaVe7jjdMBhXJmodP8hZis7Fsi3trPjTlbXHGh876BPm2OXruqspHj6/rCMEOWI7WWTiTZS2b7A5B6uTc+NPu1pHyVtkZJE33FYDSGM0MoPNeE55HoehcRtVQRl1y7sqESAWt+JKlinENL45jsmoqV2xpbh/eonPfQgNIQp8Qpp1cFJiX0bGsB7Te5tq5bG3YS+tSQ9aTB8xVOio2O7VvnG4EZ47kgbiaJX68RX5tWXbqQGnOI99QOG9Ux/UyZkabhZ3G3hch2HL7uIUV7d5Q/voOkre3gUBTl9b1NG5AOUXj1e/c92ujKO6cos0PIIptq6rijke2/1yJsRf3UGt5kqWjkqPBWT4OC7G4YWDEQj7NtxYWvAb+MFxAEHPnfK+K6z/pOrbtiZTxPPZnSzELoxJdM2XQROnec2IMGD9MSXReWbXJQTXkydf6+k3jIEFgol2sLyYiL7UBUVfUQ4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnVoNXZvaEY1ZnJnWHN6bFhJT1lpb0FwWFZyTE1mNVBCWGxxUEs5V290T21y?=
 =?utf-8?B?c0N6cWU3ak9XajhjL1JaWE9pVXN6T05OQ3RscERmRVRYWFFEdWovRVV3Zmtm?=
 =?utf-8?B?bzFjUzdGRjZYNGtvMUE1TGhDMEpiZy81ZWFNMk9wVVJiTEIvSmQzeVF1aldr?=
 =?utf-8?B?RkUzWnlsb1o0ZXd4QVhCZE5IL2R3aEd0Q045eXdYMkJKSmd0c01OWlMzZTBi?=
 =?utf-8?B?UnpqdmEzRXJWWWJtQTYxUzYyRUdpbExTSzM5TEthNVNxWDZuQzY5b3p3c2Zx?=
 =?utf-8?B?cDhuUWVhS0FQY1RJNDNtZm9YRlVXSHNFTU1QQVY4MS9TSm83UG1mdVlBQnZr?=
 =?utf-8?B?ZGhWNFZGcTJDTmFSRFV5SjZ6OHpKQ2JyUldRcnczb0hPTzZOZU9LaU16aVZW?=
 =?utf-8?B?ZXdickgzeTdubWpocGJRbFYwSlpmbVhYd0hKaUJLOE8xdElPdVlKZGdqZW96?=
 =?utf-8?B?c0FpR240RFZRSmxrdE45V0w5aWplTW42ZklmK2FwalFaUTB5NmZUdk5KUk9M?=
 =?utf-8?B?akRhNW1yOURZRFBaK3kxN09DdWdGS2NXVmJFQjhnNFI4OVRka3VMcmZkVVBx?=
 =?utf-8?B?U2U2ZW9qZkx4bHFuTU41WHdGQWhuRktkQXBybXlObld1amIzenp0TGwxZHJD?=
 =?utf-8?B?Wm5xYzB3UkpqMWhwMWRsNG05MTcxUzZvNkFjcHh2eW1CSlJXQnVTSTc5Z1pr?=
 =?utf-8?B?d0hpcFJocWRZWWhsQStvb0hsWEVVNi9Fb0xpRzlaZTZrUFhzQ1o3WHVOdVJU?=
 =?utf-8?B?c0lQNWhEK1lhTStqNHFybGZnTXpoQnFrU2RVZ1FDbFk1c3lZVTR6R3J6WnVD?=
 =?utf-8?B?Zy9DY2x2SHZKZ3h1dFEvbW9MYjAvbzM1M1k2aUNsdG9kT3VvYmZHRlRxbkNm?=
 =?utf-8?B?aDhYZjNnMEdjZVQzYjlla1hnOCt5b0kvTFZUdzkrb1paV3JlTWJqaFdTTzll?=
 =?utf-8?B?V0Jqcno2dEtZM0RmYWl3UTJXOFRJek4yTjdzdHpzMHQzcGRqTmpCa1NkZ21y?=
 =?utf-8?B?cGFCVVJaSWRXdWhhSDBVdDB1OFBVTWgrRXN2akhITldBeEFHaGliTVFRc2hv?=
 =?utf-8?B?ODBoZFBodHk2dUYwMFBJQ1hENGIwZFlvUlRJV2JlL3RPSmRPRlBkNDFzN24z?=
 =?utf-8?B?cStPYWh3Vy9TRVAyWnBselpFNkFxSXByNU9xK1h4QXlWQnlXNExCd3F6aE9s?=
 =?utf-8?B?amp4QUE2c0dHNFI3YlBkVW1sNWczZ1kwV3gwZElySkN6QVduUkRTVWo3UGFt?=
 =?utf-8?B?WXBGenZkSFc5QnVMUmx4TjVmQ3paWStVTjIvVTc5d2EzZTZlZ3BhMVpKbThV?=
 =?utf-8?B?aGtIbzJITUpYZ1FDdDBvL3VJUTM1Y3phei9DZytNWFY2b2FjdkFoSU4zd3Mr?=
 =?utf-8?B?T2Q5QVY1dmJPN1AzbVdyTWNWWEtOdTdWUnI3ZXVJQVMvV1UwWFRqRW5JYUZJ?=
 =?utf-8?B?eGdHWm1YeHJyQXBvT0Rkanh4NzZodEpvQ2UyVlQxOUNDVUo2RFUxcjdnUEVp?=
 =?utf-8?B?ZUswYXB0TURZWjBxOVJ5M1FyTlh1ZEh4ZnRXbU0zT1VGOGFjZjNzSm0xMkUy?=
 =?utf-8?B?dnJzVEE2Q0JUYitlYWhJb2JUd0JCRlhKY3VpMGFRcTAzUWoxMFZ1Q1dxVjR6?=
 =?utf-8?B?SXNoSE9MNVJmS3NZSy9NcUdHZjZRQ2ppWEtmQ3BCc1JKU3I5ZnlXeG8xYVhr?=
 =?utf-8?B?cDVMVGhrOEhHVDNXR01pQkVDem5weWF6ZmpOTzF0bE1pMTIrUWJLOTZsc0Ri?=
 =?utf-8?B?VSsrUUVnaVpEYW10NlppWnlKdWpBWDZ3aTE5ckJ2R3ZiZ2dlekdXeWdHQ1pz?=
 =?utf-8?B?bzYzby9pTWJVNEtTL01ObWF0RzBhamlRSDI4dmZiYmV6NzgwS1ZleTRGZkw4?=
 =?utf-8?B?Vnlha2tURXlBZjNSY0ZOWk1rYzBOM2xnL1ZwekYvSTY3enlpdzBxVVFEcUdD?=
 =?utf-8?B?bzlJSjRCWEFuc1dNUXpQU0Z0T3RFaXRuK21QWis1RU9VSHFlYXU1Sng1aGxZ?=
 =?utf-8?B?MEFKaU5IRFBQVkN4RExvZkVUbmtnczBWZzh0Qk5BVDdDR0ZQMGdNU2thenJF?=
 =?utf-8?B?cHZqMjM3b2hsT24wOTYvNjRBeTMzd2VQWUtoWHhzMDhha0svZ3U2b09PWFg3?=
 =?utf-8?B?ZTltM1JscnI4SzRyMUFyVnFsK0c2MjZkMi8wRUJEZmgxR2Zzdjc4bVdBKzZU?=
 =?utf-8?B?cGw1aVVsQWhhOTg5akVVaDR3U0JiVUx4cUVxTzRZUktUenVBdUdCczhMN0g1?=
 =?utf-8?B?UlpqYTBONWhHaTY5KzFsTE1JVTdmM3BpS2JDQnVrTmhTdzduQk1EbjJuNEFw?=
 =?utf-8?B?UldpK0kyL3NFdXFWenYySkIzS0lXTHc1U2tKRTdVNExyd2xLRWdudz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082f95b5-2050-4d9e-2906-08df198dd456
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:15:05.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tIBw5c1IkLwrZYqdrmaxsOftbePMt19DQNvTMQQUveN++TyS3e1cN5sR4JjZRjdXxy8IODYt7F0DGyE5tnQPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619



On 9/23/26 11:12, Fourhundred Thecat wrote:
> On 2026-09-23 16:36, Mario Limonciello wrote:
>>
>>
>> Some other thoughts that might be the root cause based on other 
>> historical issues.
>>
>> 1) Have you changed TPM policy or Pluton policy in BIOS setup?  What 
>> did you change it from and to.
>> 2) Have you enabled a storage security password?  If you disable it 
>> does it help this issue?
>> 3) Do you have WWAN in your device?  If you disable it does it help?
>> 4) Does booting with `amd_iommu=off` help?
> 
> 4) amd_iommu=off
> 
> Yes, that fixes it. With amd_iommu=off and all 24 CPUs online, suspend/ 
> resume works reliably.
> 
> So this is not really a CPU count problem. nr_cpus=16 was only masking 
> an IOMMU interaction. But narrowing it further was surprising: neither 
> of the IOMMU's two functions is responsible on its own. All of the 
> following were run with all 24 CPUs online, and I verified in each case 
> that the parameter actually took effect:
> 
>    amd_iommu=off            IOMMU off entirely                     WAKES
>    intremap=off             IR off, DMA remapping on               no wake
>    iommu=pt                 DMA passthrough, IR on                 no wake
>    amd_iommu_intr=legacy    legacy GA mode, IR on, DMA on          no wake
> 
> Verification for each:
> 
>    intremap=off           /proc/interrupts went from 58 IR- lines to 0,
>                           and irq 1 (i8042) is no longer IR-IO-APIC.
>                           iommu still enabled, domain type Translated.
>    iommu=pt               "iommu: Default domain type: Passthrough (set via
>                           kernel command line)", all 40 PCI devices in
>                           identity domains, IR still on (58 IR- lines).
>    amd_iommu_intr=legacy  "AMD-Vi: Virtual APIC enabled" no longer printed,
>                           only "AMD-Vi: Interrupt remapping enabled".
> 
> So only disabling the IOMMU outright helps. Turning off interrupt 
> remapping alone, bypassing DMA translation alone, or dropping out of 
> vAPIC/GA mode all still hang.
> 
> The CPU dependency is still there on top of that. With the IOMMU 
> enabled, nr_cpus=16 works and 24 CPUs hangs. Offlining cpu16-23 by 
> hotplug after booting with all 24 does not help; the CPUs have to never 
> be brought up. cpu16-23 here are the second SMT thread of the eight 
> Zen5c cores (APIC ids 17,19..31).
> 
> Both conditions appear to be required: the IOMMU enabled, and more than 
> 16 CPUs brought up at boot. Either one alone is fine.
> 
> 
> 1) TPM / Pluton policy
> 
> Current values:
> 
>    TpmSelection            = DiscreteTPM2.0   (possible: 
> DiscreteTPM2.0;PlutonTPM2.0)
>    PlutonSecurityProcessor = Disable
>    SecurityChip            = Enable
> 
> The TPM that binds is a discrete STMicro part, tpm0 -> STM0925:00.
> 
> I did change this. As I recall I disabled Microsoft Pluton, which moves 
> the TPM selection off the PlutonTPM2.0 default onto the discrete part, 
> so Enable -> Disable for Pluton and PlutonTPM2.0 -> DiscreteTPM2.0 for 
> the selection. I will confirm the exact original values in setup. I have 
> not yet tested whether restoring the Pluton default changes the 
> behaviour, since the IOMMU result looked more promising.
> 
> 
> 2) Storage security password
> 
> None enrolled. HardDiskPasswordControl=Disable, and the HDD, NVMe, 
> Admin, System and Power-on authentication slots all report is_enabled=0. 
> BlockSIDAuthentication=Enable is the only non-default setting in that 
> area. Nothing to disable, so nothing to test.
> 
> 
> 3) WWAN
> 
> Yes: Quectel [1eac:1007] at 0000:c4:00.0, attached over MHI, exposing 
> wwan0. Its power/wakeup is enabled. Not yet tested with 
> WirelessWANAccess disabled in BIOS.
> 
> 
> so please suggest which test I should do next, now that we have more info

Of your above the most likely cause is PlutonSecurityProcessor = 
Disable.  Please try to re-enable that and then try with IOMMU enabled.

