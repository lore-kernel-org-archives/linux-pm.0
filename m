From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get
 battery version
Date: Mon, 07 Jan 2019 19:25:52 +0100
Message-ID: <4364d7c4dc1266ca45255cdad5ba40fb20a9bea3.camel@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-14-lkundrak@v3.sk>
 <20181205205459.bsumxn57hjjzvqaj@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181205205459.bsumxn57hjjzvqaj@earth.universe>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-12-05 at 21:54 +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Nov 16, 2018 at 05:23:59PM +0100, Lubomir Rintel wrote:
> > Avoid using the x86 OLPC platform specific call to get the board
> > version. It won't work on FDT-based ARM MMP2 platform.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> I assume this patch cannot be applied to power-supply without patch
> 12 having been merged to avoid breaking XO1.5 devices temporarily?

That is true. What's the correct way to deal with a situation like
this? Just hold the patch until the other changes get in, perhaps via
linux-platform-drivers-x86.git? Or maybe this can go in together via
that tree along with the other patches?

Thanks
Lubo

> -- Sebastian
> 
> > Changes since v1:
> > - Sort the new include a bit higher
> > 
> >  drivers/power/supply/olpc_battery.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/power/supply/olpc_battery.c
> > b/drivers/power/supply/olpc_battery.c
> > index 5a97e42a3547..5323987d9284 100644
> > --- a/drivers/power/supply/olpc_battery.c
> > +++ b/drivers/power/supply/olpc_battery.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/types.h>
> >  #include <linux/err.h>
> >  #include <linux/device.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/jiffies.h>
> > @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct
> > platform_device *pdev)
> >  	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc,
> > NULL);
> >  	if (IS_ERR(olpc_ac))
> >  		return PTR_ERR(olpc_ac);
> > -
> > -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> > +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> > +					"olpc,xo1.5-battery") >= 0) {
> > +		/* XO-1.5 */
> >  		olpc_bat_desc.properties = olpc_xo15_bat_props;
> >  		olpc_bat_desc.num_properties =
> > ARRAY_SIZE(olpc_xo15_bat_props);
> > -	} else { /* XO-1 */
> > +	} else {
> > +		/* XO-1 */
> >  		olpc_bat_desc.properties = olpc_xo1_bat_props;
> >  		olpc_bat_desc.num_properties =
> > ARRAY_SIZE(olpc_xo1_bat_props);
> >  	}
> > @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct
> > platform_device *pdev)
> >  
> >  static const struct of_device_id olpc_battery_ids[] = {
> >  	{ .compatible = "olpc,xo1-battery" },
> > +	{ .compatible = "olpc,xo1.5-battery" },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> > -- 
> > 2.19.1
> > 
