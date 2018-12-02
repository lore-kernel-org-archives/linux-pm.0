From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get
 battery version
Date: Sun, 2 Dec 2018 15:24:27 -0800
Message-ID: <20181202232427.GD23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-14-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-14-lkundrak@v3.sk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 16, 2018 at 05:23:59PM +0100, Lubomir Rintel wrote:
> Avoid using the x86 OLPC platform specific call to get the board
> version. It won't work on FDT-based ARM MMP2 platform.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - Sort the new include a bit higher
> 
>  drivers/power/supply/olpc_battery.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 5a97e42a3547..5323987d9284 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/jiffies.h>
> @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
>  	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
>  	if (IS_ERR(olpc_ac))
>  		return PTR_ERR(olpc_ac);
> -
> -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> +					"olpc,xo1.5-battery") >= 0) {
> +		/* XO-1.5 */
>  		olpc_bat_desc.properties = olpc_xo15_bat_props;
>  		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
> -	} else { /* XO-1 */
> +	} else {
> +		/* XO-1 */
>  		olpc_bat_desc.properties = olpc_xo1_bat_props;
>  		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id olpc_battery_ids[] = {
>  	{ .compatible = "olpc,xo1-battery" },
> +	{ .compatible = "olpc,xo1.5-battery" },

The code previously supported xo1.5 (it seems), and the commit message doesn't
mention changing the compatible string. Was this an intentional change? If so,
it should be mentioned in the commit message.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> -- 
> 2.19.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
