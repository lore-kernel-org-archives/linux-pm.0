From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 2/2] Documentation: Add device tree bindings document
 for max77843
Date: Tue, 28 Apr 2015 14:35:00 +0100
Message-ID: <20150428133500.GE9169@x1>
References: <1427808215-19178-1-git-send-email-beomho.seo@samsung.com>
 <1427808215-19178-3-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427808215-19178-3-git-send-email-beomho.seo@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: sre@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, cw00.choi@samsung.com, sangbae90.lee@samsung.com, inki.dae@samsung.com, Jaewon Kim <jaewon02.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

DT Ack please.

> From: Jaewon Kim <jaewon02.kim@samsung.com>
>=20
> Add document describing device tree bindings for max77843 MFD.
> Drivers: MFD core, regulator, extcon, charger and fuelgauge.
>=20
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  Documentation/devicetree/bindings/mfd/max77843.txt |  100 ++++++++++=
++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77843.tx=
t
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/max77843.txt b/Doc=
umentation/devicetree/bindings/mfd/max77843.txt
> new file mode 100644
> index 0000000..4111f84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max77843.txt
> @@ -0,0 +1,100 @@
> +Maxim MAX77843 multi-function device
> +
> +MAX77843 is a Multi-Function Device with the following submodules:
> +- PMIC	  : 2 SAFEOUT LDOs for USB device
> +- CHARGER : Li+ battery charger with Fuel Gauge
> +- MUIC	  : Micro USB Interface Controller
> +- HAPTIC  : Motor Controller for tactile feedback
> +
> +It is interfaced to host controller using I2C.
> +
> +Required properties:
> +- compatible : Must be "maxim,max77843".
> +- reg : I2C slave address of PMIC block.
> +- interrupts : I2C line for main SoCs.
> +- interrupt-parent : The parent of interrupt controller.
> +
> +Optional properties:
> +- regulators : The regulators of max77843 have to be instantiated un=
der subnode
> +	named "regulators" using the following format.
> +
> +	[*]refer : Documentation/devicetree/bindings/regulator/regulator.tx=
t
> +
> +	regulators {
> +		SAFEOUT {
> +			regulator-name =3D "SAFEOUT";
> +		};
> +	}
> +
> +	List of valid regulator names:
> +	- SAFEOUT1, SAFEOUT2, CHARGER.
> +
> +- max77843-muic : This properties used by extcon consumers.
> +	Required properties:
> +		- compatible : Must be "maxim,max77842-muic".
> +
> +- max77843-charger : There battery charger of MAX77843 have to be in=
stantiated
> +	under sub-node named "max77843-charger" using the following format.
> +	Required properties:
> +		- compatible : Must be "maxim,max77842-charger".
> +		- maxim,fast-charge-uamp : Fast charge current levels are
> +			100 mA to 3150 mA programmed by I2C per 100 mA.
> +		- maxim,top-off-uamp : Top off current threshold levels are
> +			125 mA to 650 mA programmed by I2C per 75 mA.
> +		- maxim,input-uamp-limit : Input current limit levels are
> +			100 mA to 3533 mA programmed by I2C per 33 mA.
> +
> +- max77843-haptic : The MAX77843 haptic device provides the tactile =
feedback
> +	to the user by using PWM(Pulse Width Modulation) signal.
> +	Required properties:
> +		- compatible : Must be "maxim,max77843-hpatic".
> +		- haptic-supply : Power supply for the haptic motor.
> +			[*] refer Documentation/devicetree/
> +					bindings/regulator/regulator.txt
> +		- pwms : phandle for the PWM(Pulse Width Modulation) device.
> +			PWM properties should be named "pwms".
> +			[*] refer Documentation/devicetree/bindings/pwm/pwm.txt
> +
> +Example:
> +	max77843@66 {
> +		compatible =3D "samsung,max77843";
> +		reg =3D <0x66>;
> +		interrupt-parent =3D <&gpa1>;
> +		interrupts =3D <5 2>;
> +
> +		regulators {
> +			SAFEOUT1 {
> +				regulator-name =3D "SAFEOUT1";
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <4950000>;
> +			};
> +			SAFEOUT2 {
> +				regulator-name =3D "SAFEOUT2";
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <4950000>;
> +			};
> +			CHARGER {
> +				regulator-name =3D "CHARGER";
> +				regulator-min-microamp =3D <100000>;
> +				regulator-max-microamp =3D <3150000>;
> +			};
> +		};
> +
> +		haptic {
> +			compatible =3D "maxim,max77843-haptic";
> +			haptic-supply =3D <&haptic_supply>;
> +			pwms =3D <&pwm 0 40000 0>;
> +			pwm-names =3D "haptic";
> +		};
> +
> +		max77843-muic {
> +			compatible =3D "maxim,max77843-muic";
> +		};
> +
> +		max77843-charger {
> +			compatible =3D "maxim,max77843-charger";
> +			maxim,fast-charge-uamp =3D <450000>;
> +			maxim,top-off-uamp =3D <125000>;
> +			maxim,input-uamp-limit =3D <500000>;
> +		};
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
