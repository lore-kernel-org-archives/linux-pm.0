From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: power/supply: Add support for xmega16d4-battery
Date: Thu, 23 Feb 2017 18:44:59 +0100
Message-ID: <CAFqH_50cRsR=4B9hRinFn_qaUnvUfR0XQ8S60hQXi8_p=6rPyw@mail.gmail.com>
References: <20170223173812.10740-1-enric.balletbo@collabora.com> <20170223173812.10740-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170223173812.10740-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Ooops, sorry I forget to add the device tree maintainers so

CC'ing Rob Herring and Mark Rutland


2017-02-23 18:38 GMT+01:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> Add the documentation for binding of Toby Churchill SBS battery monitor
> driver. The device is connected via SPI and is able to report different
> battery characteristics.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  .../devicetree/bindings/power/supply/xmega16d4-battery.txt   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/xmega16d4-battery.txt
>
> diff --git a/Documentation/devicetree/bindings/power/supply/xmega16d4-battery.txt b/Documentation/devicetree/bindings/power/supply/xmega16d4-battery.txt
> new file mode 100644
> index 0000000..c76db67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/xmega16d4-battery.txt
> @@ -0,0 +1,12 @@
> +Binding for the Toby Churchill SBS battery monitor
> +
> +Required properties :
> + - compatible : "tcl,xmega16d4-battery"
> +
> +Example:
> +
> +       battery: smart-battery@0 {
> +               compatible = "tcl,xmega16d4-battery";
> +               reg = <0>;
> +               spi-max-frequency = <100000>;
> +       };
> --
> 2.9.3
>
