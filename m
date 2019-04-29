From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: Max17040: Add low
 level SOC alert threshold
Date: Mon, 29 Apr 2019 17:13:53 -0500
Message-ID: <20190429221353.GA25837@bogus>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
 <20190415012635.6369-3-matheus@castello.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415012635.6369-3-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Matheus Castello <matheus@castello.eng.br>
Cc: sre@kernel.org, krzk@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 14, 2019 at 10:26:33PM -0300, Matheus Castello wrote:
> For configure low level state of charge threshold alert signaled from
> max17040 we add "maxim,alert-soc-level" property.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../power/supply/max17040_battery.txt         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> new file mode 100644
> index 000000000000..9b2cc67d556f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -0,0 +1,24 @@
> +max17040_battery
> +~~~~~~~~~~~~~~~~
> +
> +Required properties :
> + - compatible : "maxim,max17040" or "maxim,max77836-battery"

This is really a charger, not a battery.

> +
> +Optional properties :
> +- maxim,alert-soc-level :	The alert threshold that sets the state of
> + 				charge level where an interrupt is generated.
> +                          	Can be configured from 1 up to 32. If skipped
> +				the power up default value of 4 will be used.

Units? This is a low or high alert? Does a common property make sense 
here?

> +- interrupt-parent : 		The GPIO bank from the interrupt line.

Drop this. interrupt-parent is implied.

> +- interrupts : 			Interrupt line see Documentation/devicetree/
> +				bindings/interrupt-controller/interrupts.txt
> +
> +Example:
> +
> +	battery-charger@36 {
> +		compatible = "maxim,max17040";
> +		reg = <0x36>;
> +		maxim,alert-soc-level = <10>;
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;

Usually there are battery properties that need to be described too...

> +	};
> -- 
> 2.17.0
> 
