From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 7/7] ARM: dts: add OPPs for i.MX23/i.MX28
Date: Sat, 28 Mar 2015 18:53:12 +0100 (CET)
Message-ID: <1470793430.944631.1427565192794.JavaMail.open-xchange@oxbaltgw00.schlund.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50035 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbbC1R4p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 28 Mar 2015 13:56:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juergen Borleis <juergen@kreuzholzen.de>, viresh.kumar@linaro.org, Lucas Stach <l.stach@pengutronix.de>
Cc: kernel@pengutronix.de, rjw@rjwysocki.net, dbaryshkov@gmail.com, pawel.moll@arm.com, galak@codeaurora.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, shawn.guo@linaro.org, sre@kernel.org, linux-pm@vger.kernel.org, fabio.estevam@freescale.com, dwmw2@infradead.org, mark.rutland@arm.com, sebastien.szymanski@armadeus.com, broonie@kernel.org, marex@denx.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

> Juergen Borleis <juergen@kreuzholzen.de> hat am 24. M=C3=A4rz 2015 um=
 21:45
> geschrieben:
>
>
> Stefan Wahren wrote:
> > [...]
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28=
=2Edtsi
> > index 98c1be6..21c1921 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -38,12 +38,23 @@
> > };
> >
> > cpus {
> > - #address-cells =3D <0>;
> > + #address-cells =3D <1>;
> > #size-cells =3D <0>;
> >
> > - cpu {
> > + cpu@0 {
> > compatible =3D "arm,arm926ej-s";
> > device_type =3D "cpu";
> > + reg =3D <0x0>;
> > + operating-points =3D <
> > + /* kHz uV */
> > + 261819 1350000
> > + 360000 1350000
> > + 392728 1450000
> > + 454737 1550000
> > + >;
> > + clocks =3D <&clks 4>;
> > + clock-latency =3D <61036>; /* two CLK32 periods */
> > + cpu-supply =3D <&reg_vddd>;
> > };
> > };
>
> Maybe you should take into account not to reduce VDD below 1.55 V if =
the SDRAM
> controller runs above 196 MHz. The i.MX28 datasheet[1] lists these
> restrictions. VDD powers the SDRAM controller as well. From the datas=
heet the
> table "Frequency versus Voltage for EMICLK" shows:
>
> EMICLK Fmax (MHz)
> VDDD (V) DDR2 mDDR
> --------------------------------
> 1.550 205.71 205.71
> 1.450 196.36 196.36
> 1.350 196.36 196.36
>
> jbe
>
> [1]
> i.MX28 Applications
> Processors for Consumer
> Products
> Silicon Version 1.2
>
> Document Number: IMX28CEC
> Rev. 3, 07/2012

the only chance that i see to meet this constraint without introducing =
a new
cpufreq driver is to change clock ref_cpu
and ref_emi.

Do you think this solution of a virtual clock [1] can be applied here, =
too?

Best regards
Stefan

[1] -
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/29=
0822.html
