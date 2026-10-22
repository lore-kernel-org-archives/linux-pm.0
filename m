Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792663822;
	b=n6vFdV8Y8b09sKxNbY2orJVGWA1IPS5T3ToNog1OzYGKlmZSSUsC8umWOglJ74DIUR7h
	 x8DyneTjY/meERNY5JiQDQDseFCivrydckJpyFSf2mRGFD8J1DUhC99hjrmV6OrsdOWwh
	 mkaS4vuBzxCPSWTdFDe8/8+kyiLWGC4LufIttsIx0DeQag4MoSd82phwSkjsOuEPHbwlL
	 RKKt4cuYqzP/qmRbkPV2JEjkOVM2/AIZlHi3C1cs/+QbRdO+NFxseA9KhACwjnjLftG5P
	 6Mi7VOY6QyRq8uTJ5bdqbIcmpys9UxRhYfF+uNspVHFyZWl+N2kX/+TUwFOdVm4vxfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663822;
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
	bh=5eTaeLrTJd60CfarPCv+CYMfGu8OOJ2oO1Agp6UwY/Q=;
	b=tR5ghkTNo/Wlt5dfMPbylcSPSR7qSZbeTb3vURBKLEgwLjVlFxCbQCpcM2ufUz77yOo8
	 kX4sCNcZm3NP75pI05g6jRsL5TyIoGc6Gbnqd1Hin0tuke/aT2bF0ekX1eclAjzUwLY+h
	 Bllu/S6I2ajlTPU3LB2p5+/MVKYrwouPtbDEqHLtEGJ1Qr8ERJdqWX1fBpH4WqfQ2adBE
	 Hdy7rB6YIYjbKIuuOAaUIikvJ7RtbX2BO3xMZ2vPTFh6hH8h0/MmsdAdiSBc82Qd4PpK0
	 POMo3X4Ar3FhNP4x+axidykrzvLwnh7RsIioZbaBvAhviXu9UXIVjoxLKK4ql4BSUHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YLMKvWdw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.5
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20360606A319;
	Thu, 22 Oct 2026 10:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20360606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YLMKvWdw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goS/NMASLNNtOeEzXch5rH55rbwK5OJbb6Tbt1mhLyqQkR+OaSjeIO9O4lHWA62J1QJyVe2iMOqelhsQ99mD9tC5EwxeD84jFT/FZb5jPGwutqTYSQvZ89hbusKf2+kQM+pJB8ygE0x0MuVVoBJV5a4E89uOQLAIrdGqb3z0adthIstwWEvNgBjtHhkieFzCTJS07utjovTfSHaiILwYvC/Mq8O192lKTbKXOljPhUWXz201GUKEjugbO6t8+ZgaV2PWrhZcMWjt+QvpXUf501Ih1AEoBXf+G20MHHda0y99AJTjm4ysj1sPZn6JlnPr7RYk8nMVntKUExEdG56k3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eTaeLrTJd60CfarPCv+CYMfGu8OOJ2oO1Agp6UwY/Q=;
 b=ZpmO5Jj1JT7bhSzul27MUGNRP5OoCh2gslvx+MptGbUERCnbFolS2iqhYczD/hb0vXstplTEdLBDhCbL4zYdJcOqcOP6Dx+pbSL9TNfTrHGXzs0rH75vPuXbemQS2aEMijdezLnYgt9ThVRzmZkKVO+VN1dnv2b3StnbGghuoYdCzoGO9czm3pKyeVVbPeZNbe0EA0H8yTAQCNZZbXC/NJizQJu5hQkJzeBYcHkn9MpWSg/AacLduURnwUuoIjORXuwPno1/GzL0ZRNuXQx2bwsTAedz+IkYsa6/HJc/Nv5RfJEgUSd/Mftpz7jp4nzn1APZY1Qn9z9C+BqgNIPp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eTaeLrTJd60CfarPCv+CYMfGu8OOJ2oO1Agp6UwY/Q=;
 b=YLMKvWdw63dEoKsp0hAMqwG4r03JnxM+Bt6uf1WiiUdQbJ2DDVa2niUDF/EAZioIfGjhYNC31dDBPxL/O4wToX5sOeSQLGhAeXF4MlkmZMhKFRoxT8Xgd3nbCJqcWdggvFx76JQ+BlEEkLKOT4aPqo3WhKJwsSMQEJVc4fCXPvqd9xfbnwUwbmM3UL6WcUY0X+n1U20t6ZILY90rA9CasYAvMhFcSnjrU2Tgc2PXipxQQSggCL3wl+FACDWeYDA9b0MXZ5vOGGzS2L5d4pZlEJGYot8Xyqsk50KFt2RFZZPvYYYpFZTcXnfYqARwC7yqPvmbZsHWnOd1EYq1yHYSsw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by DS0PR12MB8200.namprd12.prod.outlook.com
 (2603:10b6:8:f5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 10:10:16 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 10:10:15 +0000
Message-ID: <51747329-abe1-406a-aeae-94ebb7a35bf4@nvidia.com>
Date: Thu, 22 Oct 2026 15:40:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 kprateek.nayak@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20261020121846.691218-1-sumitg@nvidia.com>
 <20261020121846.691218-5-sumitg@nvidia.com>
 <cf4e3153-ff80-4d0d-94f7-572a26f369c1@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <cf4e3153-ff80-4d0d-94f7-572a26f369c1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::10) To CH4PR12MB720178.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d89d63-e0dc-480a-4782-08df3024aa8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|921020|4143699003|5023799004|11063799006|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xoUPW6hRmp2Ey+FtzO1cooRNHFBoYJhyoGd7KuFMioMnIhnF7Np2KTRfvPfnSTpBEXSrA3fVm4eMkPDmufoCtGiSF/9aKhv2H514XhyrAC+NmARUBaeZ44kYHU7Mu0V+wonK6vjTZGNH+usb71fo+47XdWBkvGStBFFoW5II3wHHkm/Kfkjht1aNnjMjaY+yZsDTbuVEf5MCAbr40IuquUSdKcAHSyhTD8yAU4xMbuEmJUNwcPB0MVNcjUjUekQL9m6jGvz2YKNAqzM72p0d1lDFllkiv7V8W+O87Gv6x5Etnk2Sl18Eak967eyqgEVF1KnLahPBGISY0geicDVOYnwhMV4DwiiAdS5p8VCpDtTEfOsyxYDAqolz8tuJY/91Q1tMr9sV1DOoMFhoMaUhOAgXwfZYrdQFvub6PkwwLPj3BnRF9uUCX/czIceXCfRC/EcNvPxsOsNkwfBAhROIXu0BxzpIEO1p3qViAfvy+/Mx/3PyoYWG1cBjkjiwomy7RFZFv68KXhBe5upkFiCwkRY1LcoAafUBEP7DyLm8NcNq3CMHXfaGdAn0OZWp0y6RQpf38UeeMykyZbpFuwrI6ReFT2iZDKaVGjFhg00igv3WxSDuzVWMfb8PZIvH34+PzM7F/QpVSsMkbp2yJFqwykFMg4lPmKfq2MbXlAiyYWUjvHPPZhjzrCJX43ipde/BUSSmDxFBgWmJEa9qHZob7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(921020)(4143699003)(5023799004)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXpIZjRKNE5wSStzYzRZY1FqdmVlVnBnTTlWRFBGY3pnTTlTcHQ1MXErbysy?=
 =?utf-8?B?MXlKOEpCMHlhQ2tXSXBMc01pMGVjR2JxVC9ldmNUQlg3ZUlsZGh2TVRoUTNQ?=
 =?utf-8?B?aWhsOGdRZk5MVXhRbit3dS9vR1pNaXR6TkFORDlBQ201R2poV2NCcTN4N2RG?=
 =?utf-8?B?c05BVnFEbDhsTk9LdnlHZVZnTHlVUVlFYWN5SnlCbVV1bmtRRkpEbDh6R0M1?=
 =?utf-8?B?NnR0NkdXZ1ZqeEpSb0pNUW43TUo4dHB2STNBMDc1ZUJVNW4wR3VxYS9DRm1E?=
 =?utf-8?B?WmFXVEtHdDdjYXYwVW1maW9jKzh4U0hvK2ZTZ2toTzc3TmlROTlhS2ZOY3cz?=
 =?utf-8?B?bXZPQ25PcnJseGwwcnhoNm43WG9OMndKYjhhMUpGaVNYUVRyQWx0aUdKUnZo?=
 =?utf-8?B?dVh0Q2FSOStZVlhaZGZ1b3pUN2dpVzlsdHNKSE9mdllGV3pTZFNzNTBMWjM1?=
 =?utf-8?B?YXN4WEFldlBpenAvSnl5SmgrOHpqZGpKTzN2dHlvNU1kc01oMHJiUWpPc1ha?=
 =?utf-8?B?MjZMS2w3S3ZOc09zNGZUSWJSL1kwZXJYZmhwdGp2VWpWZGZDZnRMWTdpaURY?=
 =?utf-8?B?ZzNEWVpMU1pxejNkajBrUnZVd3hnaDRSc3dMdFRmTjhaYnNjc0dNM1ljY0dt?=
 =?utf-8?B?RzRZbzlWUHNZaE1lOGhBWnRLR2xwRUE1T3AvK3ZQVzRaS1ArRVZPNzkwd2ZF?=
 =?utf-8?B?bUZac1BjVHNTN040aTBrM1dpUEJvcXRmWHZyMzloOHJWenVmckgzazB5MWFp?=
 =?utf-8?B?ZEFZUU9ob2pSTHFiek5qS3JoVGxsZXptVEhuU1ROamNTbkZkdkZ4NzRweU5Z?=
 =?utf-8?B?OXp2bHpQMlNLTVNtZk1XU2hkYkhWeExaOEVPQ3F4WEFuSVNOV0h6b0Iyc2JB?=
 =?utf-8?B?VkVlOWZnVFZpNTR2d3h1a1ppWnpzb0RDQzBSVnJRcHFucmtOMVpSMkdqV3g3?=
 =?utf-8?B?cUNOK1pOeFlMYm95VlZEb2xGQkNFYmthY3ZuWUh3SE9MSzV2cXF2MnZaMWhT?=
 =?utf-8?B?K1ZPcWpjaFg1a2ZjQ0N3clZHZWFYK1QwZjNsYTA0RVY4N2NEcXo2RFFxakJk?=
 =?utf-8?B?Q0FaY21qN3cvYzBvWHcrV25ENVp4ZHUzVWFRTDlxcksrb0lZcjFrVkdXNXdB?=
 =?utf-8?B?KzhiajdQU0dmYVM2OTl1K0piaDFwdmJIL3ZOME5oN0NlTjArRkNJMjdpYko2?=
 =?utf-8?B?aHJnd0hMS21ZNHNIS2pTRUlhV2JhMzc0ZEplQUZYSVBmcEp2ZW50SXdIdGhE?=
 =?utf-8?B?S05oRk41SUlQLzZMelFUa2kvcFYzOExQUHlNbUsrMlI4T1Z5Wk94UjlxeUd6?=
 =?utf-8?B?ZUptRFpZQ3ZrN2xBTU9nVnE4aC9PVWVjWTh1VVJFOWRxUGZORVFSUHc1OHl0?=
 =?utf-8?B?bmg2L0JWOHZkRGNTZnJraXpLRDBwL3hKd0IrSmtzSUdGQWRxL2EyT2U3ajcx?=
 =?utf-8?B?aERnRGFiRENiVnErbGlXRWNITTF5QVdGb1BBNHNJdCtxUGcxOXJEN1Z6VjZO?=
 =?utf-8?B?Q0FNc2t5SmtodkhpeFdhWkJJQUtFSFJmNnArMXFzRFc4NnRxNW0ydlZCTlRS?=
 =?utf-8?B?MkU4M293bUc5VExvTzNNeXdVK1lFaTh0SUNBK1JVMGxGMndBVUJwRVhOOEpU?=
 =?utf-8?B?QUM3MWFMMXB4aEw0M2JCNmkyenFNdStieXc5Z1h3RUhPamhVQnhnNnlwQU1j?=
 =?utf-8?B?aVVpekhISXZaSUxFSjBySk11bGUxanBhWHZPZTN6QlU4RDhWWkJXd1RydGtn?=
 =?utf-8?B?OGo5UUphWGNJbHYwTjI4dy9MMlhIK2JuWnJvbURBRUdlbDdlSHh5MFo4RWNE?=
 =?utf-8?B?Ty9wdk5RZEJuelk0UTBrNVhzakNQTFMwSzZqSTNSaUJERnJ2TEovN3lWeW9J?=
 =?utf-8?B?OTJOVlBZcUtQaFpSZ0NnajdURldScFQwRlJqb2lLU1A4UGV1dldNRFpza3Zx?=
 =?utf-8?B?d1RyVVYxVHMxVXQ1T29OMnNUenBkL0c0dlYxQk45Y0NwUVdNNXlSZEtQSms1?=
 =?utf-8?B?OWdLbjV6TU56Mi85V2VsZm5UTm9GTVNzYzRpWkNNdkFKNXR4dDBablVBeXp2?=
 =?utf-8?B?NnNkWkZMMjFRLzZUTmxENjdxQkkxRkNTSlc4d2Z0TEkxMTRoTlJuZE0yRWkx?=
 =?utf-8?B?TytvTW5tRndYUFN6RlhkRnNpb2NOVFFLMlB6MFdtMVJIc1lHckY5WmZRQUlL?=
 =?utf-8?B?L1FEV2hOd29nbmpjYXM0d0lCc3dUL0U3TkxJcEJRaG9VNld0ZU92RHczNm9D?=
 =?utf-8?B?R1hGbTc1eGdRakY0V1dpSmJ0aXRWTkxnUmhNdkV6aEtCbmIwMHdSemxGNXVm?=
 =?utf-8?Q?BAqdISXrwyboT+REn6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d89d63-e0dc-480a-4782-08df3024aa8a
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:10:15.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahlZO6LpoJI7LoXzwlYE2d167eDuAShBtd5Uu0KJPVQA3VSwm/tLo3yjZcr/o2oN8KPrj4qBvLV1Adocfu0wRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200

Hi Christian,


On 20/10/26 21:41, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 10/20/26 13:18, Sumit Gupta wrote:
>> Values written to OSPM-set CPPC registers via sysfs can be lost in two
>> ways:
>>
>>    - Across CPU hotplug: the platform may reset a CPU's registers while it
>>      is offline.
>>    - On driver unload: the value the driver wrote is left in the register
>>      instead of returning to its pre-driver state.
>>
>> Add a small table-driven mechanism that handles both:
>>
>>    - On init(), capture each register's firmware value before the
>>      driver programs anything.
>>    - On offline(), read back each register's current value (whatever was
>>      last set via sysfs) so it can be reapplied, then restore the firmware
>>      value.
> 
> Sorry for the late suggestion, but all the ospm-set registers I think we can
> save ourselves some headache by just saving these at sysfs_store (and not deal
> with potential read-errors during offline/suspend (which actually may happen!).
> 

v1 [1] saved the values at store time. In v2 I switched to reading
them in offline(), following the flow discussed in [2]. One read there
covers every store handler and the pending boot parameter series.

But a read error in offline() or suspend() drops the request. A failed
reapply in online() can also leave the register at its firmware or reset
value, which the next offline() or suspend() then saves over the
request. Saving at store time keeps the request in both cases.

We could combine the two. Keep the policy across hotplug and the
firmware restore in offline() from v2, and save the requested values
at store time as in v1:
  - init() saves the firmware values and uses them as the initial
    requested values.
  - Each sysfs store updates the requested value after it succeeds.
    The boot parameter series will do the same.
  - offline() and suspend() restore the firmware values without
    reading the registers.
  - online() and resume() reapply the requested values. If that fails,
    the request is kept for a later online().

Does this sound fine and keep the intent of the earlier discussion?
I will respin accordingly.

Thanks,
Sumit

[1] https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
[2] 
https://lore.kernel.org/lkml/15def9ce-abbd-4ef5-bb8f-0c55b42a0181@arm.com/

Thanks,
Sumit


>>    - On online(), reapply the value captured at offline() after
>>      reprogramming the performance controls. A failed write to the controls
>>      does not skip the reapply, as no other path restores these registers.
>>    - On exit(), nothing is needed, as the core calls offline() first, which
>>      already restored the firmware values.
>>
>> Cover the Autonomous Selection (auto_sel), Energy Performance Preference
>> (EPP) and Autonomous Activity Window (auto_act_window) registers. Writes
>> to EPP and auto_act_window only have meaning while auto_sel is enabled,
>> so write auto_sel before them when enabling it and after them when
>> disabling it. While autonomous selection stays disabled, the platform may
>> ignore those writes.
>>
>> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
>> Link: https://lore.kernel.org/all/86780f97-29ee-4a72-b311-38c89434b707@arm.com/
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 176 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 173 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 9e1214e1cb0d..1b733f15d641 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -29,6 +29,166 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/*
>> + * OSPM-set CPPC registers tracked for save/restore. A value the OS wrote is
>> + * reapplied from online() across CPU hotplug, and the firmware value is
>> + * restored from offline().
>> + *
>> + * Autonomous Selection (auto_sel) is kept first, as the registers after it
>> + * only have meaning while it is enabled.
>> + */
>> +enum cppc_saved_reg_id {
>> +     CPPC_SAVED_AUTO_SEL,
>> +     CPPC_SAVED_EPP,
>> +     CPPC_SAVED_AUTO_ACT_WINDOW,
>> +     CPPC_NR_SAVED_REGS,
>> +};
>> +
>> +struct cppc_saved_reg {
>> +     const char *name;
>> +     int (*get)(int cpu, u64 *val);
>> +     int (*set)(int cpu, u64 val);
>> +};
>> +
>> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
>> +     [CPPC_SAVED_AUTO_SEL] = {
>> +             .name = "auto_sel",
>> +             .get = cppc_get_auto_sel,
>> +             .set = cppc_set_auto_sel,
>> +     },
>> +     [CPPC_SAVED_EPP] = {
>> +             .name = "epp",
>> +             .get = cppc_get_epp_perf,
>> +             .set = cppc_set_epp,
>> +     },
>> +     [CPPC_SAVED_AUTO_ACT_WINDOW] = {
>> +             .name = "auto_act_window",
>> +             .get = cppc_get_auto_act_window,
>> +             .set = cppc_set_auto_act_window,
>> +     },
>> +};
>> +
>> +enum cppc_saved_type {
>> +     CPPC_SAVED_FIRMWARE,
>> +     CPPC_SAVED_REQUESTED,
>> +     CPPC_NR_SAVED_TYPES,
>> +};
>> +
>> +/*
>> + * Per-policy values saved for each register in cppc_saved_regs[], U64_MAX
>> + * if there is none:
>> + *   CPPC_SAVED_FIRMWARE  - value before the driver touched it, captured at
>> + *                          init() and written back when the policy goes
>> + *                          offline
>> + *   CPPC_SAVED_REQUESTED - value in effect when the policy last went offline,
>> + *                          reapplied at online()
>> + */
>> +struct cppc_policy_state {
>> +     u64 regs[CPPC_NR_SAVED_REGS][CPPC_NR_SAVED_TYPES];
>> +};
>> +
>> +static DEFINE_PER_CPU(struct cppc_policy_state, cppc_policy_state);
>> +
>> +/*
>> + * Per-policy state is kept in the per-CPU variable of the first CPU the policy
>> + * manages. related_cpus (the policy's full set of CPUs) never changes while the
>> + * policy exists, so this CPU (unlike policy->cpu) stays the same across CPU
>> + * hotplug, and every callback reaches the same copy.
>> + */
>> +static struct cppc_policy_state *
>> +cppc_cpufreq_policy_state(struct cpufreq_policy *policy)
>> +{
>> +     const struct cpumask *policy_cpus = policy->related_cpus;
>> +
>> +     /*
>> +      * related_cpus is empty until the core fills it in after init(), so
>> +      * fall back to policy->cpus, which has the same first CPU.
>> +      */
>> +     if (cpumask_empty(policy_cpus))
>> +             policy_cpus = policy->cpus;
>> +
>> +     return &per_cpu(cppc_policy_state, cpumask_first(policy_cpus));
>> +}
>> +
>> +/*
>> + * Save each register's current value, either as the firmware value, captured
>> + * before the driver programs anything, or as the requested value, to reapply
>> + * at online().
>> + */
>> +static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
>> +                                enum cppc_saved_type saved_type)
>> +{
>> +     struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
>> +     unsigned int cpu = policy->cpu;
>> +     u64 val;
>> +     int i;
>> +
>> +     for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +             if (cppc_saved_regs[i].get(cpu, &val))
>> +                     val = U64_MAX;
>> +
>> +             st->regs[i][saved_type] = val;
>> +             if (saved_type == CPPC_SAVED_FIRMWARE)
>> +                     st->regs[i][CPPC_SAVED_REQUESTED] = U64_MAX;
>> +     }
>> +}
>> +
>> +/*
>> + * Write one tracked register, skipping it when there is no saved value.
>> + * A register the platform does not allow writing is not an error.
>> + */
>> +static void cppc_cpufreq_write_saved_reg(unsigned int cpu,
>> +                                      enum cppc_saved_reg_id reg, u64 val,
>> +                                      enum cppc_saved_type saved_type)
>> +{
>> +     const char *op = (saved_type == CPPC_SAVED_FIRMWARE) ?
>> +                      "restore firmware" : "reapply saved";
>> +     int ret;
>> +
>> +     if (val == U64_MAX)
>> +             return;
>> +
>> +     ret = cppc_saved_regs[reg].set(cpu, val);
>> +     if (ret == -EOPNOTSUPP)
>> +             return;
>> +     if (ret)
>> +             pr_debug("Failed to %s %s=%llu on CPU%u (%d)\n", op,
>> +                      cppc_saved_regs[reg].name, val, cpu, ret);
>> +}
>> +
>> +/*
>> + * Apply the saved firmware or requested value to each tracked register.
>> + *
>> + * Write auto_sel first when the value being applied enables autonomous
>> + * selection and last when it disables it, so the writes to the dependent
>> + * registers can still take effect. While autonomous selection stays disabled,
>> + * the platform may ignore those writes. Do not enable it temporarily to force
>> + * them through.
>> + */
>> +static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
>> +                                       enum cppc_saved_type saved_type)
>> +{
>> +     const struct cppc_policy_state *st = cppc_cpufreq_policy_state(policy);
>> +     unsigned int cpu = policy->cpu;
>> +     u64 auto_sel, val;
>> +     int i;
>> +
>> +     auto_sel = st->regs[CPPC_SAVED_AUTO_SEL][saved_type];
>> +
>> +     if (auto_sel)
>> +             cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
>> +                                          saved_type);
>> +
>> +     for (i = CPPC_SAVED_AUTO_SEL + 1; i < CPPC_NR_SAVED_REGS; i++) {
>> +             val = st->regs[i][saved_type];
>> +             cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
>> +     }
>> +
>> +     if (!auto_sel)
>> +             cppc_cpufreq_write_saved_reg(cpu, CPPC_SAVED_AUTO_SEL, auto_sel,
>> +                                          saved_type);
>> +}
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>        FIE_UNSET = -1,
>> @@ -800,6 +960,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        policy->cur = cppc_perf_to_khz(caps, desired_perf);
>>        cpu_data->perf_ctrls.desired_perf = desired_perf;
>>
>> +     cppc_cpufreq_save_regs(policy, CPPC_SAVED_FIRMWARE);
>> +
>>        ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>        if (ret) {
>>                pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> @@ -843,12 +1005,14 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>>    *
>>    * The platform may have disabled CPPC and reset the performance controls
>>    * (desired, min and max performance) while the CPU was offline, so re-enable
>> - * CPPC and reprogram them.
>> + * CPPC and reprogram them. Also reapply the OSPM-set registers that offline()
>> + * reset to firmware values.
>>    *
>>    * Report failures without returning them, or the core would free the policy and
>>    * leave the CPU without cpufreq. A failed write to the performance controls is
>> - * not fatal, as the governor's next request programs them again. A failed CPPC
>> - * enable stops the restore, as the writes that follow may not reach the
>> + * not fatal, as the governor's next request programs them again. The OSPM-set
>> + * registers are reapplied even then, as no other path restores them. A failed
>> + * CPPC enable skips both restores, as the writes that follow may not reach the
>>    * platform.
>>    */
>>   static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>> @@ -896,6 +1060,8 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>>                WRITE_ONCE(cpu_data->perf_limits_valid, true);
>>        }
>>
>> +     cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_REQUESTED);
>> +
>>   out_fie:
>>        /* Restart what offline() stopped, with a new counter snapshot. */
>>        cppc_cpufreq_cpu_fie_init(policy);
>> @@ -915,6 +1081,10 @@ static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>>        unsigned int cpu = policy->cpu;
>>        int ret;
>>
>> +     /* Save what the OS set, and leave the platform in its pre-driver state. */
>> +     cppc_cpufreq_save_regs(policy, CPPC_SAVED_REQUESTED);
>> +     cppc_cpufreq_apply_saved_regs(policy, CPPC_SAVED_FIRMWARE);
>> +
>>        /*
>>         * Stop the frequency invariance updates and cancel the pending work, so
>>         * that no sample spans the offline window. online() restarts them with
> 

