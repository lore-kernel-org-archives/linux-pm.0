Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794909251;
	b=cPKhgLVljiOU3gtkar47UdX2UNEMq7hlJp5f4Bdh92O3p66iVxFozm5kEOujTkmPeQ3l
	 KXZjIsyit84h7INjqgOx5hQtPuol1CVkrZ2rmbdXg2LhxJpsIYsuZN2/xu9fe+3KPs0jh
	 Gzi1J5h7xdaCAfmU1zqgSHW5Z3vI1MdQhfaAAz8lISA8x4P424p5pNEDBA3Gl9pmKw3od
	 ZrlB+4RiJYiMbQ2ZQ5qtGZGEL1L2hOcFol/PalIHlCbE5/s9gnEW12PKfF6f2VBFoVxLy
	 SKCIlAPliWMTdRtaxXb6yaAtwquMURJH9t1ikQFqX2IgLBkedvtj25x3TKLMML8Jo6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909251;
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
	bh=mYM5Sg+NYFAqJmyUyoJVrtE2SIeQ3yKJ4yO6kvBsCe4=;
	b=lRdJ6gYcWD8OePSRB8XPTxuDG6uMNEKxxRLnZnhTWzdVdTGztKmSeg7pqfDhH7JUpwzi
	 SZl4ZSnHa9tArT5y6r6Vj3twmeX9CLKvI/RzDJmMX77j54WjqDIZm7ggskD3s0xMgJZqV
	 EhdkpP+uuZP0naYA0h0WrMQBOeAg8J9xUQhR6Qqy69glZvYn9E7JrxUHm3hj5TRLurior
	 lpwo3Bxws2bFZVueTK1aNig3Mo2Tft/8NKVYPEGGYmlm4dul8BpbMeCmEDdKb9RRAwmLq
	 ainl3dsu8Fl7Wm6RvyJkNLiwkubVHLwzav26V03KJvizdzAovg//3c1BVPdwuL3XQVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="VwUl/DhU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.55
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208F606A31C;
	Tue, 17 Nov 2026 09:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E208F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VwUl/DhU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeSO3Gk01jUNtegK4WoqO6VY0OBYkbW7UerXybBCuiYXEkqzchSia0kyIB67jnUhEi6du7qTk3mgrtV1JrDSLhA/6hKkZHJdTvLRGIH+hpW4sXHOerXLSpsXldC7tyG0GVsnnnPAgSgYfrWy1GbEhMl6qUzo1EDrt377ukDVkFLwJUU1YcH4mI9LJfw34GDJgsNVpUKphJZ8NIfHCrKNmm+hSa1T4kSc1AHljM4+7zf43akj1A1RYdLJ0x/PaOrV/QMu7nXdZXDZ6wh2PZd4KZLazR29kVlRaQ/s6/nIplG+Lw3XJfsOC+PmRPI0hEYr91FSeYTysItFKyMqs8wPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYM5Sg+NYFAqJmyUyoJVrtE2SIeQ3yKJ4yO6kvBsCe4=;
 b=WfA+b5SSqH7i+l5KHC5rJU+q38CT85xrp9GZ1ponDDuhrNxLdWrFfISO/GyppZFEC4BvNBedEp2uPZ1/ayPrWc4uElh8IB2sgEVXwI3Lv+gL9EZjLstFZRlexIVZrumVZ8wbbdY+mpfZsUgD4dN2TPxAOIgmj5hxArHeflIUWC6ERSqjdssT6vs3GUMvsLGdBP1Q5morhB2GWzGMMr+EdJm4eiVIbSmEw35r+ICpgs60lXE9cFTxV5zn7U76G4ow5zCL0KjMsCE5Cv0BAeh2mn0qseazbFnYpu4awQ0YrRIjrZPX/0s6KJr8XvbQskM+tny3RQxyI2jPUG0upzgj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYM5Sg+NYFAqJmyUyoJVrtE2SIeQ3yKJ4yO6kvBsCe4=;
 b=VwUl/DhUFdfGdDJk8mKCYy+kjQE6Naoks3E5d2hLFMfxezbsFt3sm6bKaBSlLQWZkfn16lbxYFR85+MSyOSIsGj/9xtcdGmtEfS0pr1EvhH+K0UucV2h6r6i977ATlbIg62kNnOH+AXe3axK2bCHVv7Q3aKmw2kCoW7sXkONvgl1UASAKo9jtNvEE0lH9iTxwfuahxsDFyrM6tAC7cGGoaVuDzaNoPISxIjUNj/Akr4p4eE9eZWIuDfihluycxGn9tAJLjIyvUlhQHan69Nyb75wg3p7DK8t16p6KOxHono1uT71EWhAn6MuPqurBUg56k2Kkv/g/73iGm54rUjfWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 09:54:07 +0000
Received: from SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7]) by SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 09:54:07 +0000
Message-ID: <7c763c61-3516-4485-af19-f8a1af0a25dc@nvidia.com>
Date: Tue, 17 Nov 2026 15:23:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] cpufreq: tegra194: move MPIDR read to CPU hotplug
 callback
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: bbasu@nvidia.com
References: <20261104181521.3003578-1-sumitg@nvidia.com>
 <20261104181521.3003578-2-sumitg@nvidia.com>
 <b3125fa1-6a7a-4f87-a7fa-64c42f6b98e2@oss.qualcomm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <b3125fa1-6a7a-4f87-a7fa-64c42f6b98e2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::20) To SA1PR12MB5637.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 1274599d-df1f-40c6-da3d-08df4490b830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|921020|261102123227099003|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T5hu/y3GTnkWy828zcnTujBG8oxBKbHdxhSrI7YPRhIycRv7xdMJ5Um/K3H7oOYcDtWmgX19YzJygBaemOlEz5f1CVD0AgznePOCNa/7FqeAkErha6xhQQKZ5YBDJQs04WhZtngI4TF/ZpLOoKY4e3f9ny0rlctM7GgQxSuA0ijuasU2aLgGizn5mTG69ycZ+FuoNk597+gfOSUtITeI+gAAYwTdXvAJK2QhFkXCKqAyGQrXStrnGKBh7YiTr2f4yTkj2z4+ewTkNOjWhX9r1h7ihc4imk9sheh8UeApgZakJoUrBKJcjjMqrDr7IWXGJut+zt2GXY7HeKoMVUhrZfyLiQUpyrmFv/DXpK8qx2OXe32gJWSNg9Vlu6xnwaWIhZurM2Q4hdEb7JojUTagxscEhxaC67AhQYDJsXgzNkb7bhCY4LZX8Pl77lcEUhHJAo7y2mi8t/lyFBoDXMTH0WDZiRSaVUXSmPoyxqXgA07APsrkwg72xF+dzW9qUg49f3I8HjUKQFo0h7KsAO1QT6uc8SpTW7SD+a6Re8gzguVtKm8AmzJGW0tkkmWklIn0a1tKt1J3CIbf8fFXfWVAJTIhG0CAZxFf2paBDiY9+KLLWGhHkaIFy5oLhJHK4cWX+SnKiovVX+ztYhMADIEA4NzMoX7dsjl102XH1ePzThWOzPx3vVawhQOW6Sl2xeRuz4Fv1MMwKQ1eyme2iRdx3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(921020)(261102123227099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUVZejdsNGoyb0FVbTNiZkQwcncxSlhIQ212QzloMnYvV2VySHIzbWRkTzFC?=
 =?utf-8?B?N1liMGtPcjdNcmx2SzdpTGFkcVRXenFmUk0wcHh4aExUNXpYdjF3Kzk1d3Vx?=
 =?utf-8?B?UHFKZkN0Z2dVYTZoMTZkT0NMY0ZkUDZJMFc4KzJtNHhrZkVHWGRBc3YrMzU3?=
 =?utf-8?B?cUJyajFzZVFCUmQ4a09ma293SUpEZitJTVc2WVUvTjJRN1hlLzJMSlJDbGRM?=
 =?utf-8?B?bjVhNHBvVTBjalljWWw3QWplUWd1VGp4QWpaV2J1dVVRbEQ5eTZwdHJYeXV4?=
 =?utf-8?B?c1dlN2FjY05aUW90elZtbTZBNjY3SWFEVGg1K1h4c2VrWFNONTcybDhDampk?=
 =?utf-8?B?R1JzNUNwSXorSXFsS05vRmFDbmlheG5XL3cwUlJGVkxaYkpLYTRzTmk5a29G?=
 =?utf-8?B?Y1Bobk8wc1lRRHRqMUF6SjhtT0RRZS9CZnRHREM0azVjeHV5clFmbGhIYW5s?=
 =?utf-8?B?ZXBJSlFGSEs2b3p0UXc5OUxzMTlFOU9wUkNiVlJGSGxqNjJ0K1JZdWRQMDBD?=
 =?utf-8?B?WG9vL3pHMXhncmhyRnE1QXZ5a1NDQit6OTYraVlZUUJoQzFMU1U2ME9iR0ZO?=
 =?utf-8?B?SDJham5HdnBORGp4T2YySlFkOUJKRVgrRFI1ZUZZcTBTMFBjR1U3TFd6K1Ew?=
 =?utf-8?B?VDMzRVdYSGdjUHZXZXpvQ1JMNEZ2OThXWFRYNStDRnpZYU0wMXgzSzNuWDJM?=
 =?utf-8?B?VDBvTmRyUENmQVRpM3Q5V0w3YXhNK1Q4UjhFd2psTDhtMnRiVERtTGZmYzFr?=
 =?utf-8?B?QVFDWG1EenhjL3lweFdaakJrY2hnVC8vY1phR29CWEgvK1dsRTYweVNDYnNT?=
 =?utf-8?B?YVdZUVYxZEZNNWZCV1I0MGNQMWd5b3pNMWp1TzNwdDY3ZzdocWQ5b3RvazBV?=
 =?utf-8?B?VW16c2Y5TS9zYkd1N29RbG8xKzlZZnhiQUVxSDQ2T1JvT2xZaVFweWM3NnlV?=
 =?utf-8?B?ZnpoczVud0JLRGdzYzIvTlNsQWZqMU8wVExaUVdNZlAyb1FycjlZY3Q1WU9V?=
 =?utf-8?B?OW81Wm1ZZldIbFcxWFlZd0xZWHRFNUF2R3hhOThwZWZXWDFKMnZIWmlHRDht?=
 =?utf-8?B?dldLcDVZL2pkV1NOSkkxR25KdVlmaFM1bkhPNHRkWElKc2tOK0R2S2Z5azlY?=
 =?utf-8?B?akRaMEsvdms0UWw3L3hndzYvTnFqd3ZIaHZaSXpKWmN1ck5OdzVWVkNrMWlX?=
 =?utf-8?B?b0ZzRFRQelZTUUdSbXIydFZEdlJWcy9ubG1EUC9IME1FWVV2ODhmS0ZkRkNl?=
 =?utf-8?B?ZklEaC9zeWREUmM4RWM3aTFKd1NYdWxsUnZZVWVJQjBpK1BHNnNxRU1qeWt4?=
 =?utf-8?B?bTJVUnM2em5BSW9xbDQyOFV5YzU5ekc2NnY0TEtJbzI3aS9aY1pkcEk2dnd4?=
 =?utf-8?B?dG5mK0pyUUFiTjRjcURjTlg4M2c0cDlCTzQ3a0cyWlF0MW5TL0lIT00wK0h6?=
 =?utf-8?B?WnQxRUhZRG1WME43dWE0aEIrekVTWEoyRzY5V1VoQ1JhdXdsT1pzbE1OQTFM?=
 =?utf-8?B?YkdUTWgwWXhPdlpJN0RjSjVzVDJqanR2cXhoZXlVTkszdmpCallMK3BIK3Bk?=
 =?utf-8?B?c3JxcEg4bXBZN3R3dnhDeU5aYWdJdE1pVEN5RkNaS3MzV0ZwWkREazZGaTR5?=
 =?utf-8?B?d3MxNHhvMGRRa09pWnlCZ2VSc29XN3g1NmRFRzJMSlZVMUp2NlZXM0JrYTRS?=
 =?utf-8?B?Ym1PL3JaMlYwZ01XUnVxTG9VdkR4MC82T1hkZ2JtOFBsWThVRnhWc3FNRGdD?=
 =?utf-8?B?dWMwS3VkU2tGQWVVV0NqSVBKTXFvZ2hUZlVwaHR0MkhpelZ0VmJhMlZmRzNQ?=
 =?utf-8?B?RFlnZTRBMFVobFM4a3NLUzhOUGhBWUM0ck50SXNiVVIyTlFVeXc1Vi9TQm5D?=
 =?utf-8?B?YkdkOEtlcldPT0U0bU91MG9xRnJ5NnNheEVhVFpLYVcydVBXWGxoNmV4QzFl?=
 =?utf-8?B?aHhqWkttTXZXcllUd0p2ZVcxOXp3SkhadnFiam1COVhlcnZKY2FlRUNBbS9m?=
 =?utf-8?B?ZDJ3cUJ2OW1kczJSYkNBTmxrNFV1UFpNYlVKOG82ZGVmQjdRVW1zWkpTWFpj?=
 =?utf-8?B?V2RlZmMzZllhcUlDTzBUUHZ0VjA2T1ZXYmJqRFdQVWJqZmx4dm4xNWlHYlQr?=
 =?utf-8?B?Vmk4Vy9vc3hMMm4yaEppQnU1SEZZMlhSUFRMd1paZ3VTUmwwNlVVMkV1VDU4?=
 =?utf-8?B?WXRDeWhwbFpVQk0zQUV3OHEyU045dFY0aTQwNGI0ZGtnSWMvaFlzK2ttTHlp?=
 =?utf-8?B?a3p1ZzY0KzVFazBFU1JuMThnQU5ZNkFyYjhUKzJHOHBMZHYrU3JrODY2NHhj?=
 =?utf-8?Q?3Q2sAWV5Hxm3B5hfQO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1274599d-df1f-40c6-da3d-08df4490b830
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:54:06.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYc4HJcQ5W3QRrYTKDW2tAtzZSkJXYYTrlA9fvGNnO4gfIh3hp7ZdvHJQ4kESiPIRDNDvc88qSZjKrFpOdDuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188



On 13/11/26 11:57, Zhongqiu Han wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/5/2026 2:15 AM, Sumit Gupta wrote:
>> At probe the driver reads the MPIDR of every possible CPU with
>> smp_call_function_single(). For a CPU that is offline at boot, the call
>> fails and the error is ignored, so the CPU's core and cluster IDs come
>> from an uninitialised variable.
>>
>> Read MPIDR from a CPU-hotplug online callback instead, which runs on the
>> target CPU and caches its core and cluster IDs and MMIO scratch address.
>> This covers CPUs online at probe and CPUs onlined later.
>>
>> The check that the SoC data covers all CPUs moves to probe, against
>> nr_cpu_ids. A CPU whose MPIDR does not fit the SoC data gets no scratch
>> address, and its NDIV access is skipped.
>>
>> Fixes: 6b121b4cf7e1 ("cpufreq: tegra194: save CPU data to avoid 
>> repeated SMP calls")
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra194-cpufreq.c | 114 ++++++++++++++++++++---------
>>   1 file changed, 79 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/ 
>> tegra194-cpufreq.c
>> index 1eb96e9f3310..be81ffd23edd 100644
>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -5,6 +5,7 @@
>>
>>   #include <linux/cpu.h>
>>   #include <linux/cpufreq.h>
>> +#include <linux/cpuhotplug.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> @@ -13,7 +14,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/units.h>
>>
>> -#include <asm/smp_plat.h>
>> +#include <asm/cputype.h>
>>
>>   #include <soc/tegra/bpmp.h>
>>   #include <soc/tegra/bpmp-abi.h>
>> @@ -77,6 +78,8 @@ struct tegra194_cpufreq_data {
>>       const struct tegra_cpufreq_soc *soc;
>>       bool icc_dram_bw_scaling;
>>       struct tegra_cpu_data *cpu_data;
>> +     enum cpuhp_state cpuhp_state;
>> +     struct hlist_node cpuhp_node;
>>   };
>>
>>   static struct workqueue_struct *read_counters_wq;
>> @@ -113,7 +116,7 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, 
>> u32 *cpuid, u32 *clusterid)
>>   {
>>       u64 mpidr;
>>
>> -     smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
>> +     tegra_get_cpu_mpidr(&mpidr);
>>
>>       if (cpuid)
>>               *cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> @@ -121,11 +124,44 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, 
>> u32 *cpuid, u32 *clusterid)
>>               *clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 2);
>>   }
>>
>> +static int tegra_cpufreq_cpu_online(unsigned int cpu, struct 
>> hlist_node *node)
>> +{
>> +     struct tegra194_cpufreq_data *data;
>> +     u32 cpuid, clusterid;
>> +
>> +     data = hlist_entry(node, struct tegra194_cpufreq_data, cpuhp_node);
>> +
>> +     data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
>> +
>> +     data->cpu_data[cpu].cpuid = cpuid;
>> +     data->cpu_data[cpu].clusterid = clusterid;
>> +
>> +     /* Derive per-core register address only when ccplex MMIO is 
>> mapped. */
>> +     if (data->regs) {
>> +             if (clusterid >= data->soc->num_clusters ||
>> +                 cpuid >= data->soc->maxcpus_per_cluster) {
>> +                     pr_warn_once("cpufreq: cpu%u: bad MPIDR (cluster 
>> %u, core %u)\n",
>> +                                  cpu, clusterid, cpuid);
>> +             } else {
>> +                     u32 index = clusterid * data->soc- 
>> >maxcpus_per_cluster + cpuid;
>> +
>> +                     data->cpu_data[cpu].freq_core_reg =
>> +                             SCRATCH_FREQ_CORE_REG(data, index);
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>   static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, 
>> u64 *ndiv)
>>   {
>>       struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>> +     void __iomem *reg = data->cpu_data[cpu].freq_core_reg;
>> +
>> +     if (!reg)
>> +             return -EINVAL;
>>
>> -     *ndiv = readl(data->cpu_data[cpu].freq_core_reg) & NDIV_MASK;
>> +     *ndiv = readl(reg) & NDIV_MASK;
>>
>>       return 0;
>>   }
>> @@ -135,8 +171,12 @@ static void tegra234_set_cpu_ndiv(struct 
>> cpufreq_policy *policy, u64 ndiv)
>>       struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>>       u32 cpu;
>>
>> -     for_each_cpu(cpu, policy->cpus)
>> -             writel(ndiv, data->cpu_data[cpu].freq_core_reg);
>> +     for_each_cpu(cpu, policy->cpus) {
>> +             void __iomem *reg = data->cpu_data[cpu].freq_core_reg;
>> +
>> +             if (reg)
>> +                     writel(ndiv, reg);
>> +     }
>>   }
>>
>>   /*
>> @@ -208,7 +248,7 @@ static void tegra194_get_cpu_cluster_id(u32 cpu, 
>> u32 *cpuid, u32 *clusterid)
>>   {
>>       u64 mpidr;
>>
>> -     smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
>> +     tegra_get_cpu_mpidr(&mpidr);
> 
> .get_cpu_cluster_id() now reads the local MPIDR, so the cpu argument is
> ignored. Could it be dropped?
> 
> 
> 
> -- 
> Thx and BRs,
> Zhongqiu Han

Yes, will drop it in v2.

Thanks,
Sumit


