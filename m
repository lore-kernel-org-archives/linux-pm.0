Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020108.outbound.protection.outlook.com [52.101.195.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1B2931DE;
	Sun,  2 Aug 2026 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695567; cv=fail; b=LWJHhdVTG2DvYlCo/7/Povfdde52FvvkHNAMsWd8IUtHQYf4VMgCsrzGIRgbnjytwnTlIJHEvEx76GP6He99fQuungPGKPrh99tJFAAbU5rnkxOmB8a4c9oGhUMgHbryjPLY1La2q23v3lXDVVQ3FUmQRnCtH28/b9OMBcHybRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695567; c=relaxed/simple;
	bh=HwbPO66NhxQ4iduNrt6DyLp0XACMFq1qap9y3P2RPsY=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=HWOqM01ChNWcqou6i4EuIWcFM2ZyVScMgJ/Kd9Y9gmj9UdHuc75J/mDsxTH1SRC1xXPc8Erzquax0a4yuhwwpXqAtJvxSOUtpZf5765xhfAivDX7VznINSvgyoJX46p9sfQV8sgB8cw0CZWMQo3J0l05L3ckKwHyci5qGPWCfHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JemVbkD6; arc=fail smtp.client-ip=52.101.195.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JemVbkD6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be2A/MDVyqTGdK1uE6lQJQhwELC/CDchGCfcOEfcvpvU/kv2dLBCDnM5BF/22998lIMsCYBWrSx6uJUPF6HNEjjUWjTXbzi/DpwgmpaNlCtxXjifRPyWLfhenygZOvMR9rMR7vQd1hLnNh8GDMO+aIm6zvIhfHKZk+W6GpljZIhihtZQehP/Q3/AXdS18DiQymd83ur96qbKZQC9q0mwMiG3/QU12Av5el5UUqUbXaE9AZh0utv6LmNN99yxl0sSMYfVdzIlDGPMD2j5YK/i2NeHhVB1SXKU8us8V5sQDQl/MKtWV3fd59p7vP269cSN9jlGeIE8RvLyVgejb0RL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rqeVwAjDAmL0icvHeaflp7HJOA7v70zKvPvKtVqZX0=;
 b=uXpcqIZuqz32PFtZAHUicF7kjtAcE5jhFCoLrLBG5qMOXAx/bnp+D+fc8DgggUSuqgxDomJOdCuNMrtal3Odn4fEn+Ypk1vxBmgwibH/6aflrQ9Otin+TyDqeCJGPghYclgcKNksv8kFhdNUEjjijFMWg1wd6oLFgpfiJqOjXRZPemjjEvQyWHQzhImm4Cs3JQsUmDp6QbyRMsIVue0ml85mMEgrANp8MSwNGilAZKlfYDS5oVXBfg56HxL0MVv6yc+oWOFZyH4C51/oniQHjEsO4GTFZqM2yizJGvOtV4kp/5Y/H9Rmn2ahwDUMsHbeUUW6nkw1NXUAw2osLU0kRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rqeVwAjDAmL0icvHeaflp7HJOA7v70zKvPvKtVqZX0=;
 b=JemVbkD6ft8wLzryqw41fbw3M5bfFiZi9bjmp0r7WZVOqTPlnoFN21/8nEpApCuw1QlXeeRAYZLZUcVdi9acP0Ou3z0Epd96qZPkI5xoUjr9L/QdLA5/jDLDKMle382kYvEGa5c5AtvC7RkEZAtaWGneRtbQtDgdpvRZFvqbdWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOAP265MB8981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 18:32:42 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 18:32:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 19:32:41 +0100
Message-Id: <DKEO8W6FXG2Z.1YKNFY9CYZZN4@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>
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
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-2-67c5f326a16c@collabora.com>
 <DKE1Z4WT4K89.3QZI5FUEB37U0@nvidia.com>
In-Reply-To: <DKE1Z4WT4K89.3QZI5FUEB37U0@nvidia.com>
X-ClientProxiedBy: LO4P123CA0421.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOAP265MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: bae2df13-9e10-4a11-02e7-08def0c4708c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|4143699003|5023799004|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FcffCP9UUSpGB4P1WFNEb0Nx5/G6t67BBw1swXr1F1Q0sQ/nCQzmX5APQ5a9JNT62FbCtuE2Vz05iXVKamYnwrVR0qU/Tl4x5epUoQCXr0di3b30ConB6zBEyzJE+vtuXXq2W7DTjHrCewUqScH0QtIInMp6/e4FIz+8vwa1px3fRKi5wg1ukHZ68Tsfh5UKATAEemIP0aAj6v0TmA7ZpM4lsEuHukVcuf/v78al4Lzdxzkcym5d7f0Cj98iyk6jR3xREh7V3cBRy2kPStrE+VWZEnSKXStZH5iwZPyoljMC39Vd3/5JI38q8nY7TvQXfmSxp5nolYeeltG1iFDOQ+Kp0GCEhqMRD5FgbPr9b05MC8594xE/NhNustVfxYBDncWtaC2RJK6yJ7cERQPE8yZIZiwVgxQXWQLFfuoF1W1muxGl17brmiTq2OHeu/5VEwhgseBrAu5QQEM7CEMtnzLNZGYS2PRVdP6UpgjDEbUc0FGU3uuuo7kohvzTHet5bAZwxDsEpRokSX0BESQ5/c0lWqHJy9q3k9tffuGb2gT6GE1Dmc1Rt4BEBzZ3hKidk/ZjIdvuKCQID2LkBjqUolelB3e9tg7bzvElxrS5R5CP7cetBtTg1HI4zILZZ1uzfux6D4nOiNoU0BvJyYpwzCIk+C5SWCLYyHVC08Jmx4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(5023799004)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFUxejc4UnVrS2R1TTZDYWRUYzhjZDFTK0FpYmgvY2FLam83dVQ2OUVaN3Rr?=
 =?utf-8?B?SUJVN2R3V0tEQ2d6bVVDU280TGpFUGlVTHpYeUNIWHpMWlVUdDN0NXgvN1pY?=
 =?utf-8?B?dmQvOEhQMFJNa0dWT1hEcGRGalo5UDgwbEhKbXh4Tk1UQU1pMkdSSXJ1ZjY2?=
 =?utf-8?B?Vzlsd0xkNTZhc05DdlZESmx6WVpPTjhYaXFyVytBcDJnSWJ4ZFpHMGpCZzE1?=
 =?utf-8?B?S0p2enQ0UzF5RFduR0hjZWh2KzFhREFtZWprcTVUbGE4R296MUt6K0lJa1B0?=
 =?utf-8?B?SnlMUG5tN1hmMWhZbVhXUXhiY0FDNmczdWdyVURZeHBNam90VXJRMWNlKy9D?=
 =?utf-8?B?WHZGeGtsdjZadGJ1OElXU2dGVlFGVjFTb0NmZFF0eklxUGhLaW9NaGZqT28r?=
 =?utf-8?B?ZkNFTWRuRE9jdDk1SHRIZWJxMkV5Vnh0Q0IxaS9JY2FRNkVVOEtpSjVMOFMy?=
 =?utf-8?B?L3RjQjgvbnNDVlFyWVJPdVFsSTk2c2FFU2RpSmdIeXV2L1liUHRyVktXZ3Na?=
 =?utf-8?B?MmtHTG1lMHBGQ3IwVWR2REJ3VjA0RVVQSzAzbUpnM01vakE3RlNGUFFoRXFl?=
 =?utf-8?B?TTFqYUUvYlVaUDBCamRTSnRPOWFOWUxzc0VxZDBQTWRVVTZHZTZIN3Yra1Mz?=
 =?utf-8?B?NUZVb2hFVFNEem5vY3R5L2VVclluci9nQmloT3M3TjNxZnBpVk5DTXlUTTBS?=
 =?utf-8?B?dW1mRjBlZ3JsNWU4ek8vT1hQbG9Pa0hkSUV6RzBNT01mZVlzNWtwSXhaQmpj?=
 =?utf-8?B?dkhmVkJkUmtBMlY2eXQ3L0VXMmh6VElHMnVJZktob3E2bTVIbkNlT3RmdmZH?=
 =?utf-8?B?VVpxbG9ldHdwMTF5SkEzVFNVSW9LbURURFRSUkFQY3RaVUd0aVB3cWVneUU3?=
 =?utf-8?B?dXJIUnQyVmZJYysrNHY4b1pIclgxRUhpRFJXbXl5bE1lT2g4TVhicTZXcmRF?=
 =?utf-8?B?NFJlK21VUFk1anRJQ0VZZnZ2S3BlOVRCMXZMcG1JSjBIRFlJMmVLMW54dXlI?=
 =?utf-8?B?Z1V4YXVnNlR2b2xnN095WVYyeXF4VzlPMS9nNzNGK3hyOHRnNjNHTEpKZndG?=
 =?utf-8?B?RTdSOG44NWY0enl1aE9CV3hpTzBNMUtLU3dkRi9ia3NSWVplYzU3cEZpMlda?=
 =?utf-8?B?OFZPNVZZRTRTNDNRMWw0c0Z3dC95Uks3cUtOTDc3L21jVTk2eVEySGszRHhv?=
 =?utf-8?B?dXUxUEYxSURZdTJPUEowb2lGZzVOeTdWSktOdERJNFFJelMxdzdtajdaWmhD?=
 =?utf-8?B?NmJxajJPRDNYZmZOS2kvRHF2czlxZ3ZoY1RDVEM2VFd4SmVPL3haNUFsV3Na?=
 =?utf-8?B?UEN1UUlMaDRXaHZaWlUxQXNSQnZiN3VKOVFiaEk1c3dIbTVvTkRWTyt2QkQv?=
 =?utf-8?B?ZXFoU3NmZmVKOVZDb053MHhGSVlaK3ZpMmgwWmxWR3FDRW0vUittS3Z0L3hS?=
 =?utf-8?B?QXBMeEpRbU1SL3JVSUNGNWpvU21uL0FWa2JUTTNNbUNyUkh4MVR6dmFmSUY1?=
 =?utf-8?B?eC9vS1EzTERURXJGeExBWjBabkJ1NGpOeGRGVHJZZ0x6WjJGSUFMT0pMS2t1?=
 =?utf-8?B?VVBTOUR5TU9PWG9JNWZ5OHhhTitQYlluOFdNWFZOZ0ZIdG5aRkRHY0xaYjZ2?=
 =?utf-8?B?a1p4bUJyaEhISmNCYjBOV05CRnBoN01va2FMVEtja0hOZWc4LzBtNk5VR0xz?=
 =?utf-8?B?cTlVOTZvUDNpWVBJcHJpWUFvRDI4eW9qbzFwT1hVQW9NWmN6bGdDYTdPWUdU?=
 =?utf-8?B?R0w5VHhvN0ZaUGNPNjduYVZNWUZjVEpuWnZIN25KYVhoQSthVXY2TFFPS0cw?=
 =?utf-8?B?TUZlc1dNNnNkeHpxOFpJcjVkZHUrRzk4eVpSZ3BOQmxKVUVrNWpUVytrbWFQ?=
 =?utf-8?B?TmJzZGJnNFB6NDlQcEVpMDNqYXJOdzh5cjlETkRxaTVsa05KNXdwWG1jWENV?=
 =?utf-8?B?WTZCZXU3VUtyLzM4NVlIOHpjaGFPQTVMbVFNQTVmMW14UjA2TXpkSmoyN0VE?=
 =?utf-8?B?MHpHbVlRNTdsdllnNGM0d0M5OVZSckdKdGovVU5hS1AzWk9la0s5NFFPajFa?=
 =?utf-8?B?VFVIc2lqd1ZCZUVFUFpaWEozakprR05BWHNIL3g4VEpjRkxYdmVKZDRnVDRF?=
 =?utf-8?B?bC9hWGVCUmthSFpvN2lNdzhWaXU4eCtKYnBub2xBR2pZL0x3U09jbzBHOU5X?=
 =?utf-8?B?TnFQVHgxQUVxcVJNaFpWeVVCU0tvSGY4OUpWc1N0aGRVYkcvMjN0TnlmVUND?=
 =?utf-8?B?eUszZTdoTmNRNVFwVUlXckpla01RR0JLSzI4cGlHQ1k0VERqRXMxb1hsNThO?=
 =?utf-8?B?TkNmRXVRREU3aGF3dlFlckhFYm1mZlRZYjJJZ1M0L1g1bi9EQVlzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bae2df13-9e10-4a11-02e7-08def0c4708c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 18:32:42.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLYK/VgxWkujMsfu8rKczj323RNM4pJwzM1m1bLLG76j4QANjMREWlY9nSnOdOwxBUr72hVoSEX9ffRN0mYV+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8981

On Sun Aug 2, 2026 at 2:05 AM BST, Alexandre Courbot wrote:
> On Mon Jul 6, 2026 at 11:37 PM JST, Daniel Almeida wrote:
>> The type-state pattern makes state transitions consume the Clk value,
>> which means a single Clk cannot be shared between users that need to
>> hold the clock in different states,
>
> Sharing a clock can be done by acquiring it several times though - this
> actually seems cleaner to me when concurrent setting of a given clock is
> needed within the same driver.
>
>> nor can a driver keep a long-lived
>> Clk<Prepared> around while temporarily enabling it for scoped sections.
>
> Something like an `EnabledGuard` for a `Clk<Prepared>` should be a good
> fit for this? If you make it generic over `Deref<Target =3D
> Clk<Prepared>>` you could even make it work with `&Clk<Prepared>` (for
> short-lived enables) and `Arc<Clk<Prepared>>` (for enable periods longer
> than a code block).

This seems to be exactly matching my issue with the current API design:
https://lore.kernel.org/rust-for-linux/DKEO7DXQ8604.1CB09QFM2EO68@garyguo.n=
et/

i.e. the type state is used for two things.

Best,
Gary

>
>>
>> Implement Clone for Clk<T>: each clone is an independent view of the
>> same underlying clock, in the same state, owning its own
>> clk_prepare()/clk_enable() counts, e.g.:
>>
>> 	let enabled_clk =3D prepared_clk.clone().enable()?;
>>
>> 	// Do stuff that requires the clock to be enabled.
>>
>> 	// enabled_clk goes out of scope and releases the counts it
>> 	// owns; the clock remains prepared through prepared_clk.
>
> Looks indeed like something an `EnabledGuard` would cover.
>
>>
>> Since struct clk is not refcounted on the C side, share it between
>> clones by wrapping the pointer in an Arc'd RawClk, whose drop
>> implementation calls clk_put() exactly once, when the last clone goes
>> out of scope. This costs one small allocation per clk_get(), which was
>> deemed negligible when compared against the pre-existing indirections
>> in the clk framework.
>>
>> Cloning a prepared (or enabled) Clk calls clk_prepare() (and
>> clk_enable()) on the underlying clock. These calls cannot fail here:
>> the value being cloned already holds a count of each, so the C side
>> only increments the respective counts. This is what makes an infallible
>> Clone implementation possible.
>
> Another point to consider is that `clk_prepare` (and thus `clone()`, as
> you mentioned in the doccomment of the patch) can sleep. An
> `EnabledGuard`, otoh, would only need to call `clk_enable` and thus
> wouldn't sleep, making it usable in atomic context.
>
>>
>> The DISABLE_ON_DROP and UNPREPARE_ON_DROP constants are renamed to
>> ENABLED and PREPARED respectively, since they now describe the state
>
> Let's give them their final name in patch 1 then, since it's also
> accurate (and arguably better) even before this patch.
>
> I am not quite familiar with the client code that will make use of this;
> a pointer would be welcome. But I strongly suspect that multiple calls
> to `get` and an `EnabledGuard` can cover most (if not all) use-cases.
> Introducing an `Arc` here forces a storage decision upon users while
> hiding it.
>
> It sets us up for some dilemmas in the future: for instance, Maurice's
> series exposing `clk_rate_exclusive_get` turns a `Clk` into an
> `ExclusiveClk`, but its potential clones are still around as regular
> `Clk`s. Moreover, `ExclusiveClk` derefs to `Clk<Enabled>`, which can be
> cloned as per this patch; so is it really exclusive?
>
> So I'd like to keep discussing this design a bit more, with more
> visibility over user code. Maybe it should be moved to the tail of the
> series, or even extracted into its own series so as to not block the
> other patches.


