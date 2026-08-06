Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF502BEC3F;
	Thu,  6 Aug 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024483; cv=fail; b=VhwEQS2573OMTLd53yuzf91VGPe2vaz0yTICRIIfM2cFnVc4MsmWBW7YgBKfcvDj6OiRGhjAG8ySS9hYAA5agXABZHP+IMWZRYlgkfclDISG1IGVCZhEzw8NM87oBQngJBv2jh8Sr9uq7vVAD2Lg2fFRkg/O/RoxVrOLmZ3J4/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024483; c=relaxed/simple;
	bh=hrwsktyehp58cJh2GuG6hWiGFdKRr1tUbLCM0SjkXsA=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=QpNs65vEvL1ul5xatgk1G/Jutt8PoMTQ+w+wfcc20BbDhP8T3GC410ehElOrEez9lv2qQnJdoN6HPLyjO78GZQ9adc8JDd6dIX6VnWB6Nm0BQRXxzKVnigGs7l2/Afl9WMpP56Pe9tYSkI8hi43n/cXjogPwTBqz/5jV2uolhk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8XOuHke; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8XOuHke"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSzE+TYbpGC0CWP+FWYcHrAy2ydE3Ai0Ki0wRvw7tx73WvFEh2+KFRIrGSe3eatuvRVUcvrggFIzNyF3sSsuFf79WTvPlXUEEA4MoancBV/0G52ShjaZGeEI/HoiWXjMJORgXCzKPFICbbBk7ceGQ4/PPtEZ/qgaPNLrtxc5Bg3HyVhtLTlUfDTOOSZLZClkGLwob+YF0nzoGgvU+vYdjSx8QgNftSzWlOcfjzfqx09hOSTE+clMqKsCSE47svcCPyzHy5es7lIuIMKZ7jHVk4xfTX29npEZjfhF2ISRvDPf+FSLaxIW7o4zJJMldBeGffCjCvq11wH4pjHgWPE3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrwsktyehp58cJh2GuG6hWiGFdKRr1tUbLCM0SjkXsA=;
 b=TI4QX5Dritqw68s/7PHQP2dVXx137RavN+pxOPqu4MT/NYFumKuds7dFtEVnK1bGLv5y98EB7IXVhxfylIkI+zwr3b7w9aJZ7Jqh86HtaBcyj9CqaxHWFaYO5oyG2gvmRT6XkDfjutBiNIr5TUmEWlzbpXaSYhqgc5QpWP6AObuy7fXkaTctGjsA6xyha3iqb8NrPyAaSutzjXxk15Q2W0RxRbXg1tw35OAus7KcGzdmuJ1HaLR14hBkCiMCe6reXA/DEpoIQFy6w8JkvKIPiX3h0uYLuTFc1Suy0+fxlTqGftEbPS3oZk56tZ2NdW+NDFJHJaVN2LGpwq/Szzdv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrwsktyehp58cJh2GuG6hWiGFdKRr1tUbLCM0SjkXsA=;
 b=H8XOuHkeu+snTkU/XNg1NTegV+A7NlKjvtTuhZ0uwIbVx47iHRujwY0cRe1bMOaqYeR+4V72X4ILw81g7zKaiMDtebfWqIKUkt+h48j885AjpH9K7Q4J7O4gXc2uz0zbb9h0bWyLN7XYNRNUBRFMO2oauhlcmL8lCCsx4OrQ+3htCoETjhuyZPwubF5ClhpL2ijLMs7bmNAXQt4nWITUUdk8p/5BMSfa2KPIwVr57+xVKJ9C0OSWjafMBLOs+aOV7BEKg0t5TRONZzIZ/bJ5lugJqnT/ToHSGPdgcMWeks/P2zHfgtDjVqv9O45U/S7+iB8aKfvn9Mad2thKNhSB3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 13:54:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 13:54:28 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 22:54:23 +0900
Message-Id: <DKHWTZRKI3NV.39TYNLA5HA4HS@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
Subject: Re: [PATCH v5 1/4] rust: clk: use the type-state pattern
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-1-67c5f326a16c@collabora.com>
 <DKEO7DXQ8604.1CB09QFM2EO68@garyguo.net>
 <DKF0BU8N7JJX.T802R11VZ0A5@nvidia.com>
 <DKFB5CL2I1FO.7ULPVEF0VG5Z@garyguo.net>
In-Reply-To: <DKFB5CL2I1FO.7ULPVEF0VG5Z@garyguo.net>
X-ClientProxiedBy: TYCP301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: afd3b8dd-3ebc-49c1-5eb0-08def3c23b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1LmhdrGKy7joZdqOuKP5j0dya0y93eTcxQstzreVuQUCeZTHMvRomX5xsnbyOBRPrMLgNbGooXaFOF9lDNrUCycD59O9W6eBC8Y2veAR2vwwBW3YfEy9cC+WdMGDTGyoOEkFapNNFxyjAhm0xyjau0uH/zw2gmOFzi+0B0f4+f4FMxNo3oVgReLH2BfGxrylBdMVGfqcmNS4Oa3sdYuI9RrSR1AlKe1yTr5trQz6ln0diDo2SLP48DN7lgjrHSjDoMypLzQ+ymeSAGyePZgCtDmCc5YhrvpAVFpKku6AiFJYCaSAYEN1aZvOy50/ysPU9V3zb0h0PoZjsIm/ierm0eiI2b3eGh0jLmFrYGraaSpZIWhZgwCgBPBsJ107U0PY617JGZWM+zk+aKZy2/BQU/MJRsUfOZEPXvVnhB5bhVwArpryPAqIBU+8oJp2i+I9I3iPGTB+EwH40RcUsuJaWe5FV1cKW2JJCdGAn9o9TaENIPMeoRyZVOHgfEsZfLDpXLZUDk/BduZ8uZJjx7mDk6/hv7URnBcmFB+MsT+jLpYrZ4eMUKnC+GavOgmbScSpRWEZiYyLHS6jp1kAL3z40O8rHOg9P2psT03xVGKobGjKNrIhNQt8Z5MVcU0CBA8fdDVXZfAo8g8TH5yeX973AhAmKT/90KsjXOlRWZLZ8pw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTRqYml0eTRpTElQbW5lazVOcUQ4emtYc1R2Q0ZyU3NmMG11b0RNQ3VNWENN?=
 =?utf-8?B?U2t6ZGlCUU9mT1FVZk5uQ0V5ODZaamlUdVlNclFQY1EyUE9IZmFtV2lra2hB?=
 =?utf-8?B?azVqUC9xSkhtczE2VHdDUGhrUnMxNjFmYWpDTVZHQ1hNakVvL3NhTlZsTHY1?=
 =?utf-8?B?V0dNMUY3UWwwenNhd25YblRjbXBIc05adUNBa1R2SU5CYXpTemVEREdzeXAr?=
 =?utf-8?B?UE5SV1h1UlVJQzluMUgwOGsxTGEzU2s3VXMrWkgxcWR2SmlPQmpRSTBCMXhl?=
 =?utf-8?B?SnBZNUNDaXZDVVZDYlFUTlFyd3VqRzJOWC9DV3JxQXBuT2VGMlB2emdKdXRx?=
 =?utf-8?B?WGtaVCt6NjBoUHZ0VE1vZ3JpMC9CcE9nSVdJaGp4WFgySXlWeUVvYndKRTFU?=
 =?utf-8?B?Qm9qRVBPSXM1TEJYWkI4T2M5L0dCbjRZdEZFWTlWbHBJSzNwWGk0aFFTZjJq?=
 =?utf-8?B?Ri9wVDl5WEs4L2JZNTl1bjFFVlk4VlVUU2Zack9ZZ29rRkljRFU1MzB6NFZT?=
 =?utf-8?B?RkE4VXFpb3hNcjVrazhwOFd4eFNiWFkwc0JzYmtMWUpaYlBMOExMdUgyTG9n?=
 =?utf-8?B?QUFQdVhtVTZyNzVpdy9tZ3hUYUJKaGh5TDFpN2NsWmV4T1pqZTdmZ3ZlZWor?=
 =?utf-8?B?ZitOZFVWSTEybTg0RjVidmI4OHZ3MW5BWnBnVzFlVkJWVEI4TnNuWkNmeFRs?=
 =?utf-8?B?OUpnckI2Vys3alJqdmlhTUNFUlUyOG00Vy9kUWdGSk1mR09wSVBnemFmYkVZ?=
 =?utf-8?B?c0ozYVljcEZ0VnloMDY1SlJFUTVuL01lWDNBK2NqbktLUkxKUzgwK2lKRFN1?=
 =?utf-8?B?VVVMWmRCWVV3akN4bSt0Zkh4ZDN4UVZyNHpwMDZtb1VRUkkxejJOY2JrZlc3?=
 =?utf-8?B?M0NQTVMwdG9xbjcyOXRKdGU5QTg0S2tOUUV4UXJuQUcydXh2WmJMSGczMzJo?=
 =?utf-8?B?aGplQ1VZUUxMeXAyb1N1RmVneTdhVGYwdjQ5dU5aZDJwZWcxbmp4blVvOTN0?=
 =?utf-8?B?aXU3aWFnaEZJaTc0MVBVWjl4V3p6ZTBwb3Fxc0U2clFLREQzQmlWdkVIUFhW?=
 =?utf-8?B?aXNxdGJPYkRhY1Y4cmRCZXRIcy9BTFAwNjF2SHFZOS9iZ2xRNnZycDUwMHRX?=
 =?utf-8?B?cnhGK0RwQm13S2dOaG9wUGVVd29wbGtqbFVxaC9wTFV2NkxsVDRPNThxKzdP?=
 =?utf-8?B?STlsTVZyclBlUVQ4NGRtUHI5VTJsMDhRWW92TlR1NnZPb2hnQ1hGTlRxZ2JM?=
 =?utf-8?B?QkNWV1pQZ0xtS3crL2JRcVVVKy9OTU56ZHVoeWZiaVJPNlF2blA0T1NWWG1C?=
 =?utf-8?B?VW4zZ0tWMzR5a3VWNHI5TXBJRW1WdXhNUXRMK2RWaStlRHJZclpPeVl2c1pj?=
 =?utf-8?B?V0JMNk9HdmJRV2xCVGo0Znh2WnVRUzdTSnV2eDM2TnpxYmxvRmNqNlhqK015?=
 =?utf-8?B?bnJJTjFuMmp5NGhINm9kNVpzWm5HdjY3c1paMm91S1U2a2VIcXh2azVkSTFo?=
 =?utf-8?B?dEFqRHMrUlJ4QWRaTkFPNTM5OThlT2FJejJ1NUkwazBRQWUxTWwxWHBGYVk4?=
 =?utf-8?B?SGRLa0RncTVhYng0NU9YZnZEZlFsODE5Zm04UmRZZTJPcVBOU2U1ZEFkSTJK?=
 =?utf-8?B?T1BQQjJxd2phM1RxcHF0YkZzTThyME1xQVdWVjY5eXpQOHpoMWZzR1d1TVdh?=
 =?utf-8?B?VUJ2VTJVcmx2YmlaQ0VkVmJ5T0VCaFdnN3dCNG4zSmxQWW16UWI0cyttMnFq?=
 =?utf-8?B?YUVWUjd6MjQ4dUZsVktsOVgvY0xybUZVRkFIS3Q5bmhlSVdqVnpXQ0tsQWZE?=
 =?utf-8?B?Sjl5YnNrVUhmeFNKbnFEZXp2ZWR5bk1jSkRaU040WFlNZ2p3ZWdEa1FDaUY0?=
 =?utf-8?B?dXArL3Y2eHBUZ3FFS1RIUHFKSCtJUzFvaFExbzhpVnQxSXg5TS95dmkrY2sy?=
 =?utf-8?B?ak81UlNvYnZTbVJaUk9uSlJDWkUxb2FtZVRTZjJRZWNmMS9UajBKaDZwNVlD?=
 =?utf-8?B?Q1Q1ZDdRNEp2WllQWHJEZTZ5SXFXQUpJMWJvNzh2QjNJR2wxTVlPYlA3ZUpo?=
 =?utf-8?B?U3JjN1JnRENWcEQxVU1DTWNyWDFXK0ovSFFWZkxRSHAwWUNrOE5paXNuSzVM?=
 =?utf-8?B?TFdRTEYxcVlrR09jL214WVZtTzNQQ291NHRFaDYyZWZlR2p1aFEyb2JDYmdU?=
 =?utf-8?B?ODVNSE9udExVMUEvendsT2JFc1BPUktLQkJWUjdlWVRKRnRxcTBndjZLQkov?=
 =?utf-8?B?Vm5rM3FxVkNBRXFkRmRkeEFYTitWd1hlcm5zUVFiNVQ1TUlhNzUxeG1FdkRQ?=
 =?utf-8?B?dWtyZU5TK0c5d00rcGU0M2daMGMxdDZqUjNFUmZsM3IzQmFGYm1tQS96WXoz?=
 =?utf-8?Q?9CCViQv66hogwfx91K2AGZ8AtPef9Bim1JXyP2eraeqaZ?=
X-MS-Exchange-AntiSpam-MessageData-1: 9AwZV/dT3LeRng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd3b8dd-3ebc-49c1-5eb0-08def3c23b45
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 13:54:27.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7n7xzSyHig7BYX45PVju3HxUP7lN1pIh2WzFS9uZ0L4dKT3HDOHGW62ZIW5nvKEIiPFle2yofjzcs42PkJFsvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

On Mon Aug 3, 2026 at 9:29 PM JST, Gary Guo wrote:
> On Mon Aug 3, 2026 at 5:00 AM BST, Alexandre Courbot wrote:
>> On Mon Aug 3, 2026 at 3:30 AM JST, Gary Guo wrote:
>>> On Mon Jul 6, 2026 at 3:37 PM BST, Daniel Almeida wrote:
>> <...>
>>>> It solves d) by directly encoding the state of the Clk into the type, =
e.g.:
>>>> Clk<Enabled> is now known to be a Clk that is enabled.
>>>
>>> The design conflate states with actions. Our existing type state for de=
vices
>>> don't do this: `Device<Bound>` means that the device is currently bound=
, not
>>> that dropping it will unbind it. Yet, a `Clk<Prepared>` doesn't mean ju=
st that
>>> "clock is prepared" but rather "clock is prepared and needs to be unpre=
pared on
>>> drop".
>>>
>>> One way around this is to mimic the "Registration" pattern: have a type=
 to
>>> indicate that a `Clk` has been prepared and its `drop` will undo it, an=
d then
>>> this type can `Deref` to `Clk<Prepared>` which just mean a prepared clo=
ck.
>>
>> Just as the driver core hands over `&Device<Bound>` to a driver as a
>> guarantee that the device is currently bound, so can the driver pass a
>> `&Clk<Prepared>` to a function to assert a similar proof. Here the
>> reference only means "clock is prepared", without any action implied.
>>
>> The typestate has real practical benefits, as unlike `Device` which has
>> a well-defined life cycle entirely controlled by the driver core, clock
>> handles are owned by drivers and their use can go all over the place.
>>
>> Driver A might want to enable a clock in short bursts in order to
>> preserve power, and keep it prepared otherwise. For this, a
>> `Clk<Prepared>` with the `EnabledGuard` I mentioned in patch 2 would be
>> a good fit. Driver B might need to keep a given clock enabled all the
>> time and only change its rate, and thus will store a `Clk<Enabled>`.
>> Driver C may have different PM states, and can encode these in an enum
>> where relevant clocks are either `Prepared` or `Enabled` depending on
>> the variant.
>>
>> Mandating a registration-like pattern here looks a bit overkill to me
>> and I am not sure what this would grant us. It would definitely
>> introduce some complexity: say that you want to keep a prepared clock in
>> your driver data, does it mean you need to store the `Clk` itself, and
>> then its prepared guard, which references the `Clk` in the same
>> structure?
>
> You could have the `PreparedGuard` takes a reference to the clock, no nee=
d to
> store `Clk` separately. We can have a method that gives out `Clk<Prepared=
<'_>>`.

The tricky part is "take a reference to the clock". `struct clk` does
not have its own get/put counter, so in order for the guard to not be
constrained by lifetimes, we would need to add our own sharing
mechanism, which is basically what patch 2 of this series does.

My main problem with patch 2 is that it adds additional constraints
(heap allocation) for a Rust driver to keep several references to the
same clock handle. A C driver doesn't need to do that; a Rust driver
shouldn't need to either.

The typestate pattern of patch 1 is nice and simple, but it also adds
constraints of its own to the C API, in that a clock handle can
contribute at most a single prepare and a single enable count to the
clock. Patch 2 tries to work around that limitation by adding the
reference count we wish `struct clk` had; but at the end of the day what
it really does is create another indirection for clock handles, and each
of these indirections can still only contribute a single prepare/enable
count to the clock.

Adding guards alleviates that limitation, with the caveat that the `Clk`
that provided these guards cannot transition into another state while
any guard exists, as the transition methods consume it. And these guards
cannot easily be stored long-term - not without unsafe code anyway.

So after sleeping twice on it, I still cannot think of a design that
would solve it all. But I sense that providing both the typestate and
guards would largely cover most use-cases until we converge towards the
perfect fit for the C API.
