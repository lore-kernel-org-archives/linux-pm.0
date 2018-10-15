From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: RE: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
Date: Mon, 15 Oct 2018 02:44:00 +0000
Message-ID: <VI1PR04MB4800555506B64C9E93F9ED36F3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-7-git-send-email-vabhav.sharma@nxp.com>
 <20181008055159.GH3587@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008055159.GH3587@dragon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Shawn Guo
> Sent: Monday, October 8, 2018 11:22 AM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: sudeep.holla@arm.com; oss@buserror.net; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; sboyd@kernel.org; rjw@rjwysocki.net;
> viresh.kumar@linaro.org; linux-clk@vger.kernel.org; linux-pm@vger.kernel.=
org;
> linux-kernel-owner@vger.kernel.org; catalin.marinas@arm.com;
> will.deacon@arm.com; gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com; Leo Li
> <leoyang.li@nxp.com>; linux@armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com=
>;
> Udit Kumar <udit.kumar@nxp.com>; Pankaj Bansal <pankaj.bansal@nxp.com>;
> Priyanka Jain <priyanka.jain@nxp.com>; Sriram Dash <sriram.dash@nxp.com>
> Subject: Re: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
>=20
> On Thu, Oct 04, 2018 at 06:33:51AM +0530, Vabhav Sharma wrote:
> > LX2160A reference design board (RDB) is a high-performance computing,
> > evaluation, and development platform with LX2160A SoC.
> >
> > Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile            |   1 +
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 100
> > ++++++++++++++++++++++
> >  2 files changed, 101 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index 86e18ad..445b72b 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-
> rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-simu.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > new file mode 100644
> > index 0000000..1483071
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree file
> > +for LX2160ARDB // // Copyright 2018 NXP
> > +
> > +/dts-v1/;
> > +
> > +#include "fsl-lx2160a.dtsi"
> > +
> > +/ {
> > +	model =3D "NXP Layerscape LX2160ARDB";
> > +	compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	sb_3v3: regulator-fixed {
>=20
> The node name should probably be named like regulator-sb3v3 or something,=
 so
> that the pattern can be followed when we have another fixed regulator to =
be
> added.
Ok, Agree this is fixed 3.3 standby voltage for i2c subchannels
Updating to regulator-sb3v3=20
>=20
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "fixed-3.3V";
>=20
> The name should be something we can find on board schematics.
Sure, I will update SMPS name which provide fixed 3.3 stand-by voltage
>=20
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +
> > +};
> > +
> > +&uart0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c0 {
>=20
> Please keep these labeled nodes sorted alphabetically.
Ok
>=20
> > +	status =3D "okay";
>=20
> Have a newline between properties and child node.
Sure.
>=20
> > +	i2c-mux@77 {
> > +		compatible =3D "nxp,pca9547";
> > +		reg =3D <0x77>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		i2c@2 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			reg =3D <0x2>;
> > +
> > +			power-monitor@40 {
> > +				compatible =3D "ti,ina220";
> > +				reg =3D <0x40>;
> > +				shunt-resistor =3D <1000>;
> > +			};
> > +		};
> > +
> > +		i2c@3 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			reg =3D <0x3>;
> > +
> > +			temperature-sensor@4c {
> > +				compatible =3D "nxp,sa56004";
> > +				reg =3D <0x4c>;
> > +				vcc-supply =3D <&sb_3v3>;
> > +			};
> > +
> > +			temperature-sensor@4d {
> > +				compatible =3D "nxp,sa56004";
> > +				reg =3D <0x4d>;
> > +				vcc-supply =3D <&sb_3v3>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c4 {
> > +	status =3D "okay";
> > +
> > +	rtc@51 {
> > +		compatible =3D "nxp,pcf2129";
> > +		reg =3D <0x51>;
> > +		// IRQ10_B
> > +		interrupts =3D <0 150 0x4>;
> > +		};
>=20
> Bad indentation.
My mistake, Updated
>=20
> Shawn
>=20
> > +
> > +};
> > +
> > +&usb0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usb1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&crypto {
> > +	status =3D "okay";
> > +};
> > --
> > 2.7.4
> >
