Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254951;
	b=wVgfEfPcH1vOO6Vl4F4l3g50vwVyvzO04Sfm5vhuCwOerqFA6PMmC0iEQu2b3gCQ3ODj
	 HEUPLQlxYXvNw3SNLeubzQJZQSqEfWtFHAPP9V3QoxPsdp4D9dJnAbBVvu0wi28B+Irb0
	 O1JrwOIXexMaggS8nYnUHhcq7L1QAhMCNVz5H7xFOKR+yFIxNZOCH0fQomPBI9tQ/GJKG
	 UpM4KMuEFgySOhVTK08Vz4ThaX5GXXkRH09+dUFQbVgfbuuxv4rOQjSpQuPGKsTMixKAx
	 0rsGuJcck8DGVDdB9SoQZQ3K3+wGJz0imEV7JLbeBQUVzEQTQa5oMKGrbaSYSpBswuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254951;
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
	bh=lV0H8SZcdBQfWN5BBnI/aCrwdyxpxlvNnzDCcEI22cY=;
	b=LJ1xt/jdckaI6VqMrKWpPyS70iKJZMU4GHG1kKdjao3guZ7HxSnoBN39xa5icztld3J8
	 zpZNYySbsns1yLaYIEq23HDRLvEwV1IEK7XlmR437FZhJm8gVnDu/Sre/gzbr39HQbTOP
	 IEc8cU0wqquY9j3MCY9us4ogWbnEcwRS1e5rnAeoi1ZU8xi/cUD5iEEm/F3wa4ye4Y0cU
	 UvD7y15ilGG55wUFoR5wykskwOvQvaiytJJKVOnxT2339Ah1z5bK1X/vsNb1/62Zlqaws
	 ax9lB8PfKFnigU4DmIGFQdNvToAcA1CxLCqsMQHEQjWV4N1m7sbhLztlMGIS/4VZfSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Wr9DCpz/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.67
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3DA606A33E;
	Mon,  9 Nov 2026 20:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E3DA606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Wr9DCpz/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9dayaExy3TaUF5YJgTHFCnUgJqwZD9W9UglKJonSUciL6dr4l1UV/gT041YCzUnZp5o+3b/W02jDBBZLFzZy7XgPvLPU+HSaeLN/qwDyT8dxJJCysP0xL8Ow/Flh9VVneK0GTQSGETHJnEkW0Gw1XSbxmNUz2RYL2c6MSCoIO9HVRP1ynhe83vjKUAsPuOKE1KqgJ1o7zm40f6/BhSL9vkl/ORMVJ8YvlZiFe7wuUKRzmCjz7/O462wyJKvc3eJ7v/yWg6bICiHo9SUukEoL2QZLcDzizJU4CPLmeKyOfi6dqyJztUnlz1i+ZLBHt35e+u5rLmUGtHUDuod3ijhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV0H8SZcdBQfWN5BBnI/aCrwdyxpxlvNnzDCcEI22cY=;
 b=EOJTWfNdlXD2qIKx2Z+dlgZ3trQObdMxohGyrnoSiLfE7RseJS4pFVPFtXcr1TUKaEtAgEdaUbI95EuREwgDPRLxRsX6mheRj5C1rvW9jM7ViRGH0wZaWilYjqhJpRzlrgJy0oIuVphoUS2+a4dKZM3c0w0tBpW9/4eRw9dCYwWkqzdy1CxbeBfMeAVmqXTW+Wmd8ypDaJHzfpFsa5l6E1NSu9Usu3u5sP4lCfimDReYHd2zCryz6RtKFC2ndWlqCv3haGS7yLbycYEHd6m/dqFalwlHz22L/DibSQ0wTczVoD9Y3yfG0O0YS+co6CKfKZjYgBP5SUxQ2mcuQmuDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV0H8SZcdBQfWN5BBnI/aCrwdyxpxlvNnzDCcEI22cY=;
 b=Wr9DCpz/5/hZKvJdNhnL71ABJd6W/aNhsITDvx1EqO2ZPPnXcKjsg5C3B6H9y3HbAI5KXlCrK00v53AtbTrHLi5KR3nUsNPKhnRYXJwgrUkDRaz3UIRbN96QaLgkYOKvrn3iyTHXqZO70JyYpwh0abx/a/rFYKOi+wRqNzV/Q3wxg9YrLMj4HTgJPPQikwiQesQGYM84U2Jm3X2upRjwt1A7vJMOAmOjt89tji9DQLFuk0N5EmykwMMEmKosPQHgzhe7QOC44NP9fVwky4zBmczyETIKqbnsw7kpECwDDeHVRXzY+6NBAFj265FZgb+pQE9H3XJmsE3/1BePGo5UMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 by LV2PR12MB707735.namprd12.prod.outlook.com (2603:10b6:408:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 20:09:07 +0000
Received: from SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7]) by SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7%3]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 20:09:07 +0000
Message-ID: <00951541-0684-41d7-a367-d63126bfa453@nvidia.com>
Date: Tue, 10 Nov 2026 01:38:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] ACPI: CPPC: Add ospm_nominal_perf support
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com,
 christian.loehle@arm.com, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20261106193304.3347374-1-sumitg@nvidia.com>
 <20261106193304.3347374-7-sumitg@nvidia.com>
 <CAJZ5v0h=iH01rZeXARa3F3rE61qgp0K6U4Fm9wRp+LYq_zD94w@mail.gmail.com>
 <CAJZ5v0gYO4cw8CFbeRJAv1_cQ1WxrsTBC9yJ15NsrBX4rDM6LQ@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0gYO4cw8CFbeRJAv1_cQ1WxrsTBC9yJ15NsrBX4rDM6LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To SA1PR12MB5637.namprd12.prod.outlook.com
 (2603:10b6:806:228::13)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_|LV2PR12MB707735:EE_
X-MS-Office365-Filtering-Correlation-Id: 86124b4b-0912-4254-fb8d-08df3e9d4f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261022075727099003|261022113327099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	m6vcM2zUp0iteXncAJ4JloySS6csqPDhyeIPALIrkzUEw2ZyxlnpNSZtF0+RRuZNtexmz6y1ii/kt5ehpjJAdV9rpmBcJMP9z8eYu2rTXXzZmtk0hAWENBOSMFYKM5zxWcrhBr2yKSnysoRREaPD71MfGT1P/x3BxQTq9OdBErPJOHSWPfiuAkzTbar5Ygnd2O/afo6C36MDSCGAiOF3k4yK9chlKBILpEhvLUZYBBWS1UH/8FzOJfKvtYCRfazq3aJk9t9LyonyXbfTpXm26wfJqCTa9kNrrClLPGpy4N4HVyW1s36nVdkwaHCcRMTp+IA0EFxFLEziEzdNPs5Et+JvgIzJTvkzaOr4tT+ay98KIhFzG7pa9oLV9u6Rip9kk0u6f4C11u4ArnsVRuwzza4esuHtoyWVT2Sb6LIDOcHfID1lnKKDVYHua9LZGDw5EV4IqOqJR6plkvQOpWqY+XADNTkJRnChJdoLyQgYLA2KjmQf6px+pn1Lk5NrHIfAVFAwI7V00kbVMbB4Ido6VXrAmcjIZOx+VsUGTgB/T15kynSuCmlE2hZL6wGA8G0ZJplQsj5DSuD6Ag/hLfq0NwNI7SD4UZ2HxMPCM3iVJjAY4h+MS/v/3y8/8riY6QD7pPiS0y0oLBY/XefTOhrOPfxdPyfg/VYfEzUPOWRvSj4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022113327099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzR3UHdlWHNWKy9iKzArVi9YZ1gxbkNOSVlwOEJWKy9pNGRSRk5WM2xON1Ev?=
 =?utf-8?B?SzQvU2k5VjhHSk04Z2Z5bjNrV3U1TVh2VUpZUVRENXc2NkFJaFhkQ1hoQzcx?=
 =?utf-8?B?ZzFHVVFmeHJibVZxZWtiVXZ3L2ZrcEZCTmpjcmw2Wnd1cTdBOEN6Ykc3bXlN?=
 =?utf-8?B?eWN6dVFLdkNHNTFVOUJRcktpenlJOHVtNVoxOXFoVEFVbXBRUVRQR2w5VDdK?=
 =?utf-8?B?MWNqdk9TUEVyZU5NeHpDYnByWDJTd09zdlQ5Y1dyUTVTN2g1RFdpZ0hqS3R5?=
 =?utf-8?B?LzdWS3ErTlJiQ1BiQ0x5VTg4aSsvRlJuMXFDcWsyQ0U0Z0p2bWk1TVNldmNS?=
 =?utf-8?B?RGduRGdDWWx4QnJMUW51czNFOUt0ODFZUk02azkyQ05QTlRkRnZwMXRnRHlh?=
 =?utf-8?B?cEVsdytDTS8rM1VLa1UyVklwUTlyYklwajR2UE5Nc3BNTnl4MThvZldDM3Jm?=
 =?utf-8?B?b0x4Vzc1NEhFLy9IZ1NpN0M4N0YrS3Y4bWk5b3hOSE8rSUN6VlhYVjlMTk8r?=
 =?utf-8?B?ekRhbzNhbzNUaFk4cVBlYXBnZTlXMnBvWE1PZG44eXBWRjFwbkVHMkpRMm1J?=
 =?utf-8?B?bzZoS2EyU01YWXlCZVY1dkgxTmcySHR6U0RpVWF1bEtwSFVzS2FkcWNob3lU?=
 =?utf-8?B?M1FQZFFCSlZKV1c2NW5tWVRrUjdNMnJrcTdBcFFIOC9sMGpMemFXc2h1T2VY?=
 =?utf-8?B?dklDY2N1WExoS214NUhMMzBoWjZMajM1ak5MUUl0and2ZXJPTFNLeG5UTFQ1?=
 =?utf-8?B?UkJ1eGpvM2NxR0xRSlozOWlFRG13SWI1Tkt3Y2VZeUp6d1BrQTV5YTMyT2dv?=
 =?utf-8?B?MmZpT0dScWZLcm1WbkFhSmJ3MW9jS2lTZkdNNjJlZDFZb000ZFduMGladmw0?=
 =?utf-8?B?QXRxTDdGK1A1Y2NwT2xNSmpiUUoxRGV4VzRIZlhtcEIxYzZ6OWtaSmpFc2hX?=
 =?utf-8?B?MlRvbVViZ0N6Nmdwa1laNFdyY3pDTHJvcVRWcElTZGpxT0VnTmRVdmUyWjI4?=
 =?utf-8?B?OENtVkczdFB6Q0JlOXBBMEc1SVdYenV0SVZWN0dRcUFOc2VvK2lVZGlrOWNm?=
 =?utf-8?B?d1JnNCtKUVZuaVFNcHRoSit0dkxlL3JobHNCeXBTK1hrNDVyVHBxT2l4b2x3?=
 =?utf-8?B?YU03ZVVUQ1g3UFlXSDlzdTdBQTlWN1FCeXY1MUNyT05rNWtKNE03RlArNmp0?=
 =?utf-8?B?R05DWnNudHovSHFlWnBEN01vTTZIZDNiZzRHSHY3Tnp4Vzg2VTZCak1hWFZD?=
 =?utf-8?B?TUpVZGMwRFM1VnBQYmR5c25EVnZwWnNzc1I5YXBVSDMvY2VzQWFmYzE3N29Q?=
 =?utf-8?B?NzZLOGNZNU01QSs2UzQ1TmJETzdpV3JrZnQxTUQ4dXNycUVhcjdUMmluaGMr?=
 =?utf-8?B?Y1BURnZXTFVQQUVRTUcwdkZBOVQzcUlvVTlMdGxibjJEMHBvOU1iUWdrckVP?=
 =?utf-8?B?R29MREcyTHNmc3AweUozREYzNzBpeGdYRnBzSmkxempSYnZSNFEzM0hYTktG?=
 =?utf-8?B?Y1dpTU03citJR1ViWTJ6N3RRSTBZOERNM2NHWEtGeFk0aVBLSnFFbHlsREdx?=
 =?utf-8?B?NVZuVmhWK0luOXFJMXdOa2lKalp6eXdOL0Zsc0lLZTg0RGhldFBOckhIR2Q3?=
 =?utf-8?B?RmRBU3ByOVhPMFBtM1NJU2c1TXhxbVRYNUI3c3JLQkMwMW5QUS9NZEJXRWhw?=
 =?utf-8?B?d1FZdHRrVVRJNU9HbksxeVUxbzltOE83ZVd3STJFR3R6WkU0SnpneVhaZGVO?=
 =?utf-8?B?cWRsaTRYREI0a2ZPVWhWU2VZRnAvVkhvQUxQa0ZyL1NWd1hhZ3RsUG9TcjBk?=
 =?utf-8?B?UE15MHZJQjlTMEFhaHRrQnpkdjVGLy9JanRmSjFrazByRVVlZTVWMDdub1BB?=
 =?utf-8?B?NFdzMXk2QWNWb1h5UjRxVGdjM0J2aGVSUGtMaGxuVTJQOXhhL1R3MlRNK3BD?=
 =?utf-8?B?WkxmcFJDQWNqKzlsdG9JdUNMNHZwOTUwM3RhOFNkVUZQaUN0QVVEMTc4Vngw?=
 =?utf-8?B?TGFpRUhocnBidk0zWU1UczFkSjRTUGRzTk12eVpNTlpqdW9nRWdVUWdWYXNS?=
 =?utf-8?B?b29rMitpQWRnRGp4TVhwSkJaaExWN1gyTmVGMkdZTXB3Mmc4bWdJQWZQQ2hu?=
 =?utf-8?B?bnFHWFdDZzZTeGViV3NUNnZBOUllMVFoRlZ2QUN3NkZyZkh4dHY4R3hMWlNQ?=
 =?utf-8?B?WWU2VzQwdG1DL1lHRXkxcUZpZ1ZhcVJpb09Wb0V3eWJoZk1JRkljNXhvQXRZ?=
 =?utf-8?B?cnlWaHVPaUtod2xWelJtQWxzVFJpVitvaVVGdHNyZnB2UCtITTJlczhiV05T?=
 =?utf-8?Q?EdWsuU+OJ2tXIjE+M4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86124b4b-0912-4254-fb8d-08df3e9d4f38
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 20:09:07.3857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +osL7LywBsdJol6yo7ttYGIetCvTk6jNbYLn9B+LIJyweey+Pq1xGFK0YiAzUkjwpKCUdb7aMLwfZVVtXG/xMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB707735



On 09/11/26 22:34, Rafael J. Wysocki (Intel) wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Nov 9, 2026 at 6:01 PM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
>>
>> On Fri, Nov 6, 2026 at 8:35 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>>
>>> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
>>> 8.4.6.1.2.6), which conveys the nominal performance level at which the
>>> platform may run. Unlike the read-only Nominal Performance register, it
>>> is writable, so OSPM can ask for a nominal level below the
>>> platform-reported one, which then becomes the boundary between boosted
>>> and throttled operation.
>>>
>>> Add cppc_set_ospm_nominal_perf() to write the register. Per the spec,
>>> the value must lie in [Lowest Performance, Nominal Performance], which
>>> the caller is responsible for validating.
>>>
>>> Add cppc_ospm_nominal_perf_supported() to report whether the platform
>>> implements the register as writable, since a write-only register cannot
>>> be probed by reading it. It uses the same cpc_is_writable() test as the
>>> setter, so support is never reported for a register that a write would
>>> reject, and takes cpc_desc_lock while looking the descriptor up.
>>>
>>> The register also joins the writable set that the SystemMemory overlap
>>> validation uses, as the driver now writes it and can compete with
>>> another control sharing an access unit.
>>>
>>> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
>>>   include/acpi/cppc_acpi.h | 10 +++++++++
>>>   2 files changed, 54 insertions(+)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index 5a1f84fddb7f..3a0ecdd1ab11 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -463,6 +463,7 @@ static bool cpc_reg_is_writable(unsigned int reg_idx)
>>>          case AUTO_SEL_ENABLE:
>>>          case AUTO_ACT_WINDOW:
>>>          case ENERGY_PERF:
>>> +       case OSPM_NOMINAL_PERF:
>>
>> Sashiko is unhappy about this change:
>>
>> https://sashiko.dev/#/patchset/20261106193304.3347374-1-sumitg%40nvidia.com
> 
> So I've queued up patches [1-5/8] for 7.5 and I'll wait for a
> clarification here.

Hi Rafael,

Thanks for queuing 1-5.

Sorry, I missed this Sashiko error.

In v9, if OSPM_NOMINAL_PERF shares an access unit with Performance
Limited, its range is no longer checked for overlaps.
It is write-only, so another field's read-modify-write over it would
write undefined bits into it.
v10 keeps its range reserved, so such a layout is still rejected.

Sent v10 of patches 6-8 on top of the queued 1-5 [1].

[1] https://lore.kernel.org/lkml/20261109195400.3600561-1-sumitg@nvidia.com/

Thanks,
Sumit

