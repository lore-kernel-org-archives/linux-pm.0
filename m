Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF61714AA;
	Sun,  2 Aug 2026 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785632741; cv=fail; b=RhY+57lHpsaOYPh6bn017fV+/XvxTli++LfvwLEPtEXgOD+UQMA/g23zI9kn3zbkHu+dd8jD9IjWx0jsnwZtS+GnBGBEcndU0JCPRUOCodOTzmxDqjfd4KxUHTM0CoPGtIl9IfmazUlamhTmY93UIYIGNeTRn3BHMu24SjuAkdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785632741; c=relaxed/simple;
	bh=t/M/Ar4o0l12BPcekNnCJfUPa/66AiEbnjscYGRQTPc=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=SwBCWOees8ZXV/iyWZGocgPluV6euH0CO0keLI9oNwWn6smA7D1FIdjJ0dtsjDu28+ts3jpbC17TEfyfUv54Fyh5aHe1dKPtL2zTrmHRjzMwhMDB7rNOSM5CtJX0wU1bk6HV7CJL6H/YDgPczLS7+N3u1n9FF6WM0IEaE9MuVDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mRqFk86T; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mRqFk86T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7jWDm8NSmnIYjf7O1eKwwyw9bLnHEZm46TMKyi0Pzt/pHPKE8koNEbxAzaUmqoYJH5/wqq2eDtToRTDQIuQLldoSWVU6pcXkdjM9KgAv3vPHLuJ7uqRDvFV5o6pzg3IHUJsF8m2PL5ME7dIDqIluMjsfIBMKxgNuA+z1Ii1cJVwKCHiV3FMXZ0yROPpCo5chHuZvDCMbtWR6UAMfwazO7Q/FJmd1FlsJ/loKLt3glIM5m7Z0MD1eMmd3pyabAwe1EH0EaH9g6+5wN9bwCa/82Fw4tETrW6OHlw4ak0tkY65SW7ZGnrGr4XHniHQ0/1+nBQ2ry62VvSI67AEl4QszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0yc9l7JR2VPjp9tivJa44UXt/uaOCu+VQpoSEf8CSk=;
 b=H8xecjl4Twchscn+iHCf+V0hg2/tUVa/3rH2UpZToKVknYRfZ7yi8Fg1WMRF6XdG8p2C3Nd+ysUp/3g12LaOlFNl7d+Co8uHppnZXZUIvGzKX5ZebdDL35fbMYAT74tCHMZlEj6uvUK4SDLtI8QeXMrVm1mzLKOSlm/Z1M5DueFKQIchkAvzllFV6WWXArQbm49Ppb0hUo+63VoUiJ2BSC4pnonTJhmPY9LzkGNYbgargupg6oVjbE56YZH78CI8OQH2z9Aq87uUCp5ZpLt6QcmYeedxtGJuRmtQNPF6CahggRkMjwG8t0VI0MrnkOIYOJPSb1afzGIj2qolZBSM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0yc9l7JR2VPjp9tivJa44UXt/uaOCu+VQpoSEf8CSk=;
 b=mRqFk86TmZnIBfqfKG96CXP6yHYQtKnyi5OOficgXA6sslR70uri4BQ0/XoAHRXf6JAF+DBlRIOHlT+7b3+StFf9o/5kM9LgGz6lEGDpCffJNkQOkkhUg+Xlg/zE37SDzht7lVBmMT7lDbCKuzv4Hx7LR5FK5f0PXDHt3JmIy0roVSTkXC0bcvRTSTng72Ih46JE8AuTd+jVB5PuVe7u0nL6Zd5liqlZ0ku7tiXGu24QUSbNl+YEgm9cU2bsLwArrUAbgLX63V2/MD1X1a3c5SV8P6ZEwog7MRVaj9xz5yioaEzOFj0FIBA/CPls5zLCdKfvMNWz2oFiRwcWWrgL7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 01:05:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.015; Sun, 2 Aug 2026
 01:05:36 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 10:05:32 +0900
Message-Id: <DKE1Z4WT4K89.3QZI5FUEB37U0@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
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
Subject: Re: [PATCH v5 2/4] rust: clk: implement Clone for Clk<T>
Content-Transfer-Encoding: quoted-printable
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-2-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-2-67c5f326a16c@collabora.com>
X-ClientProxiedBy: OSTP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:216::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a58ed6-7bdf-421a-e18f-08def0322942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|10070799003|1800799024|3023799007|11063799006|10067099003|5023799004|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MaWCjPVr8a/xi0fQoa2Mapy3+kmTYD+n/94OEmqAGLFdfTr9moPETuAFDVWcq7Htmcd77S+jvdKFykyi+Cf1BfqqziKn4IqHWZ89zzkVGl19M/zK6ukWz3D1XUtixTj2P9QlL/VCyRpRJQoZaTBOiixhbRMmwP0LgyuHQ20p0EEangDQD8pSoypRxgNPeyBjY4l0JRRtFDmaTBxln3d4YIsM8Zk/yL4hMLwjmBCbZOrEOX0rzwBOT+65hesRivG2U6fd6dCRq5jB7gakZzNfhPn4NhTRZhiSgybQ4piyjDCFS6UjYRKmc+aQ/KOfSleYxzEBl0M8/iyYtvqXkV6hmlPpNYHezmFOspujmLqyeexXp8Pa9QPNN3SLJb3ve42GTxcnvjeSiYvVQ9Z3aILuAm9846m7nLPEoU/noUJ1q3pqSaQytuzTGhS78TJdNkwePE2WMLD5QFOFk1CEbDhcCG9ucKNUFtj4ZeBLcFV91Ajxt8BpBP0zFS3SVeF47GR/+r1FLebg4r3kXutz79weLlmzuMvZBTrQ/tmpLh+vVM7IJofBurnk3Ll/8vndUYGayF/I8TBnjnwNWATjtx3zPFBH5eCvwR6PA/l6Advnu4A4Cd6C+0DDxmcHS6bKrFTtYtmHM8HeJ7h+nxV7LpJDB0PBcTiuuUZ05K93HG2NykQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(10070799003)(1800799024)(3023799007)(11063799006)(10067099003)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2U1THR5LzkvalNZN1FQNVBtRk05NWI3SlBsb2tPZXdRd08yUnhwWjk4Smx6?=
 =?utf-8?B?Um41QmhybG83ZzdYY2ozMi94bmRkWW9RSitackxHaVBkaEhrbHV2cEpId1RS?=
 =?utf-8?B?Y0M4VFNkUk83VFhMeDJkdXFmdGs5ajZOcENocFc3dDFMWjZmMVlaeEtOMlcz?=
 =?utf-8?B?UnNkTkRoYTcyOXlsTkhTSFJCY0UyWWY0eTlCVzRWd3RjdnhSQUdDb0JHZUJ0?=
 =?utf-8?B?bWxjWWVWN3hScVM0MkJjS1QwMlozT2ZPZGpwb09LakJvWVFSdHoweVgrVU9E?=
 =?utf-8?B?cXN1dGcvQkdGRG56cWhDaE5EQVpCdDVvMSt6OXVOVUx3MTRnYkM3UDZ5SEM2?=
 =?utf-8?B?L2NBYWdQU2R4dXljb2gxdTVKaitIbWcwZ3ZLYlIrclU0d1pJemwxYUpJWjFs?=
 =?utf-8?B?MkZXcnlRZzNuNHJMK2hib3o3azFTS0x3ZUlnc2JKTjRSRjRXbDZ4bjdwNTlK?=
 =?utf-8?B?QVRwYXV4SWh6TWkrWTdndFg2YTBub2FzRHpSWnkxdVMxVXBveDZWUW9janpQ?=
 =?utf-8?B?aVVFQWZkWTNFMVhVVndnUmdkOUF0QjlzUTlJcU9PUTUzbUpHWkgrZ05TM21t?=
 =?utf-8?B?L3BxMXVTUHBGcWVPZ1EwOUFvME1LZzJZSFhydHNWWFJ1NjQwNnVQYkI2bGhn?=
 =?utf-8?B?ZmNMb2oremxrMnJLUDFGdTZ6dHJzektiWTk4cW1WbWpFQ1JSMjlCZElPODJI?=
 =?utf-8?B?VTVtR3d6QmlzdC9NYzNjb3FhVFRMV2grRkFuRCtwbStZcjJLd0NaN1RtMHJM?=
 =?utf-8?B?ZTd3UllFNjNhUGV4Z1FraEhaVUdMQWNzbGpJY0wxbGkvZUhyRmNYZzJLUnRK?=
 =?utf-8?B?VUxOQS8yQ0k1QkQrK3ZxQ24rd2hFVjYzNno0R3lOeVBoaTNpNmF3TklES0lw?=
 =?utf-8?B?WW9YK0NkbFRVMW1tM0ZPM28xWDhyY1J4ZXl0aVJhd241cWNtSUE1SHY1dnZp?=
 =?utf-8?B?ZG5nbjJ5YWFuMHA1Y1kyR2FQNjdsNE91STNQSVFzODEwOFQ4RlFFM1pUcWNu?=
 =?utf-8?B?SmIrM3dSK1VyWERINDVDTDBmU1ZOYTY1cTFvMVBqckM0b3I4cTMyaTVrMGhz?=
 =?utf-8?B?VTg0Mmp1cTFhU1hBRWdyT3hreDdzbElGUmlKYkJ6YXpHS01Ia3J5WHZYajlO?=
 =?utf-8?B?SW1nUUkxblpDdk9uTnRaNW90UjBDV3puOTR3ODJ0bjArMncrVEp4RmdmV0Z3?=
 =?utf-8?B?T0xka0svQmRHcjhUOXp1ZFB5V3JLYnlEYnJXdGR1SFZ0YWdudjI5bG5YVXpF?=
 =?utf-8?B?Y01HeVpkZ1IrcS8xNzZ2U1ZodlNpcUd5d0ZyY2FxQ1JUNW5QQmNTNnllNW5I?=
 =?utf-8?B?SVdJZjY3TVg1Wm0wOEpFNmNPTWtGTU9mMmx3T2xFVzZQdGpnQzZaNDNrNFdn?=
 =?utf-8?B?Z0lFeFhrUVJyMkpNd1BtTmtIWE9RZCtyQTkzRld0RmlSMCtnUWNkL0t5QjFh?=
 =?utf-8?B?M0xaZE81bEZPTkhiYTRoOFlucUY3T08xYlcyWW1FVjI1WW1wRm5pR1RUa0Vx?=
 =?utf-8?B?MmU2Wk1wMG1qb0htaWh6ZFFUQnpUUWJJZHpRSWJCazhTbkNGYTdHNWJBNzBV?=
 =?utf-8?B?aEV5RDhkZCtWbU4xb3J2MWVwSnBxdGRoTHBtbFRwT1BPcnRxNWJsU2dJbFFU?=
 =?utf-8?B?RFdqT3laTmZwNkRtM254c040bHB6OUY2S3d2ck9talRTdy95M2hPSkFNa0pl?=
 =?utf-8?B?bTA0QllxTjJUT0FkSG9GcjJvNzBGS1p1RFM0eE9wdmFmNTVzdVVCVXhnaUJV?=
 =?utf-8?B?SE9QVU5PV1JFeHROM3VURXNMNHRtZmE2V045QWFvdTZOUjRuQmdsWmo3VlZT?=
 =?utf-8?B?SE1wVkppWjduWEdpUjNibllFY3llUU1xTHJ4OHpIcjJ6NG9VZlVYb2h6VkhB?=
 =?utf-8?B?OFJ1N00vWC9zZDlWY1YxMTllSjdnU0gzNlY1Q3VOdlU0bXZxQ3VObFl2RzNv?=
 =?utf-8?B?L0NGcUlpK2V1OXE0NHBhSWlFVlRlMXFRVGNXclo1dlNaYWZ2Q1RHNFNNbjRi?=
 =?utf-8?B?NFZxQldYeXVnYUlSdHNCQlJOMnNuTGxkTUY4cWRoUVdVZXNQYlI5czhpdzRK?=
 =?utf-8?B?WkRXa1RZWmEyUjNrRDBHUDhXWUVDdEtMK3hPd3E5SFBEdjBPTDI4ZFNXNXNP?=
 =?utf-8?B?ajdqbGFoS3p3RWU5Ym5neW1yMk8zOGxIdWtyZERjSDJkZVJEZ2JvNGxUd2p3?=
 =?utf-8?B?Q0JDT2NzY0EvNStxOE5aOE93enVHa2dxN0pQK0VUeFMrSnNLdDh3bDRjMUJh?=
 =?utf-8?B?cUJva0ZFazNhcVdsY0w4NTM4ZXZZajVxTWNoeVZOcmt5ZUdtWDVJZGc5NUto?=
 =?utf-8?B?SVJpL0ZzQURGY210b3BzR1VicGNodWtmckp6U1pzNGltTlZxeE5vOVdSTXpl?=
 =?utf-8?Q?03wxEhDVJX/ssirVmFvEVgBpm9HsHLri1VjOzY9gjksa5?=
X-MS-Exchange-AntiSpam-MessageData-1: VSlWOmIzROt3BA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a58ed6-7bdf-421a-e18f-08def0322942
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 01:05:36.7991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+Q7r1HujxgI1YoH1hfI2E49Ohwj5YmIEGIeZ/RL3HEGbokFtShQjwPijA84GXCKkLCh87a9SHiJ5wVTbSVdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078

On Mon Jul 6, 2026 at 11:37 PM JST, Daniel Almeida wrote:
> The type-state pattern makes state transitions consume the Clk value,
> which means a single Clk cannot be shared between users that need to
> hold the clock in different states,

Sharing a clock can be done by acquiring it several times though - this
actually seems cleaner to me when concurrent setting of a given clock is
needed within the same driver.

> nor can a driver keep a long-lived
> Clk<Prepared> around while temporarily enabling it for scoped sections.

Something like an `EnabledGuard` for a `Clk<Prepared>` should be a good
fit for this? If you make it generic over `Deref<Target =3D
Clk<Prepared>>` you could even make it work with `&Clk<Prepared>` (for
short-lived enables) and `Arc<Clk<Prepared>>` (for enable periods longer
than a code block).

>
> Implement Clone for Clk<T>: each clone is an independent view of the
> same underlying clock, in the same state, owning its own
> clk_prepare()/clk_enable() counts, e.g.:
>
> 	let enabled_clk =3D prepared_clk.clone().enable()?;
>
> 	// Do stuff that requires the clock to be enabled.
>
> 	// enabled_clk goes out of scope and releases the counts it
> 	// owns; the clock remains prepared through prepared_clk.

Looks indeed like something an `EnabledGuard` would cover.

>
> Since struct clk is not refcounted on the C side, share it between
> clones by wrapping the pointer in an Arc'd RawClk, whose drop
> implementation calls clk_put() exactly once, when the last clone goes
> out of scope. This costs one small allocation per clk_get(), which was
> deemed negligible when compared against the pre-existing indirections
> in the clk framework.
>
> Cloning a prepared (or enabled) Clk calls clk_prepare() (and
> clk_enable()) on the underlying clock. These calls cannot fail here:
> the value being cloned already holds a count of each, so the C side
> only increments the respective counts. This is what makes an infallible
> Clone implementation possible.

Another point to consider is that `clk_prepare` (and thus `clone()`, as
you mentioned in the doccomment of the patch) can sleep. An
`EnabledGuard`, otoh, would only need to call `clk_enable` and thus
wouldn't sleep, making it usable in atomic context.

>
> The DISABLE_ON_DROP and UNPREPARE_ON_DROP constants are renamed to
> ENABLED and PREPARED respectively, since they now describe the state

Let's give them their final name in patch 1 then, since it's also
accurate (and arguably better) even before this patch.

I am not quite familiar with the client code that will make use of this;
a pointer would be welcome. But I strongly suspect that multiple calls
to `get` and an `EnabledGuard` can cover most (if not all) use-cases.
Introducing an `Arc` here forces a storage decision upon users while
hiding it.

It sets us up for some dilemmas in the future: for instance, Maurice's
series exposing `clk_rate_exclusive_get` turns a `Clk` into an
`ExclusiveClk`, but its potential clones are still around as regular
`Clk`s. Moreover, `ExclusiveClk` derefs to `Clk<Enabled>`, which can be
cloned as per this patch; so is it really exclusive?

So I'd like to keep discussing this design a bit more, with more
visibility over user code. Maybe it should be moved to the tail of the
series, or even extracted into its own series so as to not block the
other patches.
