From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
Date: Tue, 30 Apr 2019 09:15:42 -0700
Message-ID: <20190430161542.GB731@roeck-us.net>
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
 <20190430064557.28469-4-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430064557.28469-4-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pm@vger.kernel.org, Enric Balletbo Serra <enric.balletbo@collabora.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 11:45:57PM -0700, Andrey Smirnov wrote:
> Add bindings for Microchip UCS1002 Programmable USB Port Power
> Controller with Charger Emulation.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> new file mode 100644
> index 000000000000..021fd7aba75e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> @@ -0,0 +1,27 @@
> +Microchip UCS1002 USB Port Power Controller
> +
> +Required properties:
> +- compatible		: Should be "microchip,ucs1002";
> +- reg			: I2C slave address
> +
> +Optional properties:
> +- interrupts-extended	: A list of interrupts lines present (could be either
> +			  corresponding to A_DET# pin, ALERT# pin, or both)
> +- interrupt-names	: A list of interrupt names. Should contain (if
> +			  present):
> +			  - "a_det" for line connected to A_DET# pin
> +			  - "alert" for line connected to ALERT# pin
> +			  Both are expected to be IRQ_TYPE_EDGE_BOTH
> +Example:
> +
> +&i2c3 {
> +	charger@32 {
> +		compatible = "microchip,ucs1002";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ucs1002_pins>;

Document the above ? Or is that optional ?

[ I am not a DT expert, so feel free to ignore. ]

Guenter

> +		reg = <0x32>;
> +		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
> +				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
> +		interrupt-names = "a_det", "alert";
> +	};
> +};
> -- 
> 2.20.1
> 
