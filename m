Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FF378D78
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642373; cv=none; b=aXzF2r+SY9jXE96fRvIpjQd/OJT4Wb157QcOWMDj6y4PUKuuLVdcsBgRH/VTuRwbZqju566pyBRIXfLi8CTudd6Atw+JlmypK3yLDskwNCsKnAFHdq4e6vw/vy/zdis9uxoNpugsJPlewkBIfRUg92sNzc8ZNY1bgQiqprja9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642373; c=relaxed/simple;
	bh=Tzq/vrvnRRrxr6ANFTfoWCgLcTTvncwyWNqAq7FNs+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izzs695ZtGX2QsRBcvZKK3xbZYoz4xzpMf0JtP63nrTt/WKsU1J07cZkG/+B/76zi+YYCZaLP9e70LE6hBSnz8XRI2RYbGBGHhyuJw/VKCpm6CAtTSKvBlLBiUkSGU582GXJ9xOo68R/p5T9z4xb1E/ETS35AtqBBaNAl24eIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K11jSMua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K11jSMua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332551F00ADB
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642372;
	bh=1xkuaLNf9L6gC+nrjHGpqnJIB6rDY+L5voYQo7bRBek=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=K11jSMuaPDPI0kkRhM4cYd3VtHOuDKJARLxCmdhRhJsABBbocbXiQs03D+ImZgWed
	 rpY2YoV564F4TBfUMGTzzOlDwl5BZSDAuyn6cSQlG9UCCgqYdmxq6+wUOsHKsw9lmz
	 heToLLc1zaBfLDwBbG4zJQmUMvO/rjoWC8+/XYCk298GPKSBmUzexmNE3YjbZlPz8J
	 UzEViwCM9Dtr0GhzC23Jg3jCZUs4AxNjOJHH8dEYYYPH4ZELuhRpJOYmy2pV4Q5ND4
	 XeMBgfPXZNnQaBC4ew3ledjK3t1pWaH4nPd2i0yYgM4DCMd5F5eE7LUCESFuaimwfh
	 r0Epdz08MSMZw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39ca0a30148so94877201fa.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:59:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RozdHO1Z/MiOs0plxCWWf2o8sCg4BH/VOCrHgUTTe/NnBF8o8kGCsg/sn4F1Sgs9gnsg8LQTKxIGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/m/FsZgOWNxwDpQZIGrbZZ7sTbeT75JGV/eK9clHVsQZoQdL
	s1xnQQ37VGbQHRMJFY6kax2n8wicdXtcBUW6pIUf6BuxUFQIvE1CU4HLGhDFOBd5yrnOp9kb3xE
	caNim8VRLGq/uDGH4V6lZqoMT2usQD7E=
X-Received: by 2002:a2e:a592:0:b0:39e:e845:7f23 with SMTP id
 38308e7fff4ca-39ee84581efmr10859501fa.16.1784642370582; Tue, 21 Jul 2026
 06:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704171411.1413349-1-iuncuim@gmail.com> <20260704171411.1413349-6-iuncuim@gmail.com>
In-Reply-To: <20260704171411.1413349-6-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 21 Jul 2026 21:59:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v67PMYwFBV8gMbd6U2BU8ivZfAzUq50ttLG2UkdfKEwdMA@mail.gmail.com>
X-Gm-Features: AUfX_mx_UbqtUhBgjig7P-YMGQlk22gK-yhaDfUZjTvwjqcflr721OIjYgv26EI
Message-ID: <CAGb2v67PMYwFBV8gMbd6U2BU8ivZfAzUq50ttLG2UkdfKEwdMA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] arm64: dts: allwinner: sun55i: add thermal sensors
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 1:16=E2=80=AFAM Mikhail Kalashnikov <iuncuim@gmail.c=
om> wrote:
>
> The A523 processor has two temperature controllers, THS0 and THS1.
> THS0 has only one temperature sensor, which is located in the DRAM
> controller.
>
> THS1 does have 3 sensors:
> ths1_0 - "big" cores
> ths1_1 - "little" cores
> ths1_2 - gpu
>
> Add the thermal sensor configuration and the thermal zones.
> Trips temperature, polling-delay and sustainable-power parameters are
> derived from the manufacturer's BSP.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 160 ++++++++++++++++++
>  1 file changed, 160 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index ca6a16807..2ed00e7a7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi

[...]

> @@ -355,6 +364,32 @@ gpadc: adc@2009000 {
>                         status =3D "disabled";
>                 };
>
> +               ths1: thermal-sensor@2009400 {
> +                       compatible =3D "allwinner,sun55i-a523-ths1";
> +                       reg =3D <0x02009400 0x400>;
> +                       interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
> +                       clock-names =3D "bus", "mod";
> +                       resets =3D <&ccu RST_BUS_THS>;
> +                       nvmem-cells =3D <&ths_calibration0>, <&ths_calibr=
ation1>;
> +                       nvmem-cell-names =3D "calibration",
> +                                    "calibration-second-part";

Just put them on one line. We can go up to 100 characters wide.

> +                       #thermal-sensor-cells =3D <1>;
> +               };
> +
> +               ths0: thermal-sensor@200a000 {
> +                       compatible =3D "allwinner,sun55i-a523-ths0";
> +                       reg =3D <0x0200a000 0x400>;
> +                       interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC0>;
> +                       clock-names =3D "bus", "mod";
> +                       resets =3D <&ccu RST_BUS_THS>;
> +                       nvmem-cells =3D <&ths_calibration0>, <&ths_calibr=
ation1>;
> +                       nvmem-cell-names =3D "calibration",
> +                                    "calibration-second-part";

Same here.

> +                       #thermal-sensor-cells =3D <0>;
> +               };
> +
>                 wdt: watchdog@2050000 {
>                         compatible =3D "allwinner,sun55i-a523-wdt";
>                         reg =3D <0x2050000 0x20>;
> @@ -586,6 +621,14 @@ sid: efuse@3006000 {
>                         reg =3D <0x03006000 0x1000>;
>                         #address-cells =3D <1>;
>                         #size-cells =3D <1>;
> +
> +                       ths_calibration0: ths-calibration0@38 {
> +                               reg =3D <0x38 0x8>;
> +                       };
> +
> +                       ths_calibration1: ths-calibration1@44 {
> +                               reg =3D <0x44 0x8>;
> +                       };
>                 };
>
>                 gic: interrupt-controller@3400000 {
> @@ -1102,4 +1145,121 @@ npu: npu@7122000 {
>                         power-domains =3D <&ppu PD_NPU>;
>                 };
>         };
> +
> +       thermal-zones {
> +               cpu0_thermal: cpu0-thermal {

There is no reference to this or the other labels for the thermal zones.
Please drop them.

[...]

> +               gpu-thermal {
> +                       polling-delay-passive =3D <100>;
> +                       polling-delay =3D <1000>;
> +                       thermal-sensors =3D <&ths1 2>;
> +                       sustainable-power =3D <2400>;
> +
> +                       gpu-trips {

As mentioned by Sashiko, the trips container node must be named "trips".
This is also required by the thermal zone binding.

[...]


Thanks
ChenYu
