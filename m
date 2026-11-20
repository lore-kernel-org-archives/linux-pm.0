Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160233;
	b=mSCDrqTJ7I+UrAh0jWpmRrMXrH5gNOOlQ/J7Z9mAU61A6qEb0ee3aEtE/zNfLS5//pIE
	 N0L+D/bMQYTPDcbcPowMU2UiPwHMtqURNcWqx5Sd8emtXQowg43igPPtUCmjO7/X1LAfD
	 6a9Gw4nBpRkdPCi2+8whDeB6n8eWUb1AVsj/QD9FHTKUiGiHlayIFGTb1UvNZGUxCEBuO
	 s93Z82UQTeKGWMoowTofytviqoo1rz/VmO/E91DoarSKW0haI7NmqFODT7bj3UYpAWjmv
	 l35XR6GVgp+GZrfg62fhQmYzGOKW2Y2jcS+rejFjScp3/YJP6Kk2HDS6/j7y4lPtJtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160233;
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
	bh=EE12diraHnuUqhuGnO71p5Ls3rDodAhTtGc3iVKrQVc=;
	b=JwsVzUiVXNCZ6kuMMyIxZN+tAkLG0Pm2WlniHWgGulq3f7IAHOhO7fPMBitKvbGNR6Dt
	 FxbMY2cJO19XtL+0m5khuzDyZpDakn52tonK/CVqDFCxc9+6FPKxJ4dXSnL4cYVDEsfsJ
	 csxTWNyeYm+v2RxhoUh2X4MwbHmVw0XBeRLwuSszrW2LnlKvqeqHK73dFpVE9GCB4MkVm
	 s1RDUQmS5jRgTcGoTZ4cB1Eoo5zIdSKzazB7EnniXa61o5XeEkauraLmqS0pPaeVW4drv
	 swKgyPZTPC3zcRG7nWaDeOcMMKy0NNUtYGp/rzf5IPuBgtgQvQepLvuLIMhFqLOJpaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=klirxl1r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.49
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538E606A320;
	Fri, 20 Nov 2026 07:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B538E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=klirxl1r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcYq3jySJyyCyIEQZLAQQBnb5cffSltHXeL0tOHLQ2/aX2QGENDG7iX9JjEO6sR36GIyTYdMBx1ZuSZcjhr61hsyfgLBkSS3PNSF6HHXlFfU53hRv26Raf5pjMOMMNTaeTeVhoZ1x4+YlMQH4cx48RWTZ8tzDHkJnKCydbws3+fP73iDqlUo1slD35gAPp6+FXrgUgEGwhRyBCN/nFvEaZddarvrRDKAI79qRNuVawPalkCwYVea/2u4J2J/BmdzMWn8BVaEAoXk1lU4xc9INpwlYU/7nLqzHltvT+7vXPdOib5Bg1GY0XG/U5QOK4Nat4TPL36LhU29s2pqLQW19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE12diraHnuUqhuGnO71p5Ls3rDodAhTtGc3iVKrQVc=;
 b=jX8drdHm+rBtplsZ2PJ/a7hC/6Oe/Jo1OTl6hcTSkPOq72PNFF6qTY+W+47O8f1in8lc3E/GjL0ziA5p88IJCLyogTZJ7NtJcFY0kf/NbASTvDlwj15t0IQn0mdXPG2LfzHwnJhAtkP2UeBF1Ww05B4Z4eMFMYuycwCMlZZ860lb2dlps2nLIvVpNGDUG2PutNxds5gbMcj8tb1FjBLuvcykAK0HmF7XCNBqbOGNVeV2x9J/NzlLHYOP63eXUj2JmEHtrXrJEplY1kkjygIeTwhnJjG9qlHnYyAe1FpGr9qSfOhoDYuqLvSkrfhbOMSkGJ/aqMnwV3HZnDA2CQJFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE12diraHnuUqhuGnO71p5Ls3rDodAhTtGc3iVKrQVc=;
 b=klirxl1r0ESmWp7VSShChGbdnAU/c3nLPANL/2btgEx8m0p/gEmKzdnAUmL54RAIcbLAuVrGpHngQApiHuGH0xvFn9594aqqjlAWjA67RvfnjyGaVBVWAHTKX2PJFQ91DG+OmT9B35TAdu9RwLkbGb9jBGitjbotvM8x2NBpLZMvJenvafxZfyTt5wDA8wpN/LH88QwJZR9Yr+zth6EK+NhuYQdDRZgtiI1Hb0/RMI6eSujrlXsxDVNP7x+ou8YRfVhrQjBYnN2OILfPFVDplTA+j42QZZj8mPv1eyJ3uRJoMYZyS+NiXmbBcfOvs8deHdTcU/1b3kwMs/UespAA3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:37:06 +0000
Received: from SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7]) by SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:37:06 +0000
Message-ID: <61d207b2-3155-4613-bc9e-588c68f276fd@nvidia.com>
Date: Fri, 20 Nov 2026 13:06:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] cpufreq: tegra194: add Tegra264 support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 zhongqiu.han@oss.qualcomm.com, conor+dt@kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, bbasu@nvidia.com
References: <20261119111217.902071-1-sumitg@nvidia.com>
 <av_R-8aMX7lL83ln@vireshk-B250M-D3H>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <av_R-8aMX7lL83ln@vireshk-B250M-D3H>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::17) To SA1PR12MB5637.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d82c0c3-d448-4dbc-00e3-08df46d913a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|4143699003|261026140227099003|261009223027099003|10067099003|261026121527099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QN9kDo/bgL4MrxVbktJ11aTLLKbwr7QnuVSRiCK50NFXpAK8g5N+xnxhAZqSH+ttTlA1kJwwSApUUmI4wDsY6D+F9MjwaoA/OK6NPqbsoKTge38wwXSwC09Oq6mpvrzctFT798TJ19t+9x24F41uP7zGBL2/e+X7Z4KDptr7bjX/DfivEl0cM3VDYTOr2hP+pq2Sk0l7hLOAYX5Ms7zNx+EnASMCf0bQ7lQAoVA9MCSnwNjY1He5bf9eL5mgBNMf8RxsqYYevRWpbjgQxEP91u1Lrn3zSIFqvGGkG90XLpRtFtxQOxQUTep+pjc/8tn/kAoOijXwHQUQELeC5qYePLBEggP6tFPI2Ofaa24nD/N89+AIbZtz8MKSytenfmrQv24R7Hku1NI/Cftf9uRq8g2jJ3qZK16x1zaub9v6iwgkpzBcklvG7a5MRwvG6cW2mMKr1igE5uXbwNErebZfs/ficGteBDRzGytfLElfbPAP8f5ZFtIQA5SKK0WMxn6BPyBS50VWb24L78q5PhMldJrjJwcu8ybOqG4HH2yBqiIBQAUGD3ricmc3VjSz1gtGtzh8LJoZDyEvtx07LxVH/eQnbdkXGTMCtcVfA3yFVdUc6JanlQANNyJtSKdx94eKoketioIhdW5ftPXwt8K4DtBxFVEJyAlVjLb6mI7A6FM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(261026140227099003)(261009223027099003)(10067099003)(261026121527099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2xXR3BrbXFvSnp5SG4rVHdpWGFtQnZ0Y2RCVTFjNlRpcGUyRGdZK0NST3Q0?=
 =?utf-8?B?UGlPQmw2N1RQQ3FqSnJIbU0yenEwYXJPSWVQbk5YZGVYVy9NK1F4eStCZXU0?=
 =?utf-8?B?dEJyUzlCSjZPNWpPdG1aTHFZSHpGRFgreUVtcFZPb3UvUjBRWmtiWnluaC9J?=
 =?utf-8?B?RWxZbDRkZE5vN0dkb2ZMQTgzUmpLZWdpVVVQcC9XVFNaa3Q5eThMb3ZMaDlJ?=
 =?utf-8?B?d2RoZDFYREtrS3dXWEhzV1BjbGhkVVdUTFhtby96NVY2VXFyUEpaQng1ejhR?=
 =?utf-8?B?UHZ6VVdUTk5uN0V5b0xRcWo5SnJpT0dLOGsxd1dHYTJpS1hNcE5LSDNLOUtV?=
 =?utf-8?B?QnNwb0FVcEdYNzFpTVVJVjE0cWR4RkpHUGs5Vko0WXcxVkJZaXh5MWkvamdO?=
 =?utf-8?B?Mlpuc2VwbEtXM1lQZTR5TUorZ2hmQVZ5U1JINjY2d3VyRjQ3alorNHM1WDZl?=
 =?utf-8?B?dDBDU0wwOEhjMkJEVkEybnhlemhRWHNHOUhVMHNxVTB4RzIzcitKZlNPRVA0?=
 =?utf-8?B?b05xTDgvdkM1NWpuZytua1pDWW9CT0xzdExEekRuWTU3aHpXbGtJQXFUQ09y?=
 =?utf-8?B?aXpnd2MxOW0zUERUbUF2NTdLSmR5S2JJbkNPNENtaVZHWTczWWZ6RTN6WFVo?=
 =?utf-8?B?eG1jR3lKMFh4UWl5VzFENDhXd1lMMEZwY1piK0RZR09EYk1LVnhzTWluL21o?=
 =?utf-8?B?N2gxbjBZaXVqc0pDWXE4VWcvVGd6bTR5d05sMFR3N2tidFdUenBlNkcyL3F0?=
 =?utf-8?B?UDQ2Z3o3ckk0b2tZTnZNSGh3ak95ZGJqWmwwVGVUT2c1YXlRU3YyRFY2aHhN?=
 =?utf-8?B?ZmI4L2F6ZWZnbTE4bFAwMHdmQnhXSUxFckQvZGVYbTVhSVR4NWNVN0ozZnR0?=
 =?utf-8?B?UHpySzd1ci9RSlFZQ3lCZlptbTNZWTZFWW9PbkI3QlZNSmxaaXlYeDRySFVK?=
 =?utf-8?B?WEgwOForaVJGN2ZLSDArTkNMTjEyVjh6Vk1CR2VwNXZ3OHZkeWljWXM5S3BK?=
 =?utf-8?B?WVNDRWhSdWJLVGZHRGUyVVZVaHVVbDJQMkhyNzVkejBha2pPRE1Vbm1YZERO?=
 =?utf-8?B?YW5oVUwxRjkrZDN3R0Y3QXRFbTc5Nk1NWjdBemNLTVJtTHRPdjdVSVQrVmY1?=
 =?utf-8?B?cnJaRTc2ZVF4WFo0cVRMc2YrcFNpRFVESW5YcWVFcHErL2JMOXBxNElrSjdz?=
 =?utf-8?B?djNMUnM3Ni9KaU53YTAxU2x1NVh0UnpmcHRYQ0xIZ1RjZTNDMHR1NUNwVm9Y?=
 =?utf-8?B?YlFvdEMzaVJUaHlETTVVS3VuRUl6Wm0vQlYyUS9hRGpBT203ai9IbnY5U3Rk?=
 =?utf-8?B?VVh3RVpwK0RGTHVRVlVMMjNaWHA1dTFiajBnUVVkTlFPeGpybmd4WjgrcGo4?=
 =?utf-8?B?UWN0WEpWV1RudzlrbTIyREdMZ1dEUExtYWI2T09zTE9mR2F5eVEzdS92WVVV?=
 =?utf-8?B?SzZzcTBYVmxycnJweG50UEM3MlRLTFZ3T2FENmxwc3dOOVdqM3BtN3FKbmMw?=
 =?utf-8?B?RHZISElKNFplWXduaHpZekk2VEtDSEZiNzdVWThkY09lOXVUWk0wS3U2ajZK?=
 =?utf-8?B?Tk5BMHZ0MGY4dGF4YXprU0tZRXJNa00wUjZTNUlVMjBuTlVZTURFY0RPSVRR?=
 =?utf-8?B?TFc3TWhpSTdmQUhZaGtpbVA3RFBUeVkzZ0RkMXNrSEl0MmpaNm1zQ3owQ1lY?=
 =?utf-8?B?YVZEdGhSYS9tNkt3RVc5N05rUlJ4NWRXWEs5cEI4N3NVT1h1L2J6bnVERlVI?=
 =?utf-8?B?Z2VCcUs1STJzUlBMOCs0VDlDdThlakozbUM5WkdDV3Q5dWFiRTVTaWZ0MkRR?=
 =?utf-8?B?SkZ0V3RPQ3lvOXIwK3o2KzIzMXFEY3JWYnNxVGp4WUZRbk1EdVI4L1BBbVJT?=
 =?utf-8?B?WWdKYTRXMVpVemUxN2RKNmJpaGY0aXJaQjhBUHRCa2c3Y3dpRjBUcWFrTGZW?=
 =?utf-8?B?S1RNZEdUOHE3MnhwU1U1UlpWUTFYRjRyTXd1ZFdiU1pIT3hJVlUvNU5naUdJ?=
 =?utf-8?B?MmxoMmxaeFNQZWFZbnlFRFM5dmMySEJPcXBFRGZaUE1yb3VQc0dVVGhOdFZ4?=
 =?utf-8?B?UjlWUzd2ODNjVnZzRGlCRzRuQ25GNVdQNE5KWFVSRlc4VXJ0RFhKTFdDSEFn?=
 =?utf-8?B?N1VvSk5LWDAyT0diM2RtL2g0QXJyZmx0K201MFhrelZEV3VQVUt0NWJ2SUor?=
 =?utf-8?B?Sk5zTnpjV0taLzFrTitNanl0bzVuOUhHT2ZFT1BaN0lsNmtvOEtRaUt0UzhL?=
 =?utf-8?B?TnRpU0ZuK29LcTQrQ0ZHZTF6ejBwSEFTYTlBWG9RWU9zT3dzTDBTMk4rQ3Bs?=
 =?utf-8?B?QzkvWEdQSmZmWmxFUHNTUXJyWmQvbzB3Y1FSbitURTBYVzF3d29PQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d82c0c3-d448-4dbc-00e3-08df46d913a6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:37:06.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa+qzG1RYwJ2/QBgPKnl4+jyc1Aacnz4KKFSHql0sClbMnF1rhu/FkluVYmsbSCBAMhCe3PhDBnA22FLX2eIDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

Hi Viresh,


On 20/11/26 10:22, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 19-11-26, 16:42, Sumit Gupta wrote:
>> This series adds cpufreq support for Tegra264, which joins the SoCs
>> already supported by the tegra194-cpufreq driver.
> 
> Please rebase over
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
> 
> The current series doesn't apply cleanly anymore.
> 
> --
> viresh

v3 was on linux-next, which has commit 4dd10fbbeb9c ("treewide: Convert
devm_kmalloc() family to the devm_kmalloc_obj() family") from v7.4-rc2.

Your branch seems to be on v7.4-rc1, so v4 on it would conflict with
that commit in mainline. Should I send v4 on your branch, or would you
prefer to move it to v7.4-rc2 or later first?

Best Regards,
Sumit Gupta

