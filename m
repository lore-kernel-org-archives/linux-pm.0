Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012070.outbound.protection.outlook.com [40.107.200.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B938F941;
	Mon,  3 Aug 2026 04:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729656; cv=fail; b=V0681xLnLnt+7F+Z3lDh+9WqRHnNp6xvdfsdn4F5AyBw7D0QFkNBaAqm5qFwSxyjk/TAuOPYOgUSbmbarUAR18q01+xWu2OkC02+RGait3A/YpNrrGSwJpO6UBe3ZGY0VCfB/SzKcBDDKNOwZKCNiiczmMcMwcThx7WRTaNWMnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729656; c=relaxed/simple;
	bh=PtVd90Gazq4Unm/j9/t8yKYWe2a5TkCQYnX/iCdNxxI=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=ucFZCjGIP4SwO3pDvZL/UzBQvI/45KlN3PqPY/6W4W9Vc0ysnV4KuhmVbk1UQkpZfrcPRUgmnMpNO3J7dYB56dOfg6QaJpmvn+2fcSuKbNRW3VPs0QjmzNmLuID+XH0G/JppNox7m8+m/p5+9vnAFiGzfM6APCo4FRhSEZq0hBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LLOB84qH; arc=fail smtp.client-ip=40.107.200.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLOB84qH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja0UzfWclDGM7BZRYdfhZPzfnSLIE398rR3EEBBJDCKZAPXCkyUsPDm1qvoDL7dGUpqr+UO+l1Wxlw3Axzq18mHNM+T6C6yGlAAJygpoTN4Px4QIC5MrIxHDwyg7J+ywnmzZ4Bb0iZ6jGxZhI+FDlDj45nnjCus6N5Xrvl2GNhstZcR1Ce+D9gBNrlD4i3ZQX+dz1xwkFCEPaH8PfDSQj3+ycTnvpfURuT8C7Yn+eAw9EQmxiEjtYBB9Iu1GXtn8p1g6aTVTvcgd7olI4gLIWmMPk5EiHIml/CaGNDvcLyrr5XDCrf0xNWR5FLZxsNKH8yiN9MszYj8goDjd/Qfi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtVd90Gazq4Unm/j9/t8yKYWe2a5TkCQYnX/iCdNxxI=;
 b=Rz5ccnbUUPbyPBmsLj8tPbfIrokNwHxEbKqD7oSdqjEsff9m9cgwmTtCBNintyIF+OpX8zv/Jxlc1uci2PVCtU5JSYXmpmcHZq9g35/wyNOCsMng5cKMGqXHkyRf+WtWkXxOY12Vj4EcJZB1PH2SAoD5bK3eACCEkjGXIePgRcg3IfUINeN6vnrapIzxoCANSkoaQoMALGcSKW+ysetbzbLqSoxhK3KIl53hvWIsM9SNRwGW7HUDIofPBZ2bno5w0ckDvL+z2rBN9DsoqOHfD5PuK48YGWM88UHnrSKN2TcH0Ds0sBhNuqwzGltBaePtPIbRCWOacGIhKX6uXmpdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtVd90Gazq4Unm/j9/t8yKYWe2a5TkCQYnX/iCdNxxI=;
 b=LLOB84qH6mho1Lp7jnIhWFLfByuuRdZk6QWfZDWxG6zggHZGvowSDnj0wMBLPZrDb348OGPPQuaUuU5vpmzzC9whF7uRcycwlZTuGIFsdXhaY/DcqqAXDoRz5ANd8fNMfrDvIxBzmzNCW2LhwDnxg2C3/bz949DHNTKUJ7TN5aeZ8MgAtm1BqOXY7AprbqSfYpZaRe9sXtNSlkFfBQ0TF51YhTnXjB87cG+IfxhRXGqgTyR4IpwHRdi10gojxS809s/jgmquW7eJ5iWjWq9GAq1YAWj/4wwoMFNUuBryA5yBrnS1EEVvsH4/XXy6Kaitk2W9/umQ2BB1PbhztSGghQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 04:00:49 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.015; Mon, 3 Aug 2026
 04:00:49 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 13:00:45 +0900
Message-Id: <DKF0BU8N7JJX.T802R11VZ0A5@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
 <20260706-clk-type-state-v5-1-67c5f326a16c@collabora.com>
 <DKEO7DXQ8604.1CB09QFM2EO68@garyguo.net>
In-Reply-To: <DKEO7DXQ8604.1CB09QFM2EO68@garyguo.net>
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: f0737ca1-011a-4f4e-ba6b-08def113cd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|7416014|376014|22082099003|18002099003|5023799004|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	la5lIuKmE5whqFjroxnKBJkX6nybuADCXvSxEusMGv0qJxsDpnwu0IImpsVmmb2Br4fmabx289BSoQB5EVr/+SACAWwElNUTgv2kRyhyn0tstzJliJ7uQxkWYd14yYFwlN55UM9+KgFK+2CUbWKvQPpkRIUm528PxnE3xn5dqHyD7oi2DR9P0/iWJHBEDnlKhgsgjWEGjGRK5WsKhSdCRYm4VHxOd8GqGXDYg8g66oovrXxlrSuqWG0QHn/4GRVvifCMC2ClL3IMvkIF5TglL8IggOQQLPRlmqRRv41kYKAFyaR82vsMhZSBu+DDJq5dwfDRoAZlHagC33RCr/4FIdBc20ri3kUajU8yfYoNx8VkzvBu13AEBhxk/SvbZhgdqoJ74s5k+xoA43jKWO9//rkz0YFcoR/kRYksCgoiSIYPyPiUScKRB5R5irUmEUBuOumC/NpynV7E3lBWRnhodyYpI14yOeCsCw22XeBzZT4H/HTjhj1WP9VAChvJPG87umws+AApG61dKYhnHVzObcT4d+C3/h3/7stSoa4LU0OB/kr2EBgJQjcVohI6+Z6mHbAiCC/msT89lrvyj7+qrg0QNsiJNTxLE0U6KLGsO2Q9MmZdUEaTbiJcIrAx9PFHtQ/nJUMkaeNVYYDhBh3rMLAD3CCLB1IZR/LP/tNKMT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(7416014)(376014)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnFDYWZlNWN4OUcyKzNxSENyVVg0T28xV3FNMjFZSDdDbkswSFFGbzdJSVdk?=
 =?utf-8?B?NUhTNEsreFFrbVZQU0ZrNHdmUjI3TW5hRThjY2p0cEcydzgxd0VSNnlxaGlP?=
 =?utf-8?B?K2JrcWx0Nm9jaTNSdVRpajZoTmZsZUlsMnFva1VEaC9Jc25CQnBzdzJTS013?=
 =?utf-8?B?ZmliTXRESE8wRUdvZ25TdHhoSWZsZkZ0WENYaFVDVEhOY2dRR3JZNUpmVTFz?=
 =?utf-8?B?a2VncDdNMDRpSGk5UzJCeWRlWHIra05jZUxVc2dNZTRWWG5GWmxseXVpcnJZ?=
 =?utf-8?B?RmY3dGZPZUtTbVJIcVcvSFhLRnlPaDdkNXdzbUhVTWNXemFDY1FlZDcyRzNH?=
 =?utf-8?B?RHVHc1BkQkM3Nk44ZkpXT0Erc2pMbFduWHN4U1pmS243bU9qY2xNYzBXejRq?=
 =?utf-8?B?RENPamc2WTQySTZyZU5DajcreWM4RVdkUFRoeWdFZXlEdkZpdHM2SzJQZnhC?=
 =?utf-8?B?TnV4ZzZlWDRPSys1VjVDa09BMHBhRnpiL2FJYUxoQ2RsSk5kQTFORUN1NGFP?=
 =?utf-8?B?djZCd1NIQlhpZGlmQ3JPcGhsUThSNE90Q2FzZUFlQUFmSkFnWHRMUitLNjZJ?=
 =?utf-8?B?YWxRNlhZUWwzNkRValZ4bXI2bTFnT2lUVVN4cFRFLzRRam9ZM2ZHVEt4Unky?=
 =?utf-8?B?bzBMYUVDRHRlZ3kxQk4wb2t0blVZbXExSGEwcFRHcmMwU1R0S01lSk90cVMy?=
 =?utf-8?B?UjRFeDFpREpNYjhTeWQwVUNHbmxxQVlrKzN3aHRuWlFtdmJVOUlMcmxNbUI4?=
 =?utf-8?B?b1FtZHNqN3ltNmlWd1ZhcWZTcnZSdnhZNjhST1p0NHE1d01TZWxLTDR4VjJO?=
 =?utf-8?B?Rm96VkZBcnF2SVFpVlEvbW0xaWNqcHIzMDJyMFVpUk1yaW12dk00aEljdzMz?=
 =?utf-8?B?VnR3aHJuZlJyK3NhYkYzZ1IzbjZKS2RvaDVHVk5Vbk8xb1kxem1LempzYVVp?=
 =?utf-8?B?RVJaSThqWHBqbEJ4UXlZVmUxaWlxMTZlK3ZOcGt6Ui93REs5dGdTZzAxcUFV?=
 =?utf-8?B?R1JYK0VUQ0hrcUp1M25tcVpRbVphU1c3UG9JRmNiYkVxdnRpYlEvTG8xcjcz?=
 =?utf-8?B?VGFqYkJvbklQSG1oWVcvNnNMb1dCMmxnVTR4R2hOUXA0R0JiM0liNDJYeENu?=
 =?utf-8?B?MEU0emZTZ3RUdVZPSlFMMDVOU0xCeldaUGltMk1iMmpJcnU4L2FpZGpFcTNQ?=
 =?utf-8?B?RFZ2eGRmZXJDYVVjUmp3ZnVFT1JsSTVGRmJ4RlpudVVURGdhcUNPNFJVMkVM?=
 =?utf-8?B?N3hZQWl2WTlScHVkUEd5UGJGcllEdkVScURBSlRaRG56aDJ1ZHQ0RWVER2I2?=
 =?utf-8?B?NjJKZW8yN3JoQktaYXF6ME52QzNwMTc5c3VLeEYxTjhGU1dMVHg0MFBuTmdh?=
 =?utf-8?B?T0NNaXp5WjcrZ0RRb3piN1Zwc3M3b0ZWQ0cyMTV5cWo3dERkN2hEdklmSEZ0?=
 =?utf-8?B?RWJJZUpWVW9NNllHYm9sNktUTyt6QmVvMW9xZUV6Y0ZEVnl6WFJJYjQ5Z1lo?=
 =?utf-8?B?TTU5Q0dLK0kxMXFvQlhPMFRlWEJObitpT0ZqOHpWNkE5THl2Z2tGQU1xTzNK?=
 =?utf-8?B?bk1NMFZmeXlvRUZsOTZmSURUTHQyMjk3RCtpYllUbE9lWUJGckY4aktFWHg2?=
 =?utf-8?B?cXMxaSs2c2NMbyszN2tTV0hKUlh6ZFpNdlI1ZlNJdWhlN3BsWXBwcWtEQm5x?=
 =?utf-8?B?Q2o0MDc3bG9DUkgvemdvK1M4N2I3azlFdUlOMU41em1lTlJJbEJGcHRyYWM0?=
 =?utf-8?B?OEpYYkJPOWtLeGo2VVhPQnpVY3ZUWURNN2d6aUJrS2FCdS9BU1l5YzQyblVn?=
 =?utf-8?B?SEJSd0E1aU1EUVhTMW8welZPSnY5bld6YUZONHBjcjY5b3d2WWNKQ1RsYWYz?=
 =?utf-8?B?aXJvNW5BTUxkMW9yOVdyRTJYc3hFdnhrTktpN21XTzgvZzRWYW5OVmxTdGlZ?=
 =?utf-8?B?bnJnWVA0dGZ2UGhDdmFCVXJMU1NkZk5CaEgyU3NUaVFvV2EweVVSM2piZHVU?=
 =?utf-8?B?c2hiM1BWblloMURyRkNnUzZRaHdmR0Q2Q21BZUlGNjdUZ0tzcVhQUllRYnVl?=
 =?utf-8?B?d0gzYmZwYmFrWXVQVlRDbUNjWkR4RUMzUWUxcFpqb0s4VU1jVVlHWWRuN0Z2?=
 =?utf-8?B?NjBFM3lXZDZ0UXd6SWhWanVYOWxJT2hBS1UvdURIN3hrRzdoN3ZyMlN5WEY2?=
 =?utf-8?B?OGFUYVdaWXZURE92TlVqY2F1WWVBZ2wvTHBTV010Zkl0SDZaOXd3cXhCZFF4?=
 =?utf-8?B?RlF5VVhtR2tPKzlZR3pCSXNjL3I0TkI3Mm82dUVsWGh0RzdpOE80cTFjejF0?=
 =?utf-8?B?Z3VVaWVuVWNESjQvWlFtdTdOTjRyYkgvcGk1SnZRejZPWlA1NVZQMlRqZEhL?=
 =?utf-8?Q?vBw7rWd7NUcrVxI/z9pZkweCpOYJiUNqUMz28++12WVDZ?=
X-MS-Exchange-AntiSpam-MessageData-1: IXcUqmo4JzWltg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0737ca1-011a-4f4e-ba6b-08def113cd96
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 04:00:49.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9tQfBu72J6ZyEjEzufexXb82DIPCAcjiP0UB0HJKdZ6gp4l5UzGCfkFa/SWh5lLyrMlL8gNqLf+yxD81NDfJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022

On Mon Aug 3, 2026 at 3:30 AM JST, Gary Guo wrote:
> On Mon Jul 6, 2026 at 3:37 PM BST, Daniel Almeida wrote:
<...>
>> It solves d) by directly encoding the state of the Clk into the type, e.=
g.:
>> Clk<Enabled> is now known to be a Clk that is enabled.
>
> The design conflate states with actions. Our existing type state for devi=
ces
> don't do this: `Device<Bound>` means that the device is currently bound, =
not
> that dropping it will unbind it. Yet, a `Clk<Prepared>` doesn't mean just=
 that
> "clock is prepared" but rather "clock is prepared and needs to be unprepa=
red on
> drop".
>
> One way around this is to mimic the "Registration" pattern: have a type t=
o
> indicate that a `Clk` has been prepared and its `drop` will undo it, and =
then
> this type can `Deref` to `Clk<Prepared>` which just mean a prepared clock=
.

Just as the driver core hands over `&Device<Bound>` to a driver as a
guarantee that the device is currently bound, so can the driver pass a
`&Clk<Prepared>` to a function to assert a similar proof. Here the
reference only means "clock is prepared", without any action implied.

The typestate has real practical benefits, as unlike `Device` which has
a well-defined life cycle entirely controlled by the driver core, clock
handles are owned by drivers and their use can go all over the place.

Driver A might want to enable a clock in short bursts in order to
preserve power, and keep it prepared otherwise. For this, a
`Clk<Prepared>` with the `EnabledGuard` I mentioned in patch 2 would be
a good fit. Driver B might need to keep a given clock enabled all the
time and only change its rate, and thus will store a `Clk<Enabled>`.
Driver C may have different PM states, and can encode these in an enum
where relevant clocks are either `Prepared` or `Enabled` depending on
the variant.

Mandating a registration-like pattern here looks a bit overkill to me
and I am not sure what this would grant us. It would definitely
introduce some complexity: say that you want to keep a prepared clock in
your driver data, does it mean you need to store the `Clk` itself, and
then its prepared guard, which references the `Clk` in the same
structure?

I guess it's fine if we enable this pattern via the storage of a
`Clk<Unprepared>` and the relevant use of guards, as it may be the
correct fit for a few drivers; but that's not how most drivers use
clocks, so we should also allow them to store their resource in a more
advanced state.
