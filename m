Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011032.outbound.protection.outlook.com [52.103.12.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B992FF657;
	Tue, 28 Apr 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406103; cv=fail; b=A33Ifv0O29yyP5qvbJaSt6uTrpuOT9Hmoul3Rxbivr8MWHG6MtbpgwxYfbKNOzdvsBHoiyrQlUpVngvMHgRWZ3bxe83eS1OJzxxMbggc4lA6RoNb7WINwUh4VjIa37uEUkWLJyaBEY05I91pxFd6EZY9KKagC/ucQlc/SJEqEwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406103; c=relaxed/simple;
	bh=HTuzs0h8RVjNvwpKsBRAgV3Wh6GSDXfsFM17541erPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rsVOZwI5UO9hg5QfXoz48eeiSB2icIgXW6THgFIFhJZDht1KBeS3bMqIxjYBlmVtMA35UdQ89qU63n5kVYvPq/V0Ird+AfbAIi0ovmZymMHBbocnNZQH5gZa9RIkxa51ZJvjDFKCI7hcPHJjycOHyxiAF5Pa4KpTcAkie9w3I8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RFlarvXK; arc=fail smtp.client-ip=52.103.12.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RFlarvXK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fu/W+M7idfwWq/z+QZvCOygORn3cGzKuDnNLUQLYFpLV0yhuLuW+FGxsctQPXh+VmmswIRy+tBNTSp9qq+09H0nUcT6jb6+thusA/YkJKqcO+SKI/6gnGb2p/MeodV8ZUZXkJfSY3ayTPSYvBZCqhIsG+3Y4DIaBoamEawoE8IPXW0TiPaYDSOq0XuGIp/C8AQXbQTsr5D0jE0dVonNFC1D3jKxwJfRZy3fWqUh14/u6WQ1RU935lugvEMdTqlImys1IAHnt4bJGtq6BafmyiKfAUwyIvu80Te677jMKenTylLyLxTX8eu0bF47LRg+yAznSFs1t9N9vFEa5dQvpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdwkifXSfo1jO1LRt/p15VSYC5QkPXq4/uqD6/sFveY=;
 b=fi2xOXp1iggXvciFKo4TGpDJ92nAe5oN5XIuXQSARlT5xgv2EXWMHaxjODwcFagnRjq+mCL0UJzyMhLexRAH02AhDEc68udSIFNA7o4NumGNCVAnyBx7iy0LwEKy+AACY/DyfQvihIqh1WbJpl4dYZ+dlq4K0kEQYfukvzge7Ve2xwDU15Rsr1EFx7JlKEVWLMQGyUYeD/kIaGNGUXh0evMam848L4odxt2OVw3a/XLTCIk/BNprO7ivm0OPnEoztj3dP0dEBTBlDH2II+kg1noWX/zVfYjbYHOT3aXl5j2sO80nS2eqtDH4kOKrP98U2EzY9+x8MxfQI4Y6t4StXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdwkifXSfo1jO1LRt/p15VSYC5QkPXq4/uqD6/sFveY=;
 b=RFlarvXK8q+IpSAW1cA9F9tC+rOSnE8kQ0NqphufA893aBbxVYDWhIp85R56MHFEGLDpXBDPZokjszU+7uA19J4dJm7AgLpxPdnIes8OfrmTPtkV09zV39/5EDAIRjeRHyCAU79BMArfVRzoTWemPv/oevHffhiGuElWRkBTsFAQfqCn/O/CF2WpBqyZUu1DZzU3HiDwjQB+yeyu41wdIBnzVuFC1LJ+q+y2VY+s4UYLFbyuH99g3YMr+w5de0ZXn9BWd7W87sbiIk/hCWxFxY0bJVga5XClNmhm6PKbSFwLuUu/yPNzCfZ/7gEV8P+mk6LwUz4i28pP1ENfUCP/Fg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by PH8PR19MB997230.namprd19.prod.outlook.com
 (2603:10b6:510:3ab::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 19:54:58 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 19:54:58 +0000
Date: Tue, 28 Apr 2026 14:54:53 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>,
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	xsf@rock-chips.com, sre@kernel.org, simona@ffwll.ch,
	airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com,
	neil.armstrong@linaro.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: sgm41542: document
 sgm41542
Message-ID:
 <PH0PR19MB99733813E0295B511539050BA9A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-2-macroalpha82@gmail.com>
 <20260428-bulky-nebulous-reindeer-ed45ed@quoll>
 <PH0PR19MB997338F0B06B7B99AA0ED3C6C4A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
 <534f0795-0002-4c04-a83c-fa1b3ce68216@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534f0795-0002-4c04-a83c-fa1b3ce68216@kernel.org>
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <afEQjdHClHa8U3Nw@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|PH8PR19MB997230:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e73f53-f0bd-45e6-6ac1-08dea560069c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|51005399006|25031999004|10092599007|461199028|23021999003|24021099003|20101099004|8060799015|15001099003|15080799012|5072599009|19110799012|6090799003|40105399003|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qkha1C4ia48eRZaegwcmDC8asxjBShi8YBnTYFvEP8BHREVvq7IqCFieTF6O?=
 =?us-ascii?Q?VyrUBp5Jku32sng1MZcoeV/TQrkM3y2wQZmQhNnHW/BjurdcfVosE2Y88Z5q?=
 =?us-ascii?Q?hGCCroMBH88bTEd4q+I9Ifrgc85mQmZ2b00xJxxB7oDasRlW8SYS6o8ZvxUL?=
 =?us-ascii?Q?L9kMVl4y906NhY5tKlGI8nmmTP+nRS11krZkc0UHvxr7N2PKwEG1L9SfkKdX?=
 =?us-ascii?Q?lQOmKd/SfEgSWUjbi75Igzywn041mnvULWnACSHbKCu6XkeXZQrxIATgXo16?=
 =?us-ascii?Q?Vaayck+7KL8I4mFkMSq0j6uoMcn5Xh+cmnu/SSAJ4cREGE2CqRFQghjbNk8V?=
 =?us-ascii?Q?WC5KmHvjN3cpMZSvIieFGFy0mqLcpoNASLbTXB32tjJQa1GvAHZfEl7HOi2J?=
 =?us-ascii?Q?Fwt9pBUgkZBaSuu9dMFPfoNYRGcjQjeNK9qmrV3wTZrbl/3o6UMxDOyEhMk8?=
 =?us-ascii?Q?S9pQfi1Cd6yQSUWudjIERKq0vgSeR84YajBjBCfX7Q5kkTHb7VIcFUkeqY3N?=
 =?us-ascii?Q?/Npp0Lo0Dei7rAf+JUL/DnEZjRP+wA+JTpI2C0PWEBF2HEkH6ufl8M9kZtZS?=
 =?us-ascii?Q?QUafkdAliJ5eVfVhf3jlE9w+z8Z3xDtX3v1mXP+5s2mpIyAeaQUzjWGRqjg0?=
 =?us-ascii?Q?guGOFDWBfBgu/T/CANut9SXyODyzo4bJCaXfkyKdHugLdSUyUjRU1lIVF6gq?=
 =?us-ascii?Q?B64mZmzAiCQy9ZjfE3LDMzD43a1T4Gi9C4QgJetIqnRFKuv1HXwS6jeRAzGH?=
 =?us-ascii?Q?83UYtdOUai3wYWCZJCTS6fAUjf94iVAUCrSECgYnkFikBjN9qBs1gDHcFT0d?=
 =?us-ascii?Q?eTAXqJpzk000W+XCrvhEE4SwF+WRzImFxtWPmC6zKqMPqLpRzBLhTI25vi+6?=
 =?us-ascii?Q?XYsRIlMJRzpdLuiKzszArANxh87mcHfhK34cuuCrG3d5ekhxYEM/O7IV817a?=
 =?us-ascii?Q?Oy5AfLmtJ/7pLNDQuS+FX2v03ctUKmh5qeYThIMKOpx7xw2MFVeG9z2E8Lvc?=
 =?us-ascii?Q?6p/ID+d6WHkBfE0z9mOC0R6F0fHWAfwyBTIRYIqVq4Lg+UKaY4wWYHhaVQmo?=
 =?us-ascii?Q?Kk1SA2/spnxb+kdZBbFpz55afYWdvMZaC4zlPdxQWUyy3QjVjU0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?asuQZw+SuCV74UBzyPyQD9V+iWX9UYWT0RUqpOPstT1hOISEcLwJaHg5it6b?=
 =?us-ascii?Q?lSJQw96uCU97MJr153wJFHh4UK8ILBBx9SnSOaT8zzTc0MUgKlEde9vCXU8+?=
 =?us-ascii?Q?uNGq0aEwnDl/ZWFbbmezW6BJC9CTQxwpv/B2+YMs+2cqoTacOtNs1B882EYR?=
 =?us-ascii?Q?mBPkyoRphV7ump+SZHBOQ0kQC0DfgNPlH3Aqq79B83ktUhjHtkrirE+iTJBt?=
 =?us-ascii?Q?byGeDry68lT9whBDWGF1+jmACYosBA+6+lEp10lILLRfVCE2JhtyYVlaShnb?=
 =?us-ascii?Q?G+5bmwZUy7+DuwMLkHVqDaRH7uA4xQ988yLgcy7dtG2+XXkkXilmPd30jkYc?=
 =?us-ascii?Q?4Q5HcvGV+bBcD8BwmjrFWSERRGTKtPP1+8v7V1VK9lq/H3wCUcC6BapypcJ0?=
 =?us-ascii?Q?1NxnR4EGKlExRgVuCg2U1ETjFpZoRqOcDMnNB4vFieuoApVvo2HwqSsk1CNm?=
 =?us-ascii?Q?XoWmOcniOR3WOHPio10YbqEcYiHr7hFH0+G/oaaVMoS+AIDow7A6jZKrjmBH?=
 =?us-ascii?Q?Zmv1WxIj1fGdwwhh1Si5hae2BAEI2ZDKPVgsZs5H+v25KuKZ8FwOMYv49vY+?=
 =?us-ascii?Q?Q2ylQ+6cP6ioWfOExWvImiA82er7EG/sazxZsLNfNDz3nhZDGmFeJHMipf7F?=
 =?us-ascii?Q?VTXTrkjVY8FboDNaBdOnnme4/OXUSSuDTWVQoMfRPxkrZawUWu8uxmptclG3?=
 =?us-ascii?Q?2kPxu5L496Z8+l/yjKZNDTpFTg84dmuaE//puUdGjHPRqZwwKXnPBPsmuEP/?=
 =?us-ascii?Q?Djn7UfrlNXvi/FpoICHtBe8SHSTyICwDaPe5NmnBQNr30paoSgB/i794x5yG?=
 =?us-ascii?Q?XP97IrB+R6h89hk7zt2Owlf3sLRpp1HSzJclOKIwPRV/6M6veI3ZXa0Syqtd?=
 =?us-ascii?Q?GSpna5cKwomCaB5fvhyy9q/QG1YO9c3+zTby9zIVHYGbGG2gs+RCjWCaZNVu?=
 =?us-ascii?Q?lKe0U6zCH/401L9VTkA27UxCAHXPJuyAkyje8gSl0vbPcQIzKfqoJI1RPqED?=
 =?us-ascii?Q?VeUJmrxc9FqYew0/LXmrHIcHEVuOLya+ifoi2KzkVfJrNxpsY+odVSFmV8VP?=
 =?us-ascii?Q?DOthkTBBsfRivrvNiscrAGHFYS39HuDl0djVLQWzMA4VOBdG0ml5ZRG3ERiw?=
 =?us-ascii?Q?0BZyYh0FdsvkXH/kpWELXlCH2stzLrcs5t/TOoWuTUYsSLouwLH4M13LM1TU?=
 =?us-ascii?Q?FSyw7CPQDbAgGpiCm4UUPzNWlb9tk+1oY0xWHalOo5/0nsVU6SGLL0BdtvPE?=
 =?us-ascii?Q?tjrORnHWrXNPeTbd1Cq0K15aDjGpXCOwb/cav1YMfr38aqf7F05l3J7soLZW?=
 =?us-ascii?Q?ttWkwFrNA3YnHeQn4RlbIaD1+rob27HVn2Pv4GQqUq6Q1U7ARd3r1U1PrAnw?=
 =?us-ascii?Q?4leFk563VxO9guLRG60XXdZesYRKkLo8jvGM1e+wNfRFQbBXlA=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e73f53-f0bd-45e6-6ac1-08dea560069c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:54:58.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB997230

On Tue, Apr 28, 2026 at 05:09:49PM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2026 16:09, Chris Morgan wrote:
> > On Tue, Apr 28, 2026 at 09:47:00AM +0200, Krzysztof Kozlowski wrote:
> >> On Mon, Apr 27, 2026 at 12:09:09PM -0500, Chris Morgan wrote:
> >>> From: Chris Morgan <macromorgan@hotmail.com>
> >>>
> >>> Document the SG Micro sgm41542 battery charger/boost converter.
> >>>
> >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >>> ---
> >>>  .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
> >>>  1 file changed, 99 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> >>> new file mode 100644
> >>> index 000000000000..3e5041e5b551
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> >>
> >> Filename must match compatible.
> > 
> > Acknowledged.
> > 
> >>
> >>> @@ -0,0 +1,99 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: SGM41542 Battery Charger
> >>> +
> >>> +description: |
> >>
> >> Do not need '|' unless you need to preserve formatting.
> >>
> > 
> > Will fix.
> > 
> >>> +  The SGMicro SGM41542 is a single cell battery charger/boost controller.
> >>> +
> >>> +maintainers:
> >>> +  - Chris Morgan <macromorgan@hotmail.com>
> >>> +  - Xu Shengfei <xsf@rock-chips.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: sgmicro,sgm41542
> >>> +
> >>> +  input-current-limit-microamp:
> >>
> >> Missing vendor prefix.
> >>
> > 
> > This *appears* to be a standard value (perhaps not formally, but in use by
> > enough devices to suggest a defacto standard), which is why I did not use
> > the vendor prefix here. Do I need to add that for this one?
> 
> I know, I found these other properties but I think they were just coming
> from old schema.
> 
> If it is really a common property, then should be defined in a common
> schema and this did not happen.

Would now be a good time to add it to the power-supply.yaml document?
It looks like this value is used by about 10 other devices.

Thank you,
Chris

> 
> > 
> >>> +    description:
> >>> +      Optional value to clamp the maximum input current limit to for
> >>> +      the device. If omitted, the default value for the hardware will
> >>> +      be used (2400000).
> >>> +    minimum: 100000
> >>> +    maximum: 3800000
> >>> +
> >>> +  input-voltage-limit-microvolt:
> >>> +    description:
> >>> +      Optional value to clamp the maximum input voltage limit to for
> >>> +      the device. If omitted, the default value for the hardware will
> >>> +      be used (4500000).
> >>> +    minimum: 3900000
> >>> +    maximum: 12000000
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  monitored-battery:
> >>
> >> You miss definition of this property. I guess this is power supply, so
> >> reference proper schema for power supplies. Look at other bindings to
> >> for some example code.
> > 
> > I'll look at this some more, I might have a few more questions. But I will
> > make the changes requested.
> > 
> >>
> >>> +    description: |
> >>> +        A phandle to a monitored battery node. Values for the following
> >>> +        are used by the driver and if not present will result in default
> >>> +        values being applied:
> >>> +        constant-charge-current-max-microamp
> >>> +        constant-charge-voltage-max-microvolt
> >>> +        charge-term-current-microamp
> >>> +        precharge-current-microamp
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  regulators:
> >>
> >> No need for regulators node, just define here otg-vbus directly. But
> >> honestly, your example is incomplete or you defined something implied by
> >> the compatible. If you have a fixed 5V regulator, what is the point of
> >> defining it in the DT?
> > 
> > The regulator can be adjusted within a range around 5V, and is referenced
> > by the USB subsystem. Should I still omit it from the device tree or instead
> > define the min and max values?
> 
> If it can be adjusted then it's fine, can stay.
> 
> 
> Best regards,
> Krzysztof
