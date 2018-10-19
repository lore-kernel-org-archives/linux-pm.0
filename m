From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 12/15] power: supply: olpc_battery: Use DT to get battery
 version
Date: Fri, 19 Oct 2018 16:45:03 +0300
Message-ID: <CAHp75VeEFK+47pz+he6Su630jnoGKPamhatuoXopS5Ee=LZtTg@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-13-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181010172300.317643-13-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, quozl@laptop.org, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Avoid using the x86 OLPC platform specific call to get the board
> version. It won't work on FDT-based ARM MMP2 platform.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/power/supply/olpc_battery.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 5a97e42a3547..540d44bf536f 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -19,6 +19,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/sched.h>
>  #include <linux/olpc-ec.h>
> +#include <linux/of.h>
>  #include <asm/olpc.h>

Keep it sorted, otherwise the change is good!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
>
> @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
>         olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
>         if (IS_ERR(olpc_ac))
>                 return PTR_ERR(olpc_ac);
> -
> -       if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> +       if (of_property_match_string(pdev->dev.of_node, "compatible",
> +                                       "olpc,xo1.5-battery") >= 0) {
> +               /* XO-1.5 */
>                 olpc_bat_desc.properties = olpc_xo15_bat_props;
>                 olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
> -       } else { /* XO-1 */
> +       } else {
> +               /* XO-1 */
>                 olpc_bat_desc.properties = olpc_xo1_bat_props;
>                 olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
>         }
> @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device *pdev)
>
>  static const struct of_device_id olpc_battery_ids[] = {
>         { .compatible = "olpc,xo1-battery" },
> +       { .compatible = "olpc,xo1.5-battery" },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
