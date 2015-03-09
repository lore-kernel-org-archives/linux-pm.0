From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] Documentation: Add documentation for rt5033
 multifunction device
Date: Mon, 9 Mar 2015 07:43:28 +0000
Message-ID: <20150309074328.GG3318@x1>
References: <1425864191-4121-1-git-send-email-beomho.seo@samsung.com>
 <1425864191-4121-3-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425864191-4121-3-git-send-email-beomho.seo@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sre@kernel.org, cw00.choi@samsung.com, sangbae90.lee@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com
List-Id: linux-pm@vger.kernel.org

=46AO Mark,

> This patch device tree binding documentation for rt5033 multifunction=
 device.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes in v5
> - Remove wrong Acked-by.
> Changes in v4
> - none.
> Changes in v3
> - Add Acked-by
> Changes in v2
> - Fix incorrect typo.
> - Align -uamp and -uvolt names with regulator binding suffixes.
> - Drop incorrect phandle.
> - Fix incorrect example.
> ---
>  Documentation/devicetree/bindings/mfd/rt5033.txt   |  101 ++++++++++=
++++++++++

[...]

>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +

This change will be low resistance.  I suggest you separate it out
into another patch.

>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rt5033.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rt5033.txt b/Docum=
entation/devicetree/bindings/mfd/rt5033.txt
> new file mode 100644
> index 0000000..64b23e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rt5033.txt
> @@ -0,0 +1,101 @@
> +Richtek RT5033 Power management Integrated Circuit
> +
> +RT5033 is a Multifunction device which includes battery charger, fue=
l gauge,
> +flash LED current source, LDO and synchronous Buck converter for por=
table
> +applications. It is interfaced to host controller using i2c interfac=
e.
> +
> +Required properties:
> +- compatible : Must be "richtek,rt5033"
> +- reg : Specifies the i2c slave address of general part.
> +- interrupts : This i2c devices has an IRQ line connected to the mai=
n SoC.
> +- interrupt-parent : The parent interrupt controller.
> +
> +Optional node:
> +Regulators: The regulators of RT5033 have to be instantiated under s=
ub-node
> +named "regulators" using the following format.
> +
> +	regulators {
> +		regulator-name {
> +			regulator-name =3D LDO/BUCK
> +			regulator subnodes called X, Y and Z
> +		};
> +	};
> +	refer Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +
> +Battery charger: There battery charger of RT5033 have to be instanti=
ated under
> +sub-node named "charger" using the following format.
> +
> +Required properties:
> +- compatible : Must be "richtek,rt5033-charger".
> +- richtek,pre-uamp : Current of pre-charge mode. The pre-charge curr=
ent levels
> +  are 350 mA to 650 mA programmed by I2C per 100 mA.
> +- richtek,fast-uamp : Current of fast-charge mode. The fast-charge c=
urrent
> +  levels are 700 mA to 2000 mA programmed by I2C per 100 mA.
> +- richtek,eoc-uamp : This property is end of charge current. Its lev=
el 150 mA
> +  to 200 mA.
> +- richtek,pre-threshold-uvolt : Voltage of threshold pre-charge mode=
=2E Battery
> +  voltage is below pre-charge threshold voltage, the charger is in p=
re-charge
> +  mode with pre-charge current. Its levels are 2.3 V  to 3.8 V progr=
ammed
> +  by I2C per 0.1 V.
> +- richtek,const-uvolt :  Battery regulation voltage of constant volt=
age mode.
> +  This voltage level 3.65 V to 4.4 V bye I2C per 0.025 V.

These require a Regulator (or Charger?) Ack.

> +	charger {
> +		compatible =3D "richtek,rt5033-charger";
> +		richtek,pre-uamp =3D <350000>;
> +		richtek,fast-uamp =3D <2000000>;
> +		richtek,eoc-uamp =3D <250000>;
> +		richtek,pre-threshold-uvolt =3D <3400000>;
> +		richtek,const-uvolt =3D <4350000>;
> +
> +	};
> +
> +
> +Fuelgauge: There fuelgauge of RT5033 to be instantiated node named "=
fuelgauge"
> +using the following format.
> +
> +Required properties:
> +- compatible =3D Must be "richtek,rt5033-battery".
> +
> +	rt5033@35 {
> +		compatible =3D "richtek,rt5033-battery";
> +		interrupt-parent =3D <&gpx2>;
> +		interrupts =3D <3 0>;
> +		reg =3D <0x35>;
> +	};
> +
> +Example:
> +
> +		rt5033@34 {
> +			compatible =3D "richtek,rt5033";
> +			reg =3D <0x34>;
> +			interrupt-parent =3D <&gpx1>;
> +			interrupts =3D <5 0>;
> +
> +			regulators {
> +				buck_reg: BUCK {
> +					regulator-name =3D "BUCK";
> +					regulator-min-microvolt =3D <1200000>;
> +					regulator-max-microvolt =3D <1200000>;
> +					regulator-always-on;
> +				};
> +			};
> +
> +			charger {
> +				compatible =3D "richtek,rt5033-charger";
> +				richtek,pre-uamp =3D <350000>;
> +				richtek,fast-uamp =3D <2000000>;
> +				richtek,eoc-uamp =3D <250000>;
> +				richtek,pre-threshold-uvolt =3D <3400000>;
> +				richtek,const-uvolt =3D <4350000>;
> +			};
> +
> +		};
> +
> +		rt5033@35 {
> +				compatible =3D "richtek,rt5033-battery";
> +				interrupt-parent =3D <&gpx2>;
> +				interrupts =3D <3 0>;
> +				reg =3D <0x35>;
> +		};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/=
Documentation/devicetree/bindings/vendor-prefixes.txt
> index 389ca13..73d235a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -149,6 +149,7 @@ ralink	Mediatek/Ralink Technology Corp.
>  ramtron	Ramtron International
>  realtek Realtek Semiconductor Corp.
>  renesas	Renesas Electronics Corporation
> +richtek	Richtek Technology Corporation
>  ricoh	Ricoh Co. Ltd.
>  rockchip	Fuzhou Rockchip Electronics Co., Ltd
>  samsung	Samsung Semiconductor

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
