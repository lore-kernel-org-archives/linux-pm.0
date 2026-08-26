Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1BC3E9F9E;
	Wed, 26 Aug 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753865; cv=fail; b=Wg3/1eQay3vHy9gCj5/Ngphz8ddxwL3YYbkosA0bbWjvTritXZZSLKrFAllKjJqRtEEQprDHql1aK/zFEcFBTM6zVtYOWjUo/qINWq1B0rrxJk/DTOzb/kecYezsdIDHgsiIZk+43orJrvXqXOLG0ObV+25c2E07vJHIOoP5Hoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753865; c=relaxed/simple;
	bh=vFZokmFduFJWRCw7fBDe0+uuXZNY4w+iYwYMtVUQFII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A5YIZ4/Q8FIWVHTX9F+1KKCBaU0ndOz03GhNQrGaIRVpQSCaiCzJcs5d2HR3rWQTdEuYC6ZjJJna57BsU59Bz2qfBJIhQRwS6SX8es9qqXNZEU9XOZ10oXNUsGEbiuBNvzJ8UrqTBCi9jDP1JV/6UiZeKeJEakF5JCTai9ajWRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sKPrCg4Z; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sKPrCg4Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3+GMRsuTuFrPoXKaprvRO2vCY1ygAVGj36Q1cUyck1Dz9z7pKeK8xeHJKNhXeV8/cG4GzYPyx2upyxGDQgUbWB/zTq7LwYdS212rTZ9IjblQSAyOeU6SLnpVw4j0mhQtHdwspnTUxwGVU4I0KYFSxWkSUN/OWtqbmQ8v3/Fgca8aZxuLTM1Lw7OwZlZiUB0SEDW25Ucm7t2Tf4N9ZNQeTikTc3+CWkWG5E19iI11FJR91IExFttf/BqeXgn0f1ayUl7q1oM02uvkAKEosVp6fFYTkLirpEQkTxXDxGcFexNyw3Kclt8rIq22AxJDFBU6KSFK0IhpLsI9BqiNKhZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGaX0tg5nEaLSOyxn2dqwQJfDks8yIEEU0kQYMstNtU=;
 b=W1Wsn9CBvdzvV2QJRblh1AxCvkxIMrMm1kXGEwNxTujcSKLC6lnC6DtsZkf45RbCRQvz7E7GEWElSIX2BoG7waj2OJhXctiT6JVg2TFMTX5rEN+0+QGZw8cgE99c1cYeqmIdan3L0C4RDqNdYY87OJ15WVONrHkZqrFF1d2kD21TWXElf6NwNEjIXBB60cyUAO8dCjtCT1WL6P5NmMLHnR6J6IgyGt8XGZO2xXocRid8tc23j1JLR48CCrPCQZ0p6T9ylT1Z4ZWql7IKKYJMReBVhSiZ4t7Apf1sFOUm9yzLFwL0qqXdWiYI1D3u87K+RY4e2/5hPdoqjLoUJlhhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGaX0tg5nEaLSOyxn2dqwQJfDks8yIEEU0kQYMstNtU=;
 b=sKPrCg4ZuyePBscitbjdNlR1ARovt6+5/fP9EjKHzzZ4p1RI0dSeUDeNMoFmLslgUxurw9NuQF7TLAj3RtD49QfooXwOWBpDlSvvk5PO9hakxA7jweMDbPuWk6F3YWYcEGzDaUw9ga2CWBqg4KBuDXM5/AUslq97KTf73Lc1OQljQdqxO90P7zwiScJFYrBLEGyIJzCj+dW104n2+1ph7WeVeDKB2qQ4XZVWH12LF36d86zOYqrpXlogRozlD2OlbM25/C6GYNDyqQ7aBhUxmktqBS7MT+/5lQRYIUKNNOM07imGSenxzKqi4TfCNZ3OBiKI+qRMsJ5k1cavNrkqbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 14:17:34 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%6]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 14:17:34 +0000
Message-ID: <d0b220d4-1cf9-49c0-a8e8-3613f76feec5@nvidia.com>
Date: Wed, 26 Aug 2026 19:47:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] ACPI: CPPC: Fix register access and lifetime
 bugs
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260826063019.670240-1-christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260826063019.670240-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::11) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f49a666-d602-4dad-fe18-08df037cc60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	RojFlQ/PmPbjFiuuwDLR7/ogw1/Nj+GcAI2CpHWjhi5TK29FNhhLPBiUWCe6MBO71s4rTedu20kEbHaw+xjMLlO3S3IuBE0HBgE2Ji1eSqDobGEBhp7lV7mpIPToYEN2Qw1Z3+T68e2NX0f7xBGLNRbuH7++jTFCCpgyBpPg4i9Z9/B+GkJZoeLDfODM/fZMNJ0mx93p7tfMcEMAJd5vZ8Prr3fvucZdw5B9NuxzF2s0LOociGdnSaVZ0N9JT9LYwe8Is4almIkAbgeSr1kZCgphLu7M0sRK8IlaNIxz8Q9EJvY35Y/YTL9nachj629ik/pXfCr+1qSbQCTnzaoD8NUo9QjiXSMmsrNubnRoux7tOjbrjElF7yEcigb8/BaOLQ7duDrQ2KrcpOshNEIyPeTgkMqsZcOHgcGE1dLhc5zQoJey6J/XtsSHkCckeYG0I7ZSLhzpxde4GxzdtrPkhcdsYoFJ8rCYAaAt3eEXSRY9SOEKHzKllAX/RKxHJ0f64a+8/53s2c7lRcGOWaHdnZ2JsBevy6TTExcmzABE9nEsJOcmt6Q7VqoBmiNgSo9hARugZJCqEBZmdRm4JRbSLbDaYa/0XTjMChc0wEq2XZ3gDbCQmBpPIZANMNfyIkVwxpPIxtqsY+8qK3iFYd/G5j2IH1VYfcOvVaoQjk87zjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEN3RVdjSE8yVzF6WjY5eU9nWWdsZ2ZyNlV4dHBMUE9VeHBXMlhBWGhuMFYy?=
 =?utf-8?B?NGJMRktvdnFBdU5RZlZidklPVGFSTTBIUjlhL0pSNjJ0VU1RR1V5REFsVVpm?=
 =?utf-8?B?bjY2Uldzb0tVQmEzSWRVZHArK1B6RjcvVGN6emJZays4WFFTY3B4UDFsM3ZU?=
 =?utf-8?B?RGVQWTg0TzhDWFZwZ0F0RzlXazBMajlBcHdtV1J5RURGWEJ5NnB4OWZwS0dj?=
 =?utf-8?B?dUJTRXZ2anJ2Z2c0MTk0aXV0MEs2dmQ5Q1lUM3p5OGlneitvQjV4U3JjVitD?=
 =?utf-8?B?QnFDclpJSXQzWk5pWW5mVi8vbzFMTTJTSUJrQ3ZoQ2haTmpHemN5c0x6czBj?=
 =?utf-8?B?Nk5hNktqaUpJSXh5NFV5RHV1OVZnVEZISzIxdlVoNEw1ZlhuaUt0UVA2d2xL?=
 =?utf-8?B?NFRXUjFnK0FDVWZ0UU5RY1NjZ2FJbWFGOFZqUW94Nkt5djFqdVhLbG5yVnBF?=
 =?utf-8?B?U2FTaGRRelhaYkx2TVdIZ1BVM3hiU1oxSStoaWtSTGhVSitBZ216TjBHRVlq?=
 =?utf-8?B?NEk0Ulh4QVNtcHdOZnFWNmxoNHhNZlIyTzl5UGNUTEY5U1U0SjBGZmlTdnF3?=
 =?utf-8?B?M2Z5aDRNcHd1YnNPRHJXd0orbEUvNXpNNTJNcmduZkgyVGZFK2w5dU9xVWRJ?=
 =?utf-8?B?V0lNK3VieVNLZGFSREg0SFFZdzVZajRzOTdFNkQzbFY1dVJBQlk4UkF0c3VS?=
 =?utf-8?B?T1dRWW1BbFhYZUJjNTJlUytOc29PZHJMRFV5VzNXUHYrRHBpYkYzRFJScGVi?=
 =?utf-8?B?dDRIOE0vZTB6SXFEVis3cDhqWFNETWg3REZlQ3Jxd2RHa2NIcUhjRWdIc01z?=
 =?utf-8?B?K0ZDMEdXNmpzZnR5M01sSWdxZGwyZU42RW1jdXlyTm1BMHREakdKWVA3UUtQ?=
 =?utf-8?B?Y3hhY1hJa2xteUVzcTFrTDZtZTdxTndJd3lHY09VOXZxOGlpWWNWR2lqVjVT?=
 =?utf-8?B?S2x5Nk43ajBkdjN4SGpyaVRoZTRhV0EzRlV1Z1R5aGVZTFl0TENSdWZBVHVi?=
 =?utf-8?B?TUtpaGVHMk9MTWh5a0xsclJVZllhNVYzaXViUFBLT2JnYW5yamQ2UzRjQks5?=
 =?utf-8?B?Z3F0cmM2aFNLTmg2OWJWakFCZlJJK1Eza2Vnbm5hV0hTczdPUUJWdXpxSzNz?=
 =?utf-8?B?b25ZS05aOTB2TU13L3RSckxxQzlBOHNFQzBKNkRPTGU2WUw1THZXVE90ekty?=
 =?utf-8?B?RWI0VVpQNlRFZmhidkE2OS95OHB3R0tnU2JhQlQ2ZFVFNDluY01FWS8wdlVS?=
 =?utf-8?B?Syt2SzRDdXQ4THR5OWZjQlVQZjJjN3hvaVc4YTY0ZU1menFQT2thaDNIdlEy?=
 =?utf-8?B?cW1rRittampRck9UdFFWcGFRRHBQRjhEVDZUS2k5dTg5dGhxQU80b1dGZEky?=
 =?utf-8?B?bGNwZ2dQWlhWRThzeEQ2MDh1SERuZ3ZHQ1RUeGRuMlZOeHdoRy9VaGlXa2lF?=
 =?utf-8?B?dy8xUlJKSnVGQTgrTDEvS0E0aWtzVE45bHhYdUE2T2Q3Yk15ZmUyZW1UVTgw?=
 =?utf-8?B?TlNRWHpMWHB0cnZsdThxWFNkSzc0VDF3bTgvSUFOUWFUZW0ySk5KWG9nVVB3?=
 =?utf-8?B?NU92WW5mMU5ENHM1aHZCUnJ6NzB5bFViaXNxb2c2MjBadjFrU0NFb2gzdzNQ?=
 =?utf-8?B?V3Vua1RUN3grNGFsVVVOQitCOXM1RUJjS2ROb2xuc21EUE1QUUJNNFhWWnl2?=
 =?utf-8?B?Y04xWENXNlExczBGZlhhaDlFcktHY1VRdzU5dE5NWTNCZlk3SndFN25oL2VU?=
 =?utf-8?B?SS81M013ejlJcmh4MktuYVZETG9EM1crM1ZMSXp6ak5kSVNSaU1qZHdmNWMy?=
 =?utf-8?B?NURvWFMvNFdMd1ZYNC9wTktyY0s4ZmJCbFA4MlRLTzJCa1c5SlVUQ3l4SG9s?=
 =?utf-8?B?enZhY095OFpLQXFhekc2Y2JxbXRCREFraEdzVko4a3I1TFBwZ0dleVlaTkFq?=
 =?utf-8?B?c3VBK2c0RVhGNmwvMlhuekpPTXZiTWQxaTEzRG1uVFlwQWtYYWZmZ2pWNm1m?=
 =?utf-8?B?V3JOUitmbnFGc1Y1SytGZ0tIVTE4MmRmUGJ1TTJWZ01KSXJsYmZzOUNSeFNu?=
 =?utf-8?B?Z2NDQy9JS1V1WE52MS9nZ1V1WXJCazF4SllRZkdJQitjTWhPU2JzRXlVWEhi?=
 =?utf-8?B?Z1dHczg5V05wRUoyK3R3N3d4VEdhMG1Yb0JpclZoZ0ZucWpaUVJ0ejJOQmNo?=
 =?utf-8?B?N2svSkw3K25qN1MzQnNTdnA0MUFGNnVaQStFYnhXY3RTRXpXbGI3S1lSZGJT?=
 =?utf-8?B?bjZiRnhYMTZNNXlQMU1OQXRqNk1qMXhzMzRCMndyNkNrYXg0TmN1SzE0Rklq?=
 =?utf-8?Q?pzBTFtFqoRyGAEfVBG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f49a666-d602-4dad-fe18-08df037cc60c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 14:17:34.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6midxoeSXV0qp1RWhkFNViTYLT1PWH3/OsQuNdK2qVOgdvzn8CZLEtErYDyf1tmTq9geCJewrc5+/Y8JnvfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460


On 26/08/26 12:00, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> First of all, sorry this got so out of hand, initially this was just
> trying to fix some relatively simple issues found by sashiko in an
> earlier (unrelated) series.
> But with me touching more and more code and going through rounds of AI
> review that kept finding more and more pre-existing issues I've arrived
> at this.
>
> This series fixes correctness and robustness issues found while reviewing
> the CPPC control path. They affect malformed _CPC handling, error
> propagation, PCC ownership and cleanup, CPC object lifetime, register field
> access, cross-processor aliases, and Performance Limited clearing.
>
> Series structure
> ================
>
> Patches 1-8 are deliberately small, independently useful fixes. They
> validate the _CPC encoding consumed by cppc-acpi, propagate control-write
> errors, serialize PCC payload updates, correct 64-bit field masks, and fix
> descriptor and PCC lifetime handling.
>
> Patches 9-15 are the register-layout hardening portion. Geometry validation
> is more substantial because safe RMW and alias handling depend on the
> physical access unit, not merely on a logical _CPC entry or _PSD domain.
> These patches normalize and validate each supported address space before
> building probe-only physical interval registries. Keeping this work in the
> same posting gives the complete safety boundary and a single base for
> review, while each transport and bug retains its own Fixes provenance.
> Feel free to treat the two parts as independent series, I didn't split it
> because they're all technically fixes and to get Sashiko review for the
> whole lot.
>
> No interval lookup is added to the scheduler hot path. Full-width
> SystemMemory writes remain lockless. RMW locking remains necessary only for
> a partial field, where we must preserve the other bits in its access
> unit. The existing per-descriptor raw lock continues to cover disjoint
> partial fields within one _CPC package; probe rejects cross-descriptor
> layouts that it cannot protect.
>
> Parsing and control semantics
> =============================
>
> The parser now validates the package header before indexing it, bounds the
> BYTE and DWORD Integer forms before conversion, and validates the Generic
> Register descriptor consumed by cppc-acpi. NumEntries may not exceed the AML
> package count, but additional trailing package elements are ignored because
> doing so is safe and preserves compatibility with padded firmware. The parser
> likewise tolerates trailing ResourceTemplate data instead of imposing a new
> EndTag compatibility requirement.
>
> Writable controls must be Buffer-encoded registers. Minimum and Maximum
> Performance are checked as the pair required by ACPI 6.6 Sections
> 8.4.6.1.2.1 and 8.4.6.1.2.2. Object presence is kept separate from the
> Integer-zero convention for absent optional fields, so Lowest Performance
> may retain the valid abstract value zero.
>
> Performance Limited is one deliberate compatibility exception. ACPI lists
> it as required, but permits a platform with no limiting indication to
> always return zero, and deployed firmware represents that case with a NULL
> descriptor. CPPC control does not depend on this status register, so we
> continue to accept that encoding. A present _CPC package which otherwise
> fails parsing or initialization now emits an error instead of silently
> preventing cpufreq registration.
>
> Compound performance and EPP updates propagate errors and perform every
> fallible non-PCC write before modifying the PCC payload. Updates across
> address spaces cannot be atomic, but a known non-PCC failure can no longer
> commit only the PCC portion or leave an unsent value for a later command.
>
> SystemMemory locking and support boundary
> =========================================
>
> A partial SystemMemory field requires RMW to preserve the rest of its
> access unit. Commit 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage") used
> a per-_CPC lock and noted that a global lock would be needed if physical
> registers were shared between packages.
>
> ACPI does not make _PSD a physical-register ownership boundary. Rather than
> put a global raw lock or lookup into the scheduler path, this series makes
> the cheaper per-descriptor model's assumptions enforceable at probe.
>
> Supported SystemMemory layouts are:
>
>    - naturally aligned 8-, 16-, 32-, and 64-bit access units;
>    - lockless full-width controls;
>    - read-only aliases;
>    - exact full-width writable aliases, including 64-bit aliases on 64-bit
>      kernels;
>    - disjoint partial writers within one descriptor, serialized by its
>      rmw_lock; and
>    - a partial writer sharing an access unit with a disjoint read-only
>      field, except Performance Limited.
>
> Probe rejects overlapping logical fields involving a writer, another field
> inside a full-width writable access unit, cross-descriptor partial writers,
> writers sharing Performance Limited's access unit, unaligned accesses, and
> exact writable 64-bit aliases on 32-bit kernels. These layouts were not
> safely supported by the old per-descriptor lock or generic writeq();
> rejecting them turns possible corruption into a visible probe failure rather
> than removing working support.
>
> PCC access and locking
> ======================
>
> The PCC protocol requires OSPM to acquire the subspace before changing its
> command or payload. Single-register and EPP updates now hold pcc_lock
> across ownership acquisition, payload staging, and command submission.
>
> ACPI 6.6's implementation example places a mandatory 32-bit Delivered
> Performance Counter at unaligned PCC offset 0x116. Performance controls may
> also use byte-multiple widths such as 24 bits. PCC therefore uses
> byte-oriented I/O with explicit little-endian encoding for zero-offset,
> byte-multiple fields from 8 through 64 bits. A short per-subspace payload
> lock protects concurrent aliased copies made under the shared side of
> pcc_lock; it does not replace the protocol ownership lock.
>
> Bit-level PCC fields require RMW and remain unsupported. An unsupported
> optional field is marked absent, but a present inaccessible CPPC Enable
> fails probe because OSPM must write it before using CPPC. Thus the
> ACPI-legal one-bit CPPC Enable used by the specification example is a
> documented kernel limitation. The old accessor could not program it
> correctly either, so an explicit error is safer than silently proceeding
> without enabling CPPC.
>
> Every retained PCC field is bounds checked against the shared-memory
> region. A subspace-keyed interval registry permits read-only overlap and
> exact same-control aliases while rejecting every other writable overlap
> across processors.
>
> SystemIO support boundary
> =========================
>
> SystemIO supports Bit Offset zero, naturally aligned, full 8-, 16-, or
> 32-bit accesses ending at or below port 0xffff, including legacy Access
> Size zero when Bit Width supplies the size. Partial fields never worked
> because the driver neither shifted them nor preserved adjacent bits, so
> they now fail visibly instead of being misprogrammed.
>
> On kernels without CONFIG_HAS_IOPORT, SystemIO entries are rejected or
> disabled according to the affected control's semantics. Runtime accessors
> also return -EOPNOTSUPP rather than treating an I/O port as a
> physical-memory address. A global port interval registry rejects
> cross-processor writable overlap.
>
> Write-only and Performance Limited controls
> ===========================================
>
> Between _CPC revisions 3 and 4, Desired Performance changed from
> Read/Write to Write, and revision 4 added write-only OSPM Nominal
> Performance. ACPI 6.6 Section 4.6.3 says reads from write-only positions
> are undefined. Explicit reads of both controls are rejected. Partial
> SystemMemory fields remain writable because RMW replaces every bit of the
> field and therefore does not propagate its undefined readback.
>
> Performance Limited is sticky, write-zero-to-clear, and requires
> interlocked accesses under ACPI 6.6 Section 8.4.6.1.3.2. The old separate
> read and write could clear a new event reported between transactions. The
> clear path now writes zero only to requested status bits and one to the
> other defined bits. Partial SystemMemory forms remain readable but cannot
> be cleared because a spinlock cannot interlock an enclosing RMW with
> platform updates. Probe also rejects another writable field sharing its
> access unit. QWord forms cannot be used on 32-bit kernels, where the MMIO
> accessor may be split into two 32-bit operations; naturally aligned,
> full-width QWords remain supported on 64-bit kernels. Since CPPC control
> does not depend on Performance Limited status, an unreadable description
> disables that status register instead of rejecting the processor's
> otherwise usable _CPC.
>
> Lifetime and cleanup
> ====================
>
> CPC descriptors are released through their kobject callback, keeping their
> storage and mappings alive for outstanding sysfs references. Every PCC
> allocation, reference, and acquired channel is unwound on probe failure,
> and the per-CPU PCC index is initialized before every early return. PCC
> allocation uses a separate temporary result, so its success cannot turn a
> later parse failure into a successful probe return.
>
> Changes since v3
> ================
>
>    - Allowed partial SystemMemory Desired and OSPM Nominal controls when RMW
>      discards their undefined readback, supporting NVIDIA's separate 9-bit
>      controls in _CPC revision 4.
>    - Reported an unavailable Desired Performance control as unsupported from
>      the common getter instead of returning a synthetic zero.
>    - Required natural alignment for SystemIO access units, preventing faults
>      on architectures which implement port I/O through Device-memory MMIO.
>    - Kept partial Performance Limited fields readable but not clearable,
>      rejected another writer sharing their access unit, reported fully
>      inaccessible forms as unsupported instead of returning a synthetic
>      zero, and consolidated each nonfatal fallback into a single warning.
>
> Changes since v2
> ================
>
>    - Relaxed the exact NumEntries/package-count match to tolerate safe trailing
>      package elements while still rejecting any count that could cause an
>      out-of-bounds walk.
>    - Made patch 10 independently preserve immutable-autonomous setups whose
>      inaccessible Desired Performance register requires RMW, rather than
>      relying on patch 11 to restore that exception.
>
> Sashiko v2 review not addressed
> ===============================
>
>    - Kept Guaranteed Performance Buffer-only. The suggestion was to accept a
>      nonzero Integer, but ACPI 6.6 Table 8.23 permits only a Buffer for this
>      entry.
>
> Deferred follow-up work
> =======================
>
> Sashiko also identified a broader pre-existing lifetime question which this
> series does not attempt to solve. In-kernel accessors read the per-CPU
> cpc_desc_ptr without acquiring a reference, while processor teardown can
> unpublish and eventually release the descriptor and its PCC data. The kobject
> change here fixes the concrete sysfs lifetime bug, but a NULL pcc_data check
> would not protect a caller which already holds a stale pointer. Closing this
> properly requires defining the kernel accessor lifetime contract and then
> using CPU-hotplug serialization / safe referencing across all callers,
> therefore will be handled by a follow-up.
>
> ACPI-legal bit-level PCC and SystemIO fields also remain unsupported. In
> particular, the ACPI example's one-bit PCC CPPC Enable register cannot be
> implemented by the old whole-value accessors. Supporting these descriptions
> requires transport-specific field extraction and an RMW operation which obeys
> PCC ownership or safely preserves adjacent SystemIO bits, just accepting the
> descriptors would silently program the wrong value. Therefore continue to
> disable optional inaccessible fields where safe and reject a present
> inaccessible CPPC Enable control.
> Full support, if even needed, belongs in a separate follow-up.
>
> The review additionally suggested validating the complete AML
> ResourceTemplate, including its EndTag. We currently validate the Register
> descriptor we consume and tolerate trailing firmware data. I don't really
> see the point of ever doing this, but definitely not in this series,
> where I'm trying to guarantee that no reasonably working platform is
> regressing.
>
> Patches 1, 2, 4-7, and 9 address findings reported by Sashiko while
> reviewing:
>
>    https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
>
> Patches 3, 5, 6, 9, 10, and 15 address findings from the follow-up review:
>
>    https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
>
> Patches 1 and 10 address findings from the v2 review:
>
>    https://sashiko.dev/#/patchset/20260808082644.1251332-1-christian.loehle%40arm.com
>
> Christian Loehle (15):
>    ACPI: CPPC: Validate the _CPC package header
>    ACPI: CPPC: Validate _CPC entry and control semantics
>    ACPI: CPPC: Propagate performance-control write errors
>    ACPI: CPPC: Use 64-bit masks for register fields
>    ACPI: CPPC: Serialize PCC single-register payload updates
>    ACPI: CPPC: Serialize PCC EPP payload updates
>    ACPI: CPPC: Release CPC descriptors through kobject
>    ACPI: CPPC: Release PCC data after probe failures
>    ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
>    ACPI: CPPC: Reject direct reads of write-only controls
>    ACPI: CPPC: Validate and access PCC register layouts
>    ACPI: CPPC: Validate SystemIO register layouts
>    ACPI: CPPC: Validate PCC overlaps across processors
>    ACPI: CPPC: Validate SystemIO overlaps across processors
>    ACPI: CPPC: Clear Performance Limited without a stale read
>
>   drivers/acpi/cppc_acpi.c | 1313 +++++++++++++++++++++++++++++++++++++++-------
>   include/acpi/cppc_acpi.h |    8 +-
>   2 files changed, 1131 insertions(+), 190 deletions(-)
>
> base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
> --
> 2.34.1

For the entire series, except patch 15 where I replied separately:

Tested-by: Sumit Gupta <sumitg@nvidia.com>

Thanks,
Sumit
....


