From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 03/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
 bindings
Date: Wed, 17 Oct 2018 14:38:12 -0500
Message-ID: <20181017193812.GA11939@bogus>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-4-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-4-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 07:22:48PM +0200, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> new file mode 100644
> index 000000000000..14385fee65d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> @@ -0,0 +1,24 @@
> +OLPC XO-1.75 Embedded Controller
> +
> +Required properties:
> +- compatible: Should be "olpc,xo1.75-ec".
> +- cmd-gpio: gpio specifier of the CMD pin

cmd-gpios

> +
> +The embedded controller requires the SPI controller driver to signal readiness
> +to receive a transfer (that is, when TX FIFO contains the response data) by
> +strobing the ACK pin with the ready signal. See the "ready-gpio" property of the

This will need updating based on the SPI binding.

> +SSP binding as documented in:
> +<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
> +
> +Example:
> +	&ssp3 {
> +		spi-slave;
> +		status = "okay";

Don't show status in examples.

> +		ready-gpio = <&gpio 125 GPIO_ACTIVE_HIGH>;
> +
> +		slave {
> +			compatible = "olpc,xo1.75-ec";
> +			spi-cpha;
> +			cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> -- 
> 2.19.0
> 
