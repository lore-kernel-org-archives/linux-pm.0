From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: power: supply: Add docs for Ingenic
 JZ47xx SoCs battery.
Date: Sun, 24 Mar 2019 15:30:18 +0000
Message-ID: <20190324153018.2e4011c9@archlinux>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
        <20190323172809.14407-3-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323172809.14407-3-contact@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org

On Sat, 23 Mar 2019 18:28:08 +0100
Artur Rojek <contact@artur-rojek.eu> wrote:

> Add documentation for the ingenic-battery driver, used on JZ47xx SoCs.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Looks fine to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> Changes:
> 
> v2: no change
> 
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
> +};
