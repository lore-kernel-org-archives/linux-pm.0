Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD582F1FEA;
	Sun,  2 Aug 2026 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785648268; cv=fail; b=cKxHK0U4vR6IWnvLSOU6ULGbBarTxLZnw9Bl2AI6WvAq8fDWSfvHO8ZWnCtNKvJoFQX1k9c7GFvKWTvhuy+bSxi0Ai/6bXIQyJVygDrEg3CYtFnzobCdKiCT614Yi/orLHRJhStiEN42CZsY+ndSey24J3rS52REdE5aqwbckFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785648268; c=relaxed/simple;
	bh=y8+3bhPXPvMoJLLlcnd4H49jIWu4jF0XG4pyd8uQ6DM=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=NCIcsFXsAmmFTAVSwb7tqs12/PMSVPoud9yZ3anGqUNWyM+JSkkhEFJCh/j9j942s8bi3VzHBfzF61R+nXRvikAPcTdHUWqYLOH2posk5nxQqnrBWV1yDQkXpg+kCwhPNx2H35yMHhXlgRR6tTxrfudg6YjAHtJuC0inELH9MLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wy11c1bN; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wy11c1bN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKiYpGI0yFH+ltD3UGnAyfU1WhXitJZdL1glLKpKWpsDCkT/u8IBQMbULfacGiRe2fKV7tTkI/kGtTTvjzaQV/ZHO9h91NjkGvdnppCC7sbw+jtsqKPRk4ZbKRz3ak/DQuzviglkollgHtCbO9wibtzxu+UMs8rwu/vTszQDccVRTI6/eW1QWrv4iIPLsa7yMI9OXOWafyDJc+DD8AIqKHD9i3tUqRMptqP1Rxx7KzjwQzRYaetZ7Juc8wS3A4wW1AL4XEdJu4ews9DmlKISPlrQ5kHsNx+VbFgXCtWjK2u2BqKzpP1A9UiqHZd1Bxnu2Xk6wU9ivFMpxZ8Emk7XYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eczUneMTiSCYWKDMBCUnzsG9qrQPASttq2272vQbIoc=;
 b=TusTmPA48kjadqaMbNIMtxxboU4PXc+Ce3oh8pwSVDKYtskc6RoB0jUNWFD61UU8zK50SjhkvxnRnGA9l40U1mY05PyNrxYQtfeyMkHdMPbLAQ0IePIY4ytkLsGC77xg0iLLe9U5nAvftE4Q+6Y9S9P3S/Ue7AkFFLOWPtIAI4dRc/1rnK1lTvecH0PdpaUPoqMPgCgkEF7ouBucKhWNfl6xs6aN8IJMg6OfayvQp5OO+uwGNJo3X70Ku3nCeS3eXTtmKL6wczRTTCq3Caq7xOu2PTdpVNsmrQbtLN+s2JOC+sGlKM7rqHIr3qeZ3U5Xmj8W3D7IQuYqjhif5tDGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eczUneMTiSCYWKDMBCUnzsG9qrQPASttq2272vQbIoc=;
 b=Wy11c1bNBWKjpRVRXZRmqpyg9EBjdpGntfKFHZlqZL0CFjK0XhB/bWH2rjqvZoRM+XUgKPUj7NvR9/ws2hqWDVVIUE5bu0bM56mK1Kc2qoX7+21y+1T1kKfSTi9iCp8yznc4T/d5BHGmFEmwPvh3aqaMyi/0qp7HMcldGo+qA5qtVSUAndP2/5EGnQ/G6ygHzSEcVdDo12xIjzfmqEhq34l2H22N9tk0WCjKenzO9FZefadw5vT3INtKy0MPj5ipD1SXwk7qRdxrQKrZYYE7hM047tCsb99MqPURaP5j+antukebA3TgPFMg1A7B9NJBN02d9ejMvZEgxo6fPYXNBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 05:24:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.015; Sun, 2 Aug 2026
 05:24:21 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 14:24:17 +0900
Message-Id: <DKE7H940RYTG.2DL2793GTF3XB@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
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
Subject: Re: [PATCH v5 3/4] rust: clk: add devres-managed clks
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
X-ClientProxiedBy: TY4PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f5a2a2-5f88-41a9-9943-08def0564e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mZ9/aLIv+37e04hn5BbhXb0Az87cHcXgrZVX60nyS8aS9wTS4WFud3H3JfZ4NEqr9qNZypJ/NsU2KFUVnc4Hx9nYhL27YkWQHWTpPG3qNCwaWscFstZqgkXvp5B3eh6ei+GJsCUpWPk/w4gkiLNmE3oGC8dY3V9csn6s5RRwkYsaduoAs+z2lfZahIa2PwK81UaLJB3G7dSnwbAaKouNAAA6hp1oDBkRCKE0Vq4cKzkedYgzMq+rRZD8PVt6u0lTqb9GpNkuG11IBaNy5QTtgy+27klaTo+ukfgyd5OWRL9bx2F6ioWuryKSmnhmeQ6DDeRqS5Fm4WWq6r17a0TMvDUcrIf8S4yz+YDw/UlTG4VeHfQhEgsNB58lgcyr0GFaG1PQQ5CKAtrNPI37TGnkCedBJ6MY5ICbRIGKfVEanN/rYNRLkRSQi/qYXHoMh1IhIDgndKlpm/qSi67pKms+CBGcrrPTi45vFe+rNpN0wNbTfTqFHtL58OjTGIMT4q/S3wYkcpGmDsFTKRooYvEWxOZLh6gjXhSj+AMkNJixSB6+KEB9YX7QdKjBTR2UdJDf9xU210M4i1EjrGkY0mbj6QEHvSAcZC0TygNGAkSHi4HOQOzR6RYzcmqcouE806qdr9VvBcCGgaY9rglVPrqgkh6rCGLBr/MYsQMUJJrUWKs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk5TbHExYjUyOFpZY2Q5cjlFWW1yUlhmaTlOMHZzd0RjaWtOSk16ZVZNMXV0?=
 =?utf-8?B?Unc0aUVlVXJkalo0czdJMXRRcWpsQmE2dWRzb1FhTm5VKzlaa1NvTWk3ZGxR?=
 =?utf-8?B?ZUVtSkZLUjE5VEJUOEV5QUxDUHpRTTVTdnZmYWhoVHdmalgxU0NBd0Y5bGtp?=
 =?utf-8?B?UGhJU0pEYS9qbnltVEtCV1BqMXBydXZLeFJqRzRDSnRyUy9iUk9oa3Q3VlVh?=
 =?utf-8?B?b2NHc0puNTNpZUcrdUlvT3FWeFRpcnlJYXU5VlYwY1hJQnRHUGhmNWUyblZa?=
 =?utf-8?B?eDJCa2lUdHZ6UmhVR1N0bVcxWG9jUEVTSmY4QSt3TEtnZXdFajR5TlBMY1pQ?=
 =?utf-8?B?SUtTY0Rrb3Y4MlBYQlpoSkNDbkE1d2tCa1ZQNjkrTlZSSEpYRHNuVFE4ZEZS?=
 =?utf-8?B?M1JtQ2QyajhIUlFEeXhoSEtqN1dXU3FJWWs3SmgzakN6WTRIV1ZCTUNuK0pG?=
 =?utf-8?B?U2Q2WXRyRGtDOFhGTTY3SjlacGNzNGRoTFBVVTA0cVo3QXhrc0pWeWRpMFlR?=
 =?utf-8?B?VTEvRkViZVRFMUtFd2l0V2JpWm9kVk5BbUVINGVDM2prYmVqc0FVb2xiZk85?=
 =?utf-8?B?ZlBoR2lHTzJqSlpKcnBDZ0haQzQyMVN0cVVySGM0SVo1WjlMSkY3OHo4cTB3?=
 =?utf-8?B?dzkyeG5CNkdSQ2VDRlpyWlREeFkwcTZPNnRacTBhODJvWExjODhkQUZObGtl?=
 =?utf-8?B?Y0pnVHNrb3c0UHVBNEp4Y2haMEhvNC9EL1huRkdtcFpIWUV3YUcyc1YwRWxS?=
 =?utf-8?B?OU1LV0VsUFdYVFR5WEtheWhCWXlvb1RtYld3anJtS1FqOXVGci9XMlpRZDd2?=
 =?utf-8?B?REdVWStkUkczOXZoSjF3Q0NsUDZuMTRiajNmMzNRZ3JQRU5UV0tIVlpjWWpv?=
 =?utf-8?B?ejd6ZnBqQVVlNzhEbW0yVXNOUFZiN0drbkFLY2IvbldoeUp1b0dHYW5PWGcr?=
 =?utf-8?B?OTJqY0d1R2J6bGJoUkFSMURYKzIzNzIvMXVGbk0xZTlmZS96RFo1UGZHcWI0?=
 =?utf-8?B?UmRBY0QvdTU1enRUTFJFSlNHU0ZySlJjU2svVXZocjBMelBYRUlBRE44ZDNE?=
 =?utf-8?B?QVhtT0taMXh1enhhN0ZrMHZ0OS9OUmU2S05jR2JKVUZEYlF1QUM5YzAzZWgx?=
 =?utf-8?B?MGlZbWpJUVJQTW90RGt5OEpVUjF6SkNISDBuK0N6UjNGZ3BiOGxLVUk3MDNY?=
 =?utf-8?B?TXVzMHR5VC8vV3Z4MDMvV0laTmFKVzF4SjhrR0RYWHkwelVrK3dqOHNDdDdQ?=
 =?utf-8?B?TFB2VlF6Nm9QNy9vTGpoRlJ3ZjRaelZCTXNKU09xVFg5QmNyRU9rNTdoSVRD?=
 =?utf-8?B?QjNHc1JHR1RROEVvT1FqVGw5ZDVBNkY3Z0Jma3NVZXE1N21IenMyZDZpaWx5?=
 =?utf-8?B?UmVOSTdzUzBwb2JVTEdPMUFaSmh5YWJYaUpyZklDak95eVRlTW1mbVlDMEhD?=
 =?utf-8?B?QkluNHNXS1lid29yaUZYSUgzdGdPL25DYlBuUEdzazRiQXNhWDhCN3NadldO?=
 =?utf-8?B?aVR5ZXJyemJhdWhqMCtYYnRnY1dnQkFsTFJpZXh2VVp0REZ2S1M5enVPQzdv?=
 =?utf-8?B?RndZVyttdk5OTjJJSU9NcWJhaGYwMXpYY2dJSzAwWCt3Y0FlbHlaU0pTTXQ0?=
 =?utf-8?B?NUljUUNXdk1KV1dmV1pvQkUwQW1tM2E0Y01VRXBmY1o3SmlyK1doZ2E3VElz?=
 =?utf-8?B?cUd5djV4Y3czcjlpTTVMMy80SFJDZ2g4QjNQNDMwOEs5Q0dmNWtFRWNjLzRa?=
 =?utf-8?B?THFQcFFYbkUyUTJXR3Z2ZENQRVU2bHRoTFRQcUp1M28wQU9VRWwybFZUaHVy?=
 =?utf-8?B?YzRZcHRKdVZzamxiNWJtbk42aVhTcXZ3RTJ4OVhhNUI5aWFsK2I4a3NyVmZ5?=
 =?utf-8?B?M0Q5cE5DQnBPRVhKWmJTQm5HeWpOTElEaU1zYy96RUlPZFpkQ09RRkhWelBy?=
 =?utf-8?B?SXZxeEhrOE0rQksraE5iV2NyNjcybjM3UzB5SDcrTnpWc2Y1L0xvaHZVRi9h?=
 =?utf-8?B?UFFyZW85K1VySlQ0dWVwdU0zT0tpQ0k1aDlEdmRSMndXaHcrWWpWUXNkcVI5?=
 =?utf-8?B?RzRGVHNaZnpFbzIyRmcyWDNCdFZQZHVEY2kxS0JGbHdJNFZTQ0dFdjlYWEhI?=
 =?utf-8?B?Tm41Z1VvVWJvUEpBR2JYVU8xVzB3VTJnSVdOY2UzWmJORVF4d2JQcFpndnBy?=
 =?utf-8?B?L2VjRWpkTlBFVmdRNlRCNlBHY2F0eXlvVjdXV1B1VTUvaG91anMrUUR1Y3Za?=
 =?utf-8?B?czU0Mmt3UW1LMEE2RmhXM09LRVlTR29uVFY5b2hmbTNOOU9sRjUyRnltOEsw?=
 =?utf-8?B?N25ybzRSeHprWjhBQjk4SURpT3dvMitZR1NxUUJjSXp3dHdnSUEzQVFpTTJq?=
 =?utf-8?Q?0m0njlRM9oHaZNkiEnwLI1WT7hiQtfsxRHIjPNDgIGsOU?=
X-MS-Exchange-AntiSpam-MessageData-1: dSIzGlpt4d4Zjw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f5a2a2-5f88-41a9-9943-08def0564e92
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 05:24:21.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfQQxoVrUx8WXHH14qT8FeywmXPRLJwW7bMFMeFpbawdjY4GCacChpjDT6Yur3BgoZJsR2wzcqC0UzxiHz5EdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026

On Mon Jul 6, 2026 at 11:37 PM JST, Daniel Almeida wrote:
> The clk API allows fine-grained control, but some drivers might be
> more interested in a "set and forget" API.
>
> Expand the current API to support this. The clock will automatically be
> disabled, unprepared and freed when the device is unbound from the bus
> without further intervention by the driver.
>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

One nit below.

> ---
>  rust/kernel/clk.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index dd5fd656271e..b9a44f83843a 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs
> @@ -96,6 +96,52 @@ impl Sealed for super::Prepared {}
>          impl Sealed for super::Enabled {}
>      }
> =20
> +    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound dev=
ice.
> +    ///
> +    /// [`devres`]: crate::devres::Devres
> +    #[inline]
> +    pub fn devm_enable(dev: &Device<Bound>, name: Option<&CStr>) -> Resu=
lt {
> +        let name =3D name.map_or(ptr::null(), |n| n.as_char_ptr());
> +
> +        // SAFETY: It is safe to call [`devm_clk_get_enabled`] with a va=
lid
> +        // device pointer.
> +        from_err_ptr(unsafe { bindings::devm_clk_get_enabled(dev.as_raw(=
), name) })?;
> +        Ok(())
> +    }
> +
> +    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound dev=
ice.
> +    ///
> +    /// This does not print any error messages if the clock is not found=
.

This sounds like a clock not being found returns an error, but no
message is printed.
