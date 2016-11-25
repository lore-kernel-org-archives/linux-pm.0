From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 02/10] power: supply: axp20x_usb_power: set min voltage
 and max current from sysfs
Date: Fri, 25 Nov 2016 17:42:26 +0800
Message-ID: <CAGb2v67H7guQQg6cHM7fzLNbegNWsJv=BUDAmxuPNSVXkDcnWA@mail.gmail.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161125090921.23138-3-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> AXP20X and AXP22X PMICs allow setting the min voltage and max current of
> VBUS power supply. This adds entries in sysfs to allow to do so.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 72 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h              |  3 ++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index b19754e..638cb52 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -155,6 +155,74 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>         return 0;
>  }
>
> +static int axp20x_usb_power_set_property(struct power_supply *psy,
> +                                        enum power_supply_property psp,
> +                                        const union power_supply_propval *val)
> +{
> +       struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> +       int ret, val1;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +               switch (val->intval) {
> +               case 4000000:
> +               case 4100000:
> +               case 4200000:
> +               case 4300000:
> +               case 4400000:
> +               case 4500000:
> +               case 4600000:
> +               case 4700000:
> +                       val1 = (val->intval - 4000000) / 100000;
> +                       ret = regmap_update_bits(power->regmap,
> +                                                AXP20X_VBUS_IPSOUT_MGMT,
> +                                                AXP20X_VBUS_VHOLD_MASK,
> +                                                val1 << 3);

Please also define the shift offset.

> +                       if (ret)
> +                               return ret;
> +
> +                       return 0;
> +               default:
> +                       return -EINVAL;
> +               }
> +
> +               return 0;
> +
> +       case POWER_SUPPLY_PROP_CURRENT_MAX:
> +               switch (val->intval) {
> +               case 100000:
> +                       if (power->axp20x_id == AXP221_ID)
> +                               return -EINVAL;
> +               case 500000:
> +               case 900000:
> +                       val1 = (900000 - val->intval) / 400000;
> +                       ret = regmap_update_bits(power->regmap,
> +                                                AXP20X_VBUS_IPSOUT_MGMT,
> +                                                AXP20X_VBUS_CLIMIT_MASK, val1);
> +                       if (ret)
> +                               return ret;
> +
> +                       return 0;
> +               default:
> +                       return -EINVAL;
> +               }
> +
> +               return 0;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
> +                                          enum power_supply_property psp)
> +{
> +       return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> +              psp == POWER_SUPPLY_PROP_CURRENT_MAX;
> +}
> +
>  static enum power_supply_property axp20x_usb_power_properties[] = {
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_PRESENT,
> @@ -178,7 +246,9 @@ static const struct power_supply_desc axp20x_usb_power_desc = {
>         .type = POWER_SUPPLY_TYPE_USB,
>         .properties = axp20x_usb_power_properties,
>         .num_properties = ARRAY_SIZE(axp20x_usb_power_properties),
> +       .property_is_writeable = axp20x_usb_power_prop_writeable,
>         .get_property = axp20x_usb_power_get_property,
> +       .set_property = axp20x_usb_power_set_property,
>  };
>
>  static const struct power_supply_desc axp22x_usb_power_desc = {
> @@ -186,7 +256,9 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
>         .type = POWER_SUPPLY_TYPE_USB,
>         .properties = axp22x_usb_power_properties,
>         .num_properties = ARRAY_SIZE(axp22x_usb_power_properties),
> +       .property_is_writeable = axp20x_usb_power_prop_writeable,
>         .get_property = axp20x_usb_power_get_property,
> +       .set_property = axp20x_usb_power_set_property,
>  };
>
>  static const struct of_device_id axp20x_usb_power_match[] = {
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index fec597f..8883595 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -56,6 +56,9 @@ enum {
>  #define AXP20X_LDO24_V_OUT             0x28
>  #define AXP20X_LDO3_V_OUT              0x29
>  #define AXP20X_VBUS_IPSOUT_MGMT                0x30
> +
> +#define AXP20X_VBUS_VHOLD_MASK         GENMASK(5, 3)
> +

For the AXP drivers, we keep the per register bit field
definitions in the drivers that use them.

Regards
ChenYu

>  #define AXP20X_V_OFF                   0x31
>  #define AXP20X_OFF_CTRL                        0x32
>  #define AXP20X_CHRG_CTRL1              0x33
> --
> 2.9.3
>
