From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2 1/2] devicetree: Add UCS1002 USB Port Power Controller
 binding
Date: Sun, 21 Feb 2016 20:54:46 -0600
Message-ID: <20160222025446.GN15973@rob-hp-laptop>
References: <1455789171-5093-1-git-send-email-enric.balletbo@collabora.com>
 <1455789171-5093-2-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455789171-5093-2-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Martyn Welch <martyn.welch@collabora.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 18, 2016 at 10:52:50AM +0100, Enric Balletbo i Serra wrote:
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
>     };
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes since v1:
>  - Fix units, are microamps (Rob Herring)
>  - Remove microchip,pin-ignore as is implied by absence of gpio properties (Rob
>    Herring)
>  - Group control gpios instead of use separate gpios. All control gpios must be
>    set together (Enric Balletbo)
> 
>  .../devicetree/bindings/power/ucs1002.txt          | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/ucs1002.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/ucs1002.txt b/Documentation/devicetree/bindings/power/ucs1002.txt
> new file mode 100644
> index 0000000..bb2f91e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/ucs1002.txt
> @@ -0,0 +1,41 @@
> +UCS1002-2 Programmable USB Port Power Controller with Charger Emulation bindings
> +
> +Required properties:
> +- compatible: "microchip,ucs1002"
> +- reg: integer, the I2C address of the device.
> +
> +Optional properties:
> +- interrupt-parent: the phandle of the interrupt controller that services
> +    interrupts for this device.
> +- interrupts: interrupt specifiers for two interrupt sources.
> +    - First interrupt specifier is for A_DET interrupt.
> +    - Second interrupt specifier is for ALERT interrupt.
> +- microchip,current-limit: integer, maximum current in microamps. Note that the

This needs a microamps as a suffix (e.g. 
microchip,current-limit-microamps). That's kind of long, so maybe drop 
"current" from the name as that is implied with the units.

> +    default value is based on the resistor on the COMM_SEL/ILIM pin and this
> +    value cannot be changed to be higher than hardware set value. Accepted
> +    values are: 500000, 900000, 1000000, 1200000, 1500000, 1800000, 2000000 and
> +    2500000 (microamps).
> +- control-gpios = list of gpios used as pin states when determining the active mode
> +    selection and power state. Must provide EM_EN, M1, M2 and PWR_EN gpio mapping.
> +    If this property is not set it uses I2C for configuration.
> +
> +Example (polling):
> +
> +	ucs1002: ucs1002@57 {
> +		compatible = "microchip,ucs1002";
> +		reg = <0x57>;
> +		microchip,current-limit = <2000000>;
> +	};
> +
> +Example (interrupts + control gpios):
> +
> +	ucs1002: ucs1002@57 {
> +		compatible = "microchip,ucs1002";
> +		reg = <0x57>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <30 0>, <31 0>;
> +		control-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>,	/* EM_EN */
> +				<&gpio0 3 GPIO_ACTIVE_HIGH>,	/* M1 */
> +				<&gpio1 17 GPIO_ACTIVE_HIGH>,	/* M2 */
> +				<&gpio1 19 0>;			/* PWR_EN */
> +	};
> -- 
> 2.1.0
> 
