From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 3/4] power: supply: max17040: Config alert SOC low
 level threshold from FDT
Date: Mon, 15 Apr 2019 09:27:31 +0200
Message-ID: <CAJKOXPfZBmNATxDTOqiZm_rpjEpRL9sdGF7QAOxppG+ygRmZPQ@mail.gmail.com>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br> <20190415012635.6369-4-matheus@castello.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415012635.6369-4-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: Matheus Castello <matheus@castello.eng.br>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, Chanwoo Choi <cw00.choi@samsung.com>, =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= <b.zolnierkie@samsung.com>, lee.jones@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 15 Apr 2019 at 03:51, Matheus Castello <matheus@castello.eng.br> wrote:
>
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
>
> Now we can use "maxim,alert-soc-level" property with the values from
> 1 up to 32 to configure alert interrupt threshold.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 56 ++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index 8d2f8ed3f44c..f036f272d52f 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -29,6 +29,9 @@
>  #define MAX17040_DELAY         1000
>  #define MAX17040_BATTERY_FULL  95
>
> +#define MAX17040_ATHD_MASK             0xFFE0
> +#define MAX17040_ATHD_DEFAULT_POWER_UP 4
> +
>  struct max17040_chip {
>         struct i2c_client               *client;
>         struct delayed_work             work;
> @@ -43,6 +46,8 @@ struct max17040_chip {
>         int soc;
>         /* State Of Charge */
>         int status;
> +       /* Alert threshold from 32% to 1% of the State of Charge */
> +       u32 alert_threshold;
>  };
>
>  static int max17040_get_property(struct power_supply *psy,
> @@ -119,6 +124,27 @@ static void max17040_get_soc(struct i2c_client *client)
>         chip->soc = (soc >> 8);
>  }
>
> +static int max17040_set_soc_threshold(struct i2c_client *client, u32 level)
> +{
> +       int ret;
> +       u16 data;
> +
> +       /* check if level is between 1% and 32% */
> +       if (level > 0 && level < 33) {
> +               /* alert threshold use LSb 5 bits from RCOMP */
> +               level = 32 - level;
> +               data = max17040_read_reg(client, MAX17040_RCOMP);
> +               data &= MAX17040_ATHD_MASK;
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
> @@ -161,6 +187,16 @@ static void max17040_get_status(struct i2c_client *client)
>                 chip->status = POWER_SUPPLY_STATUS_FULL;
>  }
>
> +static void max17040_get_of_data(struct max17040_chip *chip)
> +{
> +       struct device *dev = &chip->client->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       if (of_property_read_u32(np, "maxim,alert-soc-level",
> +                       &chip->alert_threshold))
> +               chip->alert_threshold = MAX17040_ATHD_DEFAULT_POWER_UP;
> +}
> +
>  static void max17040_check_changes(struct i2c_client *client)
>  {
>         max17040_get_vcell(client);
> @@ -226,6 +262,7 @@ static int max17040_probe(struct i2c_client *client,
>
>         chip->client = client;
>         chip->pdata = client->dev.platform_data;
> +       max17040_get_of_data(chip);
>
>         i2c_set_clientdata(client, chip);
>         psy_cfg.drv_data = chip;
> @@ -237,16 +274,26 @@ static int max17040_probe(struct i2c_client *client,
>                 return PTR_ERR(chip->battery);
>         }
>
> +       max17040_reset(client);
> +       max17040_get_version(client);
> +
>         /* check interrupt */
>         if (client->irq) {
>                 int ret;
> -               unsigned int flags;
> +
> +               ret = max17040_set_soc_threshold(client, chip->alert_threshold);
> +               if (ret) {
> +                       dev_err(&client->dev,
> +                               "Failed to set SOC alert threshold: err %d\n",
> +                               ret);
> +                       return ret;
> +               }
>
>                 dev_info(&client->dev, "IRQ: enabled\n");
> -               flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
>
>                 ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -                                               max17040_thread_handler, flags,
> +                                               max17040_thread_handler,
> +                                               (client->flags | IRQF_ONESHOT),
>                                                 chip->battery->desc->name,
>                                                 chip);

Now I noticed that you are not clearing the ALRT status bit. Therefore
alert interrupt will be generated only once. Even if SoC goes up
(charged) and then down to alert level it will not be generated second
time. At least documentation for max77836 is saying that clearing this
bit is required.

Best regards,
Krzysztof
