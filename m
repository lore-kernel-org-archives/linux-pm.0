Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794001127;
	b=DvcP+mZctssEtK/2GDPFpXa/0DRbErH+KAQ+SNrwv6pN2rMIdl3Wbo5r88909zUJwlao
	 0fqXGpvSwOQ+B2ddpDz5DvEAAN+ryyki9onXH81Z9u5pCVukS/uRcPFLu9ppWEWBefU2T
	 uQ5TH66yUft9ziEdVtNCkO4j/qpmfNbmlBKhbY4dstgGYL76A1GfFHO74RVTI4eMEDdV4
	 Co+B1HHbOEFwQ4FIyXu/VP2gWbkEC90n5qRLGQ+/afpy+6Ldo0rUN48lzIfQ7WwP8yXoX
	 VMqMyXYY+hHc1XdVLHUgHT4H5L3moKeDGlRQDJqMWYaHi9AK+A0RdHNug86osQc0tPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001127;
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
	bh=KA6hOiuUXui6fW0xBuJ5uYerAsVt8ridnqfSMzKqMds=;
	b=5p70rCcQUsa9wu/YKBY5gT96Y4eIZ1/OGKG44Y1kkq9DtlbnuLzivdXosjgY5D7nmENb
	 NY6AKFDtE8CvhW1AifwHKiUBu/WZMZdugJgSZ2RYEdTXgfq+kAjOUZfiTV5yB/kEK6paK
	 D9v4XVEgKUS7oNW768pLopSelZJfe18e0uht7jJdcDtl90TsfO4gYnBz8eae5REHn73os
	 3hXumnR5Sk0Z/uu36h/JqDI4FdeK8TJj7wc7lrg4lPr9zfD4PGLSVZgqy3RGaJhrKQqVK
	 XIjTJgBQQB5R/Yov1QgAQIxPpLKFBki7KyYGj72svcbFzzM2SBm/gS96jxh2ZXCUYOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JnaVd4PY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.38
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DBD606A33F;
	Fri,  6 Nov 2026 21:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47DBD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JnaVd4PY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud/wgrNZTGxVmaE64dks7t/cx7zP6LsibJgQi9sq2aFsYE48tnZXYIX/SS3YhvnS89nI804mvnPm5x3KV3dE9O4KQdMOszXP/N34j0znr1yrAXZusucEzxSlc4xAdmCWaOEZ/PjUeYqzHhb1/NmeS3qJGUqNcmNToRRX13KhiBbDEbXCN4DksNtbKdkVgao9CCAYpspB/d2UQWnGIWYCHM04v1thJoHXgGHFL4YGyak9w/R9BWCjNjA+srp3U4dhSgWRdtnQNkxXPWDJMnvq3+HAn93BZwY5UcErqBJJxpt8P+O5aZf+Yftp9i0PJO+oYJvsP+/JRXxZe6zwqeYcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA6hOiuUXui6fW0xBuJ5uYerAsVt8ridnqfSMzKqMds=;
 b=T0PePSeqebnV2800yJuEVml0ZsrSYjYvNkANHKGCAqg+OSXaNIfvGU74B9TK6hOa4wccJXmgfoOVWpOPwP3lMeqPbEHeJXyhTnP0vSQ6leclTz79ajWEpXAAKlDbWhlbzCMH6+9yLLKNIuI1ZZ3bvCmjTvItge3Sh2CE82crrycFiKN1+Me2xGNF02dGWZqPTwxl85reDiRMHz6X14tIUB7fpTodZgVexELZgaS4iCPvHWRgHGngaFFKBexFs+r589o9NBw3UdiHw902sc/3SPYsUPUTmEGPjPb+AP8glzt9gdo5i+6Nj8Jor8lQVU1QZNgXG9wmtjGuOv3jOc5/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA6hOiuUXui6fW0xBuJ5uYerAsVt8ridnqfSMzKqMds=;
 b=JnaVd4PYclxn8/amebCMFnNfCCv4aEIIpY8oirAiKHX3tfH9fTJ13BWpC4C+bNrAWlrIeTty80bAlUXDmkHShwkMpRj6Yf9abWGjiYcTV8sZZXoppCFcGaTZCWjMPHdOOy3s03b4M7PwT5H268GLUgY9nlBXnwsbiabC1idNrbq5qX3JyeoR5uDPWjjkbuHcR2jLEJiebomUXxUQfvfyTCjFrzt6yj3MBkmsd02A2LYAm59uCZ/KWypgN3Z9FCcJ8uSz1Ffv3y6EDlzE16blqgo0YG9u8D3Wn8gCdxrujcVircBiIJ8WENIn5ZdiMyhsoPm8+q9Cjx0Yl2HZlJOm7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 (2603:10b6:610:50e::10) by SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 21:38:18 +0000
Received: from CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052]) by CH4PR12MB720178.namprd12.prod.outlook.com
 ([fe80::2a60:de1e:e60d:7052%4]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 21:38:17 +0000
Message-ID: <125b1872-ce72-4842-88e3-abe7f8b1e772@nvidia.com>
Date: Sat, 7 Nov 2026 03:08:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/8] ACPI: CPPC: Order performance-control updates
To: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 christian.loehle@arm.com, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, lenb@kernel.org, ray.huang@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, kprateek.nayak@amd.com,
 maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20261106193304.3347374-1-sumitg@nvidia.com>
 <20261106193304.3347374-2-sumitg@nvidia.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20261106193304.3347374-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:261::6) To CH4PR12MB720178.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH4PR12MB720178:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 6309f48d-f778-47ad-f06d-08df3c4e4516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|18002099003|6133799003|10067099003|22082099003|921020|56012099006|4143699003|11063799006|5023799004|261022105027099003|261026121527099003|261028144727099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	vOeJZBFrPWmo6qLwQT3adKIdJZTarinSg0xWG1mImcYuoEnA7FR4Q6MyrYUSEVu82c8xZ/GFjagPANAvDav+XzJK6jkUHojr62CoSBvRQDhYWC61DmQn8W7Kh3r2OsePH0TI7FtPoFb547KrzG7e1v/ZKe9FLy0oSAiYSXj/jBJLGT8a5Re3EBD8x67Nz8xQxkbW4GkolZRGLnfsVGvmWtRK0ieOqonC0w54f1gl1uZjAVLfsdeX18YIklrpz/LHJTtxGUR51woa5BodWEutZatyKDnGzzQJKz7AXcpn3iCy2VYLv51OvMItZZRJpjdkNTs6gvadbHp25IFW5SQ17yqYE0YtojNjC0OJNn9Jv9EckmhJzvBY+Y60ofBuGJRc+nFJQZgGe83E7+mTY3GzKyguKPi/2UAnRI5Zc4KMRmtLnb/94yFrPef7SciFgiuDqrnU4EBXAACVWitcyfdl/sC5SO9WPZSMprKpHJAqS8nmRMRzvzaf3UzgPV0Cx3OW5FSLR/Kk5921ilnaBQX73g4olUNIbnjsT3gVw4RE+KRpFeFm4SNjxSSQq9WTbetAglwpClIWbzbRj0jdtahUlk+591/uJssQXulnIse5sOOalP+VV7IlwCIwmqDwRgvjk03vnSC5+tVdEbJMb/fKuH+C3oxJat3Dz8EJSdaDZuVM+8ZkP2GWwis7qO8ltdvbTQYsJF1S57vlOGg23559aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR12MB720178.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(6133799003)(10067099003)(22082099003)(921020)(56012099006)(4143699003)(11063799006)(5023799004)(261022105027099003)(261026121527099003)(261028144727099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRnOXk1ZUdla01xUjNubk1kQXA5T2syTklueEo2blJnQ09rM3dmZ1JkMTht?=
 =?utf-8?B?S2U1OUMyOFFiZlZYb0FIV1R0QTlPNytlS1lqWjB2UVVsaW9FNDdaZllZdmQy?=
 =?utf-8?B?UzhSQ0FXcmtkTVVVU2Nrek9nVyttdXR4N0FKdnRvOG9wMkNJY00wRlArNjBM?=
 =?utf-8?B?UVBzUjBsQmdRZ3NkQXFoZjVKM0prV1hMNk11V2NSS1c5dExGZFhFbGcwazI2?=
 =?utf-8?B?NG9sMW01ZnVyaGllSjBTV2IrejNiOHp0ZENiZVppdFpEYm9qeFBXV0VQUlc3?=
 =?utf-8?B?bTgvRlYrTTRuSXQyajNWUHMwMTNKeFcvT0h3V1paUU1KeEZxTU1wVkFuUkU0?=
 =?utf-8?B?QUROamtaNWJlTC8rV3M2RTNab2lFaFdHTEY4SmpJQTZQMjRFRUVTZHkxVk45?=
 =?utf-8?B?Q3NzZ2tLZENra0ZqMjZPVW4xOENJS0tIbGw3TzloVUFLdkFSbU8yNTNDQS9W?=
 =?utf-8?B?WmQxV3NFZ3VGZVUxY1U1OEVDUmNua2l1aHNMNkZaa1NNV2grdXIzY005OHM3?=
 =?utf-8?B?eERsVHZ1TVlDbUdYejdGRWowVGVJR25Qb2V5bjNmUGlwZXY5MHo3VXVha2Zv?=
 =?utf-8?B?T1JkWlZRMDZ0RkVRc0dybmJsbERqQW1DckQ2NGRSMnc2Y09wZG5MazRoTzF1?=
 =?utf-8?B?OGJIOVNkZ0dMR0ZCVzVDOGdwdnRPbCtMOEt1QlFzVm9meEtVcUZtbk5UYWx0?=
 =?utf-8?B?NCtLUXZFTGVoTnVRTDVEb3RUODYyNUZXc2p3SDE0V1FLOCs3dVg1VC9CdDZP?=
 =?utf-8?B?NS8vcWRCOGFaTGxycW14dmNFcjlBVk1oMDl2Qktib09RSmh4RnphOVNabTFu?=
 =?utf-8?B?dzMybHcralZMRTNlZW1UN002ZG5WbTQrOVdra0hiQ0Z0bk5qN1Zzd3dRRzUz?=
 =?utf-8?B?eklFcHhUMTZKdk9xSzEwZVpib3d5bm40WjZlUm96dC9QVnhENzk3SFJNNlV3?=
 =?utf-8?B?dXMvVWVla1JaVjVlL3RwamtIS3JEQVJBUkZWS1JNanlsWGhVbU9BTnVjMHBQ?=
 =?utf-8?B?OE9GeG85ZHJTTWRuQlVSUzBKWUNiOUswYXAyUDlvZVlBS1MrYmhtOHgwUjZX?=
 =?utf-8?B?WkEvRHpES1hQczNQZG9vbTdwcG13R2VnTDVDK2ZOd1JLdGMrcVpkbUZ5eTkr?=
 =?utf-8?B?eHh0dGlMTzA1czRMMkR0ZUErZU1STmJ2Q05LYTNURXdwSldIamFoMVVrQnk3?=
 =?utf-8?B?cGVJRVljd0lHVkF5cUVsUUhIemVhSnJMTVZQM3JicXViVzkwWmduMFN5UTho?=
 =?utf-8?B?OHgxV2VsYjBSREhSNXkrYk52MjNCbkhpQ2FGQklUZ2VWeEZnZldWTFRtRHJF?=
 =?utf-8?B?V1EwckF1SDloaWVjeVdTdzE2UzFMaW9mcFVoak5jQy8vVkFxTGNhWVB1NmQr?=
 =?utf-8?B?LzFyMW83S0lORVAyVCtJQS9KNTVhL3Jqell1eTlBUkR6WW1HTG5sVi9TSVV6?=
 =?utf-8?B?RzR4RUNrUzlEZDRQQXpsb0hDclE4ZkZRR3dwY0VWY09RT1hCcnphSDJDYjR3?=
 =?utf-8?B?OUMxTUJ3dkFoR29TaHhpQjdJaUNSTlNYVWRmbkhCc2ZhYkZ0VHNVbld3cTBI?=
 =?utf-8?B?RGkva0pLbHFDMUEyS2tFRE9FdHhESi9rM2plVUMzV3JqOTI3SHpTVmVlbWUv?=
 =?utf-8?B?YnYveGtTeXV6RHIxTUJtSHVTWXplRmlXVHhZRGhCSE9XN3NyYUhKa3RtbXRN?=
 =?utf-8?B?d0RCYzh3ZVFrK0oraExJRmZRVU9nczlUWjJvVHRFVzhzYklndFBGOFJ4MDdZ?=
 =?utf-8?B?elNHeWpGT1RFbERZUHhzTzJlTzVhUlZCT2I2bExab1NxNWRCWWFXQ0xuQ21C?=
 =?utf-8?B?NUdvN2ZtRURhMHVNOUF1S0FxK2Y1L3ZuM1BFUm5qSGhnbWZBaEgvYUJ0V1F2?=
 =?utf-8?B?bVZFWTk3NmplZ0pXZllsUlJiSXRIZFFlTjBuU1JkUDFtcHQ2dG9ZVUl6WXFa?=
 =?utf-8?B?TGQyN2JXVUpYdkNCZ0pRM0hwcTgvRkFYM3Jhb1AyMHRzWUNqMHh2YmRvN0Zn?=
 =?utf-8?B?SGhKTXV2cHc1UmhSMHpBZlNmdlN0TUUwd2VPOG1FWTkyUmFuWmpkT1N4bGpa?=
 =?utf-8?B?UEdsTTcwOERsOGpCQlBUV0VlVVNHMHF0dzQvN1kySGhxYTk1ZEcvVGlIQ1FM?=
 =?utf-8?B?VmlwZmRjTEZjUGRGam5mYVNtUGxvV1c0NE1wd0wyWG5DWk8wNCtsRWtFZHdr?=
 =?utf-8?B?eTIvVzMzRFpMMys3a3E2YjEyNnBVRDFOY3piZ2hZY0tkbU01ajJ3UWRSZE9E?=
 =?utf-8?B?YmwrWTVNRzVUdEgyYXVTYXdFSyt2TmpFR0JENERERWhvWElSTEFPOFRSYnBT?=
 =?utf-8?B?ZC9acDBMTnBjUGhPb3NBSnRjdGdjMkRzVFlSWHBuWkVtWWdKYk93UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6309f48d-f778-47ad-f06d-08df3c4e4516
X-MS-Exchange-CrossTenant-AuthSource: CH4PR12MB720178.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 21:38:17.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iCUvsjaEPCZEHfng9+FmyqIHbi8Rd+PsvdE7sGKnEVNwJfi0u+G8sP7RrwJ7dEfTGXdpT5b6ZT4wZ2yHv/hUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059

Hi Rafael,


On 07/11/26 01:02, Sumit Gupta wrote:
> From: Christian Loehle <christian.loehle@arm.com>
> 
> The ACPI specification requires Minimum Performance to remain below
> Maximum Performance. When autonomous selection is disabled, Desired
> Performance must also remain within those limits.
> 
> cppc_set_perf() writes the three controls in a fixed order. This can expose
> an invalid tuple after firmware resets the controls or while policy bounds
> move across the current desired value.
> 
> Read the live limits. Apply non-atomic updates in three phases: widen the
> interval, update Desired Performance, then narrow it. Submit PCC controls
> in each phase together. Keep the existing single-command path when the
> complete tuple is in PCC, reject invalid requests, and stop after the first
> failed access.
> 
> Make cppc_cpufreq fast switches include the limits only when they differ
> from the last successful request. Invalidate the cache across resume and
> after a failed request, since firmware may have reset the controls or an
> earlier phase of a failed update may have reached the platform. Publish
> slow-path limits only after the complete request succeeds.
> 
> At policy teardown, lower Minimum Performance together with Desired
> Performance so the final request remains valid. On initialization, clamp
> Desired Performance to the live interval left by firmware or an earlier
> driver instance.
> 
> [sumitg:
>   - In cppc_read_perf_limits(), skip an unimplemented MIN or MAX, and
>     do not fail on a live MIN above MAX.
>   - Clamp Desired into the new MIN and MAX instead of rejecting it, as
>     amd-pstate resume can round it above MAX.
>   - In init(), request the full range if the live MAX is zero or below MIN.
>   - Clamp Desired in set_target(), fast_switch() and store_auto_select(),
>     to keep the cached value in range.
>   - In store_auto_select(), publish the request only after success.]
> 
> Fixes: 76531df5e13b ("ACPI: CPPC: Add min and max perf register writing support")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Link: https://lore.kernel.org/all/01d7f07e-839c-428b-833d-713ed2128f4d@nvidia.com/
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---


Sashiko flagged three issues on this patch [1].
I think none of them needs a change in this patch:

1) SHARED_TYPE_ANY, when policy->cpu changes: the driver uses one set
    of controls for all CPUs in the policy, and always writes them
    through policy->cpu. So the MIN and MAX written earlier still apply.

2) MIN and MAX not written when the requested frequency is the current
    one: not new with this patch. Since commit 9801be8bef65 ("cpufreq:
    Avoid redundant target() calls for unchanged limits"), the core
    skips ->target() in that case unless the limits changed, also for
    the first request after the governor starts. I will send a core fix
    for this separately.

3) store_auto_select() racing with the governor: this is not new
    either. Before this patch, both edited the shared
    cpu_data->perf_ctrls. Now each builds its own request.
    store_auto_select() holds policy->rwsem, so the policy limits cannot
    change while it runs. store_auto_select() and the governor both take
    MIN and MAX from these limits, and keep Desired between them. So
    MIN <= Desired <= MAX holds, whichever write lands first. At worst,
    Desired keeps the older value until the next governor update.

[1] 
https://sashiko.dev/#/patchset/20261106193304.3347374-1-sumitg@nvidia.com

Thanks,
Sumit

....

