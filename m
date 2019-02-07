From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 4/8] devicetree: bindings: Document first ROHM BD70528
 bindings
Date: Thu, 7 Feb 2019 14:04:18 +0000
Message-ID: <20190207140418.GH20638@dell>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <52b17ed2599b21f4b93665ac689113ce3f8816b7.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52b17ed2599b21f4b93665ac689113ce3f8816b7.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 07 Feb 2019, Matti Vaittinen wrote:

> Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> drivers) and 4 GPIO pins which can be configured for I/O or
> as interrupt sources withe configurable trigger levels.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> new file mode 100644
> index 000000000000..f80be7e40184
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> @@ -0,0 +1,102 @@
> +* ROHM BD70528 Power Management Integrated Circuit bindings
> +
> +BD70528MWV is an ultra-low Iq general purpose single-chip power management IC

What's an Iq?

> +for battery-powered portable devices. The IC integrates 3 ultra-low current
> +consumption buck converters, 3 LDOs and 2 LED Drivers. Also included are 4
> +GPIOs, a real-time clock (RTC), a 32kHz clock gate, high-accuracy VREF
> +for use with an external ADC, flexible dual-input power path, 10 bits SAR ADC

"bit"

> +for battery temperature monitor and 1S battery charger with scalable charge
> +currents.
> +
> +Required properties:
> + - compatible		: Should be "rohm,bd70528"
> + - reg			: I2C slave address.
> + - interrupts		: The interrupt line the device is connected to.
> + - interrupt-controller	: To indicate bd70528 acts as an interrupt controller.

"BS70528"

> + - #interrupt-cells	: Should be 2. usage is compliant to the 2 cells

"Usage"

> +			  variant of ../interrupt-controller/interrupts.txt
> + - gpio-controller	: To indicate bd70528 acts as a gpio controller.

"BD*"

"GPIO"

> + - #gpio-cells		: Should be 2. The first cell is the pin number and
> +			  the second cell is used to specify flags. See
> +			  ../gpio/gpio.txt for more information.
> + - #clock-cells		: Should be 0.
> + - regulators:		: List of child nodes that specify the regulators.
> +			  Please see ../regulator/rohm,bd70528-regulator.txt
> +
> +Optional properties:
> + - clock-output-names	: Should contain name for output clock.
> +
> +Example:
> +/* external oscillator */
> +osc: oscillator {
> +	compatible = "fixed-clock";
> +	#clock-cells = <1>;
> +	clock-frequency  = <32768>;
> +	clock-output-names = "osc";
> +};
> +
> +pmic: pmic@4b {
> +	compatible = "rohm,bd70528";
> +	reg = <0x4b>;
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <29 GPIO_ACTIVE_LOW>;
> +	clocks = <&osc 0>;
> +	#clock-cells = <0>;
> +	clock-output-names = "bd70528-32k-out";
> +	#gpio-cells = <2>;
> +	gpio-controller;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +
> +	regulators {
> +		buck1: BUCK1 {
> +			regulator-name = "buck1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <3400000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <125>;
> +		};
> +		buck2: BUCK2 {
> +			regulator-name = "buck2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <125>;
> +		};
> +		buck3: BUCK3 {
> +			regulator-name = "buck3";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <250>;
> +		};
> +		ldo1: LDO1 {
> +			regulator-name = "ldo1";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +		};
> +		ldo2: LDO2 {
> +			regulator-name = "ldo2";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +		};
> +
> +		ldo3: LDO3 {
> +			regulator-name = "ldo3";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +		led_ldo1: LED_LDO1 {
> +			regulator-name = "led_ldo1";
> +			regulator-min-microvolt = <200000>;
> +			regulator-max-microvolt = <300000>;
> +		};
> +		led_ldo2: LED_LDO2 {
> +			regulator-name = "led_ldo2";
> +			regulator-min-microvolt = <200000>;
> +			regulator-max-microvolt = <300000>;
> +		};
> +	};
> +};

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
