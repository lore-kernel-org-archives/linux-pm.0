From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/17] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
Date: Sat, 17 Nov 2018 10:03:05 -0600
Message-ID: <20181117160305.GA31494@bogus>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

On Fri, 16 Nov 2018 17:23:48 +0100, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - s/cmd-gpio/cmd-gpios/
> - s/ready-gpio/ready-gpios/ in the documentation paragraph
> - Remove status = "okay" from the example
> 
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
