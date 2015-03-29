From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 7/7] ARM: dts: add OPPs for i.MX23/i.MX28
Date: Sun, 29 Mar 2015 21:09:08 +0200 (CEST)
Message-ID: <1275326545.964987.1427656148956.JavaMail.open-xchange@oxbaltgw00.schlund.de>
References: <1470793430.944631.1427565192794.JavaMail.open-xchange@oxbaltgw00.schlund.de> <201503291640.56538.juergen@kreuzholzen.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53042 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbC2TKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2015 15:10:48 -0400
In-Reply-To: <201503291640.56538.juergen@kreuzholzen.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juergen Borleis <juergen@kreuzholzen.de>
Cc: dbaryshkov@gmail.com, rjw@rjwysocki.net, kernel@pengutronix.de, pawel.moll@arm.com, lgirdwood@gmail.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org, shawn.guo@linaro.org, sre@kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, dwmw2@infradead.org, Lucas Stach <l.stach@pengutronix.de>, viresh.kumar@linaro.org, mark.rutland@arm.com, sebastien.szymanski@armadeus.com, broonie@kernel.org, marex@denx.de, devicetree@vger.kernel.org

Hi Juergen,

> Juergen Borleis <juergen@kreuzholzen.de> hat am 29. M=C3=A4rz 2015 um=
 16:40
> geschrieben:
>
>
> Hi Stefan,
>
> Stefan Wahren wrote:
> > > Juergen Borleis <juergen@kreuzholzen.de> hat am 24. M=C3=A4rz 201=
5 um 21:45
> > > geschrieben:
> > >
> > > Stefan Wahren wrote:
> > > > [...]
> > > > diff --git a/arch/arm/boot/dts/imx28.dtsi
> > > > b/arch/arm/boot/dts/imx28.dtsi index 98c1be6..21c1921 100644
> > > > --- a/arch/arm/boot/dts/imx28.dtsi
> > > > +++ b/arch/arm/boot/dts/imx28.dtsi
> > > > @@ -38,12 +38,23 @@
> > > > };
> > > >
> > > > cpus {
> > > > - #address-cells =3D <0>;
> > > > + #address-cells =3D <1>;
> > > > #size-cells =3D <0>;
> > > >
> > > > - cpu {
> > > > + cpu@0 {
> > > > compatible =3D "arm,arm926ej-s";
> > > > device_type =3D "cpu";
> > > > + reg =3D <0x0>;
> > > > + operating-points =3D <
> > > > + /* kHz uV */
> > > > + 261819 1350000
> > > > + 360000 1350000
> > > > + 392728 1450000
> > > > + 454737 1550000
> > > > + >;
> > > > + clocks =3D <&clks 4>;
> > > > + clock-latency =3D <61036>; /* two CLK32 periods */
> > > > + cpu-supply =3D <&reg_vddd>;
> > > > };
> > > > };
> > >
> > > Maybe you should take into account not to reduce VDD below 1.55 V=
 if the
> > > SDRAM controller runs above 196 MHz. The i.MX28 datasheet[1] list=
s these
> > > restrictions. VDD powers the SDRAM controller as well. From the d=
atasheet
> > > the table "Frequency versus Voltage for EMICLK" shows:
> > >
> > > EMICLK Fmax (MHz)
> > > VDDD (V) DDR2 mDDR
> > > --------------------------------
> > > 1.550 205.71 205.71
> > > 1.450 196.36 196.36
> > > 1.350 196.36 196.36
> > >
> > > jbe
> > >
> > > [1]
> > > i.MX28 Applications
> > > Processors for Consumer
> > > Products
> > > Silicon Version 1.2
> > >
> > > Document Number: IMX28CEC
> > > Rev. 3, 07/2012
> >
> > the only chance that i see to meet this constraint without introduc=
ing a
> > new cpufreq driver is to change clock ref_cpu
> > and ref_emi.
> >
> > Do you think this solution of a virtual clock [1] can be applied he=
re, too?
>
> This would imply we can change the SDRAM timing at run-time on the fl=
y. IMHO
> that is not possible (at least not easy).

it's possible since the cpufreq driver in the FSL can do it. But the co=
de isn't
nice and contains some workarounds.

> I think when the driver detects the SDRAM controller runs above 196 M=
Hz the
> clock for the CPU core can still be
> changed, but VDD must be kept at 1.55 V.

The cpufreq-dt doesn't know anything about SDRAM controller and i think=
 it isn't
necessary if we use 1.55 V for all
operating points.

>
> Juergen

Stefan
