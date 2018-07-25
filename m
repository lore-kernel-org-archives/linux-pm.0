From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/4] power: supply: max17040: Config alert SOC low level
 threshold from FDT
Date: Wed, 25 Jul 2018 12:42:34 +0200
Message-ID: <CAJKOXPd93QKfUQvruwGe3WL52_yhbCG_mPSwt74thPNqdJ7qxg@mail.gmail.com>
References: <20180723040816.19455-1-matheus@castello.eng.br> <20180723040816.19455-3-matheus@castello.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723040816.19455-3-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Matheus Castello <matheus@castello.eng.br>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23 July 2018 at 06:08, Matheus Castello <matheus@castello.eng.br> wrote:
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
>
> Now we can use "maxim,alert-soc-level" property with the values from
> 1 up to 32 to configure alert interrupt threshold.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 36 +++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Hi Matheus,

In series, bindings describing new DT property should go before
introducing them in the driver.

>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 6e54e58814a9..3efa52d32b44 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -47,6 +47,8 @@ struct max17040_chip {
>         int soc;
>         /* State Of Charge */
>         int status;
> +       /* Alert threshold */

Threshold in what units?

> +       int alert_threshold;
>  };
>
>  static int max17040_get_property(struct power_supply *psy,
> @@ -123,6 +125,28 @@ static void max17040_get_soc(struct i2c_client *client)
>         chip->soc = (soc >> 8);
>  }
>
> +static int max17040_set_soc_threshold(struct i2c_client *client, u8 level)
> +{
> +       int ret;
> +       u16 data;
> +
> +       /* check if level is between 1% and 32% */
> +       if (level > 0 && level < 33) {
> +               /* alert threshold use LSb 5 bits from RCOMP */
> +               /* two's-complements form: 00000 = 32% and 11111 = 1% */

Please use Linux style comments.

> +               level = 32 - level;
> +               data = max17040_read_reg(client, MAX17040_RCOMP);
> +               data &= 0xFFE0;

Please define the mask.

> +               data |= level;
> +               max17040_write_reg(client, MAX17040_RCOMP, data);
> +               ret = 0;
> +       } else {
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
>  static void max17040_get_version(struct i2c_client *client)
>  {
>         u16 version;
> @@ -165,6 +189,16 @@ static void max17040_get_status(struct i2c_client *client)
>                 chip->status = POWER_SUPPLY_STATUS_FULL;
>  }
>
> +static void max17040_get_of_data(struct max17040_chip *chip)
> +{
> +       struct device *dev = &chip->client->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       if (of_property_read_s32(np, "maxim,alert-soc-level",
> +                       &chip->alert_threshold))
> +               chip->alert_threshold = 4;

1. You read s32 and later cast it to u8. Either some validation of
possible values or of_property_read_u8().
2. You have hard-coded default value - please put it in some define.
There are already defines, e.g.: MAX17040_BATTERY_FULL
3. Also the bindings say something about power up value... not 4.
4, I think that  default - missing - value should mean "no interrupt warnings".

> +}
> +
>  static void max17040_work(struct work_struct *work)
>  {
>         struct max17040_chip *chip;
> @@ -231,6 +265,7 @@ static int max17040_probe(struct i2c_client *client,
>
>         chip->client = client;
>         chip->pdata = client->dev.platform_data;
> +       max17040_get_of_data(chip);
>
>         i2c_set_clientdata(client, chip);
>         psy_cfg.drv_data = chip;
> @@ -262,6 +297,7 @@ static int max17040_probe(struct i2c_client *client,
>
>         max17040_reset(client);
>         max17040_get_version(client);
> +       max17040_set_soc_threshold(client, chip->alert_threshold);

1. Return value ignored.
2. First you enable interrupts for whatever default value of alerts
and then you set the alerts threshold. You might generate false
warning in such case so this should be in reverse order.

Best regards,
Krzysztof

>
>         INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
>         queue_delayed_work(system_power_efficient_wq, &chip->work,
> --
> 2.13.3
>
