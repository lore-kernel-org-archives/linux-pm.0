Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC32745E;
	Sat,  1 Aug 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594824; cv=fail; b=iMLr99fXkpzXZiR1qhIst+klObnODdIQ13q2xUnEDkgR8Xt//P+OHtGAeuIl/QpjpwakjscdIvBB7dDuuXeTZHhHezF9/w3c7vy95GYDVBkRIYl+pINfUOTSwWI6xSAk0dBZTFtRVJd/VndBbluINPJVRWL4y6PimqWXOsYKh10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594824; c=relaxed/simple;
	bh=OYNe9vp816mkrkrXe6gZXtq7VfajmZYkL38yQyN/vnQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=UBdzZmx5Ih3L7etUcpo0Hls69sar/OxUaJtoqDl9O/Yu5SGSyqELHZO+rcZE9Ma3WpNgJuBo/V8TQgHma2T3y80XKNmI4VRVLyUIP9800+KWew/n+UK+m+L4zYCp7V35KhUpf1ioRe9kHzmCUFJpL1Cqy6M6dwaCZqSiSY8tOas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3nuFvMZ; arc=fail smtp.client-ip=40.107.208.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3nuFvMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjKXbrCL1qTWKLMDetnUWXdEKFeuw54lB69wQmsnqWihuc37xDH5bgR3zGAhvg0nNQb7fk0q7kNahb67p4l8fLGVw/Li6hA0nYlYTrXl8ETQHHEaWroiweopyw9pExH0ywDrC49mM5nG/dwnIU8TFpveVIP2c7wVqbRJu52frsx0c7i4YowtYimE5vKZN8f8ifopaLTEKukoLYzfujO2FwfbeAVTV1H2co1FXVT9bDCXejjwtTNzU62tpR+3fgShOm1bkzDj5mw0E8dAs+iaW9oEi/e6ygTBel53g7rfXL/u8QppSueS+dn1A03HEoLWG5suNmgXNmYE/13Y6iJ1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jiTRJyHDrVrx3fgdmuyU4wTkkwBCKJH1mYwe/FE/ZA=;
 b=yj08Fhqasc23Svq4x49rx+3WshavM+illP1U89lUULAZonuMEKPzb9aIvEhwwXMT0xDFvNlXT4+F0ePOB5XBReq5AR23HVC6emJAQ/+2jLh4liYQxB0aYRmuj1XbkBTaQu1wvS2z41pl9hVOGOipKPVgoE0p+2FQnlw8JrXOScK6vFXWBCufvQd/FZ5nJ3ERd++ZhwbygCNAvFoYDKVWNPpqzwZathHM5O8vrvvqYWyJMenxnEG4fI7JVJHeyXQCIZyfnjC0o3L0tsWkNO+A6IRtFJXZhaydfVbOGhExgNtI5nFh78i9DJOZQjFx/LIx4keCs9fc2ynr29s5Ns5UgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jiTRJyHDrVrx3fgdmuyU4wTkkwBCKJH1mYwe/FE/ZA=;
 b=Q3nuFvMZy+w7wG49iwaKnGZmRi6fZq3DHLuf1M36/fZOiBxRnNt1umxGDix+CsB6dcFAOYrKL/KUshVrRkTOv06jJvNM31wkAFkkf2jlAgIFKdhr8E30FYAbSkFDeToK/CJmj/gisGg+7yCuTPVkqMH6g0giOjvvWHzUzEfGhLdRF6a/ftDZi/WJMql3PAqIMmnC0MwZ4ub27L1bt5WPlVdrBMvuVw8ZOPk907+wYfe9bCKnacmdyaLoP0zw+d4BQTZuacrT7/PLpDemORaF20LTH06Liz+okliTTrLHFigKtpLGqFW7f7ilfhhxrP2+6Edkna1xZStLWNPpQhaQmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 14:33:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 14:33:36 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 23:33:30 +0900
Message-Id: <DKDOJ7X5N45Y.3OUM7ODP8X5ZU@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Danilo Krummrich" <dakr@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew Fustini"
 <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Boqun Feng"
 <boqun@kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Maurice" <mhi@mailbox.org>
Subject: Re: [PATCH v5 1/4] rust: clk: use the type-state pattern
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Content-Transfer-Encoding: quoted-printable
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-1-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-1-67c5f326a16c@collabora.com>
X-ClientProxiedBy: TY6PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e717bb-0fc2-4e73-e29c-08deefd9de2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|376014|7416014|4143699003|5023799004|11063799006|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	do/Yb8dTqM4jn3Sg+rPENC308Sip2a4ilOdp8/xXvpYVarR/+cTS6nglpN2raijJNK/Txeqw8ObfEZpBBNvrjpcjrAmnVLwoJMdNZozFwdfGbrk9KdLq7EDnrtAleblaG0ZQyz7yMN2ifuN4K7h++XouKHzkxKLDeD5CrD7SG05MFhvjVFGKGhBFtE6k4Ll3L0SdoI+SztS2qRz9IRrQNEByNUyQZXgdAGabDpVR7cQJxCAOjmJdRWMEz4ujIdJpyWjwl1Ht85OQOG/OY6VloarzAIK1JKxyHHn2Ridh1y2MVZutaSzEFR8Cyw3pieo8VRf3DE/1aEAIaZJs14L3O7L7VfS/14iMF1p5wQZzXkMezp/IkhE82fJ0Xi9ZTlCDAC8ndBt6u4TSAUznSRJj/5zTRPVihnZwC9T5cXA/yh+pSaj8G7uWe6itrzoE3+Cm2puAOkQIWS3YD7ec6B1VQ1BSI7LzCB511Lm322cLTic9w34vD5A9XACyyp4lEbpIHUCEwbCamM8i8ShHClsfFWDeayu4293ELgKCB4YndmfJ33CRhXhU4Y0kPK6ubA++fnj4W8BCakM/UMzpLtzStMPAT7N0xa/4rURoJSvk1nsCJ8zTsBwKuL4yzvOSIFAxNFSnqAvzXVcRxMJL+1tn6a25IY0OppgLrXM9VXqCbQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzIrOTZtYnpGUzB0MzAybnVoQ3JDTVdxSE40OHlYNzZKcVE4WjRHUExaRXJN?=
 =?utf-8?B?blMxc3dJbnZ2Y3lWdU95ckUxZXFSWnoxWGttQWFlWmVWWnFVdU5vTWdQdEhn?=
 =?utf-8?B?V3doV2lORkpIeEJFV1BFVzhaNnlKOGppdC9IVGs2eVNmdE5oMi9kS1B1L2pJ?=
 =?utf-8?B?Yjdpd3QySEtjdmdyZWIxRjZFNkpYRms0QTBTTkFhNldUbHhKQXVGdng2eW56?=
 =?utf-8?B?RDFtNU9LNitydGh1bGpoOEwyM1BKWit4YkZNc2VCbHZBQndvODhzcmZPTGJh?=
 =?utf-8?B?YU00TWxrZDc1UWhjSjZsWHBxZ2RzZGZFamVkREROSlBNaWYzc2lMYUo1ZDYv?=
 =?utf-8?B?dVdvQXRqWkUvY1B1ZXllYjVnUnU0aDRiUktMNklURGlWZkExaXIyRGdDQ053?=
 =?utf-8?B?T1dhRUE4YVorNXIvV01aN2djWk5MRjc2NSswbDEwYkJmSHRoclJmaE9VK0lU?=
 =?utf-8?B?UWNRSWZJMGZmZm15NmFEOG9LaENSb050YkdnaGRHUG5SZDVSWjBaaHl6ck1j?=
 =?utf-8?B?MStYMkhzUEREbGhKanZRUGo4M2VYeHkyUXZ4WFRtYVorTlFGbzR0ZWY5a3Fz?=
 =?utf-8?B?TXZxRjlxUWxDOWN4Z2o5RVQ3dWJlWEJCWFMxTVc4Qnk3bzNqQ1NmQUF4c1dJ?=
 =?utf-8?B?YWRsa05KSXhFeEUrd2JJRFlmWG1UNlhUL3ZXRzJ3LzBvbFRzZFgrYUo5SXVW?=
 =?utf-8?B?R3ZSa1RkdDV2ZXZxZ3dQS2NOTkxzT0NZQXRLK3hxOHBJWktRaFQ5aUJDdjZu?=
 =?utf-8?B?V201dmVNM2tYeDRsRFpHWm9vemo1RTRBQXBrdlNGT3czekY1eUdRUGxnMktF?=
 =?utf-8?B?ZCswdXJZTzhrSStDSFIxbDExM2YwbVNHV3h6M3hZN0Z0djJNNVh3R1dWWEtz?=
 =?utf-8?B?V0hUaVNJd25IU2dkdTY2NUkxL2pIUTN1MFM0SDlpaVV1NlIyOUw2aGtjR3RI?=
 =?utf-8?B?OFlodWpkUXJIeDVkaGhZTTF4K2RadmoxVEVwZlhOc0orbG8xajl4dTN2alBw?=
 =?utf-8?B?aXphT1gwd3EyYUxsK0htN1p2RjdvVDBnSW1MYXArM1ZnYmthbEFBcnpEVHIw?=
 =?utf-8?B?OEQ4cmNGaDB0UTlSeEI3bTduc09WL0lmWk0zc2tKZFF4M0prYytYY2lmVEZt?=
 =?utf-8?B?SWgxTW5BN1NCUWVlaVBzbWsxZGZCNDJ4c05vZmpNVWg1WmYwWjRVR1FBeXpa?=
 =?utf-8?B?ajFSTlVZb1NMYVFFbEd5d2ZsMVN2UDhSYllJOFFkbmd0N1lpTUFuOXN1ZUJl?=
 =?utf-8?B?c25QTzFVUTl6SFYrWmh2U2VCZVVSQjFBMmlqYzdLN0IxMkt4OEtyKzVpdG1M?=
 =?utf-8?B?ekg3cWJJenZvaGVEWFYweUlyc1VtWjA1UmNFSjVkWTM5UHVVdHZQenFzdEp3?=
 =?utf-8?B?VUMvTWJ0aC9na1IyR0p4a3VpUit2c0FQbDJCZUVPSVRpTHpLWUJYclN5emcy?=
 =?utf-8?B?NHhBWGVaMzI4NUl0UWVjSU1OV1lFWkJhUlByQ1FJRmdHMjBCN1Q5NmJkbmdB?=
 =?utf-8?B?QVVwRkpwUzJJb0MyaGh4dlAvVEZwSDFxT2ZpQ2FHTkVWaGlnTXAzYnl4Z2FB?=
 =?utf-8?B?Q2FzSFlaaC9WcFFUNzVzTlZ5MlYxVXowbXNHK2doUDNJbU1acHZBbGxCLzRh?=
 =?utf-8?B?MlU1aUlVeHZ3cHlYMFhFS0FQMDNYVG8rVllhejIySFM1Wk43dFhOUVpyMGg2?=
 =?utf-8?B?M3JzVHJNa2FMcGltWU1WM0hyUHE1MWxnTDd4bHpJTW9qZFRGSmNHNTNLOVBC?=
 =?utf-8?B?UDNudmFrZEE1YW5oeW4vSWYwakVza3dMN2EvVGcyRVc0MkU1OStyclBwaFA1?=
 =?utf-8?B?QlhOelZaUFd6UFBENyt1V2UyRmtxbjlkNXJqakV3MllFa3BSZDVCeVo0Mlhs?=
 =?utf-8?B?ZXZ6dUNhS29rZEllY3hPUVRVaGlnOUlGUHZQWVVQbXVPdHpNbjRINDdYQzh6?=
 =?utf-8?B?aFBhMzBFdys2OHdDRllSbDQ2N3hER0VOOFd4ZndId1BWRWo4N3BVYnJHMTVn?=
 =?utf-8?B?NEIrK3UzdzFXNTVKUEI2MFYxK2ZLSnkrd0J1V0UvbjROVGhSL3h0aXVqSGhq?=
 =?utf-8?B?bzgrMWVRUFU3TmhUcXQ0L0ozenU3eGhFY21naEtvMmI3MVk4cjlTNWJMTWY1?=
 =?utf-8?B?WFZUVkU3ZCtLeGJPTFhrajdMOElVMFQramtLUTRMNGMwbFVNWXhCaGlhTFlt?=
 =?utf-8?B?NC9CSTdPcnc4bGdsMEQ2Z1AxSUhGTGZucFdGVnlySEtwTklPOEVBZTNZNlJL?=
 =?utf-8?B?ay8vSjJFVnFKSmV2MFNZRURULzV6WFBDZko1bnJkNVFNeTdManlubGVrY0xS?=
 =?utf-8?B?UThleW05d0hqVmxMY1RiTXU2bE51UXpRdTVUQmJtQkpWOGo2TVpmVFd1T3Fn?=
 =?utf-8?Q?BGQ0vppZwx+bmFBWi+at8L4VdkFz42WGxintJtnsSMOrv?=
X-MS-Exchange-AntiSpam-MessageData-1: kYOyD65M8LqOhQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e717bb-0fc2-4e73-e29c-08deefd9de2b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 14:33:35.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RhgXBPjbHwkB9aPlOga3w7y4drjAfLTL+1zTmIGbT1HZ5OaUiPI0JqEFEWb/iHuMpKaRby1j3fk0eyTVCHOHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

On Mon Jul 6, 2026 at 11:37 PM JST, Daniel Almeida wrote:
> The current Clk abstraction can still be improved on the following issues=
:
>
> a) It only keeps track of a count to clk_get(), which means that users ha=
ve
> to manually call disable() and unprepare(), or a variation of those, like
> disable_unprepare().
>
> b) It allows repeated calls to prepare() or enable(), but it keeps no tra=
ck
> of how often these were called, i.e., it's currently legal to write the
> following:
>
> clk.prepare();
> clk.prepare();
> clk.enable();
> clk.enable();
>
> And nothing gets undone on drop().
>
> c) It adds a OptionalClk type that is probably not needed. There is no
> "struct optional_clk" in C and we should probably not add one.
>
> d) It does not let a user express the state of the clk through the
> type system. For example, there is currently no way to encode that a Clk =
is
> enabled via the type system alone.
>
> In light of the Regulator abstraction that was recently merged, switch th=
is
> abstraction to use the type-state pattern instead. It solves both a) and =
b)
> by establishing a number of states and the valid ways to transition betwe=
en
> them. It also automatically undoes any call to clk_get(), clk_prepare() a=
nd
> clk_enable() as applicable on drop(), so users do not have to do anything
> special before Clk goes out of scope.
>
> It solves c) by removing the OptionalClk type, which is now simply encode=
d
> as a Clk whose inner pointer is NULL.
>
> It solves d) by directly encoding the state of the Clk into the type, e.g=
.:
> Clk<Enabled> is now known to be a Clk that is enabled.
>
> The INVARIANTS section for Clk is expanded to highlight the relationship
> between the states and the respective reference counts that are owned by
> each of them.
>
> The examples are expanded to highlight how a user can transition between
> states, as well as highlight some of the shortcuts built into the API.
>
> The current implementation is also more flexible, in the sense that it
> allows for more states to be added in the future. This lets us implement
> different strategies for handling clocks, including one that mimics the
> current API, allowing for multiple calls to prepare() and enable().
>
> The users (cpufreq.rs/ rcpufreq_dt.rs) were updated by this patch (and no=
t
> a separate one) to reflect the new changes. This is needed, because
> otherwise this patch would break the build.
>
> Link: https://crates.io/crates/sealed [1]
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

The new API looks super nice; I really like it. A few nits/questions
inline, but regardless:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

I will try to go through the rest of the series shortly.

> ---
>  drivers/cpufreq/rcpufreq_dt.rs |   2 +-
>  drivers/gpu/drm/tyr/driver.rs  |  37 +--
>  drivers/pwm/pwm_th1520.rs      |  17 +-
>  rust/kernel/clk.rs             | 541 ++++++++++++++++++++++++++++++-----=
------
>  rust/kernel/cpufreq.rs         |   8 +-
>  5 files changed, 423 insertions(+), 182 deletions(-)
>
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt=
.rs
> index f17bf64c22e2..9d2ec7df4bac 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -40,7 +40,7 @@ struct CPUFreqDTDevice {
>      freq_table: opp::FreqTable,
>      _mask: CpumaskVar,
>      _token: Option<opp::ConfigToken>,
> -    _clk: Clk,
> +    _clk: Clk<kernel::clk::Unprepared>,

Maybe import `kernel::clk` to shorten this a bit.

<...>
> +    /// An error that can occur when trying to convert a [`Clk`] between=
 states.
> +    pub struct Error<State: ClkState> {
> +        /// The error that occurred.
> +        pub error: kernel::error::Error,
> +
> +        /// The [`Clk`] that caused the error, so that the operation may=
 be
> +        /// retried.
> +        pub clk: Clk<State>,
> +    }

Can this have a `Debug` implementation? It can just forward to `error`.

> +
> +    impl<State: ClkState> From<Error<State>> for kernel::error::Error {
> +        /// Discards the [`Clk`] and keeps only the error code.
> +        ///
> +        /// This makes the fallible state transitions usable with the `?=
`
> +        /// operator when the caller does not need to retry the operatio=
n on the
> +        /// original [`Clk`], e.g.:
> +        ///
> +        /// ```
> +        /// use kernel::clk::{Clk, Enabled, Unprepared};
> +        /// use kernel::device::{Bound, Device};
> +        /// use kernel::error::Result;
> +        ///
> +        /// fn get_enabled(dev: &Device<Bound>) -> Result<Clk<Enabled>> =
{
> +        ///     let clk =3D Clk::<Unprepared>::get(dev, Some(c"apb_clk")=
)?
> +        ///         .prepare()?
> +        ///         .enable()?;
> +        ///     Ok(clk)
> +        /// }
> +        /// ```
> +        #[inline]
> +        fn from(err: Error<State>) -> Self {
> +            err.error
> +        }
> +    }
> =20
>      /// A reference-counted clock.
>      ///
>      /// Rust abstraction for the C [`struct clk`].
>      ///
> +    /// A [`Clk`] instance represents a clock that can be in one of seve=
ral
> +    /// states: [`Unprepared`], [`Prepared`], or [`Enabled`].
> +    ///
> +    /// No action needs to be taken when a [`Clk`] is dropped. The calls=
 to
> +    /// `clk_unprepare()` and `clk_disable()` will be placed as applicab=
le.

s/placed/made?

> +    ///
> +    /// An optional [`Clk`] is treated just like a regular [`Clk`], but =
its
> +    /// inner `struct clk` pointer is `NULL`. This interfaces correctly =
with the
> +    /// C API and also exposes all the methods of a regular [`Clk`] to u=
sers.
> +    ///
>      /// # Invariants
>      ///
>      /// A [`Clk`] instance holds either a pointer to a valid [`struct cl=
k`] created by the C
> @@ -99,19 +185,36 @@ mod common_clk {
>      /// Instances of this type are reference-counted. Calling [`Clk::get=
`] ensures that the
>      /// allocation remains valid for the lifetime of the [`Clk`].
>      ///
> +    /// The [`Prepared`] state is associated with a single count of
> +    /// `clk_prepare()`, and the [`Enabled`] state is associated with a =
single
> +    /// count of both `clk_prepare()` and `clk_enable()`.
> +    ///
> +    /// All states are associated with a single count of `clk_get()`.
> +    ///
>      /// # Examples
>      ///
>      /// The following example demonstrates how to obtain and configure a=
 clock for a device.
>      ///
>      /// ```
> -    /// use kernel::clk::{Clk, Hertz};
> -    /// use kernel::device::Device;
> +    /// use kernel::clk::{Clk, Enabled, Hertz, Unprepared, Prepared};
> +    /// use kernel::device::{Bound, Device};
>      /// use kernel::error::Result;
>      ///
> -    /// fn configure_clk(dev: &Device) -> Result {
> -    ///     let clk =3D Clk::get(dev, Some(c"apb_clk"))?;
> +    /// fn configure_clk(dev: &Device<Bound>) -> Result {
> +    ///     // The fastest way is to use a version of `Clk::get` for the=
 desired
> +    ///     // state, i.e.:
> +    ///     let clk: Clk<Enabled> =3D Clk::<Enabled>::get(dev, Some(c"ap=
b_clk"))?;
> +    ///
> +    ///     // Any other state is also possible, e.g.:
> +    ///     let clk: Clk<Prepared> =3D Clk::<Prepared>::get(dev, Some(c"=
apb_clk"))?;

nit: maybe use a different name as this is otherwise obtaining the same
clock.

>      ///
> -    ///     clk.prepare_enable()?;
> +    ///     // Later:
> +    ///     //
> +    ///     // `?` works directly thanks to `From<Error<State>>`; the fa=
iled
> +    ///     // `Clk` is dropped on error. Match on the returned `Error<S=
tate>`
> +    ///     // instead (its `clk` field is the original `Clk`) if you wa=
nt to
> +    ///     // retry the operation.
> +    ///     let clk: Clk<Enabled> =3D clk.enable()?;
>      ///
>      ///     let expected_rate =3D Hertz::from_ghz(1);
>      ///
> @@ -119,122 +222,339 @@ mod common_clk {
>      ///         clk.set_rate(expected_rate)?;
>      ///     }
>      ///
> -    ///     clk.disable_unprepare();
> +    ///     // Nothing is needed here. The drop implementation will undo=
 any
> +    ///     // operations as appropriate.
> +    ///     Ok(())
> +    /// }
> +    ///
> +    /// fn shutdown(clk: Clk<Enabled>) -> Result {
> +    ///     // The states can be traversed "in the reverse order" as wel=
l:
> +    ///     let clk: Clk<Prepared> =3D clk.disable();
> +    ///
> +    ///     // This is of type `Clk<Unprepared>`.
> +    ///     let clk =3D clk.unprepare();
> +    ///
>      ///     Ok(())
>      /// }
>      /// ```
>      ///
> +    /// Drivers that need to change a clock's state at runtime (for exam=
ple to
> +    /// enable it on resume and disable it on suspend) can keep it in an=
 enum
> +    /// and move between the variants:
> +    ///
> +    /// ```
> +    /// use kernel::clk::{Clk, Enabled, Prepared};

I know patch 4 eventually fixes the imports, but a more logical ordering
would be to fix them first, as it would avoid a bit of churn. Not a big
deal though.

<...>
> +        pub fn unprepare(self) -> Clk<Unprepared> {
> +            // We will be transferring the ownership of our `clk_get()` =
count to
> +            // `Clk<Unprepared>`.
> +            let clk =3D ManuallyDrop::new(self);
> +
> +            // SAFETY: By the type invariants, `clk.as_raw()` is a valid=
 argument
> +            // for [`clk_unprepare`].
> +            unsafe { bindings::clk_unprepare(clk.as_raw()) }
> +
> +            // INVARIANT: The `clk_prepare()` count was released above, =
so the
> +            // returned `Clk<Unprepared>` owns only the `clk_get()` coun=
t.
> +            Clk {
> +                inner: clk.inner,
> +                _phantom: PhantomData,
> +            }
>          }
> =20
> -        /// Prepare the clock.
> +        /// Attempts to convert the [`Clk`] to an [`Enabled`] state.
>          ///
> -        /// Equivalent to the kernel's [`clk_prepare`] API.
> +        /// Equivalent to the kernel's [`clk_enable`] API.
>          ///
> -        /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api=
.html#c.clk_prepare
> +        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.=
html#c.clk_enable
>          #[inline]
> -        pub fn prepare(&self) -> Result {
> -            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for
> -            // [`clk_prepare`].
> -            to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
> +        pub fn enable(self) -> Result<Clk<Enabled>, Error<Prepared>> {

Note that the `Regulator` API uses the `try_into_enabled` pattern for
state transitions that can fail. Now that these transitions are
consuming the clock, it might make sense to align?

> +            // We will be transferring the ownership of our `clk_get()` =
and
> +            // `clk_prepare()` counts to `Clk<Enabled>`.
> +            let clk =3D ManuallyDrop::new(self);
> +
> +            // SAFETY: By the type invariants, `clk.as_raw()` is a valid=
 argument
> +            // for [`clk_enable`].
> +            to_result(unsafe { bindings::clk_enable(clk.as_raw()) })
> +                // INVARIANT: `clk_enable()` succeeded, so the returned
> +                // `Clk<Enabled>` owns a single count of it, which is re=
leased
> +                // when it leaves the [`Enabled`] state.
> +                .map(|()| Clk {
> +                    inner: clk.inner,
> +                    _phantom: PhantomData,
> +                })
> +                .map_err(|error| Error {
> +                    error,
> +                    clk: ManuallyDrop::into_inner(clk),
> +                })
>          }
> =20
> -        /// Unprepare the clock.
> +        /// Runs `cb` with the clock temporarily enabled.
>          ///
> -        /// Equivalent to the kernel's [`clk_unprepare`] API.
> +        /// The clock is enabled before `cb` runs and disabled again aft=
erwards,
> +        /// so the [`Enabled`] state is scoped to the closure and the [`=
Clk`]
> +        /// remains [`Prepared`]. This is convenient for drivers that on=
ly need
> +        /// the clock running for a short, well-defined section (e.g. wh=
ile
> +        /// touching registers) without giving up ownership of the prepa=
red
> +        /// clock or threading it through an intermediate state, e.g.:
>          ///
> -        /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-a=
pi.html#c.clk_unprepare
> +        /// ```
> +        /// use kernel::clk::{Clk, Enabled, Hertz, Prepared};
> +        /// use kernel::error::Result;
> +        ///
> +        /// fn read_rate(clk: &Clk<Prepared>) -> Result<Hertz> {
> +        ///     clk.with_enabled(|clk: &Clk<Enabled>| clk.rate())
> +        /// }
> +        /// ```
> +        ///
> +        /// Equivalent to a balanced [`clk_enable`]/[`clk_disable`] pair=
 around
> +        /// `cb`.
> +        ///
> +        /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.=
html#c.clk_enable
> +        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api=
.html#c.clk_disable
>          #[inline]
> -        pub fn unprepare(&self) {
> -            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for
> -            // [`clk_unprepare`].
> -            unsafe { bindings::clk_unprepare(self.as_raw()) };
> +        pub fn with_enabled<R>(&self, cb: impl FnOnce(&Clk<Enabled>) -> =
R) -> Result<R> {
> +            // SAFETY: By the type invariants, `self.as_raw()` is a vali=
d argument for
> +            // [`clk_enable`].
> +            to_result(unsafe { bindings::clk_enable(self.as_raw()) })?;
> +
> +            // Borrow the same clock as `Clk<Enabled>` for the duration =
of `cb`.
> +            // It must not be dropped, as that would run `clk_disable`/`=
clk_put`
> +            // against counts owned by `self`; the matching `clk_disable=
` below
> +            // balances the `clk_enable` above instead.
> +            //
> +            // INVARIANT: The clock is enabled for the lifetime of `enab=
led`.
> +            let enabled =3D ManuallyDrop::new(Clk::<Enabled> {
> +                inner: self.inner,
> +                _phantom: PhantomData,
> +            });
> +
> +            let ret =3D cb(&enabled);
> +
> +            // SAFETY: The `clk_enable` above succeeded, so this balance=
s it.
> +            // `cb` only had a shared reference, so the enable count is =
unchanged.
> +            unsafe { bindings::clk_disable(self.as_raw()) };
> +
> +            Ok(ret)
>          }
> +    }
> =20
> -        /// Prepare and enable the clock.
> +    impl Clk<Enabled> {
> +        /// Gets [`Clk`] corresponding to a bound [`Device`] and a conne=
ction id
> +        /// and then prepares and enables it.
>          ///
> -        /// Equivalent to calling [`Clk::prepare`] followed by [`Clk::en=
able`].
> +        /// Equivalent to calling [`Clk::get`], followed by [`Clk::prepa=
re`],
> +        /// followed by [`Clk::enable`].
>          #[inline]
> -        pub fn prepare_enable(&self) -> Result {
> -            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for
> -            // [`clk_prepare_enable`].
> -            to_result(unsafe { bindings::clk_prepare_enable(self.as_raw(=
)) })
> +        pub fn get(dev: &Device<Bound>, name: Option<&CStr>) -> Result<C=
lk<Enabled>> {
> +            Clk::<Prepared>::get(dev, name)?
> +                .enable()
> +                .map_err(|error| error.error)
> +        }
> +
> +        /// Behaves the same as [`Self::get`], except when there is no c=
lock
> +        /// producer. In this case, instead of returning [`ENOENT`], it =
returns
> +        /// a dummy [`Clk`].
> +        #[inline]
> +        pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) ->=
 Result<Clk<Enabled>> {
> +            Clk::<Prepared>::get_optional(dev, name)?
> +                .enable()
> +                .map_err(|error| error.error)
>          }
> =20
> -        /// Disable and unprepare the clock.
> +        /// Disables the [`Clk`] and converts it to the [`Prepared`] sta=
te.
>          ///
> -        /// Equivalent to calling [`Clk::disable`] followed by [`Clk::un=
prepare`].
> +        /// Equivalent to the kernel's [`clk_disable`] API.
> +        ///
> +        /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api=
.html#c.clk_disable
>          #[inline]
> -        pub fn disable_unprepare(&self) {
> -            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for
> -            // [`clk_disable_unprepare`].
> -            unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
> +        pub fn disable(self) -> Clk<Prepared> {
> +            // We will be transferring the ownership of our `clk_get()` =
and
> +            // `clk_prepare()` counts to `Clk<Prepared>`.
> +            let clk =3D ManuallyDrop::new(self);
> +
> +            // SAFETY: By the type invariants, `clk.as_raw()` is a valid=
 argument
> +            // for [`clk_disable`].
> +            unsafe { bindings::clk_disable(clk.as_raw()) };
> +
> +            // INVARIANT: The `clk_enable()` count was released above, s=
o the
> +            // returned `Clk<Prepared>` owns the `clk_get()` and `clk_pr=
epare()`
> +            // counts.
> +            Clk {
> +                inner: clk.inner,
> +                _phantom: PhantomData,
> +            }
> +        }
> +    }
> +
> +    impl<T: ClkState> Clk<T> {
> +        /// Obtain the raw [`struct clk`] pointer.
> +        #[inline]
> +        pub fn as_raw(&self) -> *mut bindings::clk {
> +            self.inner
>          }
> =20
>          /// Get clock's rate.
>          ///
>          /// Equivalent to the kernel's [`clk_get_rate`] API.
>          ///
> +        /// Note that the returned rate is only guaranteed to reflect wh=
at the
> +        /// hardware is doing once the clock is [`Enabled`].
> +        ///
>          /// [`clk_get_rate`]: https://docs.kernel.org/core-api/kernel-ap=
i.html#c.clk_get_rate
>          #[inline]
>          pub fn rate(&self) -> Hertz {
> -            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for
> -            // [`clk_get_rate`].
> +            // SAFETY: By the type invariants, `self.as_raw()` is a vali=
d argument
> +            // for [`clk_get_rate`].

Ideally these cosmetic fixes would have been in their own patch to not
distract from the rest, but not a big deal.

>              Hertz(unsafe { bindings::clk_get_rate(self.as_raw()) })
>          }
> =20
> @@ -245,88 +565,29 @@ pub fn rate(&self) -> Hertz {
>          /// [`clk_set_rate`]: https://docs.kernel.org/core-api/kernel-ap=
i.html#c.clk_set_rate
>          #[inline]
>          pub fn set_rate(&self, rate: Hertz) -> Result {
> -            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for
> -            // [`clk_set_rate`].
> +            // SAFETY: By the type invariants, `self.as_raw()` is a vali=
d argument
> +            // for [`clk_set_rate`].
>              to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rat=
e.as_hz()) })
>          }
>      }
> =20
> -    impl Drop for Clk {
> +    impl<T: ClkState> Drop for Clk<T> {
>          fn drop(&mut self) {
> -            // SAFETY: By the type invariants, self.as_raw() is a valid =
argument for [`clk_put`].
> -            unsafe { bindings::clk_put(self.as_raw()) };
> -        }
> -    }
> -
> -    /// A reference-counted optional clock.
> -    ///
> -    /// A lightweight wrapper around an optional [`Clk`]. An [`OptionalC=
lk`] represents a [`Clk`]
> -    /// that a driver can function without but may improve performance o=
r enable additional
> -    /// features when available.
> -    ///
> -    /// # Invariants
> -    ///
> -    /// An [`OptionalClk`] instance encapsulates a [`Clk`] with either a=
 valid [`struct clk`] or
> -    /// `NULL` pointer.
> -    ///
> -    /// Instances of this type are reference-counted. Calling [`Optional=
Clk::get`] ensures that the
> -    /// allocation remains valid for the lifetime of the [`OptionalClk`]=
.
> -    ///
> -    /// # Examples
> -    ///
> -    /// The following example demonstrates how to obtain and configure a=
n optional clock for a
> -    /// device. The code functions correctly whether or not the clock is=
 available.
> -    ///
> -    /// ```
> -    /// use kernel::clk::{OptionalClk, Hertz};
> -    /// use kernel::device::Device;
> -    /// use kernel::error::Result;
> -    ///
> -    /// fn configure_clk(dev: &Device) -> Result {
> -    ///     let clk =3D OptionalClk::get(dev, Some(c"apb_clk"))?;
> -    ///
> -    ///     clk.prepare_enable()?;
> -    ///
> -    ///     let expected_rate =3D Hertz::from_ghz(1);
> -    ///
> -    ///     if clk.rate() !=3D expected_rate {
> -    ///         clk.set_rate(expected_rate)?;
> -    ///     }
> -    ///
> -    ///     clk.disable_unprepare();
> -    ///     Ok(())
> -    /// }
> -    /// ```
> -    ///
> -    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
> -    pub struct OptionalClk(Clk);
> -
> -    impl OptionalClk {
> -        /// Gets [`OptionalClk`] corresponding to a [`Device`] and a con=
nection id.
> -        ///
> -        /// Equivalent to the kernel's [`clk_get_optional`] API.
> -        ///
> -        /// [`clk_get_optional`]:
> -        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_o=
ptional
> -        pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
> -            let con_id =3D name.map_or(ptr::null(), |n| n.as_char_ptr())=
;
> -
> -            // SAFETY: It is safe to call [`clk_get_optional`] for a val=
id device pointer.
> -            //
> -            // INVARIANT: The reference-count is decremented when [`Opti=
onalClk`] goes out of
> -            // scope.
> -            Ok(Self(Clk(from_err_ptr(unsafe {
> -                bindings::clk_get_optional(dev.as_raw(), con_id)
> -            })?)))
> -        }
> -    }
> -
> -    // Make [`OptionalClk`] behave like [`Clk`].
> -    impl Deref for OptionalClk {
> -        type Target =3D Clk;
> +            if T::DISABLE_ON_DROP {
> +                // SAFETY: By the type invariants, self.as_raw() is a va=
lid argument for
> +                // [`clk_disable`].
> +                unsafe { bindings::clk_disable(self.as_raw()) };
> +            }
> +
> +            if T::UNPREPARE_ON_DROP {
> +                // SAFETY: By the type invariants, self.as_raw() is a va=
lid argument for
> +                // [`clk_unprepare`].
> +                unsafe { bindings::clk_unprepare(self.as_raw()) };

With this `Drop` can sleep, this is probably worth mentioning in the
doccomment.

