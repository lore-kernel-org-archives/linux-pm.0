From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/2] Documentation: Add documentation for rt5033
 multifunction device
Date: Thu, 22 Jan 2015 09:02:43 +0000
Message-ID: <20150122090243.GA5465@x1>
References: <1421899601-19327-1-git-send-email-beomho.seo@samsung.com>
 <1421899601-19327-3-git-send-email-beomho.seo@samsung.com>
 <20150122074101.GK22024@x1>
 <54C0B1EA.7030901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:62399 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbbAVJCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jan 2015 04:02:50 -0500
Received: by mail-ie0-f169.google.com with SMTP id rl12so352273iec.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2015 01:02:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54C0B1EA.7030901@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org, lee.jone@linaro.org, broonie@kernel.org, dbaryshkov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, cw00.choi@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com

On Thu, 22 Jan 2015, Beomho Seo wrote:

> On 01/22/2015 04:41 PM, Lee Jones wrote:
> > On Thu, 22 Jan 2015, Beomho Seo wrote:
> >=20
> >> This patch device tree binding documentation for rt5033 multifunct=
ion device.
> >>
> >> Cc: Sebastian Reichel <sre@kernel.org>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Pawel Moll <pawel.moll@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Ian campbell <ijc+devicetree@hellion.org.uk>
> >> Cc: Kumar Gala <galak@codeaurora.org>
> >> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> >> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Acked-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > I did not Ack this patch.
> >=20
> > Your new vendor bindings require a DT Ack.
> >=20
> > Although, as the ones I'm concerned with are Regulator related, and
> > Ack from Mark Brown will also suffice.
> >=20
>=20
> I want to apologize for my mistake. I completely misunderstood your r=
eply.
> Unfortunately, This patch merged by Sebastian at his git.
> Please tell me what to do.

That's strange, as I haven't heard anything from Sebastian.

Anyway, he needs to remove it from his tree until we receive a
suitable Ack.

> >> ---
> >> Changes in v4
> >> - none.
> >> Changes in v3
> >> - Add Acked-by
> >> Changes in v2
> >> - Fix incorrect typo.
> >> - Align -uamp and -uvolt names with regulator binding suffixes.
> >> - Drop incorrect phandle.
> >> - Fix incorrect example.
> >> ---
> >>
> >>  Documentation/devicetree/bindings/mfd/rt5033.txt   |  101 +++++++=
+++++++++++++
> >>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
> >>  2 files changed, 102 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/rt5033.t=
xt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/rt5033.txt b/Do=
cumentation/devicetree/bindings/mfd/rt5033.txt
> >> new file mode 100644
> >> index 0000000..64b23e8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/rt5033.txt
> >> @@ -0,0 +1,101 @@
> >> +Richtek RT5033 Power management Integrated Circuit
> >> +
> >> +RT5033 is a Multifunction device which includes battery charger, =
fuel gauge,
> >> +flash LED current source, LDO and synchronous Buck converter for =
portable
> >> +applications. It is interfaced to host controller using i2c inter=
face.
> >> +
> >> +Required properties:
> >> +- compatible : Must be "richtek,rt5033"
> >> +- reg : Specifies the i2c slave address of general part.
> >> +- interrupts : This i2c devices has an IRQ line connected to the =
main SoC.
> >> +- interrupt-parent : The parent interrupt controller.
> >> +
> >> +Optional node:
> >> +Regulators: The regulators of RT5033 have to be instantiated unde=
r sub-node
> >> +named "regulators" using the following format.
> >> +
> >> +	regulators {
> >> +		regulator-name {
> >> +			regulator-name =3D LDO/BUCK
> >> +			regulator subnodes called X, Y and Z
> >> +		};
> >> +	};
> >> +	refer Documentation/devicetree/bindings/regulator/regulator.txt
> >> +
> >> +
> >> +Battery charger: There battery charger of RT5033 have to be insta=
ntiated under
> >> +sub-node named "charger" using the following format.
> >> +
> >> +Required properties:
> >> +- compatible : Must be "richtek,rt5033-charger".
> >> +- richtek,pre-uamp : Current of pre-charge mode. The pre-charge c=
urrent levels
> >> +  are 350 mA to 650 mA programmed by I2C per 100 mA.
> >> +- richtek,fast-uamp : Current of fast-charge mode. The fast-charg=
e current
> >> +  levels are 700 mA to 2000 mA programmed by I2C per 100 mA.
> >> +- richtek,eoc-uamp : This property is end of charge current. Its =
level 150 mA
> >> +  to 200 mA.
> >> +- richtek,pre-threshold-uvolt : Voltage of threshold pre-charge m=
ode. Battery
> >> +  voltage is below pre-charge threshold voltage, the charger is i=
n pre-charge
> >> +  mode with pre-charge current. Its levels are 2.3 V  to 3.8 V pr=
ogrammed
> >> +  by I2C per 0.1 V.
> >> +- richtek,const-uvolt :  Battery regulation voltage of constant v=
oltage mode.
> >> +  This voltage level 3.65 V to 4.4 V bye I2C per 0.025 V.
> >> +
> >> +	charger {
> >> +		compatible =3D "richtek,rt5033-charger";
> >> +		richtek,pre-uamp =3D <350000>;
> >> +		richtek,fast-uamp =3D <2000000>;
> >> +		richtek,eoc-uamp =3D <250000>;
> >> +		richtek,pre-threshold-uvolt =3D <3400000>;
> >> +		richtek,const-uvolt =3D <4350000>;
> >> +
> >> +	};
> >> +
> >> +
> >> +Fuelgauge: There fuelgauge of RT5033 to be instantiated node name=
d "fuelgauge"
> >> +using the following format.
> >> +
> >> +Required properties:
> >> +- compatible =3D Must be "richtek,rt5033-battery".
> >> +
> >> +	rt5033@35 {
> >> +		compatible =3D "richtek,rt5033-battery";
> >> +		interrupt-parent =3D <&gpx2>;
> >> +		interrupts =3D <3 0>;
> >> +		reg =3D <0x35>;
> >> +	};
> >> +
> >> +Example:
> >> +
> >> +		rt5033@34 {
> >> +			compatible =3D "richtek,rt5033";
> >> +			reg =3D <0x34>;
> >> +			interrupt-parent =3D <&gpx1>;
> >> +			interrupts =3D <5 0>;
> >> +
> >> +			regulators {
> >> +				buck_reg: BUCK {
> >> +					regulator-name =3D "BUCK";
> >> +					regulator-min-microvolt =3D <1200000>;
> >> +					regulator-max-microvolt =3D <1200000>;
> >> +					regulator-always-on;
> >> +				};
> >> +			};
> >> +
> >> +			charger {
> >> +				compatible =3D "richtek,rt5033-charger";
> >> +				richtek,pre-uamp =3D <350000>;
> >> +				richtek,fast-uamp =3D <2000000>;
> >> +				richtek,eoc-uamp =3D <250000>;
> >> +				richtek,pre-threshold-uvolt =3D <3400000>;
> >> +				richtek,const-uvolt =3D <4350000>;
> >> +			};
> >> +
> >> +		};
> >> +
> >> +		rt5033@35 {
> >> +				compatible =3D "richtek,rt5033-battery";
> >> +				interrupt-parent =3D <&gpx2>;
> >> +				interrupts =3D <3 0>;
> >> +				reg =3D <0x35>;
> >> +		};
> >> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt=
 b/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> index b1df0ad..b6a2ca1 100644
> >> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> >> @@ -134,6 +134,7 @@ ralink	Mediatek/Ralink Technology Corp.
> >>  ramtron	Ramtron International
> >>  realtek Realtek Semiconductor Corp.
> >>  renesas	Renesas Electronics Corporation
> >> +richtek	Richtek Technology Corporation
> >>  ricoh	Ricoh Co. Ltd.
> >>  rockchip	Fuzhou Rockchip Electronics Co., Ltd
> >>  samsung	Samsung Semiconductor
> >=20
>=20
> Thanks,
> Beomho Seo

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
