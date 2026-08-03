Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022125.outbound.protection.outlook.com [52.101.101.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9E4052A7;
	Mon,  3 Aug 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760345; cv=fail; b=dbJy2cQ0PL/DSA1mOwIv5awEjzF4jXKh2x4bpwIp4CNoilPb9D00a/arla6ib8TOoyfVFizFn4C1PDYuAiGc/AFSRtMp4xf+FB8uHwL+Mpf4Ivd+5rJ+XqJCVX6L8n6H1kUZFqGAUDK7qGude193B3SYO199fQx/ULKdrq4mXGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760345; c=relaxed/simple;
	bh=2zibimD1DLiLn0TvtvSizE/X4xhrgYC/XLRxJyUA6IY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=pCTFt6VN53rPlzLz6QunQA4HpFDgdQ7ob51I62ACbhgv967n0wBmGKXr5QufLinAuapuPuPFVaqXWBFL20I5nZPdZQ1CMPYko8fYabbUX2tP40/he90YPeT0WLr5ngk9e1ijlvEYyvzQwrNLHutsC3aAezbXsl9+hGPqY2KcPSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TlP93Qbo; arc=fail smtp.client-ip=52.101.101.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TlP93Qbo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnFrnKWjWGfGxlQu/B7tbbBZzHRa78+mUxZNfzC2qP6Drs0iqIzvDkQ+vn+FiV+EgIWICd4qOF/J/4A5I98Xctr23MtzJvg2cSXS+EGL3QU33DiT1orsaqrrFvIR0oUji/KjACsB9fg6f2kzmEg97qKtuv1OLjqafq0g5J+Ji41ThvN9G3eZRrXo2AWP+Ptt0mZsfAgmTwteYBTfMrtxvaqy5Wy222ylgvLnI0EmlIJ5WZEXqE1G410bpNjDBDp2c3ClGpO+WWSYvDPb8P3mJDt3SHYqb6b6N+1xLvn0v34oNJd2xx8CfjmVOYj+hDL3lIq/nxgE8QUieYOEwZxavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zibimD1DLiLn0TvtvSizE/X4xhrgYC/XLRxJyUA6IY=;
 b=TR4t388eLWprSEamIZhhC2AI1JLoi8QxfxJCeNVkNtk1nE0gzkbwrQWlz9YrR30x7F2WSWp2W5u1Krp/TL2fuPdGTcFaBQHdHPBcfgxX4eOpZQwBOgT+HjVMU3RvkDhpU6ozCYWYp4WG6RfyFLijtTUoJPZYCJQ2+tuDpeKzOR9vDfTfRmvskkStZVThylYNUFhEDRjdOZFZ6bWkx5ESSw1ZQPi0uPiLdz3SSUFkfaHwfJuI2UKolZy632i7ZVus/ebd6SnGqQa9ezGVg/0jyBziMOFGibrQcJTFAJzfsHu2TyHN4YNa1IwWOtgZPz+oqJbNzGTYYurJ87uYbkDnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zibimD1DLiLn0TvtvSizE/X4xhrgYC/XLRxJyUA6IY=;
 b=TlP93QbouNcrmb67p85Nln+Om947qaWPkOxNtxobUfP9yCCRUjqYBsWszPQk2lEre6akz2V6+SG9QpcQFahXV79yZjwjwAPjsPN1wIcGCsbpPt0r4ouMKDaQ6bRr6ZPkJl3dm1tZjoLpljfsF5SymgUjX6l95L6ouQpNEVRtAXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB1857.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:32:20 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:32:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 13:32:19 +0100
Message-Id: <DKFB7IQSSV68.AWEGY447I16@garyguo.net>
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
Subject: Re: [PATCH v5 3/4] rust: clk: add devres-managed clks
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com>
 <DKEO9XYE7EGU.XU9OHA368TC3@garyguo.net>
 <DKF09OYPH41X.A5DBVPSRM4CD@nvidia.com>
In-Reply-To: <DKF09OYPH41X.A5DBVPSRM4CD@nvidia.com>
X-ClientProxiedBy: LO4P123CA0651.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB1857:EE_
X-MS-Office365-Filtering-Correlation-Id: 480507ee-db08-498e-5beb-08def15b4329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|1800799024|7416014|376014|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	K3PdqvwkcPV+RtzrRn+tCWZxCGSaAjh/Dos43l0+3y5iD+FSE1Tt6IYDTU0hm+fe0yW4Tcko2X7sdjsG57IG8ucHUSKkLG3xhwRDReiI5B6IsxOxKCbpqO6hTBSJZPB8SSxdkvJk1dq6Sa5eiGTmokxc19VYVMvwIBTczwTfaWWIZvfS+VzgOJ+O1kHw7gHxRAWTEX/kk2Nkxjkz9ejU4cROu0x4Oq4+LgDajtMc6uKyljv6SENcC+DuLVbLs2chDbPBdVd8UJeVkMvBRG2skLTBt0zbAzq+dct7Qp7RJQNyr/ofxWggIoa/+ZQpWxvrKx5b+NA77OBki/f8rS/cCEfXk6XsJ1+SXT/QcyH1AmPurEaUU5skpXC7cH9vTyfYVX/nXWtdnsih+tMCuR1T0GFe1Lgj+f/JY9Q7RgDcoVEY6JjiGoOXyW1ip6zFCeIuGnHqz8TA2SVKb15cIk7DQSnjqOrtHvOghnUU1yoyyoHkNdZeyrPp1MKoUY2p0NTuauJplWBOZpVYxEhEfWA9LymME7g4RqpTei0OqhbmdSJkqjNqrmhKU3TKPBAdQY1wW3iBa58GWKTvrHD+K8O7EMUWBKnCxUZw5b8r4bXN9IlVzrbO/KaYwnoD0xJg+MRC5v0AzRRzAaT9ZtHJGLkAFkeT7qKbLKvP1NcWppHziII=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHlVRFI3bWNGWklQaGlTUGlvWHFZczlNTnMwa1ZIMHZDSWFQcHpFM1F1VEl1?=
 =?utf-8?B?Q1FRMTdKYXJrYzBDakRJSlBBVXdTNlFhSnphWWM5ZCtpbUJlbGFadmlvN2ZP?=
 =?utf-8?B?WUVmZ2xoVnJrZVk4R3k4UUh4OWhYWkFnbENKVUFWakdCZlY5VjF5VWlDcjlr?=
 =?utf-8?B?OWZYU2hRV1ZrOHUrbXRWRzhUZmlCQWZyRlppVVZQQ25wQnFZRzErWS9HWWph?=
 =?utf-8?B?NHpmN2ZQTXdYdGVXb3pPelNJeWV4R2JMQ1BwbGJBZklOTk9sQ0haandXcTJK?=
 =?utf-8?B?dDZjclBqZSs3MVloSlVMSXFHazRrSjBXWkZ5VTN3cTVZSUhjUTREVGxUbXFz?=
 =?utf-8?B?dmh5UEVGQmtvQTkweGp2OEVFektxa2VQL3pCUzNrVnNsV0NEQ2g5NDdwdTV1?=
 =?utf-8?B?dXZKSmtSeVRKQTdCcHA2ZStDY0lxUkJjVFRRVHBtbHlKUWFjZ1B3Nk05YWw3?=
 =?utf-8?B?YzREalNIeTN5ak5pUXFLN0JRVFp3dVZMUi9XZUo4YkVmTU0wRHpKRllQalpk?=
 =?utf-8?B?c0J5a2dDcldST3J1THlHdlNIbVRXYTU0dWRSZmZ0WlkrRE1QZ3lSQndLMWNL?=
 =?utf-8?B?WFAxU3JzQzRQb3gwdnlYWFJwdXVHb3JWc3dkL2tYTkF2OVNiZWFYWGJhT0J1?=
 =?utf-8?B?S0ViM3lwaUVWTEZWem5Cb0pDaW4vTjZjamFWTTNaS0VDenV1czA1V1FKQms1?=
 =?utf-8?B?QlZ0cytYaVFvUWVpZExiRjVMc25zMTdHRFVSMWNQeDEwZmI2M3dUejFHMEpj?=
 =?utf-8?B?WXUzaVNOMUM4ZXk4cnZpcjJtc3dSZTc0TWxGS21OUFA5WlRRS2J5OGp2M25l?=
 =?utf-8?B?UTVFSTFxV2Uwa0NMS1ljakM4Rk8ycVpmM1JCaStzdlJHMy9YdURwczFXSURX?=
 =?utf-8?B?MzZvVWhacU0wYTJvY3FhMU44azN3NkhZOUNhakk0K0RzQTBsdUNHS09ZbEVN?=
 =?utf-8?B?ZGtuUnJXeGJXUWU5RHB5S0FHWGthSFJ1amVmb25Va0F5MHpFbVMxZU5jTC93?=
 =?utf-8?B?ZzVlTGwxR0syT2xmaXlCdWdlM2oyR0JxV3JDMVhMTW5LbExzRE5Xc2phQzdO?=
 =?utf-8?B?VjVmRHRSRWI5VGNYdE5PYVc0TUt4NW9vUzJxaVJoNEo1VHV6WGtab3NUSGRz?=
 =?utf-8?B?Q01HU0Y1bzlQMGZmN2VTZjNIWE0xR3QyWjloMGNMSkMvZXFnV2k1d1o0MnI3?=
 =?utf-8?B?RUZPMDRvNEF3WTVNMElNQ3FvL1Q2SVpydFN0ZDVObnByWC9EQ3UyY2dMV1Vq?=
 =?utf-8?B?V3B2NmlYL0UwNGtsNENCMXFqVElBWDY2czVxQmhGWFpyY0ZZL3BPR2JjYlNR?=
 =?utf-8?B?dnRyTGUyOVB4RGE5RmVKUTJBdWZFQ0E0MHhlakVVWFVZbTZ3N0VKVUowSHVJ?=
 =?utf-8?B?dlJXcmdxcHZuUVB2OW9KZ3ZkYzlQWUFiU3JxVFRTM2h3Tk5YeHNyek95VE44?=
 =?utf-8?B?UGdsQkk2QVJnc3MxMlQ0amVJQ00wYkI5b2Z4MFA0SHdBSm1NWnRKMHNzVHVj?=
 =?utf-8?B?WWYzUEJzeldJVmF5bS9VQndHVnJsVHR1TFBWc1RhZGhnZHRhTGhMRldRU0RB?=
 =?utf-8?B?dHNvdHRJaHNoMjJNcy8xRjV3WUpMN0ZRMVlocElncFRWZ1RCZWZYL1ZCMmdN?=
 =?utf-8?B?RFJxRS8wc2tUbytMbVkra1lDY2IxaUc2eU4rb283dEhmWlNjaVZwNWo5RTN0?=
 =?utf-8?B?Wm9WZkE4K0hzNTZqbXBVZkh5c2hnNFI2Z24vd2lFMDFCUW1jK2s2QjZZZk1T?=
 =?utf-8?B?K2NuaW5mTmsxbUdTdWtmWkgvVkpUSTRaOUdWaWliV00yMHozS2Y1THNBWlgr?=
 =?utf-8?B?S1FiSW1nZG1ZcWwrTnRSc1E4QkNMUkk1T1ArNU56YVlReWJYOEwrZTh0V0RU?=
 =?utf-8?B?MzE4bGV0RkNESnIrNFBqTzhzVGZFMnU3dG4xYmdocFJBeGFyZmd3MUZjTG5D?=
 =?utf-8?B?SnNpdVFvU00vVDJZYUNpWWVKQ09DTG1Hd3UwMkFhakRjcHZ4NGM3di9Ka25L?=
 =?utf-8?B?UFp5bzY5VWl3QlR1NnNiTU16aUVsaXl4Z01zYlNHUXBUWkdqQ0tqYkZXakQ3?=
 =?utf-8?B?d0p4UndHRlQ3bHJsbmV2MDgrZGx1dXdhMG5KRFc4SWlId2xNOUZDa2tYcElD?=
 =?utf-8?B?a3oyTnFuNUJOcmkvMzJWbnlxb3Uyd295Ym8rVkswYnNtS1YweVVJeGZUNHZa?=
 =?utf-8?B?WjZta2MyZ3ZsV1ZPYWpIM1lOZlhiWVdIRGdBNUNPTU9LdXZJKzFjSXphVzFl?=
 =?utf-8?B?bFdIdDZWZ3JvOHcrV1hiSkNvM1UxYWtRb0prR3IvQkZkbEFxVjJsOTFKV0ly?=
 =?utf-8?B?NUo5TW5YRVVFMEMyTXhZQm9OQVo5OGhLaDNkdlI1VHUvaEJyc0Ntdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 480507ee-db08-498e-5beb-08def15b4329
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:32:20.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej0esxlzQwIJCihyZ+DZ2eQL8I8jClqqInNJMDyN6U3L4gCjNEUKAf31DXJ7pp3vyd8rZWWB5RZcVDvLgj3gKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1857

On Mon Aug 3, 2026 at 4:57 AM BST, Alexandre Courbot wrote:
> On Mon Aug 3, 2026 at 3:34 AM JST, Gary Guo wrote:
>> On Mon Jul 6, 2026 at 3:37 PM BST, Daniel Almeida wrote:
>>> The clk API allows fine-grained control, but some drivers might be
>>> more interested in a "set and forget" API.
>>>
>>> Expand the current API to support this. The clock will automatically be
>>> disabled, unprepared and freed when the device is unbound from the bus
>>> without further intervention by the driver.
>>
>> Drivers could just put the enabled clock into their driver data.
>>
>> Given the general shift from devres to lifetime-scoped device resources,=
 do we
>> still have a need for this?
>
> This mimics what `Regulator` does; back then it was merged with quite
> some consensus [1].
>
> IIRC the justification for having this was that it's a nice
> fire-and-forget interface for those cases where you don't even want the
> driver to have a way to touch the resource after acquiring it, and it
> also ensures that the resource is dropped at unbind time even if the driv=
er
> data survives it for some reason (for instance, DRM open fds?).
>
> [1] https://lore.kernel.org/all/20250910-regulator-remove-dynamic-v3-2-07=
af4dfa97cc@collabora.com/

I suppose we could integrate this with `DevRes` with a fire-and-forget API,=
 so you can do this to arbitrary resource.

I think just dropping `DevRes::inner` without running the destructor would =
do the job.

Perhaps


