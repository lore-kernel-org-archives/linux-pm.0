From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: power: supply: Add docs for Ingenic
 JZ47xx SoCs battery.
Date: Thu, 28 Feb 2019 12:48:22 -0600
Message-ID: <20190228184822.GA17624@bogus>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
 <20190217142914.17433-4-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190217142914.17433-4-contact@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 17, 2019 at 03:29:13PM +0100, Artur Rojek wrote:
> Add documentation for the ingenic-battery driver, used on JZ47xx SoCs.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  .../bindings/power/supply/ingenic,battery.txt | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> new file mode 100644
> index 000000000000..66430bf73815
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> @@ -0,0 +1,31 @@
> +* Ingenic JZ47xx battery bindings
> +
> +Required properties:
> +
> +- compatible: Must be "ingenic,jz4740-battery".
> +- io-channels: phandle and IIO specifier pair to the IIO device.
> +  Format described in iio-bindings.txt.
> +- monitored-battery: phandle to a "simple-battery" compatible node.
> +
> +The "monitored-battery" property must be a phandle to a node using the format
> +described in battery.txt, with the following properties being required:
> +
> +- voltage-min-design-microvolt: Drained battery voltage.
> +- voltage-max-design-microvolt: Fully charged battery voltage.
> +
> +Example:
> +
> +#include <dt-bindings/iio/adc/ingenic,adc.h>
> +
> +simple_battery: battery {
> +	compatible = "simple-battery";
> +	voltage-min-design-microvolt = <3600000>;
> +	voltage-max-design-microvolt = <4200000>;
> +};
> +
> +ingenic_battery {
> +	compatible = "ingenic,jz4740-battery";
> +	io-channels = <&adc INGENIC_ADC_BATTERY>;
> +	io-channel-names = "battery";
> +	monitored-battery = <&simple_battery>;

Isn't this just an ADC monitored battery? What's specific to JZ4740?

Maybe a generic binding is appropriate here?

Rob
