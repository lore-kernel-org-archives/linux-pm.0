Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252434040A;
	Sun,  2 Aug 2026 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785649020; cv=fail; b=L2RiipgCoG/CNXmynXq39NS4HGJcLgrjQT0n/dX/Cxyxh5v+4CefMMAYDo8f8K58C5HHh7wh8pJVvbD68NrQQytNWHecUeVVKX0bAMsi9NBxwbEYyWacc2joGcg7mcQ/1lmPuDYrnh43CBsfeUNbude0CZz4iMUMSzeV9OFc4VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785649020; c=relaxed/simple;
	bh=wt+d81DEChFSRPyORDMlvJxWdlWJUzlMiDNI8hLs9V8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=s4WFFZd1LL5R0kOB/DlYEnhlZ7/XRL2zRPX7g+DVgtEjegGRxo7dwM/bopIdP524hSrPSGSSnebVCTo4j+1uaK7zx7GXXNrBl3tOWzLr8n4uIYNUWgaGYotxxuj7sR6K9b7XbsSlQe7ZJ48QLZFsbH8Rpd2PsiI78frimFdUU9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oa/65k6G; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oa/65k6G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbdn39Logz3oyDXyuB+9GnVEU4amGz1QhUnkEPm2UMdmdmK1kRZXnlVeeq06WmKENMe+yu0Z9Ijp7x4NhB/S7ESXoC0Qn/YSnH1FZbMbxD/Uz3aGoUwGrITWdtqlOj9huRQn/X3euE9YVzVDIk2Pa2OBY15/8RBTvMm3KFnWjqO9LOOxmht1gCcx+MKm5Plykt9mshKCesjvY4+hmXoQHv0mHXAER1qfldUEkFhtFbp8ujefYDofmDhL+HP99AAkjkcqL5+qax+z+s79L/LBFLFrc1Z9tsizAg/lr5HLI5omKfGVrBraQlabJGQ3W62x+MRF7a/ubnySNxJ4RjRiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQP0KkgX4x6So4quJepdUIAgBLtxYx2odpddBaABKpI=;
 b=crgHP3/bY6G7va3zLsFaH6z0cp+Ffkc9Yfjs4Etw/Ij54J2jDQua3oIbsCXztnMiewAqy7iJ/drIbquJo4Wv4/BfZHk7TJmDAIeYCmclyDKeN/n/pKl1uqSq9m9ENGMU+Hb744IgSNxe0AWg8mRnAJwNb6YGfOcW13b2GNoSvqg0iTQosjfC1tBWLZRicJnjtPo4BJaexPgHYCsjrIa/4eQ0vUt56hjKGHM8jtIuF1rqo8fhOTF+6q7jZLWJciay97vyd2Y4ZT4TFG6PrCruah/sJRXb94HCes3N0ThSuCD5/f3EgKGL1nyi/GJpstEe/EqzJxfqrhtszdzhlLkrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQP0KkgX4x6So4quJepdUIAgBLtxYx2odpddBaABKpI=;
 b=Oa/65k6G1Z9ow/4MzqIFY8VfgYnbUGvKu8GuTfc2/ZUuj11K6oUtu2ZhU6PN5FY8EcaGxLaYZhYSUEjOmGrLEM8YiNEYsj6kfZAQ5aP32yfGNewTdAZA9YwecNhXF88zl499WCnq+AYpUAqGxZqo3CTCowVbiSuZUTrNQJUF6EvXoOqxZe0hRkSa01/DpSjyH9s49+q/vnQpjjSHXCQS5TYooDS2fORGk4bbX9ONBa7Bn+djhABq/8yDdsSNWVwzSFwrJ9vlHSEkHjT+841jP2rR5w32ftQatYE2tt7MDvZsKD7J4z6HcbwMZpJyJ+v/xhPxjjM/tA4fBEn7g2IH5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 05:36:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.015; Sun, 2 Aug 2026
 05:36:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 14:36:45 +0900
Message-Id: <DKE7QSH5J55L.2C0VNKQXS731Q@nvidia.com>
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
Subject: Re: [PATCH v5 4/4] rust: clk: use 'kernel vertical style' for
 imports
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-4-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-4-67c5f326a16c@collabora.com>
X-ClientProxiedBy: OS7PR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:604:24f::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ef38e1-2072-4fa9-479b-08def0580ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|7416014|376014|1800799024|6133799003|56012099006|4143699003|5023799004|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZhlgkZro/XZmuuMN4ii8HgobXs1/kVF/q+llp8spPWs2Vbqemo4JxhZP6+e+yhuMa55OPsQYnA2gVTaMsIhPVqBPK8p1w4Fbud02BaxVoL0+RKbu2OsP5zmOuGvg5+0jNVulDaRHlWW+sOuzvif5arLn/Uco8mXHW0DfboQfkApBcVD6CpauwLb8U0t8cQh1ypdMpQi+2ANOOpUN2VBDa/ar5e4iCqoqandR5simVko3zVGh7UTvperwwsITPPAPoZWZ4AE5w75psRawnWg+0j5BC2LFLicI6uKtOYLZpJ1WZUBkF/6hAkYKIzm0bdeQtREkg55NHmv4kaof87sgNd4RiUqxgWIgicNNAcyEM0sltCGKEspYKEV3m7Ozq0f9R0JaSTaXnf1qGOw7LHMEJSB9OP8bvht5aNqU9fZ/NwH94XHLAUkyI9WfCLhq7GPnpnsFAr4RgMJv+OAE/31hmZW/EV/jEB6HYtQU2z0TWhJvmck0+BdweECL5tZSfqo2bQ9mW2n9JwLf931pwRlFUmVXirSsma+xm/qv26qf3G4u9B18db1rC/Z70yZaYDSYGdOGnsyzFcvT430wnt6Tyn0JOFXxUc+Rp5O6yjxhMy+sCl7e0SEA570TaTy3VfQ+BElmFx0lHVrwIyRqV2/1vT1wVJFwAG5A41CsViLaAoA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(7416014)(376014)(1800799024)(6133799003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjdWbWtIdGxUVHFUeDZlUG1xaU1kVUc2L1FHZXI1bHNNYXVac2hodnZWcEFy?=
 =?utf-8?B?c3pncEo5c01aQWlKTnhPSGZVZkw0WmsrVEs2WS9Ub0FGSm84Um5KcUVTbkdQ?=
 =?utf-8?B?YUxaQi9heGJhdXZwZTlEOGZUemJvUUZIY1VJU2EzYWdIWXUyeTFyQUEraFRO?=
 =?utf-8?B?ZDMxYUVhYTFJNGVCaW9FVkExL1BuRlEwbWdrU2ZXbWZjZmJKZWNFc0ZpU2dM?=
 =?utf-8?B?bTNtZFRHVk9LZ0lwL3RkYXRiRzRWWFRDYnBYUUJ3NWpPWE90S2dnaEZLNUFO?=
 =?utf-8?B?b2Zpb0xrMWI4OURteDZrbFhNeDZlRzJ0NXdxYXN6blZWRStPdEdpNlVhekwv?=
 =?utf-8?B?UDR4VmhYKzdrVmlHdFprekxhTXpnMk4raUpVWjd6eXhtb2NlTkcvbHk0NHRu?=
 =?utf-8?B?TzhzQWpRMWtDOUhpaWZQRlBodkp1NitzV0N5NXFuRXN2TnNTN2oyNks2WEdu?=
 =?utf-8?B?SkdQVHdKYVdXQU5BRFFYVmNHZG9Jekg0MUNab3JabGFwQ1VvYjl6Q3c5d2dR?=
 =?utf-8?B?ZzRKVHRsemordXZmV2RYWXp1SGpkdjc2RWw4WUQ1NDQ4aUZSUGs1c1JDdnhE?=
 =?utf-8?B?Mm9yWlg0QWUydk1Va2RscVovVFNQMUhQWDZuVmduZENtWHhqdzR0bnI0MTlm?=
 =?utf-8?B?Vno3Rkx1OG1aekdJckNqa2pUd2pXcTNXNUprUWR3Y2R1aFpxWW9Zc3hHelNs?=
 =?utf-8?B?aGh4c2huSDZ5SnpoL0R0UVNRSXptVVFmUDdSUnZHVHJBWW15WjBjdkVHLzJB?=
 =?utf-8?B?MUUwbUd1Mk15N091Sk5ua3lFQkNPZzFkb3U4VVpHd3c5R1pvRytrSEVvU1M4?=
 =?utf-8?B?SmMvaUNYbXhQY3kwZVUyMlBCbWQzdktUVUhJdDV6WExjY2J0Z20vMTlIOHp4?=
 =?utf-8?B?SzlDMXhEemtBNEludllHTlExbktYUkJUTVJ0NjIvcWFWazBuSXYyRVZkUTkx?=
 =?utf-8?B?RDV1dWFBd2VhTE4ySldvTTlZUVA3Nm4venFSTldZRnVVUkx5UTU0Y3VJOVU0?=
 =?utf-8?B?WlRLUGNTdG1pRFp6Y2hPVTZmOGx2aEFVMkJTQUNicVE4cS9CUERYR1VnNlZR?=
 =?utf-8?B?SjlZZmR1UTA2R0lJZTNEMmkvZ1dnTjM5a2s1NTZCZWpiRjRrczdlakNpMzVM?=
 =?utf-8?B?aXVmaDlaWndxLzhoS3hrNWNoQzl5K282dmpwQWo1S2Z2SloxZFFwSkZqTDlS?=
 =?utf-8?B?WlpVWGdMSldXNk1NSnpLWEVURy8zRFRqSWV0YkFndW4yc3Z3S1EvUkNFUTR0?=
 =?utf-8?B?UzR5MkhlQWdYajFBY1QrS09zVDZJd0psNjg5YUdmYW9acGJ5SEliMU04aUIr?=
 =?utf-8?B?SGFtaFZpWERvVk1KSWdmbkdQQTNTZkRSWm4zeTQ1RW50OUo1aU5PVXdHbkdu?=
 =?utf-8?B?VTlzQmhWNzNhOTZlVGdNQTRqaCt5WEoxbjFBYitpczVpRldOcVUvVklpc2Ey?=
 =?utf-8?B?Q09UN3Q0UVUrdEZrS2s5UFg3RTFwZTJNeHVyeVkwa2tXNTluNGVVd1kxRUZL?=
 =?utf-8?B?cHZRdjNCSWJ1MmVZUTJJbmhsNnNmZUZ3QkFuVlNWejR5blhoRmcxY1hoQXFo?=
 =?utf-8?B?c1BHSUptZHZqN1VvbHBWeU9uSmJiU1VPOTd2WllWbVhGeXF1UlFJYmkycVlG?=
 =?utf-8?B?QWdsOFBlQTYyaVNsbGRlclJ4MDA0WlVtTS9KRXZkUDE2R1JxeXBvOG1FdHl0?=
 =?utf-8?B?Z056Y1labHUwMjE5dG55UlhQWElpVkcxMHJseDdYclhFaytyRUpVQWZ0L0tn?=
 =?utf-8?B?YktPODdud0Y1YStQMXRHcFRYcVZEZFIvWVQ0YzdPMm9adWljZE1VUUtyOGxx?=
 =?utf-8?B?REFjMEdwaDNTbURBKzFQS0FnOE5vbTIrY29zWXUwMndZVUxZQ09ZcC95WURu?=
 =?utf-8?B?WVVHeUNzUGNlbHRBaWdJRFN2bHJ5SmhrTFNwTkd4cXFoMXNXQ1lqL29PcHMz?=
 =?utf-8?B?VmJXdTYwaWc0RVhtSTRub1o3dU9iemVnQmlwMkw4eWNrUmtRSmxJTGRqQjJX?=
 =?utf-8?B?UGR1RTJ4L29CZU1ZZlRZQkhCQ1MzdVRJN2pIVDBIdndnWmdnWTlHV0w2a28v?=
 =?utf-8?B?Q3A2eVBoUm45V1NDSUlwQTFmend0SEV1RTlDc2MrckhTSVhsQm1kTkhLQVdQ?=
 =?utf-8?B?QnhsWk9KZXFuaWhhOS93VnBmNGs0OTFSdHNQQU5jSUJGaWFPQkQwalVWUkpY?=
 =?utf-8?B?MlVnclo0TkNYbGVRL1V4WFBxS2d5K1pqLzljb1BTMmltOU5uOGdVU0FDU3lV?=
 =?utf-8?B?ZDRZNVRURmIrVzAySnB6aWhLK2hBbnJwTjZWQjB1ZG1rSHJPWGQzeXcyS2l6?=
 =?utf-8?B?ZHFiVkJRR2tJdUc2UVAvM0VVOVZyT2grcVdiRHBWMnc3NmxjRFlHdDkrM2da?=
 =?utf-8?Q?uTH6znDImjFdzXRMc1wQoh7sO5hCHyiyWeHSvYYY73wbl?=
X-MS-Exchange-AntiSpam-MessageData-1: YqM9FKmQzIVwZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ef38e1-2072-4fa9-479b-08def0580ca9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 05:36:49.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0NQVoFT3ga6WhiaEUnOprrDzGoiFQ+yF+hBRLkNaLCsfKE3I2d8Rwebe+sMftruVIMakoGglE6EGrJ9iZ8bgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9612

On Mon Jul 6, 2026 at 11:37 PM JST, Daniel Almeida wrote:
> Convert all imports to use the new import style. This will make it easier
> to land new changes in the future.
>
> No change of functionality implied.
>
> Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Would ideally be the first patch of the series to avoid churn. One small
comment below.

<...>
> @@ -193,9 +203,15 @@ impl<State: ClkState> From<Error<State>> for kernel:=
:error::Error {
>          /// original [`Clk`], e.g.:
>          ///
>          /// ```
> -        /// use kernel::clk::{Clk, Enabled, Unprepared};
> -        /// use kernel::device::{Bound, Device};
> -        /// use kernel::error::Result;
> +        /// use kernel::clk::{
> +        ///     Clk,
> +        ///     Enabled,
> +        ///     Unprepared, //

Doctests aren't reformatted by `rustfmt` and don't need the trailing `//`.
