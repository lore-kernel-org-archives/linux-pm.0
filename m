Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793804940;
	b=EmgYRxkT6d1kOohjDDAsFBIhZwhR/mF4TxpHm8BB++v9yoJ8+Zxi6/bG8d2NUY04zjHL
	 JwLsxXVWoYRJGQnoMB7NCx2KPIuW5aOUjT4a06HTkNpEsJ/Mua+s9Jqqckw5wYVLBOqQc
	 f3Th7TVsTQ3WUuPXuQsUDiCjNw9+2GxMddyQPrDmkCxfCJHAXucUm6FTiAHwBdKhlGZ4g
	 EuKvQyVm78ftKlgchSYsdgdFOrcB9bhqlZmVfkaw8m8tTUXLsjRtCSe3KxsVzE6Jku+Ez
	 X2CpixM3DC4gOMSh/OppKIoE/brpPlBpJVPts60zQpqmP4MoZj66wY/QKAKXd+q3idQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804940;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=r2m7d82psHbVoULaiy2tqIpw9L12sh7/1C3DaZ04tSk=;
	b=KLDu8yUbu9whX/xiQ0b6jX+LRvoUYG60/PDH11Ez9g4aXM6V7rJqOCgaYul6QXREP+lg
	 fVPJ1HOvGdBKK7Duipkb20nTPdQBHAj+0IwWsCHdZoM7zfZMolbaA+uCJBdgdE2hczZuE
	 /k9j8Ll/MmknIkK+zbgHaUr3l0PeEVWuEe4oR4ZAmMw6XfkUTjmVqn468m73qf1NDeqiD
	 Y8sE5+xebNHwQRnByYIIfCG97tm2ff28nnQ7Uw9dfjbXb0JV6HGcKfV0X06wbu0eG+WUB
	 CX95SNN6jDNqGNTga/ZSdgIN8c5EZiMEoIxp4a8Q1DjFvtBAu1jvOnw5V2CyBvePwkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UubxFMw8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9E606A31B;
	Wed,  4 Nov 2026 15:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF9E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UubxFMw8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExIxMcgvRTh3+dLGXqmtvE+SUjBE9DO14/cSWeqBnCW+8F1AiKYrsjd/CPBS5X7J+KE9AWmq8lk5/nfFvvp/6pcLRyUWsILrR1FyQdREs/rTwxl50vQ9SzhbxwKuFDyi1bf/APorxR4yBACa8xnD6GL70TEG8z+f5QbfUJeBWEGaYDYcb5GKE1l62P6+IJq1ZLULcOGfhTJ6ix4z3KfRRPv3UHyu7b3kYNL5joC976sDwpCMp+uQgR3pw6TnppDZYC8M1Yz6Mm3yiNKNQPqQpOTAx8OVPD66qtoWaJ0v9/rCyYwwy/w8Otke6E4dbVh6svdIisdC1653NPn4RqAHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2m7d82psHbVoULaiy2tqIpw9L12sh7/1C3DaZ04tSk=;
 b=GqDFP3TT4GiBF3caUUlX7xHpfg3fNstfyidtzeeNmgv1J6kxAazd3gh7buUI/0SXSpI/PktEOrlIzb6BKGAG9DJqc2nXjc8gWWjBO5iOPtYJ29RgoGoWaNcA8QU0N/E5BuadriavQUrkquLPAi8zrz0+iBjsJEnyj7CDzVoOpdMPFEhyFGQhHGkYMIrfoOvV+i63LOrfoUdJNl4UegANdsLvGUVGTGraRSStiCksWjH1KF3V/L8Lt5lu+gYb2p+W2QxjDwCez71Fx18nC/MzginF4hArAg4THMFYUCwhaSNQbT95tklFIOt25oU+ANcbBahpl0XaCe/nKlx1CV8bpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2m7d82psHbVoULaiy2tqIpw9L12sh7/1C3DaZ04tSk=;
 b=UubxFMw8YrzSbofFubIQpGgTv378Os6mvdIscqkfrYgBiWpUlU4JdnR7T1+4PB0WRRSbm4TPcO2NulKRnzfDF9Oab2nQGb3zcWLdUB04ynMMz004WpyKaPKdfIFT0OJLKXsY359nNntdkZMkvKtH1wiHSF8EfqsWvuFK8FvZkWcKgXQ0lhhvrgQ0rny6uVaB40uSACNlQZNETht5eafWW3J6uRRsNJWvzWSr1avzn0acxynERxX7KPBk5FV8Z9Pe1Rkm0gG6Y/00k0aX0Fu9Rkm/VAm7pdLI+roo03HwNtqALcUBQY3eJa/IRN7GaSLHc05ZJIzhtzDW5FPoq1ho5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by MN0PR12MB6271.namprd12.prod.outlook.com
 (2603:10b6:208:3c1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:08:54 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:08:53 +0000
Message-ID: <4d9aa879-316c-4188-bc5a-71e3b65e8a3b@nvidia.com>
Date: Wed, 4 Nov 2026 20:38:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] cpufreq: CPPC: Reflect the OSPM nominal in boost
 and limits
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 mario.limonciello@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20261030172745.2045743-1-sumitg@nvidia.com>
 <20261030172745.2045743-4-sumitg@nvidia.com>
 <6392b2cb-0cbf-455a-8c05-c273535b2c10@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <6392b2cb-0cbf-455a-8c05-c273535b2c10@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::16) To CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10)
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
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 195e9ebf-653a-4728-207c-08df3a8589c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|6133799003|10067099003|22082099003|18002099003|921020|261022105027099003|11063799006|4143699003|261026121527099003|261102123227099003|261021123027099003|56012099006|261028144727099003|261021121427099003|261022075727099003|261026140227099003|261009223027099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	0xo/zKjZq1LbdUB/aaa99RVNRBn8+/8jbQeESQUbDnwCji7TPCNLwbD+orAqpG5hyC344Z1UDe+qA55Oia/LYJ9VqY1nJAwsxN4hp1E4t8cTM8xNiZgDO9V5jlMy8FqtJI76F7q18P4gN8NdGFZrI58kF4XS2x0ETeb8sV+OXZV2y7Dydbm4MMAWX9s/FR+LVTGEVI7Zn8ZbB8lQFiv7bUIskBmslD4z+h8hzAq+e3k4ui80SAIa1cXmYEfK0p93OZaoGxNm207aAJrqpL64AU/SI7ndtrucUO18+MOSBJBC9+xhaaiHwSsha3P5xdSiy9NgpigWyl5kfGvVruO9RmBfywFOlvXbpxq5rBE5LMp44tOXC44gMiMrHJ+Mt1S1CIyZa6AblaxTPNDKAs3P6PdB3/uJG53/QUgss+yYzhvSjuVOyix7WfIT3T6O0cgGc1sffrOEfbAlr/GWW0qCXozW7SdO/Z/1ItV8cy6GZQcmsF0Fqy4mcEIVxzaFrM/PYRSaKtUHdi6d+8LWvv7SQgRTju0hiU1nHcV6v3aAtmF935nswUfKMoHdDGHTPeXPMJwD9GBlRzgpy2jpSoirw+XtUYhRV8mIwNe1WaQViKUeFuBss1BOb0ShbM8VNe+2SjQg6HurCRMS6+WeCC5yReUitlrgavFHjN0jYesXGLvsjNdT0p9PnYOy+ItUt8GdnThi3Vl47vR0adqj7N4PPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(261022105027099003)(11063799006)(4143699003)(261026121527099003)(261102123227099003)(261021123027099003)(56012099006)(261028144727099003)(261021121427099003)(261022075727099003)(261026140227099003)(261009223027099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU5IN1VaSzBJMFowNGNkZ1FJb200V0xNaXQrQ3AzU2NEeVl4NEgwVnNRSmQ5?=
 =?utf-8?B?OG9pS2VwdlgxYUVFbE9CbWVsVXV0c0p3QytVRjJPUTQ5cU9kT2F4dlE1bnZt?=
 =?utf-8?B?MkxRaFIyYlphajRDRkw0ODBZdklTT2tuTzBUYloxUStWQkt6YWhRS1RMSkxz?=
 =?utf-8?B?cU4xN2hOekM0Q05GaVcvR0JkQzZtNnJZdDlkNWo0NDR3Y3AzbEVTcG9CVGRH?=
 =?utf-8?B?MTZCeitqRE1wWktqNjJnRUxDMElxRk5DQTdmR3ZzZ01BbjY3cVprMW1UdWJw?=
 =?utf-8?B?RHpMdXR5c1N3V1BpWEVTTUNDemUyTHdkUUU2ME5IMmJxb0xIT0FyU0NDT2Jl?=
 =?utf-8?B?Nk1IQzdoT0tCYXJuZG5OV1hMak1ublk3SkpvZng1T21lajRYRXVKazU3eUNo?=
 =?utf-8?B?Sm9IcUpYRHNYWnlvbE9DalBsYzM0d2pzOThnNFMvNFZGTWR6Z3FUeW5wWGNn?=
 =?utf-8?B?em9ra2N5d05HRHZ1RTljcTIvUGt2Q2o5SzZKT296NU9PSjViaEtsZGNMWmJZ?=
 =?utf-8?B?NTc4ZnR1NUNwY0w3U2RVV0JSdEJyN3ByaDJPenFBVHBlamJnOEhDa3hHQnpN?=
 =?utf-8?B?RDJPeitCUlhFM3hXcGtVbm84b202T3Rjb3VtZWMyWmdUUDJaR3hNZEFCckhI?=
 =?utf-8?B?eG44RWgyU0UxQWlkRS9YZzJMSmdFNE5IUlJucTY4bFdCV2RpekZ2aUpHT2lj?=
 =?utf-8?B?VnFxUVhBbEx0TEdwOHhCOUEvWnM1L3BUckNPZitIUWdUN3lJTHB5YUtJd1o2?=
 =?utf-8?B?akZKOU1QYlg1ZWpJeVlkMjgxRFdSL1pGM29mU2ZkSERXR0hGVkwwZXF0cmdW?=
 =?utf-8?B?TWtIeElWY0tvcWRFUVh5VUlCWWg2WGhubUh5NnZnSGRPS2V6Mkw3TjRWWG9S?=
 =?utf-8?B?M21QK0k5RG9qZnQrd3JUQnJkR3cvRTZnS0tibkE5R2Yrb0xQaHA4a0RRM3Nn?=
 =?utf-8?B?UWhocnpzMnl1c2VjSHFjMElVeFRtQ3l3OEpUMDZYRjhyYjV4ZUtvc0pMZVNE?=
 =?utf-8?B?OGVBcnVGaVByNGpheEdFU083dC82WWxUSDVHcmNHNW9aUEpFSVJ1djFWWi9Y?=
 =?utf-8?B?UFZmUFVTOTRzREt0Q0lWMS9TVHR1eWZzcFVaUWRsVkk0L2FwZGt4U3U1a2pQ?=
 =?utf-8?B?M3dubmo2anpsdEM5VDkrMmF2STQ4ajdqbU1zYUhKd0I0MGhIcnJJU0tUVWFY?=
 =?utf-8?B?OWUxNWpSZS9PRkpNdWo2bk9JeXRDTi9lVDBYR3JiVWlDNTBYaVd1Q0VGZTN2?=
 =?utf-8?B?UjdkRFdldklXOFYwOXZsUUZkNGNIVHoxQ0hwMTkxOXdvZGpib1BibGZOanVO?=
 =?utf-8?B?VnI2c0FOcXpIUEJRT0ZyT3E2L0R1QjBPMGdZbEpUcDNaK2JRRm04RW1tY09R?=
 =?utf-8?B?UTJ1a3hmTEE1Qnp0dXR5WDJYeTlVeDM3OTIrNlBQTXUzekhPWGN6VWlTYTFx?=
 =?utf-8?B?Zi8zc3crY1dZQUlwV1ZQMmNzMFYwUUZsMnhGcktLQU1RZHFHSE5LanJDdTBx?=
 =?utf-8?B?a1NKajFxT0duaVZqbWVBOGgrWVR2azFMQjU2VW9EbTU0SGlSZ29TdytxRllq?=
 =?utf-8?B?S25jdlFUTG1NUCtyY2VIZGR4NzY0M0F6aFJnUWtEanBYVFlvVDU0VkoxeDlp?=
 =?utf-8?B?V0hWbjhydzZQMGcweTdCNU1zZkFuek1DNXZPL0hlMEhxdlNVWCtyeTVGYzRJ?=
 =?utf-8?B?R0k3NFlIWmZuNWs0aDMrVVRqR0Zpb2Q5YThpbGk3czR3eHVaQkdRejI1cTJj?=
 =?utf-8?B?MTQ0WXlScnhDVC9lNmwrcU9Qek83MGFROWMvUWs0ajJFdXR0dFAwN0p1UmZZ?=
 =?utf-8?B?dUlWVVBieXBxeTExVFVtU3o4cFNnVEhOL1BWTEFKQ3U5b3NZSzIzU21iSHRi?=
 =?utf-8?B?ajNDMk03Q0FYNG5PMWNPbzZtZHB3TVNwSFBuemc3MWEwRDJhbFVwelUybmpj?=
 =?utf-8?B?UnVQSHdGTnpzRWxMazJqRDVHVnZQTXVicDdtdFFxZ041RGx0TXFINmRtWnlK?=
 =?utf-8?B?aGE3U3dXUEdSSUxzeG1RYWRhS2cxZ1RmYzBxbGdVOGRWTGRuN2dsTGxjbE0x?=
 =?utf-8?B?SGNCNzQzV3IrY0hoY296UDh1bkwydDB2bGdDdGd4cHJ4c2pJT05ITWJSYW1m?=
 =?utf-8?B?ek5hb0F1N1h2dGlxMitKblRTVUtITmwyRStiWENaR05WbVJsb1RqZERQMVhV?=
 =?utf-8?B?WVBYc1BJK0JrdmxFQU1CREt2SFRlVFFJSHJKTjY0VmpGTFVQNjZ2TmMrRGVw?=
 =?utf-8?B?MVlPU3ZjZzVUTkJjMXVwY0ExWGM1enlMNmF6V0lzSkZBc1lFUUhXU256MDFW?=
 =?utf-8?Q?HmemIS9Z3vq+mzc6cm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195e9ebf-653a-4728-207c-08df3a8589c5
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:08:52.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4eaz21QF94FQmCBoTYfEwaKcvngyPw7tNDS0OG+8FkK02V1sUfjIbIgjZwLq2MHr1y6uVupbtwG3kvAVOS1tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

Hi Christian,


On 03/11/26 22:42, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 10/30/26 17:27, Sumit Gupta wrote:
>> Boost is the performance range above nominal, so lowering the OSPM
>> Nominal Performance enlarges the boost range and drops the non-boost
>> ceiling. Keep the policy limits consistent with the register.
>>
>> Add cppc_cpufreq_effective_nominal(), which returns the OSPM Nominal
>> Performance when set and the platform nominal otherwise. Use it for the
>> non-boost ceiling in set_boost(), and to update the policy limits when
>> ospm_nominal_freq is written.
>>
>> The cpufreq core caps scaling_max_freq with a per-policy QoS request,
>> boost_freq_req, that it sets to cpuinfo.max_freq and refreshes only when
>> boost is toggled. A write to ospm_nominal_freq changes cpuinfo.max_freq
>> without toggling boost, so cppc_cpufreq_update_nominal_limits() updates
>> the request itself, rather than leaving scaling_max_freq at the old
>> nominal.
>>
>> When boost is enabled the ceiling is highest_perf, not the nominal, so
>> the update is skipped. set_boost() applies the new nominal when boost is
>> turned off.
>>
>> A platform with highest_perf == nominal_perf has no boost range at boot.
>> Lowering the OSPM nominal from sysfs can create one. The core, however,
>> adds its boost FREQ_QOS_MAX request only at policy setup, and only if
>> boost_supported is already set. Set boost_supported in init() when the
>> OSPM register is supported and highest_perf > lowest_perf. Boost can
>> then be enabled after the nominal is lowered.
>>
>> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> 
> Thinking out loud here:
> I'm curious if there's actually a use-case for this, presumably once we
> let userspace effectively dictate boost allocation, we practically expect
> userspace to sort out scheduling, too (e.g. by pinning?) and therefore this
> becomes largely irrelevant?
> 

I think it is still needed. Lowering the OSPM nominal puts the levels
between it and the platform nominal into the boost range.
Without this patch, boost=0 still allows those levels. Userspace would
then need an extra frequency cap to stay out of boost. This patch makes
boost=0 cap the policy at the OSPM nominal.

>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      |  4 ++
>>   drivers/cpufreq/cppc_cpufreq.c                | 72 ++++++++++++++++++-
>>   2 files changed, 73 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 6af7fa86e44c..d219fc27a0c9 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -362,6 +362,10 @@ Description:     OSPM Nominal Performance (kHz)
>>                Write a value in kHz, between the frequencies corresponding to
>>                Lowest Performance and Nominal Performance.
>>
>> +             While boost is disabled, cpuinfo_max_freq is set to this value
>> +             and scaling_max_freq cannot go above it. While boost is
>> +             enabled, cpuinfo_max_freq is the Highest Performance frequency.
>> +
>>                The register cannot be read back, so a read returns the last
>>                value written, rounded to a performance level. It returns
>>                "<unset>" before the first write. Reads and writes fail with
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 662397526433..7cac31de7325 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -915,6 +915,29 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>>        policy->driver_data = NULL;
>>   }
>>
>> +/*
>> + * Return the non-boost performance ceiling. This is the OSPM Nominal
>> + * Performance the driver last requested, or the platform-reported Nominal
>> + * Performance if none was requested.
>> + *
>> + * The register is write-only, so the requested value comes from the
>> + * software-tracked state rather than from hardware.
>> + */
>> +static u32 cppc_cpufreq_effective_nominal(struct cpufreq_policy *policy)
>> +{
>> +     const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     u64 ospm_nominal;
>> +
>> +     ospm_nominal = st->regs[CPPC_SAVED_OSPM_NOMINAL_PERF][CPPC_SAVED_REQUESTED];
>> +
>> +     /* U64_MAX means OSPM has not selected a nominal level. */
>> +     if (ospm_nominal == U64_MAX)
>> +             return cpu_data->perf_caps.nominal_perf;
>> +
>> +     return (u32)ospm_nominal;
>> +}
>> +
>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   {
>>        unsigned int cpu = policy->cpu;
>> @@ -974,9 +997,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>
>>        /*
>>         * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
>> -      * is supported.
>> +      * is supported. A writable OSPM Nominal Performance register can also
>> +      * open a boost range at runtime by lowering the nominal, so assume
>> +      * boost is supported in that case too, letting the core register its
>> +      * QoS request up front.
>>         */
>> -     if (caps->highest_perf > caps->nominal_perf)
>> +     if (caps->highest_perf > caps->nominal_perf ||
>> +         (caps->highest_perf > caps->lowest_perf &&
>> +          cppc_ospm_nominal_perf_supported(cpu)))
>>                policy->boost_supported = true;
>>
>>        /*
>> @@ -1280,11 +1308,12 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>>   {
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>>        struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>> +     u32 nominal = cppc_cpufreq_effective_nominal(policy);
>>
>>        if (state)
>>                policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>>        else
>> -             policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>> +             policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, nominal);
>>
>>        return 0;
>>   }
>> @@ -1494,6 +1523,41 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>>                         cppc_set_perf_limited)
>>
>> +/*
>> + * While boost is disabled, the nominal is the ceiling. Set cpuinfo.max_freq to
>> + * it and update the core's boost_freq_req to match. The core only syncs
>> + * boost_freq_req when boost is enabled or disabled, so a plain nominal change
>> + * must update it here. Without that, raising the nominal again would leave the
>> + * stale request capping the policy.
>> + *
>> + * Refresh the limits directly rather than leave it to the QoS notifier, which
>> + * only schedules the update, so the new ceiling is in place once the write
>> + * returns. The sysfs store path holds policy->rwsem, which the refresh needs.
> 
> Interestingly the global boost toggle doesn't seem to hold policy->rwsem when iterating
> over the policies. That seems to be an oversight, I'll send a patch.
> 
> The rest looks okay to me FWIW.
> 

Thanks for the fix.

Regards,
Sumit

....

