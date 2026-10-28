Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793155271;
	b=eRbsF62BeC/YkLmrHxHQdYnuLtUithl+w2HTzD3chBUxxaC9BLcGhZJ0eQ6coDpvipla
	 EDMq54zuQUcYsIQUmAH3fumRcl/G1+ql2O9I5bgMCrv+JFrKhqxzWFSSs58hh0yZhBhU9
	 fR+DyA67KSfG+UMaft7SEQt9AkM0MDEhT7TEF9OovnLDv5C7bidm52Csc9vaY153ZXh0H
	 CVe2mPLlLX0TNvdK4l//hys+ixFarzxlS/yYthMJ9I3byD5lYhwAQ9NfXl+33SCu3Jaop
	 I4/Ry78euVjxbzUr6m+woch7qIx2xE2PaTaywY4EmwwEIZ2ly51N1rHKTk7rrwm2DlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155271;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xUavhKmLPQPLbg94dxPACI6ZZG5fBqK8xXKoyjcc1tM=;
	b=DCT6b40e/8/WbjQmflQ12f1EgoHm/bVK4cTcK2/xj4bd15GY2Ss353MQVBPJXWJsoU7W
	 pDXFAEF5VfjZdtZzY7+AJVarW4TjUQt+WkfhOvBq4kUv12VMhWg87ylpIsr4bnjogC5NZ
	 VNvvrK1/dKVtIm2Q3/hQ0RhvCGMj1fuYjYq5CMSpwTCKQ1SdJ3Q0sCNLmUq2659fAVnwl
	 ir4VIWmibf8F86yJUBWG/yrD0fOmUFhDgkty115nGu6kP+TAEAh+z4v/4dDFQ+zelauHn
	 h/5EczjtRYPxOLdTwrWBuZg5NBcs+80Vc7mfP+MILIcrzslKxCmAASYhNA4KYjwjMxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BCaDSU+Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.23
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45423606A31A;
	Wed, 28 Oct 2026 02:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45423606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BCaDSU+Y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrLXxdsO7ULwW/nEf5WCPQ60xMwiT4BEEnXMCbIa6jqmbzSMYEwm2raLQAPBE8oKGaNOHCdBhqrf8/B6PhDnhgawWUHK3yNR8wyt8Ir/LC10OhuuHE/tzdosp8p7p49RfKVqGTZ2nYVLK4n5Msw9vPTf3lAQajMqcuRuLEh9R/pBQTeDXxgJbNaVXeLUXGhpX/Y4+Py0NJ+m8dti389ZQmpJcP4FNg9y8hSMKlO4dgkbxpuPzDPBHnzagpsf0oW2H6hdOLB2RMTZMXXsmcXdwNxVyG/aMNv/D0IrJs1cbiRiofCjIMZjZgQo9fTwLimABS/UFZzNJSqNTk7Do1ZkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUavhKmLPQPLbg94dxPACI6ZZG5fBqK8xXKoyjcc1tM=;
 b=khkF3owxswNaB3j30nhD9GdcJ2hHZIixj0VupyAabAlpYbVwWElUJhoP2WYvouhXaebECeONoZ9HQk+uLFsOOh48odDvEFCbVQuBB8yg/goDBK3R2tqVcZlQAIO/LTV333aSNy8cbP6syQKzYRKSVYVjfjltAP25gxLVt997Nm0QmOKlipRzbFtg7lzN6VIg4uPk8zOGA4aeR2PvSMl/Ts4jwWNfGv5tWLj3yXpmhOavKxkajGKDXnbO1gxU8nlrq4VLDvkLkiZerIIq+f3ryxCDJIF/r37F+f3MP9JrZBSOeos2YEm95FTRFxA7+3YedR3wd9meBl4Sw73ni/4Xiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUavhKmLPQPLbg94dxPACI6ZZG5fBqK8xXKoyjcc1tM=;
 b=BCaDSU+YZ0Kfvu6fBA7k06/IHe6BFnzuwh9orMBZLsze3tmmQ5STzfChPM3ojueSFU1u+seVn67HlNBAqFKoqFdHcI3oB2xd7bjW3OztPMZHeUkwy3NZdbQTI+KxzsZ7OoFzkz4beslsV3i1hwCgdju9+heYQ5xYGqzuBFR4O85yOqTcVjnSk405TLdJ6gRHpSrFpFj3uvwPkLvJPig9RZswvs+777JtDqNzZi5b/ips5f274K26Gq+XNf14E4h4ejKbSpKl2XvlMifgeNIe4h3datrICRiNAIFzliQMFQTBGSrrn0oFVopTpAX1yopQ+u8nPTWpbThMfpRntEXJVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 02:41:05 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 02:41:04 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, webgeek1234@gmail.com
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Srikar Srimath Tirumala <srikars@nvidia.com>,
 Eugene Vernik <crimsonslayer76@gmail.com>,
 Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH] thermal: tegra: Add Tegra210B01 Support
Date: Wed, 28 Oct 2026 11:41:00 +0900
Message-ID: <xWFJZZETTW-FWLmRyyuBKA@nvidia.com>
In-Reply-To: <20261018-t210b01-thermal-v1-1-af15746d86a3@gmail.com>
References: <20261018-t210b01-thermal-v1-1-af15746d86a3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS3PR01CA0076.jpnprd01.prod.outlook.com
 (2603:1096:604:da::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 6088e925-89fe-4563-1b73-08df349ce96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|56012099006|261026140227099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	9uH4Hii3LoxDACqTjbzseEKMtuelPeAJi4Mwx49CYIQkR5X7/faLkFqqgLKFz5khzyv55wAng+izCt39yhrG6PGsezYJQfF+cuzZoKc3KhahM1Xo9fmpXT5LGCNgg7c9WyAtu7ZiuF+iZY4DON1DcAfzEOUuSNtRQgbZrJrOKEgcZyE2iCGrcr4Hrhs5/w5Ik669mJWlLkLjufblbrRviAcBxpQhxcPqBCb+I7VNPozB2t+nCScyEW0v16u/xtpDp2s6nzu+b/O+Ky0mXDcu+95+tQJmSv7nU6bE1TimcW3wGSU1n+nS0LM6BVJ+z6wXvwUKLU/nSySv7cUowdbSs7Mq+0dsoh0Nsp1eK9RaWAlhEuTNM9nBPw1+GUvxvRMkMXkSVKgqJiZ5847ltCwaPtGnxGCcEejeVXwmHtfnC7FLXJvEPhrjUIWup9FT9wy1YFJkm0vApSKzTEJ3YfyKliIIAtKNqntYSRlgO/r/tD0096zMQ1prnMbhyKU0/1mDwtORShsv1Kz50rgSk8xkIJiQEjFWh9IMAflk36yfKUQM9XVTj209gg92d3mAZx171Vc3DhwuhDExkUCsGc9sHgBWgYXHD4Kqohs2k/IniChaAn/YpYnDptnbu+/miXlnplln1C0058Xm+JyXTMu2aPu+wb40uVRi0zTKZWwB9is=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFd2eG1lNFlwNU5RcUFrMnBxVFNhaUxLcUI5S3hlREl5ZXNYS2ZaSFY2a014?=
 =?utf-8?B?a29VaVk4Yk9rSnVYMXRsY3U0azdVckJCWVlzTzNIZnhIK1JTK1VkRjFydXJP?=
 =?utf-8?B?Y3BBWmk0SFErTlJ3Q0dOU0t1aEk0UE96ZU9OR0RxY29FbytPTzMwRkhNNVVs?=
 =?utf-8?B?MzRhY2M4UUxIZFNpdnZxaWlIVExmZlpUWG5SdkQvKytPeVpENWU0b3pmcE9P?=
 =?utf-8?B?WDIzK0Z0WHhicTFTWEY4L0J4cjI3QS9MRFc1VTdzSzdjM1B3NWhwbnlDN1VM?=
 =?utf-8?B?eTZ6ZnN0MTFORUp4aWNTbHJNUnFNU1B6UGRhOTVMU0lLUG1FclZZd2JUTDU4?=
 =?utf-8?B?bFhRNGtWNnJORE9wZXZ3ZXZ0RWc4YkVaSXppY2hKcVVJcWxFWmJGaWIzTkFT?=
 =?utf-8?B?cEF3MVRzOHhkODY1Tk1mMlJMOGVRamM5Q0EvQ1p5dHpxd050SzBUbUdYQUVH?=
 =?utf-8?B?TVpjTUNwMVNoRjgxT3hYUjNGakVpU2RtQXNwMEtqK2t5R1NPRjl4SDJ2Njg0?=
 =?utf-8?B?R01mZmNST3kxTHJuU0lvN0o0eEV4WGE0VXJhNDJqbkk5VXdxRC9mWVRlVjNB?=
 =?utf-8?B?ODhubDBQTER6cTV3Nkc2T2laa25uOVVndXBxVTlsck9BYzVSdHVNUGZ3a0s0?=
 =?utf-8?B?TER4TWZhbUZJbHVaQWk0ZGhKWHhIeE41cm1MYkJrYmJFRHdhczJ5R2NPcDI5?=
 =?utf-8?B?c1JKV29XNkRzZzNCQy81ZVNRVlhhMnNyU1FOVWtVOEY4TmtiaGlPYjd6QnRX?=
 =?utf-8?B?dWZnWnVnS3B6a29IS0pRdC90ZHd5YVhGeUVjRWszcEpaWlFIWkZIeDJDU1Zn?=
 =?utf-8?B?N2JoNzBtQzFQZzhja3lPMVo3TnlzYWtSeGtyR2Eyb0hZczdzM2RTVW1jVVVl?=
 =?utf-8?B?Z2hiM01US0UxcmFxcW9MK2RaZ3ZiT3pnc2pVbHh2TW11bDM3WkQxdVZsV2Ey?=
 =?utf-8?B?NmFGSGpKV3VQZ0E2NU80TG1KUVpHU3V0QzBTbWZCYUVEbzg5MGp5ZmVaajY5?=
 =?utf-8?B?akRJTnZmK3BUNWJzMjdCUitSSVdlMzUzVXZRV2ExNzRxcUNHVzg1Y3pHbFhW?=
 =?utf-8?B?UW8rcFBlM0J4NzU4MjRQRHlzUTFPUytDRExRQ3d4OGtzOC9wQmQ4NmpzVnhw?=
 =?utf-8?B?SmthNGFVOHZqTDhkVERKZmZNTGxsQTdFc09FZjBId1NmVkViTkFMdFh3YlZo?=
 =?utf-8?B?QXBZK0pZMVhTVHhFdk1WRGRvTGtKOWtvaXJuNEI4dXBRbWtRNW5HSkt2UlJi?=
 =?utf-8?B?RWR6Q0p1dThuUTJGYUFzemgzR05uVlI1aHFTQ3Ywc2NGYjd1UVhMQzRMc05F?=
 =?utf-8?B?MDZ4SVhPSzRTYlRDRUR2b2kyZnEvUGF4YVlacDMyS2s0VTVBNXMxa2JMTkJM?=
 =?utf-8?B?NC9oc3JzWUh1SDhXZXZLd1FLcnNCZDNIRExoNCtYajZyQmlQT0NGZ2tVdXdP?=
 =?utf-8?B?TUNROFZ6R0tpd0xWT1gvYXJFVmMwMEp3OEJxSCtPeTF5Nmt1QWUrYU9QcEFC?=
 =?utf-8?B?N1ByNDdDbmdzYkwyL2crS2pKWnVmWlU2ZkJTTzM5QWxmdy9XNmUrM3hETG5x?=
 =?utf-8?B?Syt1UUdJUlJ3MzUzdFc1L1paUUlwOG43UkxNTlVQM1RIcE9DWmI1cVcwN0ls?=
 =?utf-8?B?amtlREw4NjNzcEVxVzlVdS9md1lvZG1HV0tMS1AxMWJWa2xPSHR6SmFldi9r?=
 =?utf-8?B?NCtIVEZ6NEtlUnNLbHVaOGVDSFBJdlhTTSthSm4xcWpld3BoY2ZhaEZGbzVP?=
 =?utf-8?B?T0RIU0ppbUg5Q3BlVnByTENhRDZkUXEyQ2pFbHNSRnNsNFd5SHU4WGxtMHQv?=
 =?utf-8?B?aG1hZTNBNFlWWTloRTYvYk5rZkROekZIOEgrU2ROSlhaZzRKVTY5OWFKY1A5?=
 =?utf-8?B?VE1WTWNmM1VVdjBpVnlBWWxDbXdRWitRd2IrOWFHbEhLa2EybXJ2OG9EbVZE?=
 =?utf-8?B?KzV4MTFqVVFaR1dPcmM1OUorbzloT0E1azdVTHF3QUszWmtNbXNCVVY5Smxx?=
 =?utf-8?B?eWxKaUtobWtZNEx6My92TVJUTXZaT2RYTFllVW5Qd0lIcVFQUG9RbTBZV2hH?=
 =?utf-8?B?TTYxa0NnbVN0aThWbVBrdEN4WjVKQWI2a2dKMzhiTHJKc2UyUXNpd2JFbmhW?=
 =?utf-8?B?L2FBa2QwUFBpeHFHdStDNENkOVJvWVpGYlp5QUxoYkhqN1FGMkdRdWx2TTVs?=
 =?utf-8?B?VWRaWENKTXlMMmNaZnhIcTRuUE9KZmN6TGxnTEJSeExLWmhTZHpoTnM5Yjds?=
 =?utf-8?B?WW9KUEt2NzAzMFRoYlJqeHRVa2NCUEZLTW8rT1JPY1VHMUVXSHZQQlU2OGhE?=
 =?utf-8?B?QWVJaS9zSjNieDVPWTh6S0lQQkZjcUhITWMvM2I2MUhrZlBwbXBDV3B5UVRI?=
 =?utf-8?Q?Xkkb1J+zmXxzRB+IZgz0HLon7/KGGVH4PI/DDu70frKGu?=
X-MS-Exchange-AntiSpam-MessageData-1: nWCTSaU1I6xgiQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6088e925-89fe-4563-1b73-08df349ce96f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:41:04.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myW3yV8w6gWip6XKVx9Jh8NzEnOiraCpUtidghQH5qsadiWCZZTLWfcDZCGIskukjROf5Fr52cT++hCtzoT/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737

On Monday, October 19, 2026 7:20=E2=80=AFAM Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> Add Tegra210B01 SOC_THERM configuration. There are two main differences
> from the original Tegra210:
>=20
> * There is no mem thermal sensor
> * Pdiv and pdiv_ate differ

tsample is also changed

>=20
> Based-on: https://gitlab.com/nvidia/nv-tegra/linux-5.10/-/commit/b15149a1=
5154e6b2fc827f4f169e37c9e5b389d9
> Based-on-patch-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> Co-developed-by: Eugene Vernik <crimsonslayer76@gmail.com>
> Signed-off-by: Eugene Vernik <crimsonslayer76@gmail.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> thermal: tegra: Add Tegra210B01 Support
> ---
>  drivers/thermal/tegra/soctherm.c          |   4 +
>  drivers/thermal/tegra/soctherm.h          |   1 +
>  drivers/thermal/tegra/tegra210-soctherm.c | 133 ++++++++++++++++++++++++=
++++++
>  3 files changed, 138 insertions(+)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index d8e988a0d43e9..95451d1bd4e62 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -2082,6 +2082,10 @@ static const struct of_device_id tegra_soctherm_of=
_match[] =3D {
>  		.compatible =3D "nvidia,tegra210-soctherm",
>  		.data =3D &tegra210_soctherm,
>  	},
> +	{
> +		.compatible =3D "nvidia,tegra210b01-soctherm",
> +		.data =3D &tegra210b01_soctherm,
> +	},
>  #endif
>  	{ },
>  };
> diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soc=
therm.h
> index aa4af9268b05d..4bc1e44e28827 100644
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -156,6 +156,7 @@ extern const struct tegra_soctherm_soc tegra132_socth=
erm;
> =20
>  #ifdef CONFIG_ARCH_TEGRA_210_SOC
>  extern const struct tegra_soctherm_soc tegra210_soctherm;
> +extern const struct tegra_soctherm_soc tegra210b01_soctherm;
>  #endif
> =20
>  #endif
> diff --git a/drivers/thermal/tegra/tegra210-soctherm.c b/drivers/thermal/=
tegra/tegra210-soctherm.c
> index f6e1493f0202f..b4f2c7837fd69 100644
> --- a/drivers/thermal/tegra/tegra210-soctherm.c
> +++ b/drivers/thermal/tegra/tegra210-soctherm.c
> @@ -44,6 +44,14 @@ static const struct tegra_tsensor_configuration tegra2=
10_tsensor_config =3D {
>  	.tsample_ate =3D 480,
>  };
> =20
> +static const struct tegra_tsensor_configuration tegra210b01_tsensor_conf=
ig =3D {
> +	.tall =3D 16300,
> +	.tiddq_en =3D 1,
> +	.ten_count =3D 1,
> +	.tsample =3D 240,
> +	.tsample_ate =3D 480,
> +};
> +
>  static const struct tegra_tsensor_group tegra210_tsensor_group_cpu =3D {
>  	.id =3D TEGRA124_SOCTHERM_SENSOR_CPU,
>  	.name =3D "cpu",
> @@ -63,6 +71,25 @@ static const struct tegra_tsensor_group tegra210_tsens=
or_group_cpu =3D {
>  	.thermctl_lvl0_dn_thresh_mask =3D TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK=
,
>  };
> =20
> +static const struct tegra_tsensor_group tegra210b01_tsensor_group_cpu =
=3D {
> +	.id =3D TEGRA124_SOCTHERM_SENSOR_CPU,
> +	.name =3D "cpu",
> +	.sensor_temp_offset =3D SENSOR_TEMP1,
> +	.sensor_temp_mask =3D SENSOR_TEMP1_CPU_TEMP_MASK,
> +	.pdiv =3D 12,
> +	.pdiv_ate =3D 6,
> +	.pdiv_mask =3D SENSOR_PDIV_CPU_MASK,
> +	.pllx_hotspot_diff =3D 10,
> +	.pllx_hotspot_mask =3D SENSOR_HOTSPOT_CPU_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA210_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA210_THERMTRIP_CPU_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA210_THERMTRIP_CPU_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_CPU_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_CPU,
> +	.thermctl_lvl0_up_thresh_mask =3D TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK=
,
> +	.thermctl_lvl0_dn_thresh_mask =3D TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK=
,
> +};
> +
>  static const struct tegra_tsensor_group tegra210_tsensor_group_gpu =3D {
>  	.id =3D TEGRA124_SOCTHERM_SENSOR_GPU,
>  	.name =3D "gpu",
> @@ -82,6 +109,25 @@ static const struct tegra_tsensor_group tegra210_tsen=
sor_group_gpu =3D {
>  	.thermctl_lvl0_dn_thresh_mask =3D TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK=
,
>  };
> =20
> +static const struct tegra_tsensor_group tegra210b01_tsensor_group_gpu =
=3D {
> +	.id =3D TEGRA124_SOCTHERM_SENSOR_GPU,
> +	.name =3D "gpu",
> +	.sensor_temp_offset =3D SENSOR_TEMP1,
> +	.sensor_temp_mask =3D SENSOR_TEMP1_GPU_TEMP_MASK,
> +	.pdiv =3D 12,
> +	.pdiv_ate =3D 6,
> +	.pdiv_mask =3D SENSOR_PDIV_GPU_MASK,
> +	.pllx_hotspot_diff =3D 5,
> +	.pllx_hotspot_mask =3D SENSOR_HOTSPOT_GPU_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA210_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA210_THERMTRIP_GPU_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA210_THERMTRIP_GPUMEM_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_GPU_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_GPU,
> +	.thermctl_lvl0_up_thresh_mask =3D TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK=
,
> +	.thermctl_lvl0_dn_thresh_mask =3D TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK=
,
> +};
> +
>  static const struct tegra_tsensor_group tegra210_tsensor_group_pll =3D {
>  	.id =3D TEGRA124_SOCTHERM_SENSOR_PLLX,
>  	.name =3D "pll",
> @@ -99,6 +145,23 @@ static const struct tegra_tsensor_group tegra210_tsen=
sor_group_pll =3D {
>  	.thermctl_lvl0_dn_thresh_mask =3D TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK=
,
>  };
> =20
> +static const struct tegra_tsensor_group tegra210b01_tsensor_group_pll =
=3D {
> +	.id =3D TEGRA124_SOCTHERM_SENSOR_PLLX,
> +	.name =3D "pll",
> +	.sensor_temp_offset =3D SENSOR_TEMP2,
> +	.sensor_temp_mask =3D SENSOR_TEMP2_PLLX_TEMP_MASK,
> +	.pdiv =3D 12,
> +	.pdiv_ate =3D 6,
> +	.pdiv_mask =3D SENSOR_PDIV_PLLX_MASK,
> +	.thermtrip_any_en_mask =3D TEGRA210_THERMTRIP_ANY_EN_MASK,
> +	.thermtrip_enable_mask =3D TEGRA210_THERMTRIP_TSENSE_EN_MASK,
> +	.thermtrip_threshold_mask =3D TEGRA210_THERMTRIP_TSENSE_THRESH_MASK,
> +	.thermctl_isr_mask =3D THERM_IRQ_TSENSE_MASK,
> +	.thermctl_lvl0_offset =3D THERMCTL_LEVEL0_GROUP_TSENSE,
> +	.thermctl_lvl0_up_thresh_mask =3D TEGRA210_THERMCTL_LVL0_UP_THRESH_MASK=
,
> +	.thermctl_lvl0_dn_thresh_mask =3D TEGRA210_THERMCTL_LVL0_DN_THRESH_MASK=
,
> +};
> +
>  static const struct tegra_tsensor_group tegra210_tsensor_group_mem =3D {
>  	.id =3D TEGRA124_SOCTHERM_SENSOR_MEM,
>  	.name =3D "mem",
> @@ -125,6 +188,12 @@ static const struct tegra_tsensor_group *tegra210_ts=
ensor_groups[] =3D {
>  	&tegra210_tsensor_group_mem,
>  };
> =20
> +static const struct tegra_tsensor_group *tegra210b01_tsensor_groups[] =
=3D {
> +	&tegra210b01_tsensor_group_cpu,
> +	&tegra210b01_tsensor_group_gpu,
> +	&tegra210b01_tsensor_group_pll,
> +};
> +
>  static const struct tegra_tsensor tegra210_tsensors[] =3D {
>  	{
>  		.name =3D "cpu0",
> @@ -193,6 +262,58 @@ static const struct tegra_tsensor tegra210_tsensors[=
] =3D {
>  	},
>  };
> =20
> +static const struct tegra_tsensor tegra210b01_tsensors[] =3D {
> +	{
> +		.name =3D "cpu0",
> +		.base =3D 0xc0,
> +		.config =3D &tegra210b01_tsensor_config,
> +		.calib_fuse_offset =3D 0x098,
> +		.fuse_corr_alpha =3D 1085000,
> +		.fuse_corr_beta =3D 3244200,
> +		.group =3D &tegra210b01_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu1",
> +		.base =3D 0xe0,
> +		.config =3D &tegra210b01_tsensor_config,
> +		.calib_fuse_offset =3D 0x084,
> +		.fuse_corr_alpha =3D 1126200,
> +		.fuse_corr_beta =3D -67500,
> +		.group =3D &tegra210b01_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu2",
> +		.base =3D 0x100,
> +		.config =3D &tegra210b01_tsensor_config,
> +		.calib_fuse_offset =3D 0x088,
> +		.fuse_corr_alpha =3D 1098400,
> +		.fuse_corr_beta =3D 2251100,
> +		.group =3D &tegra210b01_tsensor_group_cpu,
> +	}, {
> +		.name =3D "cpu3",
> +		.base =3D 0x120,
> +		.config =3D &tegra210b01_tsensor_config,
> +		.calib_fuse_offset =3D 0x12c,
> +		.fuse_corr_alpha =3D 1108000,
> +		.fuse_corr_beta =3D 602700,
> +		.group =3D &tegra210b01_tsensor_group_cpu,
> +	}, {
> +		.name =3D "gpu",
> +		.base =3D 0x180,
> +		.config =3D &tegra210b01_tsensor_config,
> +		.calib_fuse_offset =3D 0x154,
> +		.fuse_corr_alpha =3D 1074300,
> +		.fuse_corr_beta =3D 2734900,
> +		.group =3D &tegra210b01_tsensor_group_gpu,
> +	}, {
> +		.name =3D "pllx",
> +		.base =3D 0x1a0,
> +		.config =3D &tegra210b01_tsensor_config,
> +		.calib_fuse_offset =3D 0x160,
> +		.fuse_corr_alpha =3D 1039700,
> +		.fuse_corr_beta =3D 6829100,
> +		.group =3D &tegra210b01_tsensor_group_pll,
> +	},
> +};
> +
>  /*
>   * Mask/shift bits in FUSE_TSENSOR_COMMON and
>   * FUSE_TSENSOR_COMMON, which are described in
> @@ -230,3 +351,15 @@ const struct tegra_soctherm_soc tegra210_soctherm =
=3D {
>  	.use_ccroc =3D false,
>  	.thermtrips =3D tegra210_tsensor_thermtrips,
>  };
> +
> +const struct tegra_soctherm_soc tegra210b01_soctherm =3D {
> +	.tsensors =3D tegra210b01_tsensors,
> +	.num_tsensors =3D ARRAY_SIZE(tegra210b01_tsensors),
> +	.ttgs =3D tegra210b01_tsensor_groups,
> +	.num_ttgs =3D ARRAY_SIZE(tegra210b01_tsensor_groups),

One issue in soctherm.c appears with this since the ttg ID space isn't=20
compact anymore.

The array thermctl_tzs[ID] is only allocated to size soc->num_ttgs,=20
which isn't enough when there are gaps. The array should really be of=20
length TEGRA124_SOCTHERM_SENSOR_NUM. Can you add a patch to change that?

Thanks
Mikko

> +	.tfuse =3D &tegra210_soctherm_fuse,
> +	.thresh_grain =3D TEGRA210_THRESH_GRAIN,
> +	.bptt =3D TEGRA210_BPTT,
> +	.use_ccroc =3D false,
> +	.thermtrips =3D tegra210_tsensor_thermtrips,
> +};
>=20
> ---
> base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
> change-id: 20260714-t210b01-thermal-227e6cfd2574
>=20
> Best regards,
> --=20
> Aaron Kling <webgeek1234@gmail.com>
>=20
>=20
>=20




