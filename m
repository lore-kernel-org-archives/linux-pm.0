Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020105.outbound.protection.outlook.com [52.101.195.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28535A3A4;
	Mon,  3 Aug 2026 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760176; cv=fail; b=MWNIWZCXsOomfDEwaqVIdqm1BpBK2uq7ak2DZk5sjQZyYCheGt0Z57VGljRX2fZY45YmaObXqrA4oAAZ8c0yWtW6xKC6RWtWKj8xQ48/P2QLFhR38MyheIzaITSj1odXOtq7oVjOlwam3VEAWPtOtFv30KGgYb+reiRHKjN4y4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760176; c=relaxed/simple;
	bh=1rjRZUYgtoPmEuQdUA/VltwMx3Qs/rfqobU9ye6l4iU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=sfDSoC53FNAndO+az0gbJqVI3/Z2wL8Wmk/iS/HTaTIEBs1ei/noBvcrgUaK8SjLlSPiZqwBguZyefKoqHtxHB5ZO2hZ1Q7eaOkrKxMvfPjTVqjJBJw/VTjRrL57Pl8YjtUZmvH483etNlnZ5JrD0GbnHjaI236/eJyjsmd0PRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YpuRy0+i; arc=fail smtp.client-ip=52.101.195.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="YpuRy0+i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy7n/GDLGHeZaSc964lHB1KUPkNqwJ3AN0P5WSCkg3W2+w1mF5RmABzllq33DGAbdAR4XNvpjU56OSSVKh9TbqU12aXNp3/AF/7k/T+69Tq2LcO48zaeQ87Oq4WfnQAVFn53xqdKHo0U+brVXafOthc7a87xVgNT7FRJdL5jf2zofbrIThRLr2mntwxj2RZ1PbPhrrgeyndcJKSEjVqPVgsiRRI9sVtz0ZZ4mkZ4jur7UbbVQJjTCFZOu9BRhZ8nTaq6qPgc/cxAk7meY1MV7FwpHthXh+K8x+iWw2UO8/RJ1RsexCghNYTnefK7xf0cGNdG3yOIpr1k55iEfcAx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXwwUv4AU7eNZgEqa5ZHD/NioKWhoX0HHu4w5IUr1KY=;
 b=r5RBkWjpYBbi158dNLJVqBjKNbCwXIZ10Y2y4UXKnOWtlj3qFBcx1ve/XJij9pUIGUbA6rRP1ACACVzE0ZXM1kW+bVZIfiDndj0vS9WfhdoSFTdpX3A2Pva7myIihhCdhILviNGp95NxiEDfSWY0ZRPNZy9EFBX0+lwWx/u0kwo2gmF0Er0qfBMl3a/ZMcr/jwlO3SEjqxRUK1EXHNow75ZHyRjMx7+h62eZaBj2zKUaIFM7LGu2oDmfNPQ0Os4q/6H4LOGRC0+qY9XLWA9dEu3p+ZlFS+NNvP140Pdg6MAvO/ruxPIS5qWt3Y5Dso/zbUpyPtDFQPjv96cdh6lNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXwwUv4AU7eNZgEqa5ZHD/NioKWhoX0HHu4w5IUr1KY=;
 b=YpuRy0+iXOKzsUlKZjsCZZzqpS9Okh6rMXNnV0eCpJM27mS8irJQE7Oqte+AqTFsqU6U+xytAjlPPIfHafIha49endRI6uiuDcfCZNQQ1SbxIN+YY+VyN+po8g640n3N/flfqUyyJqFIQjfMu+g7yMJlMHY2X9Qiu0AymDQe6YQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB8891.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 12:29:31 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:29:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 13:29:29 +0100
Message-Id: <DKFB5CL2I1FO.7ULPVEF0VG5Z@garyguo.net>
Subject: Re: [PATCH v5 1/4] rust: clk: use the type-state pattern
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 "Boqun Feng" <boqun@kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Maurice" <mhi@mailbox.org>
X-Mailer: aerc 0.21.0
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-1-67c5f326a16c@collabora.com>
 <DKEO7DXQ8604.1CB09QFM2EO68@garyguo.net>
 <DKF0BU8N7JJX.T802R11VZ0A5@nvidia.com>
In-Reply-To: <DKF0BU8N7JJX.T802R11VZ0A5@nvidia.com>
X-ClientProxiedBy: LO4P123CA0388.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::15) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: dcde09be-5d55-4d3f-3393-08def15addd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|10070799003|1800799024|56012099006|5023799004|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2/8QGUni+R+/LmjB1rsz3I35f2TIUV/neyjpn2VbnJ41hF1JHk2MvTuR0hycNLLYc2iBP5Aqv6x5FlnBvoQn4DoBUMYwH4H1hsK602Oa9anpgTd5YnLWISITH7vLXhIRi5ERFEWZqRNPKjWXCWIJ8tYLFQ0HxJS/5jwNyWDrff4laMzEwFJNRGNkmrX+NErZ3ueKpE8D6GGKvniRZCLouUE/JmNX+otBlDThsGst6J5Z8cQwMIeqqsONFez0LRFFhQXaBCP/8JOkDhahlfzANl9pRGPDLOQEdaue+uP+SerKRZBZlvWkWwy6y6HRxI87xQV39RSIuWTyY0daljPf1gqJgQlkauv5nB+n1XPaX3ZtPXuKj0ImBEoa5fdWzGUUP6k6E6kCK+O+tlOvC22g0GZeU8cIeaL8/fCNQD1eeFz7yXX/cdCpCl5Fwb1XaohPKdGQmEhV3Kk/lTy8GMqYSlUec+yGJp5Yp5+F0dfdwmHADvn4rqox9JWrMknxvCKkw02lzu2qrQWmpNm+mVuKgpHxVPMXHiCZs8ukkE9kPq7eoO/RqII+66PtkwVVIKxxlQlIyPlZG3hVINLmBV0015aqGYJ93kw3SB18+58NHBpMvXig9PY3w6nYFaPmWasSqgcUv1WHy/t1eUYqA52qB977jedbQdm4qqhx2BGKJ7g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(10070799003)(1800799024)(56012099006)(5023799004)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzIwcVhjMEg1bWdNT3FEV3gvSUhxZUhUZmdvNnY1YmVWdmxVUkhBODNPV2k1?=
 =?utf-8?B?bGpSbnNzYVRsa3dDQkJyMTZGTDkwU3RrMG5aWWY1cXNsQVl0bmh5aCtxZEdr?=
 =?utf-8?B?QUNDb200enUyTVZGOWFmOWF0VWhzMjgyTXY5a0tHQVcvSVBUNythejFSVXly?=
 =?utf-8?B?VTB1V05qLzRNeXNLZ0Zkb1JycGpqT0Y1SnRzWVpSQ21TSThRKy9IZGZpUm9U?=
 =?utf-8?B?cjFnVVNseVFWTVZCbm5FWjRmbE5RWTA3RjZjZFEwQk5GSThJNVpGZ253OEEz?=
 =?utf-8?B?TzdOdVFnSFlEaGlhQWpYWXNlcDVIalFpRG5FWXo4TnlFRHZ1Rjd5cllXNHFH?=
 =?utf-8?B?c0FROThlRFg5T05rKy96bzJMdXBpOGNJeklqT3B3VUVQdElUNEl3TVFwUlNF?=
 =?utf-8?B?czgwdVh0UGxWa2lJRTErZ1NzNExuQktsanFnOUJMZHNPTWZPNkxLY0g0RFRQ?=
 =?utf-8?B?TUF6dk95dU9VbGIvTzhXN2I1ZlREaks0NThMMWVBMlFJcXVWVUJ4cDVySDE0?=
 =?utf-8?B?V3NsOEQxMmQ1TTkwaWRkSXJldm9FWDkzMUZQMm9GR3Q0bjBtT3FQWXduNXNu?=
 =?utf-8?B?S0hGTlF2VS9SS3A1U1QzWkIwVVRuOUFvSWdWNnhYSFE0dm9LUi9JcHlSeXFy?=
 =?utf-8?B?NFBsVmM5ZlB2bzVaVXc0Tlp5VGJiNWR6alEyRS8zMVI1OFZCY1JjQzBTYkpr?=
 =?utf-8?B?MUxvSnQwWDZqOXMwQURGd2xCL1ZFdUd0US8wTGlZN1FVZWJnSlJoSVlnMGk3?=
 =?utf-8?B?eFp6V2JVMXlKQnFOWmlaM3lWa0pDRHNQRWlhNEllbklQRXBoRE9pQXdNTVVL?=
 =?utf-8?B?M0QrNHhsUWh3VGVPZlhLcWFqL1hLMGovVUFYaU1xUDBiT0Nnc0NuRG5KNzdn?=
 =?utf-8?B?V2NLR2Y3QjhNN3dqUk11ckVEeUtxNjBteStsc1RacEgvVC9EcTBiSkZpUXNw?=
 =?utf-8?B?NWQ2T2dmb0NLQUhYekp5aHF6ellwb1lHR0NNVVNOM2JZUzdCNW80Wm5lQ2Mx?=
 =?utf-8?B?NytZVmVzK2FoVlN3QlZlL3AzcDFuMEVmM1Q4V2ZZS0RURnJYc2dqR1ExQld2?=
 =?utf-8?B?eVlCM1ZzZXVJZkN6Y1pIWG4yZkI5SVl0bEszNFJ2dkxOd2tsMVo0MkY2OWFC?=
 =?utf-8?B?NnRTZ2dVNURGUjhLU3lqaVI5YVBoOWVFL25RT3pucXk2WGRPVU5rTHdpbGl0?=
 =?utf-8?B?eGNrb0J6OG1NNWhQQnN5dXVHSDhZVHNreDJlRDc5ZjBjakVhUzllck1YMVRZ?=
 =?utf-8?B?UEtzcUluNG1VeXVVRUYzUGxVME02MjFzcXBxR3F2UGNUYzJYb0FBV1FXL3Bu?=
 =?utf-8?B?SURha0Zvc1VDam1CeDBJWjlnNHo0eTBnRi80VjVJUlV4Tm5qSlJUUHdod0Ri?=
 =?utf-8?B?THdyV001MDlmdWFPRkJkTVI1aWY4NjR6NDI4YU1QcG5UWFZMZi9EdzBSSUZ3?=
 =?utf-8?B?ODRBbUtWL2p6UDMvV3pHMDQyZ21kbnMrVGgzM040bDh3RG1sUmpnVFUrS2dZ?=
 =?utf-8?B?dmZaQjZRNzhDLzZ0VE5sMkVjYk1ud3pPMjI2RHNyV1FqUUtYL0dUQmRzUU9F?=
 =?utf-8?B?blNIK2VsTGNhb1B4NWZsRWRZaStLZkNEa0NVL1Fvd2UrN1M1NGN2eE14TXRT?=
 =?utf-8?B?VnZiSzZRTHhvZHY2S1JGOVNOVVpqYjNQVC91L2dLdGYyZ1RyT25MREh6SmNL?=
 =?utf-8?B?cGVlOWlrelp6VGNxS29SbEhvR3JXZUNJS1k0TjhxekFGdzNMN2xwOGh4WFlH?=
 =?utf-8?B?eSt3UVpobkJkekxiV2FrWFdJYmsxVDZEYmV4bStOb1M1Q1ZkcThDSVpyWkhR?=
 =?utf-8?B?QzJHVVJKOEtaYmJCODZFN2FGYktJZWtEdkpSaUFXU0tvTHNMeHZyeE1YNDNp?=
 =?utf-8?B?eWtqNW1PODh0WHIwTDdDN1J3b25na252eUxBMGdldWRObEh3YytOMHFjWVNa?=
 =?utf-8?B?dXNTQTMranUzY2JSMklleU5iTkVMSGc0QWxLQkRleXhrek9xUWV5M1FuT0JL?=
 =?utf-8?B?T05ZVFFhNWwyYWJ3N1k1NUVLQ0xSMlgzK2drd0JkaWp4UEZjaFJnM3RzdXdi?=
 =?utf-8?B?eTROR2tTYVErU2NMb2huTmlRQ1Q3cTNIN3orZFV0YnRJaXVFdEFhTWd1L2Ru?=
 =?utf-8?B?N2tkM1ZKTDZFenlKdXd4TnNSczRWaUV2eGxXM1dsRFdtMXliUWwyU1AvRndZ?=
 =?utf-8?B?Wk9QYjZZdjZKNFhTekFqM3RCVGllN1F1QmhQaURrdGkzMzBGM0NoV2Fybkwy?=
 =?utf-8?B?OHM2SGdDcWxvNHFlbUx4U1pRWVAzL0xjVExzU05HcjRoZDhFazdId01FUjM1?=
 =?utf-8?B?SEpsS3VLR0lWZUs3QWxuamI3Q1h3UEtiK29KK1ZmVU5USVpmVmR5Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dcde09be-5d55-4d3f-3393-08def15addd4
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:29:30.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qukRCU61aM+Y82CH6tyYTVca9kEy6C/6ZnTPfejLnlJJ9paZCsI/RlakV/rgplqyRvyfdirPDMyrAng3Y3fScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8891

On Mon Aug 3, 2026 at 5:00 AM BST, Alexandre Courbot wrote:
> On Mon Aug 3, 2026 at 3:30 AM JST, Gary Guo wrote:
>> On Mon Jul 6, 2026 at 3:37 PM BST, Daniel Almeida wrote:
> <...>
>>> It solves d) by directly encoding the state of the Clk into the type, e=
.g.:
>>> Clk<Enabled> is now known to be a Clk that is enabled.
>>
>> The design conflate states with actions. Our existing type state for dev=
ices
>> don't do this: `Device<Bound>` means that the device is currently bound,=
 not
>> that dropping it will unbind it. Yet, a `Clk<Prepared>` doesn't mean jus=
t that
>> "clock is prepared" but rather "clock is prepared and needs to be unprep=
ared on
>> drop".
>>
>> One way around this is to mimic the "Registration" pattern: have a type =
to
>> indicate that a `Clk` has been prepared and its `drop` will undo it, and=
 then
>> this type can `Deref` to `Clk<Prepared>` which just mean a prepared cloc=
k.
>
> Just as the driver core hands over `&Device<Bound>` to a driver as a
> guarantee that the device is currently bound, so can the driver pass a
> `&Clk<Prepared>` to a function to assert a similar proof. Here the
> reference only means "clock is prepared", without any action implied.
>
> The typestate has real practical benefits, as unlike `Device` which has
> a well-defined life cycle entirely controlled by the driver core, clock
> handles are owned by drivers and their use can go all over the place.
>
> Driver A might want to enable a clock in short bursts in order to
> preserve power, and keep it prepared otherwise. For this, a
> `Clk<Prepared>` with the `EnabledGuard` I mentioned in patch 2 would be
> a good fit. Driver B might need to keep a given clock enabled all the
> time and only change its rate, and thus will store a `Clk<Enabled>`.
> Driver C may have different PM states, and can encode these in an enum
> where relevant clocks are either `Prepared` or `Enabled` depending on
> the variant.
>
> Mandating a registration-like pattern here looks a bit overkill to me
> and I am not sure what this would grant us. It would definitely
> introduce some complexity: say that you want to keep a prepared clock in
> your driver data, does it mean you need to store the `Clk` itself, and
> then its prepared guard, which references the `Clk` in the same
> structure?

You could have the `PreparedGuard` takes a reference to the clock, no need =
to
store `Clk` separately. We can have a method that gives out `Clk<Prepared<'=
_>>`.
The lifetime would be that of the guard, so the token cannot outlive
`PreparedGuard`.

(Using `klint` annotation below just to demonstrate if they can be used fro=
m
atomic context)

    struct PreparedGuard { ... }
    struct PrepareEnabledGuard { ... }
    struct EnabledGuard<'a> { ... }

    impl PreparedGuard {
        fn as_clk(&self) -> &Clk<Prepared<'_>> { .. }

        #[klint::atomic_context]
        fn enable(self) -> PrepareEnabledGuard { .. }
    }
    impl PrepareEnabledGuard {
        fn as_clk(&self) -> &Clk<Enabled<'_>> { .. }
    }
    impl<'a> EnabledGuard<'a> {
        fn as_clk(&self) -> &Clk<Enabled<'_>> { .. }
    }

    impl<S> RefCounted for Clk<S> {
        #[klint::atomic_context]
        unsafe fn inc_ref(..) {
           /* just add inc count here */
        }
    }

    impl<S> Clk<S> {
        #[klint::process_context]
        fn prepare(&self) -> PreparedGuard { ... }
        #[klint::process_context]
        fn prepare_enable(&self) -> PrepareEnabledGuard { ... }
    }

    impl Clk<Prepared<'_>> {
        #[klint::atomic_context]
        fn enable(&self) -> EnabledGuard { .. }
    }

Best,
Gary

