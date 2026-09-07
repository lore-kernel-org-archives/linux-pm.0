Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDC46EC64;
	Mon,  7 Sep 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788804872; cv=fail; b=pVU/MHOC1Nde+4/Y1piep2BJ5F1MONI1ZcLfn3yGJgQBEcEF255H+8TMxbhoiTG7H9y3bCY0X78Vt85R7ayCXwAXnL9eSrLTATBtSyWobbsEduWG+S4gaOUYqZBtKCLfaR7IdUgMOr9QHJGsQ+qPD9jFsQ5tdLrdWLcJJ5Gyip0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788804872; c=relaxed/simple;
	bh=HSeK8xk0pgdEX5tnSmR0MffLPBj+XSU5tFRGAd8ZRmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DFny6rwsdPTLRIv4XW4CkhG2eLgfy3SfzFGVG7z90LAAbwHorN3VZjHXkKvQG602KRvbYVfSNnZumricg9yxj94mGUIeF4dfgt/jWRp+PZeuEknuQYtYSy1zr2L+Isb/nqLXtXiyBmnNCxVlYYeaLdRlKDZJ8kQbQvfIzsn0xcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sHrXiWXw; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sHrXiWXw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdZS8cbWqqnj6Bhmisq5z63Ts4WMDU4jk6Bkb1DWHmBb/sN+ElHkqHeJGcUCJkyqNsD2rANVhCNlHBlY0p78oZPErwy2/Nna+6IiSMGl9rL03JjsGiYWHuxhIpv+9LlzsT5haDVTHf3Tpkqtzh9jjIEe5If6CrhOLjdsZPxJfSXptbXaV/WaaAVrYf+87El8/e8jy8aUQt6XM/vL7AL0h1UaE2V4BlHYNaJdG/iecOW5DFy7UvzhVxWPjT2ITAS17WpZcM26VZq7Vpy+5huXQPB/g07DJw+ja2mFssc38bL5YXudAFQEPFQ3QZLu0RfFkXlaMmtb7/92FszMAdfkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aa6ao8XVNw1fVhgwn2RXxT9+RLGaongUwWfqbopPRy0=;
 b=GHpwQnAvAW3VeH7IlsrS/RNN7hBEVArQ9d7cpQrCG1Qor/RT327OQ5ukGi76qFdil3rP+ZdqwSVB9pGth/WfaOC1kATiwj8Cc5UtwnAle53BkOdEmOLLdwUIS4uRe+sWbxzNhu3f9s2FGbSIUUjUkb882CFyOTTazHP3XFPYQd84DmYJVZGN+sMFBjnGfjeH9kClcVaVEstoPhlfDKK23UvHuemPE43fsAiAMIPdQvqAXzgWll9nnT9sYAB8qqVxX+OncCoavBILfF8mJZq+2yLMD5kf/5+eeSJCCfXt1auHRGna2xfm/IautpeF+i/av5Tu2n/rtVo+KRZ4Fg5dZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa6ao8XVNw1fVhgwn2RXxT9+RLGaongUwWfqbopPRy0=;
 b=sHrXiWXwZzP1oCcpK0g7u7Z5W2EwvkDzjHh+AKK4X8x6/mmOLP71KvspOYSycxGWmgkZtBlmh6xzzq74aQ+ScrtH7Tk1TFli4YaxsMZh0p6UUPSSilfY3iWbaYNz7359z+h2JawMpEJg7xbyN8M+79l8tybhK/BrW5Ow2dNFby9ouT3r0uVNM+ZGP2F48tG28wJx4bvUH5EiJ5a05fORC1cBS6JWVy57SZLLsdzfduixGOXw2Wzmarkr7+lhGhb6gvbOhY9+GoI/w0m+HbUMRj8hZOE1js4YrOFi9IoSHFTgV1TcDD9crvxmCvS4f9JwVIClq/kvLStCIVjAss5Xmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by LV1PR12MB999328.namprd12.prod.outlook.com (2603:10b6:408:3f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 18:14:27 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 18:14:27 +0000
Message-ID: <84499fc8-d4e4-4a1e-adf5-37279e971969@nvidia.com>
Date: Mon, 7 Sep 2026 23:44:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/15] ACPI: CPPC: Clear Performance Limited without a
 stale read
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, Sashiko <sashiko-bot@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260830115644.2056983-1-christian.loehle@arm.com>
 <20260830115644.2056983-16-christian.loehle@arm.com>
 <55a5c9fa-cfd3-4000-b3cc-52c343841c9f@nvidia.com>
 <ffff3d56-74c7-4980-8831-0aa4fc192f83@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ffff3d56-74c7-4980-8831-0aa4fc192f83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::17) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|LV1PR12MB999328:EE_
X-MS-Office365-Filtering-Correlation-Id: be5700d5-9e9a-4656-9031-08df0d0bda33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|10067099003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	00bCQutR75El8NTKNWm01OnMehs2GNA/vr7aD4vFJmEhwCZHf3RKgfn8SXYnkZx2XZebvTVhQxxz5GdNt/U/PhCimGEJmLw3uv4VfH0P3UcOlx2eLBUvTKZJhdk7koKis7pwYY7PGH8YrQosiGa6X2ct4WNVkh3pAcyIat/FDxEAnXFhMblXgpUAv4vKEdiCJ5sDeczcy3AyAeCDpmcWLIPa5egeySlWA8UiqHpttUlG2JLdQn2VTWg+2J3M8puRdyjgxgYTZ6upyvoXZj5AU3iofeaXaxQdidxn1U8Ah8n8o7ExUB13CUYqJr0oHLgpoKd436lBHEiKB17OsQFQhRUJNcF/fZqrqap4ZWfIvbtyWlrKj9MxMDz8Zi1K2Rz3kwFhVpNZCyaXsT/Fb7oULMf/zMQQTwAs+3rUU35XepGPjkY3qfxGto0sKjq6MKLpsB57utyGT784K4s9BiBz4+5WwuxQsyXfO2SF0Y++IXipvrBl9IIRuA2hRn8EE0vEGnAo26dIIFQEl4GkHhdeC98hSP5XxglzxlPlhPrbFFjGkPY+NeKNRC/dOb/uX0hgiBVTwExwfPMbk6LJC0La01R+OMVwIzbMsjIdJM4YSyM+rx6elb6036h8GKpjMrFtwmiBiOEvq4F1AX12q/XUj2u54Kjlx6wj4lZQdr0CgNA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnJNL0drM2J4eENIN0JyM3FzVS8zVGRHa2hZeWRkcUVhOHRYQU9ScXlySTBS?=
 =?utf-8?B?bUFBblVNOTIrbFJDTGpQVFJjS1E4QUxqcGVSc1I2RlY5NzhqVmlaUzg1d3ls?=
 =?utf-8?B?RTI0Nzh0RHlxamJvb1ZVVmRyNGlXT1ZRcU91VHdGeEsyOTFxMEM1UytSL2Ji?=
 =?utf-8?B?VTd3ODJ5WUNqVW1ja250eTJNS1VaUkpuaVFrZGRxM25GSHN5dDVUOXBPSDNH?=
 =?utf-8?B?YTZKdUdMU240WW10VU11MllKNWV4cWJHbjZrZjZUeit6QTg4WFU4NmpkVlZ4?=
 =?utf-8?B?bWV1VHlGbVdaenQ0eG5CQW9TUGRtNTJUMmpFNUNjMHJGVDQ5Zm1ZWlFzUG9V?=
 =?utf-8?B?RGpOY0YxU3dhVjJwOU8vV2hNSWE3TWZhL3FxMHprWWxuSng5Uno0RmF1b0FX?=
 =?utf-8?B?UFRXa2U5R0hXVlYxWXB6dmxDcUtSVTlEWmtXb1R1OTNCQi9CZ0pRd2NSZXFL?=
 =?utf-8?B?cXROMmU4YURwdHc4T25lQ2VEVGw3YzE1azBwYWZpNUZXY2x0dWlzK2xVeENo?=
 =?utf-8?B?Zmg2ZjR4R2QvVVJwVHAxV204L1ZZWExuc21obkp0MWNyYTh5dEtKUTNpQVg5?=
 =?utf-8?B?R0U0MzRwMnNxR2NXZWZXdzhkeEk2eFVORlZOTTUxY242RXY4Y2tsTVBDZEZ3?=
 =?utf-8?B?QytXNjRBaEFSeW5IM0tSM0poWkdZZkNqNHZ6alB1OVR4anpvakVvWlZud2RB?=
 =?utf-8?B?bUZyK0ZOWnNlT1VTcUIxcXVwUkh6bHUyc3NVVEwvTEQycFhjQ3FEczFaUUNP?=
 =?utf-8?B?djFWVnZKUVkxQVQ0dU5xOFpvN01xdVA5MDd4YVdXT21mUGlob0kvTG01YU5B?=
 =?utf-8?B?aHJGajVDcUpFakwvR0N2N01udzZhZ0FxeEhSRzFFTGZQQmhYejlscXcvSFpF?=
 =?utf-8?B?STl3WXlEZU4vRXQvV0E5V2pEZnVITFdLdml0UUszL2d2WUhVZ0xabVdoRmRt?=
 =?utf-8?B?U3g1ZXVGZjhBTGN3ZitwOXdCQTF2NjFWUmZhc0k5RmZObXRCNjRuOTZzdU8x?=
 =?utf-8?B?L1hpT2hlbkN4bXpYVGhhb1IzVHhxaTFWayt6allIa0FwTkVHS2FRcEY2TE12?=
 =?utf-8?B?amtGL3I0WUxwUGNZcVZGSlpJY3EwM2dQd1VseWpOaHV6eTg3T1FWRkNmWCto?=
 =?utf-8?B?UzVWdm1pcGE3Q0JoaVRzQ1BNTVEvS3hpa3lEVnA2Ylh3WXJ1ckV2K2RldVk4?=
 =?utf-8?B?NCtiWG9xejJVT08xYitWTzZHUC91djB1Z3I1cWlWQkhQcVFLU01ac2pWeThO?=
 =?utf-8?B?anBQOS9rVzhwMmVBdzVDQUwvckpuMzJpQnhmV294OW1POW1jZk9RK3QwanNO?=
 =?utf-8?B?ZjNUcStoVFVnNlgxbTJUaW9Yb1lBTVdKaW9oWVNVRWtrNVhpSlhVZ0p1alh3?=
 =?utf-8?B?eU14QVVNbkM2U0dXRndXcGMxS0FTYWh4U3VwelBQeEY0eUt0T3R5STdhNmFK?=
 =?utf-8?B?aE5Dd2ZzZ2NCblNZZFlrVzBnTTFmTEUyc25UL2ZOVnFVZUt3NUQwYmYyZ2lU?=
 =?utf-8?B?cVorcFRUQkN4MFNndzYzMDMzTnduK3hWNCtYbkRzcEJXZzNzVXg1dFlRYUVx?=
 =?utf-8?B?WmRkSTFiSkxKNkpSNFQwMnJxb1NvWmsxU2k4b3N2MDNSdk5CWTZnRUw2Y3Z4?=
 =?utf-8?B?TnJ5NzRvL3hkWDEzS1RwbDhFTzZvOVlWNUhmWXN1ZjdQME16TXBrcmhvMXdq?=
 =?utf-8?B?ZEVmemtvWGdMM3hyQVROdDgrSDEvdU1aZU4yeTlSVWw4Y3RFZjNMaVBGZ01N?=
 =?utf-8?B?NFRMNUhCN1lsOTN5cGJ4b3dHbWZ0MlBpdndMMjNmY0RoWjFqZytmZE93WHhp?=
 =?utf-8?B?aDJpRnBDTjIzeVpNTXZ5Y0ZvdmdqTmN4T1JEdWNwRWtPTTFWS3IzVUZEWmk4?=
 =?utf-8?B?MXNJQ0Q5cExvcVVlY1lMUmNxNmpFb3RqSVFnSmcvL05TczBrTWpoeWNnNmtw?=
 =?utf-8?B?UTlOT0pUemRTZ09XMHBhUEEyUm1vUkllK0ppU0FBTUhEVFo1djNhL1FSTWhp?=
 =?utf-8?B?V1hQU0xWU0E5QkNMM2hyWXM0dXVZdDNVWE0rOXBydjM4TDJvazRlTmU4MnIz?=
 =?utf-8?B?THFCYUhpSk5WeUNsMXFBclNHeU9TZHhHZ0ZPdVI2Ukx3clNWWjgxUHNPZk8x?=
 =?utf-8?B?eVdmWUJ0aHl2OUdIcE5uR2ZQenI1NUR1VVpzL0ErZmxQVzB6MHh5VU5QU1Zx?=
 =?utf-8?B?cDg1TER3YmJoL2hmRjMwSEhUbHRYT2ozWm5sYTNuQnQwRWVhNndEVDJDRTQv?=
 =?utf-8?B?WDRIa01pWk13Vnl5cGlFbWxFKzg5MUlDcWgzN0ZGOExKSjZvbGZqcXdxTUZ6?=
 =?utf-8?Q?ZRzuebu5zLLJE0fmjD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5700d5-9e9a-4656-9031-08df0d0bda33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 18:14:27.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9UC7KF3q1o3aCtAVcaue7ekD3vTSs8X27fcFNDO+oUhWq3wAek8Gh27cuUBKuXSbUuvCnvArK4TjkprDeJaHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999328



On 07/09/26 18:07, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 9/7/26 11:33, Sumit Gupta wrote:
>> Hi Christian,
>>
>> Continuing the discussion from v4 [1].
>>
>>
>> On 30/08/26 17:26, Christian Loehle wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> The Performance Limited status bits are sticky and write-zero-to-clear.
>>> ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
>>> accesses.
>>>
>>> cppc_set_perf_limited() currently reads the register, computes a new value,
>>> and writes it in a separate transaction. If the platform reports another
>>> excursion between those transactions, the stale write can clear that new
>>> event.
>>>
>>> Write zero to the requested bits and one to the other defined status bits
>>> directly. Keep reserved bits zero as required for hardware status registers
>>> by ACPI 6.6 Section 4.6.1. This removes the stale read window.
>>>
>>> A partial SystemMemory field would still make the generic writer perform a
>>> read-modify-write to preserve the containing access unit. The
>>> per-descriptor spinlock cannot interlock that RMW with platform updates, so
>>> reject clears of such a field. Keep the descriptor mapped and readable,
>>> because reading the containing access unit once and extracting the field
>>> does not require RMW.
>>>
>>> Classify a field as a writer during overlap validation only when its _CPC
>>> semantics permit writes and its validated resource remains writable. This
>>> allows partial Performance Limited fields whose clear path was disabled to
>>> share an access unit with other read-only fields, while still rejecting an
>>> actual writer in that access unit.
>>>
>>> Also reject another writable SystemMemory field sharing Performance
>>> Limited's access unit. Its RMW could similarly replay stale status bits,
>>> and an OSPM lock cannot serialize against the platform.
>>>
>>> Also reject 64-bit SystemMemory descriptions on 32-bit kernels, where
>>> generic readq()/writeq() may be split into two 32-bit operations and cannot
>>> provide the required portable interlocked access. A naturally aligned
>>> full-width QWord remains supported on 64-bit kernels, where the
>>> architecture provides a native 64-bit MMIO accessor.
>>>
>>> Retain any inaccessible Performance Limited descriptor whose conservative
>>> physical range is still locatable, while marking both reads and writes
>>> unsupported. This includes a QWord on a 32-bit kernel. Skip its mapping and
>>> the flexible-address-space capability gate, because Linux will issue no
>>> access, without hiding the asynchronous status range from
>>> neighbouring-writer validation. Both the interval registry and pairwise
>>> overlap test use the larger of the access unit and logical field span, so a
>>> malformed field extending beyond its nominal access unit remains covered.
>>>
>>> Performance Limited status is not required for CPPC control. If firmware
>>> describes it without even a locatable physical range, disable that status
>>> register instead of rejecting the processor's otherwise usable _CPC
>>> package. Report reads as unsupported rather than returning a synthetic
>>> zero, and emit a single warning for each nonfatal fallback.
>>>
>>> Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>> ---
>>>    drivers/acpi/cppc_acpi.c | 76 +++++++++++++++++++++++++++++-----------
>>>    1 file changed, 56 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 25bccd4cfb34..a07440ed7f80 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -443,6 +443,22 @@ static int cpc_validate_sysmem_reg(struct cpc_desc *cpc_desc,
>>>           if (!cpc_reg_access_aligned(gas, access_size))
>>>                   goto invalid;
>>>
>>> +       if (reg_idx == PERF_LIMITED) {
>>> +               if (access_width == 64 && !IS_ENABLED(CONFIG_64BIT)) {
>>> +                       pr_warn("CPU%d: Performance Limited register cannot be accessed atomically; keeping its range reserved\n",
>>> +                               cpc_desc->cpu_id);
>>> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.read_unsupported = true;
>>> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.write_unsupported = true;
>>> +                       return 0;
>>> +               }
>>> +
>>> +               if (gas->bit_offset || gas->bit_width != access_width) {
>>> +                       pr_warn("CPU%d: Performance Limited register cannot be cleared safely; keeping it readable\n",
>>> +                               cpc_desc->cpu_id);
>>> +                       cpc_desc->cpc_regs[reg_idx].cpc_entry.write_unsupported = true;
>>> +               }
>>> +       }
>>
>>
>> Agreed on the generic behavior. With Bit Width 2 the remaining bits are
>> not part of the register, and the driver cannot treat them as reserved.
>>
>> On the firmware option, I confirmed with the hardware team that
>> bits 31:2 here are unimplemented. They read as zero, have no side
>> effects when written, and are unused elsewhere.
>> Future firmware can describe the register with Bit Width 32, but systems
>> already shipped cannot be updated. For those I have a patch which widens
>> the descriptor to the access width, so the clear becomes the single
>> DWord write you describe. It is pasted below and same attached.
> 
> OK, good.
> I'll start carrying a similar quirk like you proposed below on
> "NVIDIA", "T41     ", affected_revision, ACPI_SIG_DSDT,
> in the next version.
> 

Thanks. Two details:
- Please use "T41" without trailing spaces, as the OEM Table ID is NUL
   padded on this platform.
- The DSDT reports OEM Revision 1, but firmware may not bump it when
   the Bit Width is corrected. Using all_versions and widening only a
   descriptor narrower than its access unit avoids depending on that.
   The fixup becomes a no-op once firmware reports Bit Width 32.

>>
>> Testing with that applied uncovered a second issue.
>>
>> The commit description says the status bits are write-zero-to-clear.
>> I could not find where that is specified, have I missed something?
>> ACPI spec describes the register as Read/Write and requires interlocked
>> operations, which reads as an expectation of read-modify-write,
>> but I found nothing defining what a written one does.
> 
> Ah right :/
> Yeah that's really unfortunate then...
> 
>>
>> Here a written one sets the bit, and the hardware team confirmed the
>> register is plain Read/Write on my test platform.
>> Writing CPPC_PERF_LIMITED_MASK & ~bits_to_clear therefore sets the bit
>> which is not being cleared, and Linux reports an excursion the platform
>> never signalled:
>>
>>   #cat /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
>>   0
>>   #echo 0x1 > /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
>>   #cat /sys/devices/system/cpu/cpu0/cpufreq/perf_limited
>>   2
>>
>> The read before the write avoided this, at the cost of the stale read
>> race you describe. Clearing both bits would still need no read at all,
>> because the value written is zero in either case.
>>
>> How would you prefer to handle that?
> 
> Yes that's a good question.
> I think we should just not support partial clear then.
> 
> Reading the spec and given that these are supposed to be short-term
> excursions I wouldn't think that keeping the register as read-only makes
> much sense, therefore just support full clear and document the race window.
> I think dropping the stale read still makes sense, even if it widens the
> window, it'll be there anyway.

Agreed, the window cannot be closed without a hardware interlock. But I
think it is better to keep the partial clear. The race loses the other
bit occasionally, while a full clear loses it every time.

We can skip the read when there is nothing to preserve:
- If the request clears every defined bit, write zero directly with
   no read.
- Otherwise do the RMW, with the missing interlock documented.

If you prefer to drop the partial clear, the ABI documentation lists
0x1 and 0x2 as valid writes. So that would need updating too.

> 
> But I'm happy for Rafael and you to chime in, too!
> Do you have any userspace actually caring about Performance Limited?
> What would be the most sane behaviour?


No utility consumes it yet. So nothing depends on either choice and
it can be decided on which behavior loses fewer events.

Rafael, do you have a preference?

Thanks,
Sumit
....

