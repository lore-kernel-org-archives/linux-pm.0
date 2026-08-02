Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020119.outbound.protection.outlook.com [52.101.195.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BB1F2BAD;
	Sun,  2 Aug 2026 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785695648; cv=fail; b=bPScgDJZkdzpSlHxRDOTIYxYZlrs0J0lMP95nhGBLcqZYYYO2OEJ55P71NOvi2TVmbjisEn/1jgXv2nL+FhG/Pyn9y4Ts+QSAX7FAQNWF/ML3K0Yd4VYbAQjR7Wt+Mymn4xBviewBbrUas4eb6r+FasQ+XpUFBt9k/61oNSOzEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785695648; c=relaxed/simple;
	bh=dRJ9skN/B49v4Cw9s2xA708iQqCYUG++aC4P1jmwY8g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=rD063XoHPeXtwgCZRFJ7SaGfkhOr0psdwX/0nRfg88WQMFLnkHUUTnk/pqr+d0xTEPyVBfg3T8yoH2YXdELfCdXYwr+zeGGM9F4CZ/hlz+1k3qombjgBC1z25oyX+7dEl4a5EBSjNAOu1CHq9jDzf/UVkicDEs81Z8Tbh1e8SfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=I9lt/mV6; arc=fail smtp.client-ip=52.101.195.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="I9lt/mV6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTy6npGLgY3n+ssBbnQ6ToBaJ13AGElEXZo7d4BoWetgAiV2DFKLq3zCpHjR2itBv0tewInFQUpB1eEE8k9L/e/+ShrzkNbPuzhiSIWv9+VsGEU42D0AY1B9i3PI+2B/gh8iOOzZb+fJtp2n+GiFEOyX8+a/OJfBFViO32YZdsAUvE6G/2z6aC3PjXhGfnvc1F3pBNCXolZ4hYe3Z/+rVHl+V+yVvLgcJMR0umJh6TZ6ftHk86cNTeXmHpRVWweqPYcC+n1mrANV9xUkehFp/0TfWpcIF/9jsu/hGWOOSq2pgwHq9GF4rO5+i0mcdS8ONfR45pAdqPyJs5Pku7OtZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRJ9skN/B49v4Cw9s2xA708iQqCYUG++aC4P1jmwY8g=;
 b=a83r9wEEVgwpK4C7hJde2w6KNadew1Oq0TehqCJWMAtkc6JO8GSOAoC13Stph68aA70daOG2Z1XcCtOt1lD0Vx9dbTk0kUepXPosUDFhVdCWHfHmrUvQPFs5ntcUxEqtc1YEjBjxDXId+sTCsxBVX9sR854bFfyOkxY0mhWktB53692BU4Z/s3ptAthfwIz8AnfS1hap7Iv5OsF25bo9fdttzaGjQwdr5rRdPRAwCLpzKxofwGXav1OPrwRROl4cDg4OReMTc6dfS+DXrMRP+s9CYdlRQAyZBO4PlXlxenAbUYGWCeQWLqWx8Pi46Ec4tQQKGmQnq2tRxchwq7RfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRJ9skN/B49v4Cw9s2xA708iQqCYUG++aC4P1jmwY8g=;
 b=I9lt/mV64azlnUJAwL2VF4b5sRzkDAyIqCJdBdpwIKz4//yO3bxQH+aPiDj5ZcVtWVgMerazYVtvdwALk5KYSkhVY+swZimp1jDiKC82BzVzZ7NNDHme6EiUMEatb91GNIe5z7bGslgPHGD2fXz2yeB6lGbBD1FjTZ9BHdLRWEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOAP265MB8981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 18:34:04 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 18:34:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Aug 2026 19:34:03 +0100
Message-Id: <DKEO9XYE7EGU.XU9OHA368TC3@garyguo.net>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Maurice" <mhi@mailbox.org>
Subject: Re: [PATCH v5 3/4] rust: clk: add devres-managed clks
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Boqun Feng"
 <boqun@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
X-ClientProxiedBy: LO4P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOAP265MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 936826e1-77a7-4904-3b4a-08def0c4a197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|4143699003|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	EO+zAq5iuhAMtc5mbKEEFMmMYCiQvBPOL49ebDdYxlNbHJcuaMsy4m+HU+juKP84Ib+fwv3StNjJwfEkrHcENjzjy53ZSfb8fKAgdY4Lfi/kaoE1mlm+Ud6ARE9QDJCkSyMO3GG1NcnXiWuGv2ylRKRzDWT5pA8V//72Eq6unJR2SDC2GicbBx0+vt5KDs2qvdxc+7AXzU4JSfZHN8nXY1vUCseEPaJua+YVj9z2lhj2/iWRsmAgSx1AtDuSR/3LukAqJ2kiCzqkJcWPXMDRPr3nnlM/n3WbQPjQYwnMkvxymFiDz5CJE2HZ+WmLN7rRgUmqJ3x96pmzq0HDEuMOFzzrttDiw1XRBN/ZVZFFH/RXFWkNs4stl4g0QHIcn3zIMiqPj2wtwbbgj6VZudCNBvbAie+44gw2z3Z5lrEUzgzX7AEV6ao+mwQqbaBFXOJ4LnitHJDV+BT/O4Z54J9ZsB3uV/v3LhdYaUkNIpPm5//aq0swVxdKt8N7GZkMgneuTA5HP69n3eCeAtaFZZ4qqOxru/YLHogn+/0nAXJQ2zzgzlJ89n225A3XvXr3EChmqQSq5feMmdalq2o6FJcuJPy6Pn5JpkkFe3rtMeTUNiN2rzFJsbuAQ8EyQvN0bwpzKW8gwO6WTYz6x4xmeC0qrUu5pmZJP1br/2gHaMPqmj8zkOycMNlhZELG3B8npVneHJ1+fWojrjiWXv9A5mk1gQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFZBZ3YyaEZIWFRTeERRNE5pdjhUak9BcFY0YjhxWGx6NjM3L2xzUXZVenNa?=
 =?utf-8?B?OHpCZ2NlZmg0MEx6ZmJ1WE9nZGZKUit3dDZ5UXVXVTlQenZOUGZKdmZjOE40?=
 =?utf-8?B?MXZoUkUzc3BQeW10SEUrRWxzZHVMS3J1RXRoZGVGUWNUT3M4WHE4OHJEaHpN?=
 =?utf-8?B?SzlzcDZXWlF6YXdtQWFycGI4UVd6N2dqR0NSRG9idXVUd0FZM1A3K3VoRFFy?=
 =?utf-8?B?dHdXZEg2U3R5ZEdBc3VjNWZvdDl5aWRrYmpvWTNLTkhxWUlJbVlEQVpVV0xw?=
 =?utf-8?B?YWZlZE1tdSswZEdrYS9oMGlxY1FsQ1NmK0NON0MwRndCTDNDQm9CRk0vMVBO?=
 =?utf-8?B?YzFYalFDaWN3YkY5UlZWNU4vM3VvY0FBaVJ4N3hLMC8vTWx5TEh5di9qcHhn?=
 =?utf-8?B?YkZXL3hSS2RQVjY5eEtmMXVkUTV6ZS8vYzBBem5yREJmWlROVHI1RE5Nenp1?=
 =?utf-8?B?dHRaK3FZWlVVVEFpZjRUY21FeUlRUmoyRVhIKzdGL0dXNW0rTVdlcnRmNFUr?=
 =?utf-8?B?RENoaU55dGhHamtkYmYveTBSbDJNbFRNZS9xem4wTDRCM2xCZ3N5bkNoelNT?=
 =?utf-8?B?NHVxdEJWYnA2WmFuTUw4aEFGU09JOEdKcjNwc3ZpRDhHbklwazhMdzlZUWJR?=
 =?utf-8?B?ZmVtT254TytUVGJuNVFJc2hmcTZiZmtPdzlFNkpVWFBZZ1NFQlAzUzVWK2tY?=
 =?utf-8?B?ZWMxUEpXbDhKZ3ZOcXhPa09NWVRzZmZWRkJsVmcxTnFxTEtmWVZuSXRzS25V?=
 =?utf-8?B?KzV0TDVyRlJ6RGdhL090N21HZFRySTRpVDloYnF3WC9lZGFhUkVpbkZrWnFk?=
 =?utf-8?B?M1RWa2RyU1AzUTR0VzhZMldJM1NYZEcvbk1GS3dvWkRZeThFdStieFJkUC9I?=
 =?utf-8?B?NTdBenVBQitBSEE0OFVpQUd4UmlpdDBTbTFvZHRwWHQ3MTRPMFoxMWdSMDNu?=
 =?utf-8?B?SmpmUDY1WVVGS0NzSjZEemlBY0FNMWE2L3l1d3lFRzlTNHNVS0R1ZTBiY242?=
 =?utf-8?B?MHVZQUppQ1d4dUNUcXFiV3FKTVI2VndZTHQ1MGJLaEt1UURhWGFqeUpyeUI0?=
 =?utf-8?B?dzRIODlSb1YwOEdpVXNoTWVONnQzYWVjaU4yY0tBWHZjQjllSFpzMGpsd3Z5?=
 =?utf-8?B?WFp0VkU0VmVuWTA1Yk1nNTUxT1JsRmc2UmZ2QjhMSWx3Rzc5dkRqa21uNWdh?=
 =?utf-8?B?Q2JOMmxYdXhlbHI4c0w4d0NXTWdwaVJEQy9KZlVJWVQzN1RUTmxvdlBMWFdW?=
 =?utf-8?B?eVpaZ1ZyeWV2YkxKcVpUMW5JMEFBakhTMHRaaSt6Ym5UTCtBanpFK0dUZHA5?=
 =?utf-8?B?bjY3Z3Q0UTR6cHBSOUowR0hLYXBqUVVPKzhvUEE2SUk1M2lYSXM3V1ZRMFUz?=
 =?utf-8?B?djFwZkp6NEh4Y0xwayt0bWsxak12My9COGYvV2hKcEF5elNVR3J4b2VEbndl?=
 =?utf-8?B?WFVHU0ZjSGt5SkRaQUhvQ2hUbUI0SEVlcHFYeWk5dUlzbk0weCtBZm5uUEZJ?=
 =?utf-8?B?NDYvQmVqV0o3T0pOVGNwWU5ZUFJ2d3BqaXY2UGJpZ2NwQ1F5ZEpyOEF3Vmh2?=
 =?utf-8?B?bGhNMkdTU0lHSm1kd2xuRU00MThjSkx5enYyZ3IzRTZ0WVRWVWhXdW1yVmlu?=
 =?utf-8?B?b3kzd2c2SjUxZTdKMm9WTzZTRFkvK3ZLY3NIVW5oTnpVeHpjUlppOGhsV0FP?=
 =?utf-8?B?d1FrZUxrVWl4OERESEFxaXd6UVRaMU9WZnRGV2FRTHladHlIR2c5VUVWYmla?=
 =?utf-8?B?dElpQU8yOWxBMStUd3VYTTNlRTFrWkRJZjU4K0ZKQUdZSUw4aUdVbFZGU3M2?=
 =?utf-8?B?R0tYT1RnMis2b3JQMkh0cUg1V1RWZ2pRcWpnQUdCVFFCbWZ1YUprSHdRN3FD?=
 =?utf-8?B?TWt1R2pkM0NDQ0NSQWhwZG50VzEzYXYrdWZ2cXRGcVg0dWV2dUdoazlkRmJu?=
 =?utf-8?B?V2lEckRyTGlxWEltcUpxVVRuUEEyM3poT0duUm1tWkltZ2ZUaDhFZnk5dnBp?=
 =?utf-8?B?ZWs2VmVVcithOWR2dDIxeWlrc0N6WmdoRWh2UDFEVFU2UVU5QklTQU8xdHlM?=
 =?utf-8?B?OEtXZnFhaGV3MWdSZTRIRzdyeHlWS01hRGlZeEg1NkpJV0QyelRvL0kyZXNT?=
 =?utf-8?B?SFQ1dUx1MkhYY0ROc2FDeEkvN0hNZ0FscDNTOHpGSFdwa3IzQjJXT2FxSnZm?=
 =?utf-8?B?SnZhNFAvN0tSMGlTSnJvY3dPMmcydno2ak9VZmZhYWlwVHBhaGpRLzRYNVVk?=
 =?utf-8?B?dmJrSk5wVXdHNU5XNmpCdHRudHBlR0VNVkFjaEw5VHFXUUFkeU5sQnkvRFc5?=
 =?utf-8?B?bWNkV0RjZ3ozRXVhV0pGeFkvUmQrRkt3NzJTYTNpZ2V5cVhReDc4Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 936826e1-77a7-4904-3b4a-08def0c4a197
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 18:34:04.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5jsg5i/VZdXh16E/YkehO7LZ2Oi0rV/UTjp9HIpXjVQuPKLLObpCRjZmqwj6Ck8UFhC9CHZTK3ABbBHTCcuMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8981

On Mon Jul 6, 2026 at 3:37 PM BST, Daniel Almeida wrote:
> The clk API allows fine-grained control, but some drivers might be
> more interested in a "set and forget" API.
>
> Expand the current API to support this. The clock will automatically be
> disabled, unprepared and freed when the device is unbound from the bus
> without further intervention by the driver.

Drivers could just put the enabled clock into their driver data.

Given the general shift from devres to lifetime-scoped device resources, do=
 we
still have a need for this?

Best,
Gary

>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

