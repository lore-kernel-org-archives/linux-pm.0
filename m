From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2] power: supply: bq24190_charger: add support for bq24196 variant
Date: Thu, 29 Nov 2018 15:07:15 +0100
Message-ID: <2186433.S1hFpfxTzA@phil>
References: <20181113124753.29948-1-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113124753.29948-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

Am Dienstag, 13. November 2018, 13:47:53 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> The bq24196 is another variant of the bq24190 charger ic.
> Its register set is identical to the bq24192 and it even reuses
> the same part number (0x5).
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

any opinion on the underlying bq24192 and this bq24196 support?
It's a month now for Brian's patches and 2 weeks for my small bq24196
addition, so it would be cool to know if there needs to be done more
to get it included.


Thanks
Heiko

> ---
> This should go on top of the bq24192 support patches from Brian Masney /
> Jonathan Marek [0]
> 
> [0] https://patchwork.kernel.org/patch/10663409/
> 
> changes in v2:
> - add missing compatible to dt-binding
> 
>  Documentation/devicetree/bindings/power/supply/bq24190.txt | 1 +
>  drivers/power/supply/bq24190_charger.c                     | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> index c8ac028bd3c7..ffe2be408bb6 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> @@ -5,6 +5,7 @@ Required properties:
>      * "ti,bq24190"
>      * "ti,bq24192"
>      * "ti,bq24192i"
> +    * "ti,bq24196"
>  - reg: integer, I2C address of the charger.
>  - interrupts[-extended]: configuration for charger INT pin.
>  
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 4e64e6ac95c5..effa7c3c21e6 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -143,7 +143,7 @@
>  #define BQ24190_REG_VPRS_PN_MASK		(BIT(5) | BIT(4) | BIT(3))
>  #define BQ24190_REG_VPRS_PN_SHIFT		3
>  #define BQ24190_REG_VPRS_PN_24190			0x4
> -#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193 */
> +#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193, 24196 */
>  #define BQ24190_REG_VPRS_PN_24192I			0x3
>  #define BQ24190_REG_VPRS_TS_PROFILE_MASK	BIT(2)
>  #define BQ24190_REG_VPRS_TS_PROFILE_SHIFT	2
> @@ -1973,6 +1973,7 @@ static const struct i2c_device_id bq24190_i2c_ids[] = {
>  	{ "bq24190" },
>  	{ "bq24192" },
>  	{ "bq24192i" },
> +	{ "bq24196" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
> @@ -1982,6 +1983,7 @@ static const struct of_device_id bq24190_of_match[] = {
>  	{ .compatible = "ti,bq24190", },
>  	{ .compatible = "ti,bq24192", },
>  	{ .compatible = "ti,bq24192i", },
> +	{ .compatible = "ti,bq24196", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bq24190_of_match);
> 
