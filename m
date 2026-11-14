Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794636171;
	b=ttE5g/S1lnx2F8XlJoggwNfaAJzsQXpuW7l4GT7Ar8c9ketUF3i/pXTeObWCwn3UGENu
	 dadqpSxG7fvO73hDhfYw05WqH1ziSdx4uaHzjjNPPEY666CU8YvhJU8OI1E+t7pcMNv/b
	 WiimAuxbribXMqbYn+S0zG/tAUBtLtuTdgrQ66QydYMKaYeCcnmIPTvwz9nMCYFzCe/a5
	 M9bk8J4Sv0hao84dRm44TgMnvKU5IhHJSUGKLKm0CwWtGnlnNDBMzx+A2D8/7VQI6jcZR
	 zsJRUsAtZXz45mgDRiwSEBLwlmdYAfEGN6BbYzVwpamDhuwXZoHcluC9u0HH40C4yQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636171;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
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
	bh=Cd7nGFjAMFPBZW1zjVVXd/CgJe5v6HUA2C1Ko2Gf2w4=;
	b=H/WjuERLz6blqOc3VtXcpjwUctbb3BYwiFpoEzJfMOD5VBLENxsu3uBds3yx6r1irqdh
	 vPyDqxlTuWfsKE3MTUDfbpGHcQ28yWhqYbaFTiFLRGzQkS0bRsWFM4tcF/Gzwx/TH6lht
	 6gYqV6LaRSUtLgERUM7LV7D/ZpqDZ/Iv87Pxfuy/ho5SPyympAWS20GEErwuoS0j4u+ZL
	 K0mjcbBdriowtegTy/eABY9vvzS8/+538NGiJjq+Q8uqZ0Lsbe++vAjgnaObV+umxjADq
	 NIWThY58DMfPAGDka5etE0hc5N99zd8ng2rnhKdQGs5dFAiVSXnqGLPYXJB4QR4SL4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bgryzEnE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.31
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6B606A329;
	Sat, 14 Nov 2026 06:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D6B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bgryzEnE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab+8nCEBH5cK5VIIqox9q8EYCgx6yIDmudCFwayxUcGk06V3cjphJ5b6a9IDXF+7SSm8JH7c2CbYHXJnoot53eRXYGYc5eVgHTyqEb4V3Pac1oDZhMtOgr7akQJdRosZBsXn5hastf9K0RL9V5GIeXhp8/hFS0OfozlyBavFtXDwRlz7zAR+0TEtJBpMKtB/XOYS1K5mBggeVtrPiubJc3CJ2lpd31pe3CK8J7XZzJAXbEVqQl+Wr5twzlqP1BVVLK/j9UB1D8eLHbtVoTWeK+o3VCBXBNHLl2whQfa7TAXJOZvJpwj+Z7yuc7BkrBN6OCcykKs6zANVYpfvNooBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd7nGFjAMFPBZW1zjVVXd/CgJe5v6HUA2C1Ko2Gf2w4=;
 b=G9sKJC3MqqsfK5dSQxuFx4PIczQAV8dtZmiJTEEyWdbG7oylmYWJHOrw7EDtt8GOgHGsCCUQmOcIXhxLpY6WW96Q/wzA/qgVZz5BJwMPeckQJ5RAFIlh0bigWo2ZtUrjrSMnss68xE9qVku45e+Km+CqyJX7Fup5XIEqpf/DIrG57GBrflReo0mOrufsWFN2V9YCY4vDIb2JQBcD9kuiPYtPd9k6AewhA9z3wHWGCWTfV0gFn7CfckIgfKrzRueLHq9BzgySuZCkAq1ruu7KPK95PYiFuMqS9ImV/Fy3XdGFIA03fWkDXUpjFz3Pg0TQe3umWZoOsMdO5s/MYZ7JrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd7nGFjAMFPBZW1zjVVXd/CgJe5v6HUA2C1Ko2Gf2w4=;
 b=bgryzEnE0FLjJd5nMBksyJDzWodxTOJk4ngs+ozVH0xc0CBd6sHhFVvhSF+6Z43yebHpt59WT7SRE9MT/HxrLo4LSHAcxLOxeeUqWyJxTGKdZNMnTh8V39ZCr9azAfpUnw9BqiZspVVBaweZ37CFfBY/twQMlzWOeQC/YNlKNKk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by CH1PPF73CDB1C12.namprd12.prod.outlook.com (2603:10b6:61f:fc00::615) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Sat, 14 Nov
 2026 06:02:45 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 06:02:45 +0000
Message-ID: <ecc3eeb4-30d7-4d0c-b899-ab281c240964@amd.com>
Date: Sat, 14 Nov 2026 00:02:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: amd-pstate: Detect Zen 5 / Zen 5c hybrid
 topology via CPUID 0x80000026 and program cpu_scale
Content-Language: en-US
To: Aiden Hecker <heckeraiden@gmail.com>, Perry Yuan <perry.yuan@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <A> <20261113012639.464343-1-heckeraiden@gmail.com>
 <20261113012639.464343-2-heckeraiden@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261113012639.464343-2-heckeraiden@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:806:d2::26) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b31ce7-cf0f-4421-3c19-08df4214e67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|261026140227099003|56012099006|4143699003|261009223027099003|11063799006|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261026121527099003|261009221227099003|261022105027099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VHyDrFnmKXn1ry8e/ES/H36LIle1W+zHiuA4vHyb3zusGyzyWGmu91Tr0ReDZc253Ik56jYMulM7FA7QdW6CenFSMHz3wtJfDhMbi4BlSa4Oazg1YFhkEGP9WsaH3eJU8Z7sB+roQFQBe2C9rv3PrbSwizPhQDMqvia+vkdtUyjGqDeMDghQJ9zJ7YkFOfqSwxIM1rcobKDFPNgbtDF5ZFxfWTbBBVTybcn0reTJMbQ/F8j2a5KdxDt1rFnkEogPVRnxbDJeZrXR2Rpge7B/LTfFC3rRns4Mpt6XjJq9d6SlWDmjRKlwCiVPCl5/sETMH+uY+P3pyvCFGLjvJe9kP2cfIkxMbP+TEn853TBtiA4uXwedmvaj6EZhEXXGOHGOOSpcGFDUNoyeoiv8DYpj4dZvvPyvJi/Ej9HhbW8h48No9QNKrzLsgxqQGL4NTyJI1QPvPnR3QtUpxnbSZwcvWtr30a4T1kP+FArQzZzY6dPvzBGzdz7mCK5xEby4tciB8LDF+NQ/PSYZquNGrNHL8NAKx06qxUlI4W4qwOrTJWjiiMiHycIImCCUrwWHe043XSPgE8gTXCSCpPgpOroqhkyEKS6CIiAGP7vNou5B3RaC/+Revv47EPuTRXOM9F+vcR0yFaABf9hHUyugpKWNB6uDHhNVn+TRfq8hHGwkmVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261026140227099003)(56012099006)(4143699003)(261009223027099003)(11063799006)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003)(261009221227099003)(261022105027099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THpJY3JCUnNDT011R3lTY3VRVEFHbDZVUDRLa3lHQ0tCdXVFTTNwYTJBZGZa?=
 =?utf-8?B?c3V1SnludGJzNGU3QmN6Z203dlNzWlJVSHpTU09JNG1zczB1S3NpdzJLU0VL?=
 =?utf-8?B?ek0zQWNBSjV1czdjQnlGeFlnR1AwMytZMzhsTVRQcGtlTW9MdzRPWXFWdzFm?=
 =?utf-8?B?L0czK0ZEOXBSUnhDYVBsZW1kQzBCbTZoT09HZnZINm9tTXN3NWdmSmxWQ1Fq?=
 =?utf-8?B?OUVuaVNLdkU4M1V4UzE0dVFsYklYQjZSbmxWK0NUTGJoK3dwWHRWRis3Z0ZS?=
 =?utf-8?B?NjE4MEZHMjY4V05xa3c0NDJMeXhmaW43VXNyY3RTZzNVVEtMbWh2NkFxMVhu?=
 =?utf-8?B?bTZpcklucFE4dkFiTVVDalFjYlFxbzU0Nk1TUW1tb2hnUTRaaEVSQXBObmh4?=
 =?utf-8?B?ZXQwQUFaWTRFU2IyeGorWk1xMW9UallUbGl1anl4bWpRMVBJUUd4UXQ1QmVG?=
 =?utf-8?B?RGZLVndWQkVmRnBzeWE0UnVRRHFveExwQk1iNW00Uk9TT0hDK3V0Z1FCSysw?=
 =?utf-8?B?STRrcnlndjgyNUVNYm1GOERlNGFLT3Fxckt2NzIweVhPYkNnYXdnMFRyQnZS?=
 =?utf-8?B?VlR3cUMrb2lKcTM3L0VadXRLRVBQWVpFcmVtRjR0ZEpBcVFTVk9QYkVGRi96?=
 =?utf-8?B?QlEvOUdYdm03ZUNiM0wvSW50MDhUTkhBaHB0dm03c2pRRWRGc04vRWdiLzND?=
 =?utf-8?B?UGJZRWxxTjVlVWZmM2djVTlkanFMcklWT2h5WFNTWlB2MjgwdWtpbk0zTjRG?=
 =?utf-8?B?SW9PNTdFa3pWcTdwdzhXWGI2ZmYrdEhpcjF5dkdvcWRzODBlVDRRQml6ODJ0?=
 =?utf-8?B?OWpMWVRNdWRYSVo3VWZ5SkRvRzRHd3llZS9Sb2MxUmY2elVsalBQNnhRL0Iv?=
 =?utf-8?B?UFlNTTFubmlESkVyck5zWElyajhBNVYySWtDcGNBa2NKL3I3YUxNRWlNVUQx?=
 =?utf-8?B?RTNycFJIK0JoLzFiNEpPTDE2K1A0akl6SjVTdCtROTE3WFhyWW90THhLRG5z?=
 =?utf-8?B?ZXlDVms1QXdMOEJKWUdSQ25NeWw0NkRFT2t6UkpuVjFNa2hsbW05QlJselNO?=
 =?utf-8?B?YjVDMnR3VVVnbFZaRXM1dFRlK2lOUERFL0gza05Pa0dBR3h4QkY4UkNQYVRM?=
 =?utf-8?B?MDBRZE5mclVidWZSWEhyd3phVEdTVjVyQURhY0dwUTBoZi9oNWQ2REQyejl3?=
 =?utf-8?B?VVl2ZmhuNnFDZ1pWeSt0RnVUWkhWNUhMOUpNcjh6TWNtb001NlRMTUpYQXZo?=
 =?utf-8?B?emFlTSsrYWRPRWVkdVdLbDNZdUZ5Z1loRVo2c3BaT2EzeGpxQ0xsWmdLRHp5?=
 =?utf-8?B?MFVMR1Z5VUxpbW02d3hMS2FMK3RwZ3NHQWtIL2lVSkIwQnNLeEFoRGRMdWRY?=
 =?utf-8?B?Q0VHN0ZWWkg0SUpHdVFWTTF0RHE2L05QVHpxcXBtZEJCZEJOM05ZNGJqbm1u?=
 =?utf-8?B?UUpyekhHUjcwVHYxM1kyNTRaN0craUczTTgvcHZBdXp3K2V4OGZxY1BCNmcy?=
 =?utf-8?B?dVVLWnBnaW96YWJ2SDFyQkszNE9qZWp2cXFVc3ljRWswTjE2RVo5YkFVNGpZ?=
 =?utf-8?B?MjRyZjg2ejRSUmdFMDVOR1kyRmxwWlpzYmU1TU5XekkyVWdrVnd0ZWd0cHBv?=
 =?utf-8?B?N05COEV5Q1R4VjJvRTRXL283ZklCUzlpQi9jV3pLb3RGdlhQaXBXdzJaakxX?=
 =?utf-8?B?YnJPZWYxMHZZSnQvNURHYVpWUHNEaHJXRFRjd2podWI0UlRZWnVIc0orQnhs?=
 =?utf-8?B?d2pRQkxNbC9rTlFZZTVlbGU4SUJPWGFORE9ocStUcXAzUE9ocjMyNWtncHRM?=
 =?utf-8?B?L2w3aFBDTEFPUFBaMC8wZGZmNExaTXoyUW9hMHFvYWcxMzZWTkVrdlBUL3lC?=
 =?utf-8?B?YjJ4K0dZYmRCYjN2ZW5vN2EvclpYbFJoNG5GMWR4K0tMRSt1Z1k5Z0JnMGRN?=
 =?utf-8?B?UEQ0NWx5Y0c0UkFpcTBXdndwM2F6R2UvR0IzTU1OY1VXNlJqUWlrNGc1MERJ?=
 =?utf-8?B?L2FvTUtBRC9SQmI2azIxSklsSVc5dmMrRHgrK2FWVk1EajA1emVGaEwwUjcv?=
 =?utf-8?B?cW5tbmdRR09MSzVsRURveERFR1JmTGFlcXdxazVwT1VVWGd0b0VKdUQ3ZGJo?=
 =?utf-8?B?SDBnVnJERVAwT210b01JQVRmdnJGenVoZy9FMHh6QmtEeG9TczZ6MGNnVFFT?=
 =?utf-8?B?VWx4SWFqMUdzK29IbXRwc1U0dmErSkRNWVhLbHR5MUk3ZlhLczk5NEUzMkds?=
 =?utf-8?B?czNBZWpJeGlyRU9DRmtrQUdHbFB0VzRFRnIwbmF2WFlFVG9ReXVTaXZaOU9S?=
 =?utf-8?B?b1dqZVBKZ2xLTXAwYzE1djRtM0pxTDZwZjJvOUlSR2RZb3dhZGIwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b31ce7-cf0f-4421-3c19-08df4214e67e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 06:02:44.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+08+d+E9ulmL3RgFXGwu0GpwXF5kR59VXrJbkShkeTY85rPI8itFLQQlxoWv0UEjtPa4DpCudYQse4/RaYZjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12



On 11/12/26 19:26, Aiden Hecker wrote:
> On AMD Family 1Ah Model 60h (Ryzen AI 7 350 "Krackan Point"), physical cores
> alternate inside a single shared 16 MiB L3 CCX:
>    - Even cores (0, 2, 4, 6; SMT 8, 10, 12, 14) are Classic Zen 5 (5.09 GHz,
>      CPUID 0x80000026 CoreType=0, ACPI CPPC highest_perf 208/202/196).
>    - Odd cores (1, 3, 5, 7; SMT 9, 11, 13, 15) are Dense Zen 5c (3.51 GHz,
>      CPUID 0x80000026 CoreType=1, ACPI CPPC highest_perf 135).
> 
> Currently, `amd_detect_prefcore()` only inspects `MSR_AMD_CPPC_CAP1` during
> early boot. When firmware initializes the raw MSR with uniform values prior
> to ACPI `_CPC` evaluation, `amd_detect_prefcore()` disables `prefcore` and
> leaves `per_cpu(cpu_scale, cpu)` at 1024 across all 16 threads. As a result,
> `select_idle_sibling()` treats 3.51 GHz Zen 5c cores as equal to 5.09 GHz
> Zen 5 Golden cores inside the shared L3 domain.
> 
> Fix this by:
> 1. Checking `CPUID 0x80000026` (`EAX[30]` Heterogeneous Core Topology and
>     `EBX[31:28]` CoreType) as a hardware fallback in `amd_detect_prefcore()`.
> 2. Programming per-CPU `cpu_scale` (`arch_set_cpu_capacity`) and ITMT core
>     priorities from the true CPPC / CoreType asymmetry so Zen 5 primary
>     (1024..965) and Zen 5 SMT (840..788) are ranked strictly above Zen 5c
>     dense cores (664 primary, 512 SMT).

On a Kracken system why are you even using amd-pstate for rankings?

They should be coming from amd-hfi.  Did you not enable that on your kernel?

> 
> Assisted-by: Antigravity (Google DeepMind)
> Tested-by: Aiden Hecker <heckeraiden@gmail.com>
> Signed-off-by: Aiden Hecker <heckeraiden@gmail.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 68 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4a2d81e9012b..b87c4f319e04 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -39,6 +39,8 @@
>   #include <linux/uaccess.h>
>   #include <linux/static_call.h>
>   #include <linux/amd-pstate.h>
> +#include <linux/arch_topology.h>
> +#include <asm/topology.h>
>   #include <asm/msr.h>
>   #include <asm/processor.h>
>   #include <asm/cpufeature.h>
> @@ -812,6 +814,67 @@ static void amd_pst_update_limits(unsigned int cpu)
>   	cpufreq_update_policy(cpu);
>   }
>   
> +/*
> + * Program asymmetric scheduler capacity (`cpu_scale`) and x86 ITMT priorities
> + * for hybrid Zen 5 (CoreType=0) + Zen 5c (CoreType=1) processors sharing an LLC.
> + *
> + * Even physical cores (Zen 5, 5.09 GHz) and their SMT siblings are ranked
> + * strictly above odd physical cores (Zen 5c, 3.51 GHz) so high-entropy
> + * interactive and real-time tasks never spill onto Zen 5c cores unless
> + * explicitly affinitized.
> + */
> +static void amd_pstate_update_hetero_capacity(int cpu, u32 highest_perf)
> +{
> +	u32 eax = 0, ebx = 0, ecx = 0, edx = 0;
> +	u32 core_type = 0;
> +	bool hetero = false;
> +	unsigned long cap = SCHED_CAPACITY_SCALE;
> +	int itmt_prio = (int)highest_perf;
> +	bool is_smt_secondary = (cpu >= 8);
> +
> +	if (boot_cpu_data.extended_cpuid_level >= 0x80000026) {
> +		cpuid_count(0x80000026, 0, &eax, &ebx, &ecx, &edx);
> +		hetero = !!(eax & BIT(30));
> +		core_type = (ebx >> 28) & 0xF;
> +	}

FWIW, we already have feature flags for detecting a hetero system:

X86_FEATURE_AMD_HTR_CORES

We also have topo information:

TOPO_CPU_TYPE_PERFORMANCE
TOPO_CPU_TYPE_EFFICIENCY
TOPO_CPU_TYPE_LOW_POWER

You're re-inventing quite a bit.

> +
> +	if (!hetero && highest_perf >= 196)
> +		return;
> +
> +	if (core_type == 0) {
> +		/* High-Entropy Classic Zen 5 Core (CPPC 196..208) */

Your intending this to be Zen5, but you're actually applying this to any 
hetero design perf core AFAICT.

> +		if (!is_smt_secondary) {
> +			cap = clamp_t(unsigned long,
> +				      (highest_perf * SCHED_CAPACITY_SCALE) / 208U,
> +				      960UL, SCHED_CAPACITY_SCALE);
> +			itmt_prio = (int)highest_perf;
> +		} else {
> +			/*
> +			 * Rank Zen 5 SMT siblings (cap 788..840, prio 160..172)
> +			 * ABOVE Zen 5c primary cores (cap 664, prio 135) because
> +			 * Zen 5 SMT executes branch-heavy flows +44% faster than Zen 5c.
> +			 */
> +			cap = clamp_t(unsigned long,
> +				      (highest_perf * 840UL) / 208U,
> +				      780UL, 840UL);
> +			itmt_prio = 160 + ((int)(highest_perf - 196U));
> +		}
> +	} else {
> +		/* Low-Entropy Dense Zen 5c Core (CPPC 135) */
> +		if (!is_smt_secondary) {
> +			cap = 664UL;
> +			itmt_prio = 135;
> +		} else {
> +			cap = 512UL;
> +			itmt_prio = 105;
> +		}
> +	}
> +
> +	WRITE_ONCE(per_cpu(cpu_scale, cpu), cap);
> +	sched_set_itmt_core_prio(itmt_prio, cpu);
> +}
> +
>   static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   {
>   	int ret, prio;
> @@ -831,6 +894,11 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   	} else {
>   		cpudata->hw_prefcore = true;
>   	}
> +
> +	amd_pstate_update_hetero_capacity(cpudata->cpu,
> +					  READ_ONCE(cpudata->highest_perf));
> +	if (cpudata->cpu == num_online_cpus() - 1)
> +		sched_set_itmt_support();
>   }

