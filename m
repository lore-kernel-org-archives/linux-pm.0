From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] devicetree: Add UCS1002 USB Port Power Controller
 binding
Date: Thu, 28 Jan 2016 20:35:39 -0600
Message-ID: <20160129023539.GA3092@rob-hp-laptop>
References: <1453799541-5445-1-git-send-email-enric.balletbo@collabora.com>
 <1453799541-5445-2-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453799541-5445-2-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Martyn Welch <martyn.welch@collabora.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 26, 2016 at 10:12:20AM +0100, Enric Balletbo i Serra wrote:
> The UCS1002-2 provides a USB port power switch for precise control of up
> to 2.5 amperes continuous current.
> 
> You can add support to your board with current binding.
> 
> Example:
> 
>     ucs1002: ucs1002@57 {
>              compatible = "microchip,ucs1002";
>              reg = <0x57>;
>              microchip,pin-ignore;
>     };
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  .../devicetree/bindings/power/ucs1002.txt          | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/ucs1002.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/ucs1002.txt b/Documentation/devicetree/bindings/power/ucs1002.txt
> new file mode 100644
> index 0000000..1b89f0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/ucs1002.txt
> @@ -0,0 +1,47 @@
> +UCS1002-2 Programmable USB Port Power Controller with Charger Emulation bindings
> +
> +Required properties:
> +- compatible: "microchip,ucs1002"
> +- reg: integer, the I2C address of the device.
> +
> +Required properties (if pin-ignore functionality is not set):
> +- em-gpios: which GPIO to use for EM_EN pin.
> +- pwr-gpios: which GPIO to use for PWR_EN pin.
> +- m1-gpios: which GPIO to use for M1 pin.
> +- m2-gpios: which GPIO to use for M2 pin.
> +
> +Optional properties:
> +- interrupt-parent: the phandle of the interrupt controller that services
> +    interrupts for this device.
> +- interrupts: interrupt specifiers for two interrupt sources.
> +    - First interrupt specifier is for A_DET interrupt.
> +    - Second interrupt specifier is for ALERT interrupt.
> +- microchip,current-limit: integer, maximum current in mA. Note that the default

mA or ...

> +    value is based on the resistor on the COMM_SEL/ILIM pin and this value cannot
> +    be changed to be higher than hardware set value. Accepted values are: 500000,
> +    900000, 1000000, 1200000, 1500000, 1800000, 2000000, 2500000 (uA)

uA?

Either way append units (-microamps)

> +- microchip,pin-ignore: boolean, if present uses I2C for configuration, otherwise,
> +    we must provide EM_EN, M1 and M2 gpio mapping.

Wouldn't this be implied by absence of gpio properties?

> +
> +Example (poll):
> +
> +	ucs1002: ucs1002@57 {
> +		compatible = "microchip,ucs1002";
> +		reg = <0x57>;
> +		microchip,current-limit = <2000000>;
> +		microchip,pin-ignore;
> +	};
> +
> +Example (interrupts + pin control):
> +
> +	ucs1002: ucs1002@57 {
> +		compatible = "microchip,ucs1002";
> +		reg = <0x57>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <30 0>, <31 0>;
> +		microchip,current-limit = <2000000>;
> +		em-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> +		m1-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
> +		m2-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +		pwr-gpios = <&gpio1 19 0>;
> +	};
> -- 
> 2.1.0
> 
