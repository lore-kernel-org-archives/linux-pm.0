Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB647ECDF
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989982; cv=none; b=mI4GT9tJAU1AlMAxpfPyeTykcFP+pinz2Kx8e1AuESYOnbIlaZNWX3E6LhOMgR4ilblTW1dHsWcZL8lMaFGnbE1wt4903xxpk5DlFFsJ0nZArMMyDbsK4VQAsicpJemt5e7UcQ6/ejNwJsMTTcttuqL3hWxHlWnuf6asVygyBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989982; c=relaxed/simple;
	bh=rNYgNQr5mkdtUhLGKFLW7WoA8FnDIdcH1ROMQwGb3HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+u3FOxQoYlqzcDiCnmP9hPADnI8QVhWjJOxB3w040vANQYcs5V2q5+W/2qFowi7x5FwclTm/okGXd03DDrwKVcHrcr8ntGBGvTKP638HeMy+0QqU+fozwNi4u20rz7UCXORuF0ELL3c8iv1RNZibVUCoRRmfnxVA1MQbJMIu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CznDH8OZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CznDH8OZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B412C2BCF4
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777989982;
	bh=rNYgNQr5mkdtUhLGKFLW7WoA8FnDIdcH1ROMQwGb3HI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=CznDH8OZkfci3IkrcPCxNPxUtXMmRMbNCkG0X7cs8TotwZFUCiXVEylt7yB7/ETo9
	 fTmCpCCCPiHFaYtSjfhwYDV6eFRZlnJLg1clUWLvvmY0LyBtEmdhxEcF0Qks8GfLhU
	 QbN9TolhxujFloiHthou3gCeRMWLN3TiIr8/wC5eE6fkhPVzNT9MlfAeFtU5+u9P91
	 P/K7hvucSBR54GUWicxoUuvGai1hAKs+wTuGg8KEVTrSPzsLNcCqPhcCkUG4hbH+Uf
	 MpQ0Tq0xGbrs4dePpipdRyiEbM1Pc3PSUdg2sf0z0I9uDf9xz1qDgysPU9kBQg0ye5
	 JGD1XZPCvauVg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so45134691fa.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 07:06:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8bD0cMcCQxmVCgI2laNijXYGpng1EMJOL4Kmj5FgpFap+jy3Y3BbDVFqSG7HT3s3FbLwSOAA82qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK771uUiz+pWo2u6byEjx5IfQ7gH8/Elu0NPQq0IH3IHPb0Fv8
	eaH4jFYphXRW6zppqTvesI9TcifFAVmp62Z/M/Es6V55kJs9bMHpIFdbZXZaXwI5NiFg8XSEXHi
	dGFo2hUKY2x+QQvY4YHNW5XOQ2qF2GPs=
X-Received: by 2002:a05:651c:1113:b0:38e:9eb1:6949 with SMTP id
 38308e7fff4ca-393b4d5c2d9mr13859431fa.14.1777989980570; Tue, 05 May 2026
 07:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504050245.646078-1-iuncuim@gmail.com> <20260504050245.646078-6-iuncuim@gmail.com>
In-Reply-To: <20260504050245.646078-6-iuncuim@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 5 May 2026 22:06:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v65e=vLh05=4LyyzGGta4ztfqaid1f-AxRby=AT_SG-6zA@mail.gmail.com>
X-Gm-Features: AVHnY4J0fkZsvugR5CVYJTl2H3_fmrJpYd2yKAtceV_whYV2Bj11TnBfcpEN4Vs
Message-ID: <CAGb2v65e=vLh05=4LyyzGGta4ztfqaid1f-AxRby=AT_SG-6zA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] Allwinner: A523: add support for A523 THS0/1 controllers
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

Hi,

On Mon, May 4, 2026 at 1:04=E2=80=AFPM Mikhail Kalashnikov <iuncuim@gmail.c=
om> wrote:

The correct format for the patch subject should be:

    arm64: dts: allwinner: sun55i: add thermal sensors

> The A523 processor has two temperature controllers, THS0 and THS1.
> THS0 has only one temperature sensor, which is located in the DRAM.
                                                                ^
                                                          "DRAM controller"=
.

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
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/=
boot/dts/allwinner/sun55i-a523.dtsi
> index 5afa8d92a..288a4710b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
>  #include <dt-bindings/power/allwinner,sun55i-a523-ppu.h>
>  #include <dt-bindings/power/allwinner,sun55i-a523-pck-600.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         interrupt-parent =3D <&gic>;
> @@ -26,6 +27,7 @@ cpu0: cpu@0 {
>                         device_type =3D "cpu";
>                         reg =3D <0x000>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu1: cpu@100 {
> @@ -33,6 +35,7 @@ cpu1: cpu@100 {
>                         device_type =3D "cpu";
>                         reg =3D <0x100>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu2: cpu@200 {
> @@ -40,6 +43,7 @@ cpu2: cpu@200 {
>                         device_type =3D "cpu";
>                         reg =3D <0x200>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu3: cpu@300 {
> @@ -47,6 +51,7 @@ cpu3: cpu@300 {
>                         device_type =3D "cpu";
>                         reg =3D <0x300>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu4: cpu@400 {
> @@ -54,6 +59,7 @@ cpu4: cpu@400 {
>                         device_type =3D "cpu";
>                         reg =3D <0x400>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu5: cpu@500 {
> @@ -61,6 +67,7 @@ cpu5: cpu@500 {
>                         device_type =3D "cpu";
>                         reg =3D <0x500>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu6: cpu@600 {
> @@ -68,6 +75,7 @@ cpu6: cpu@600 {
>                         device_type =3D "cpu";
>                         reg =3D <0x600>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>
>                 cpu7: cpu@700 {
> @@ -75,6 +83,7 @@ cpu7: cpu@700 {
>                         device_type =3D "cpu";
>                         reg =3D <0x700>;
>                         enable-method =3D "psci";
> +                       #cooling-cells =3D <2>;
>                 };
>         };
>
> @@ -565,12 +574,46 @@ dma: dma-controller@3002000 {
>                         #dma-cells =3D <1>;
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
> +                       #thermal-sensor-cells =3D <0>;
> +               };
> +

The device nodes are sorted by base address, so the thermal sensors should
be much further up in this file.

>                 sid: efuse@3006000 {
>                         compatible =3D "allwinner,sun55i-a523-sid",
>                                      "allwinner,sun50i-a64-sid";
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
> @@ -1087,4 +1130,115 @@ npu: npu@7122000 {
>                         power-domains =3D <&ppu PD_NPU>;
>                 };
>         };
> +
> +       thermal-zones {
> +               cpu0_thermal: cpu0-thermal {
> +                       polling-delay-passive =3D <100>;
> +                       polling-delay =3D <1000>;
> +                       thermal-sensors =3D <&ths1 1>;
> +                       sustainable-power =3D <1200>;
> +
> +                       trips {
> +                               cpu0_threshold: cpu-trip-0 {
> +                                       temperature =3D <70000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };

Please have one empty line between nodes, per the DT coding style.
Same for the other two "trips" nodes.

> +                               cpu0_target: cpu-trip-1 {
> +                                       temperature =3D <90000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               cpu0_critical: cpu-trip-2 {
> +                                       temperature =3D <110000>;s
> +                                       type =3D "critical";
> +                                       hysteresis =3D <0>;
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip =3D <&cpu0_target>;
> +                                       cooling-device =3D <&cpu0 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu1 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu2 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu3 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               cpu4_thermal: cpu4-thermal {
> +                       polling-delay-passive =3D <100>;
> +                       polling-delay =3D <1000>;
> +                       thermal-sensors =3D <&ths1 0>;
> +                       sustainable-power =3D <1600>;
> +
> +                       trips {
> +                               cpu4_threshold: cpu-trip-0 {
> +                                       temperature =3D <70000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               cpu4_target: cpu-trip-1 {
> +                                       temperature =3D <90000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               cpu4_critical: cpu-trip-2 {
> +                                       temperature =3D <110000>;
> +                                       type =3D "critical";
> +                                       hysteresis =3D <0>;
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map0 {
> +                                       trip =3D <&cpu4_target>;
> +                                       cooling-device =3D <&cpu4 THERMAL=
_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu5 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu6 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu7 THERMAL_N=
O_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +
> +               gpu-thermal {
> +                       polling-delay-passive =3D <100>;
> +                       polling-delay =3D <1000>;
> +                       thermal-sensors =3D <&ths1 2>;
> +                       sustainable-power =3D <2400>;
> +
> +                       gpu-trips {
> +                               gpu_temp_threshold: gpu-trip-0 {
> +                                       temperature =3D <60000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               gpu_temp_target: gpu-trip-1 {
> +                                       temperature =3D <90000>;
> +                                       type =3D "passive";
> +                                       hysteresis =3D <0>;
> +                               };
> +                               gpu_temp_critical: gpu-trip-2 {
> +                                       temperature =3D <110000>;
> +                                       type =3D "critical";
> +                                       hysteresis =3D <0>;
> +                               };
> +                       };
> +               };
> +
> +               ddr-thermal {
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;
> +                       thermal-sensors =3D <&ths0>;
> +
> +                       trips {
> +                               ddr_temp_critical: ddr-trip-0 {
> +                                       temperature =3D <110000>;
> +                                       type =3D "critical";
> +                                       hysteresis =3D <0>;
> +                               };
> +                       };
> +               };
> +       };
>  };
> --
> 2.54.0
>
