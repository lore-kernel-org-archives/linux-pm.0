Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011072.outbound.protection.outlook.com [52.103.23.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F483FD12B;
	Tue, 28 Apr 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385378; cv=fail; b=nB027FsZlSDCnv70vPDL4jy4I0tPUQbSPpS1cy+pLw4Vjc/6eH5KKyJVk18uFVQgza9hRAAhIBvJ+9Fb1ebKIVSwKVI7XcptqSC7ANeIe4FzRd0K6ibuXxAhSb6VvjTYOBR9H68MyRXu1hNsHGYoc887GlS81T4yBgpukabenxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385378; c=relaxed/simple;
	bh=4wYYBm5lh/MjMLC3BrabHO/jedY0PrhSz/rUL1lbvto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=McvoFUPVk2ImvM46/DxFziJqLaPVnwwZuNOTYb3KQlBs5zKSvXhPS0LCY2IIs19NcmcAZV0PGtGnmStRtzHEzMICWQaAsAIUPT2DADXY2y10wk5cuCPlM18M93s5LlpeeEuSR7fgqYGIExWrqZ8t79NWHny5u/fxu/svPapdrkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=h4GhKy4n; arc=fail smtp.client-ip=52.103.23.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="h4GhKy4n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7SFpk0D3bpz72iROmPYSupSks5csufLprkB7ORBZpsBfeNaUvzinPeYMHON0vQUPRW6bsCJxaJimkGjyOhZjMyGY4b7YtIk8udDQPcyT43LCLx0eOljyekhDBdslPIbXymf1pKeDbfi+nC3wrI8AI3hXv6LzXMv0H9MoU7vs3X9t8afeNYikBPpIYHP765CkEpe7FNhAk1yOn5K9wXxN/al3T+5zt0HyycAefl4uEFVbK6RcgtCziQqhWx8sObAq3ashFltvdvT+h11sc4MCik0ldl1/BHAEuaL+Va9Kglbf9CFSYM1AoaV9MkrfekU9d2bAZSJlLYHUVJWvTHf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ej9TvUCL3Ze9l4edZ1r/QWQgNZ+IAlip5owdlVA7Bs=;
 b=JbLPOuMoLXc8rhEf32PzBE+FD9dJUelmg5m5nD2qG2p5+SsP8i5ON8OazRjXmkbX+pFAvmSDX84pFEyvyO2+/ctbg8E01sZBCcIoWocF22aPg6060BfgO6kG/L0dQxaLePCpxyBWFDJcPvDW0/oHOKNsEIugMkr48P4HFqveK/o6K7ZsVAlWZFCUBWeReP72heZ9Lf2Rua6pHqBefKXYuC+HSklVkAger7xynOoHndd+vHahawdcQjx5Bsa91wqxCJllbLdjMaki12RtJzzYp0fuxR8CrUeeRDr7DrDE+yBIrZqSJDmzNrdFSnn+SkMd5SIM6QXWY+Ke0WwCSBP9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ej9TvUCL3Ze9l4edZ1r/QWQgNZ+IAlip5owdlVA7Bs=;
 b=h4GhKy4nBhouXXxvLpgNIGm7vaYcGT4wfrkqZcTL8FQx8MmeG8IWANyxl9SOvwTQxoaT0sNpB9iaYBFQAhojQEz0yhsuDkQzn2r86dRwHh9qGAXspce/2Cx2kkWvNfTdSV8tUaB+DtJUWLCupRcM3JUK6hw8Yt9dR8tWcvkCvLhdt4SaCKoUU69rhTHT5o5d5Wt0NcpLu0XDH/tbC0faVziA1t6/M889AiMaXBqXKFpRaHSHXin/RiIA5Rm0Bb71pSLi5mSzvCmt1qvSH+HOomm8nmw0pt0ePezJY1ejabZ1Xa/HQOkGQyqOLyUW+3VEcHSSh/eMIfRCAAxY9OayXg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DM3PR19MB8358.namprd19.prod.outlook.com
 (2603:10b6:8:1af::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 14:09:34 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 14:09:32 +0000
Date: Tue, 28 Apr 2026 09:09:29 -0500
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
 <PH0PR19MB997338F0B06B7B99AA0ED3C6C4A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-2-macroalpha82@gmail.com>
 <20260428-bulky-nebulous-reindeer-ed45ed@quoll>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-bulky-nebulous-reindeer-ed45ed@quoll>
X-ClientProxiedBy: SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::25) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <afC_md94llV0cKmI@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DM3PR19MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abdc3d1-273f-492b-b4be-08dea52fc529
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|461199028|6090799003|15080799012|19110799012|5072599009|23021999003|10092599007|37011999003|24021099003|51005399006|25031999004|10035399007|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcPSMRYf6jRD6KAFVSNMd6cnnry3qM2QC11GlL3Xdn9ua43MJ4c6EZAZMQ1H?=
 =?us-ascii?Q?hEBK0Km3B5Y3fb/mZWgOQPnWeNfHbj4xj37ov23kfIZSWwfzvYhr/6tOvhVG?=
 =?us-ascii?Q?PiRNgBC5rc02HCumCL5AYHn90J/h2/CmaNA3YvcPiIxDrdkxOfdOLFxuNK1y?=
 =?us-ascii?Q?o31DPOtinkRtXQkqO5qk+KoaVY7Ln4YvRvIC+Rbea04HOpkVNVDlh8YxqVH7?=
 =?us-ascii?Q?BsHGTRN/1GojK5cPEoNMXFBLoc2pXwRGd2ci9Ii9e4PK9Uyv+m+pxGsW4jq7?=
 =?us-ascii?Q?RGGc8M+qnBBRyQ0lbwZoDUDegC9kcMmzZ8Rl36QGQb5mYYt16KtKeutuV1fZ?=
 =?us-ascii?Q?bWvni5KAFyxgePaQ0q8+cNZMdI+HNPdDDoVc3r4hDGh8MqhPhQond0j+xjv5?=
 =?us-ascii?Q?4jbrg0Sq5U9w95v6MaC9wtWzhkKSMgZdEhuo7dzPbkv0lCo2rdvIA3Hkp0KU?=
 =?us-ascii?Q?yRuXcO6SpOpxjTUAxnTUwuCWfUOqvp6B+PEhoagf3rFOkfpxQ1NRfKzD4N5S?=
 =?us-ascii?Q?6W/xOrPE4nGaO0vyoDGaPeHh9bUsKUd5j8NQ6GXf+S9KXQCS3XoIMP69lLXu?=
 =?us-ascii?Q?19oV9mrohUXWedlTmFr2pvUh3KaQb5Pcy6OOOQtU/VVYiYsrxV6CMb9Iw9Ww?=
 =?us-ascii?Q?o8Te+cMkyzHs0ddT9A1YoxzGyUWqcSgmjuXNA/GBJ0YgB0v/aEJ0RXZBq6l7?=
 =?us-ascii?Q?fU2RDZRwjsGZzmyuhCmgAzVMHUaG02OQYd69CPGz1nOPbS3pIc/kqL6TRTV1?=
 =?us-ascii?Q?uKXMoOtEu4MOARtrMt4lsgmkdTyu1l7Ej+E5ajJd9xS8kQp6zoYpCQbav7xH?=
 =?us-ascii?Q?yK01vRHl3GvH56y6PKRMeRajQuSnQsjF0CzWpDx8LMRHAjyiNan8tzwrzPbd?=
 =?us-ascii?Q?Cu6VpPSRoQMdBA4SEQYJB69VXdVrMtr+dpbzsPUjl7CIXfNEQKAl8FjsxM7H?=
 =?us-ascii?Q?p4xrCnxRW9vWDaRub+CVbeteArR/zMfOgXMZWsSXzkgr8kanAcPnbg4OBl/z?=
 =?us-ascii?Q?lpj2dSLzWzNPMLnXlopX7efzyTCLqxPyw1tXIo+fjPV35atds81HzWrXJpLk?=
 =?us-ascii?Q?ApVZP6PPLdtySzus4hqKz5L5ipucaQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+tNuUJTKvh7AQCVT51Rd8sy2Vrxc4TJXRDnvdNx/InPO2CUsqjZqg5oAZyv?=
 =?us-ascii?Q?kFL/KFPDPE/XVO4SvXV3LMmITP30HQ8S+QhN2jfrgEZ+iuNNAmPOp/GB0YVK?=
 =?us-ascii?Q?YIAfM4IOp1L3UgPClppc5hqrWhdJB3KHUhLPOLFmGNoLue7A8/SCkXqE8Qix?=
 =?us-ascii?Q?ktRoAYDnoDJ//uaM1KNtsfaSqvSeZrAipq//Ml4hrzag4HXpi6XJM1i+7MI+?=
 =?us-ascii?Q?J9w/NDjQSXdBuV/WrCFqGXFLU+A4qWLbMqKCSEXk8y1eZDhs9oOJofe5JRb/?=
 =?us-ascii?Q?7Ox4f0gtfLzBx+sQqKmirPHBG4hgmB4NCjRwL4v3vufFOecp2Lfpt6DxH34Z?=
 =?us-ascii?Q?Pf3/YlL753ClIRfMnxdXJ4zAsaPtgkfS/LhVSJ8GF7nMs9MvxMJ/u3OstRsi?=
 =?us-ascii?Q?itxk0kc6UpG/UIGOwohICxP19u6hlJ9s0WrEaFofDzAk9uSj6VWBDcIsAY8p?=
 =?us-ascii?Q?GJJz5PCAzmeoZJf7sPn4rTDkOzWAdDflOcww0zwNrABL9hNJxLeGxe6MWNQF?=
 =?us-ascii?Q?0/ZQGoeFiTUXF8J6mCw5/SR3Bls6YW7ey8cw7CsGiSHWgC1MZpnO+hhdypwZ?=
 =?us-ascii?Q?DJBsI0uTkZWKSZvQzVVr3IUNRwft6VQvDrAth427Pna1uf2UD/qmvlW8iBHB?=
 =?us-ascii?Q?vttZqbbx/5WViI/wIVx08bneny3y1Qx7I6xRDqcX9uR24vehE6D94N+JmV64?=
 =?us-ascii?Q?66vprQxZ1X2DlpWD+bQXZnnPmUnnaJDmKMDIVkb3AoBmcuvHmsAkxnmqV2Da?=
 =?us-ascii?Q?OZ8R7hQYEewnrF5slGTMAuuS9MaDDTzgWcgpnybXNpUInzzNEhX3F1T8OrgL?=
 =?us-ascii?Q?+VsKvBYbk6wVUMIjODGIju0jeX1R2cAr+TAqSCZ2F5qGfpqQtR6WTtUkeDDY?=
 =?us-ascii?Q?iHhyQDEBTtCAV1FUQdY1xHMw/pl3BX2ZYbDQ+y0Qe6YMZgxeoXYV8hqfze17?=
 =?us-ascii?Q?Dsopcmqhv/ZxPUs0bdlyPNNZIxhEnviLqfkM+q4UadxtqLhJ638dzs5W21ma?=
 =?us-ascii?Q?+IHRG+Bd11mhjhTdN0a8k0lxGBc627yfRkhjLqbbWqI+zZzaCbcCHZ1WoAsp?=
 =?us-ascii?Q?WB/y16HuWGuE8I4CpGbur+00iDW9SBCHXm7I40pbSYOogybDlASiPhrU9AIN?=
 =?us-ascii?Q?ofIBYjHt0z57WrIbqGtOg5gt0nwqx7a4ZR9yGxUDAMA+MZrzggwEL23kOw7m?=
 =?us-ascii?Q?z0dBnQH/TI88Yov56UEJhs4BnTelgYN72+n8i13YTQy9on6B3+AvrBWiRRjX?=
 =?us-ascii?Q?mAFcUFSEO8RPvAcMmxMI9akxA7EsMG6CQrHOLIBDBPMVpxgQ2hxTxDffN98b?=
 =?us-ascii?Q?EkaJD24hFruYLAfhgDlUAXoCZtqSxKGqyHVdFb3xIEJQUeGmH4gqgiL1BtmR?=
 =?us-ascii?Q?QYfHw/RL5SH0ZeBrw6EFPJLWFHmODKp9SisKh3M+4DQ9S3c4Eg=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abdc3d1-273f-492b-b4be-08dea52fc529
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:09:32.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR19MB8358

On Tue, Apr 28, 2026 at 09:47:00AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Apr 27, 2026 at 12:09:09PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Document the SG Micro sgm41542 battery charger/boost converter.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > new file mode 100644
> > index 000000000000..3e5041e5b551
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> 
> Filename must match compatible.

Acknowledged.

> 
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SGM41542 Battery Charger
> > +
> > +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 

Will fix.

> > +  The SGMicro SGM41542 is a single cell battery charger/boost controller.
> > +
> > +maintainers:
> > +  - Chris Morgan <macromorgan@hotmail.com>
> > +  - Xu Shengfei <xsf@rock-chips.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: sgmicro,sgm41542
> > +
> > +  input-current-limit-microamp:
> 
> Missing vendor prefix.
> 

This *appears* to be a standard value (perhaps not formally, but in use by
enough devices to suggest a defacto standard), which is why I did not use
the vendor prefix here. Do I need to add that for this one?

> > +    description:
> > +      Optional value to clamp the maximum input current limit to for
> > +      the device. If omitted, the default value for the hardware will
> > +      be used (2400000).
> > +    minimum: 100000
> > +    maximum: 3800000
> > +
> > +  input-voltage-limit-microvolt:
> > +    description:
> > +      Optional value to clamp the maximum input voltage limit to for
> > +      the device. If omitted, the default value for the hardware will
> > +      be used (4500000).
> > +    minimum: 3900000
> > +    maximum: 12000000
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  monitored-battery:
> 
> You miss definition of this property. I guess this is power supply, so
> reference proper schema for power supplies. Look at other bindings to
> for some example code.

I'll look at this some more, I might have a few more questions. But I will
make the changes requested.

> 
> > +    description: |
> > +        A phandle to a monitored battery node. Values for the following
> > +        are used by the driver and if not present will result in default
> > +        values being applied:
> > +        constant-charge-current-max-microamp
> > +        constant-charge-voltage-max-microvolt
> > +        charge-term-current-microamp
> > +        precharge-current-microamp
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  regulators:
> 
> No need for regulators node, just define here otg-vbus directly. But
> honestly, your example is incomplete or you defined something implied by
> the compatible. If you have a fixed 5V regulator, what is the point of
> defining it in the DT?

The regulator can be adjusted within a range around 5V, and is referenced
by the USB subsystem. Should I still omit it from the device tree or instead
define the min and max values?

> 
> > +    type: object
> > +    properties:
> > +      otg-vbus:
> > +        type: object
> > +        description: OTG boost regulator
> > +        $ref: /schemas/regulator/regulator.yaml
> > +        unevaluatedProperties: false
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    battery: battery {
> > +      compatible = "simple-battery";
> > +      constant-charge-current-max-microamp = <10000000>;
> > +      constant-charge-voltage-max-microvolt = <4350000>;
> > +      precharge-current-microamp = <180000>;
> > +      charge-term-current-microamp = <300000>;
> > +    };
> > +    #include <dt-bindings/gpio/gpio.h>
> 
> Drop this one

Will do.

> 
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      charger@3b {
> > +        compatible = "sgmicro,sgm41542";
> > +        reg = <0x3b>;
> > +        input-current-limit-microamp = <3000000>;
> > +        input-voltage-limit-microvolt = <4500000>;
> > +        interrupt-parent = <&gpio0>;
> > +        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> > +        monitored-battery = <&battery>;
> > +
> > +        regulators {
> > +          otg-vbus {
> > +            regulator-max-microvolt = <5000000>;
> > +            regulator-min-microvolt = <5000000>;
> > +          };
> > +        };
> > +      };
> > +    };
> > -- 
> > 2.43.0
> > 

Thank you for your valuable feedback,
Chris
