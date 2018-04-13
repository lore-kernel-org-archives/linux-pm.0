From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings:power:supply: Add docs for ADP5061
 battery charger
Date: Fri, 13 Apr 2018 16:06:09 -0500
Message-ID: <20180413210609.hhysieyzjl777bei@rob-hp-laptop>
References: <1522829832-7866-1-git-send-email-stefan.popa@analog.com>
 <1523459415-31636-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523459415-31636-1-git-send-email-stefan.popa@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Popa <stefan.popa@analog.com>
Cc: sre@kernel.org, mark.rutland@arm.com, davem@davemloft.net, mchehab@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, akpm@linux-foundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 11, 2018 at 06:10:15PM +0300, Stefan Popa wrote:
> Document adi,adp5061 properties.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
> Changes in v3:
> 	- Split devicetree bindings into a separate patch.
> 
>  .../devicetree/bindings/power/supply/adp5061.txt        | 17 +++++++++++++++++
>  MAINTAINERS                                             |  1 +
>  2 files changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adp5061.txt
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

Same question as the last version. This seems awfully simple for a 
charger. Don't you need to know and describe battery parameters.

Rob
