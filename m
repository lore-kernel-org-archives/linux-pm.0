From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] adp5061: New driver for ADP5061 I2C battery charger
Date: Tue, 10 Apr 2018 08:50:17 -0500
Message-ID: <20180410135017.7sikebbbdsdxjsxs@rob-hp-laptop>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Popa <stefan.popa@analog.com>
Cc: sre@kernel.org, mark.rutland@arm.com, davem@davemloft.net, mchehab@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, akpm@linux-foundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 04, 2018 at 11:17:12AM +0300, Stefan Popa wrote:
> This patch adds basic support for Analog Devices I2C programmable linear
> battery charger.
> 
> With this driver, some parameters can be read and configured such as:
> * trickle charge current level
> * trickle charge voltage threshold
> * weak charge threshold
> * constant current
> * constant charge voltage limit
> * battery full
> * input current limit
> * charger status
> * battery status
> * termination current

Don't you need to describe all these parameters of the battery used? 
Charger bindings are never this simple.

> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ADP5061.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/power/supply/adp5061.txt   |  17 +

Please split bindings to a separate patch.

>  MAINTAINERS                                        |   8 +
>  drivers/power/supply/Kconfig                       |  11 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/adp5061.c                     | 745 +++++++++++++++++++++
>  5 files changed, 782 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adp5061.txt
>  create mode 100644 drivers/power/supply/adp5061.c
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adp5061.txt b/Documentation/devicetree/bindings/power/supply/adp5061.txt
> new file mode 100644
> index 0000000..7447446
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adp5061.txt
> @@ -0,0 +1,17 @@
> +Analog Devices ADP5061 Programmable Linear Battery Charger Driver
> +
> +Required properties:
> +  - compatible:		should be "adi,adp5061"
> +  - reg:		i2c address of the device
> +
> +The node for this driver must be a child node of a I2C controller, hence
> +all mandatory properties described in
> +Documentation/devicetree/bindings/i2c/i2c.txt
> +must be specified.
> +
> +Example:
> +
> +	adp5061@14 {
> +		    compatible = "adi,adp5061";
> +		    reg = <0x14>;
> +	};
