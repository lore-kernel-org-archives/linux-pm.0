From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v5 2/2] thermal: uniphier: add UniPhier thermal driver
Date: Tue, 25 Jul 2017 18:19:18 +0900
Message-ID: <20170725181918.7EA9.4A936039@socionext.com>
References: <1500636105-11520-3-git-send-email-hayashi.kunihiko@socionext.com> <CAK7LNATDnAbByOZN2YDUfnTQLwMiSPVZtz5rfewUzrC9uGUCHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATDnAbByOZN2YDUfnTQLwMiSPVZtz5rfewUzrC9uGUCHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Jul 2017 22:21:05 +0900 <yamada.masahiro@socionext.com> wrote:

> 2017-07-21 20:21 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> 
> > +static int uniphier_tm_initialize_sensor(struct uniphier_tm_dev *tdev)
> > +{
> > +       struct regmap *map = tdev->regmap;
> > +       u32 val;
> > +       int ret;
> > +
> > +       /* stop PVT */
> > +       regmap_write_bits(map, tdev->data->block_base + PVTCTLEN,
> > +                         PVTCTLEN_EN, 0);
> > +
> > +       /*
> > +        * set default value if missing calibrated value
> > +        *
> > +        * Since SoC has a calibrated value that was set in advance,
> > +        * TMODCOEF shows non-zero and PVT refers the value internally.
> > +        *
> > +        * However, some boards don't have the calibrated value.
> > +        * In that case, TMODCOEF shows zero and the driver has to set
> > +        * default value manually.
> > +        */
> > +       ret = regmap_read(map, tdev->data->map_base + TMODCOEF, &val);
> > +       if (ret)
> > +               return ret;
> > +       if (!val)
> > +               regmap_write(map, tdev->data->tmod_setup_addr,
> > +                           TMODSETUP0_EN | TMODSETUP0_VAL(tdev->tmod_calib0) |
> > +                           TMODSETUP1_EN | TMODSETUP1_VAL(tdev->tmod_calib1));
> 
> 
> This code is strange.
> 
> What if TMODCOEF has no calibrated value and
> "socionext,tmod-calibration" is not set either?
> 
> 
> ->tmod_setupaddr will be set to zero
> and the sensor would not work, right?

Yes. When both are true, the sensor would not work.

> > +       /* get tmod-calibration values */
> > +       calib = of_get_property(dev->of_node, "socionext,tmod-calibration",
> > +                               NULL);
> > +       if (calib) {
> > +               tdev->tmod_calib0 = of_read_number(calib, 1);
> > +               tdev->tmod_calib1 = of_read_number(calib + 1, 1);
> > +       }
> 
> 
> From your DT change (https://patchwork.kernel.org/patch/9826391/),
> this property seems a pair of u32 values, like follows:
> 
> socionext,tmod-calibration = <0x0f22 0x68ee>;
> 
> 
> Why do you need to use of_read_number() to retrieve each u32 value?
> 
> See the comment and return value (u64):
> 
> ------------------>8-----------------
> /* Helper to read a big number; size is in cells (not bytes) */
> static inline u64 of_read_number(const __be32 *cell, int size)
> ------------------8<-----------------
> 
> 
> Also, you are not checking the length of the property.
> of_read_number() may over-run the property.
> 
> 
> 
> of_property_read_u32_array() will be a better choice.
> 
> 
> I'd propose the code like follows:

Thank you for your examples.
Surely the driver needs to get the value from the register,
and when failed, tries to get the value from DT, and at last
should issue an error when failed.

I'll try to apply your recommended code.

> 
> diff --git a/drivers/thermal/uniphier_thermal.c
> b/drivers/thermal/uniphier_thermal.c
> index 1a77c5bf6930..eea8a3053584 100644
> --- a/drivers/thermal/uniphier_thermal.c
> +++ b/drivers/thermal/uniphier_thermal.c
> @@ -94,16 +94,16 @@ struct uniphier_tm_soc_data {
>  struct uniphier_tm_dev {
>         struct regmap *regmap;
>         bool alert_en[ALERT_CH_NUM];
> -       u32 tmod_calib0;
> -       u32 tmod_calib1;
>         struct thermal_zone_device *tz_dev;
>         const struct uniphier_tm_soc_data *data;
>  };
> 
> -static int uniphier_tm_initialize_sensor(struct uniphier_tm_dev *tdev)
> +static int uniphier_tm_initialize_sensor(struct uniphier_tm_dev *tdev,
> +                                        struct device *dev)
>  {
>         struct regmap *map = tdev->regmap;
>         u32 val;
> +       u32 tmod_val[2];
>         int ret;
> 
>         /* stop PVT */
> @@ -123,10 +123,22 @@ static int uniphier_tm_initialize_sensor(struct
> uniphier_tm_dev *tdev)
>         ret = regmap_read(map, tdev->data->map_base + TMODCOEF, &val);
>         if (ret)
>                 return ret;
> -       if (!val)
> +       if (!val) {
> +               /*
> +                * No preset value found in the register.
> +                * Look for the fall-back values in DT.
> +                */
> +               ret = of_property_read_u32_array(dev->of_node,
> +                                                "socionext,tmod-calibration",
> +                                                tmod_val,
> ARRAY_SIZE(tmod_val));
> +               if (ret) {
> +                       dev_err(dev, "neither register nor DT has
> calibrated values.\n");
> +                       return ret;
> +               }
>                 regmap_write(map, tdev->data->tmod_setup_addr,
> -                           TMODSETUP0_EN | TMODSETUP0_VAL(tdev->tmod_calib0) |
> -                           TMODSETUP1_EN | TMODSETUP1_VAL(tdev->tmod_calib1));
> +                            TMODSETUP0_EN | TMODSETUP0_VAL(tmod_val[0]) |
> +                            TMODSETUP1_EN | TMODSETUP1_VAL(tmod_val[1]));
> +       }
> 
>         /* select temperature mode */
>         regmap_write_bits(map, tdev->data->block_base + PVTCTLMODE,
> @@ -254,7 +266,6 @@ static int uniphier_tm_probe(struct platform_device *pdev)
>         struct device_node *parent;
>         struct uniphier_tm_dev *tdev;
>         const struct thermal_trip *trips;
> -       const __be32 *calib;
>         int i, ret, irq, ntrips, crit_temp = INT_MAX;
> 
>         tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
> @@ -269,14 +280,6 @@ static int uniphier_tm_probe(struct platform_device *pdev)
>         if (irq < 0)
>                 return irq;
> 
> -       /* get tmod-calibration values */
> -       calib = of_get_property(dev->of_node, "socionext,tmod-calibration",
> -                               NULL);
> -       if (calib) {
> -               tdev->tmod_calib0 = of_read_number(calib, 1);
> -               tdev->tmod_calib1 = of_read_number(calib + 1, 1);
> -       }
> -
>         /* get regmap from syscon node */
>         parent = of_get_parent(dev->of_node); /* parent should be syscon node */
>         regmap = syscon_node_to_regmap(parent);
> @@ -288,7 +291,7 @@ static int uniphier_tm_probe(struct platform_device *pdev)
>         }
>         tdev->regmap = regmap;
> 
> -       ret = uniphier_tm_initialize_sensor(tdev);
> +       ret = uniphier_tm_initialize_sensor(tdev, dev);
>         if (ret) {
>                 dev_err(dev, "failed to initialize sensor\n");
>                 return ret;
> 
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

--
Best Regards,
Kunihiko Hayashi
