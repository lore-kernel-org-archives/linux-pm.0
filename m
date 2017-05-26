From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v3 4/4] power: tps65217_charger: add support for NTC type,
 voltage and current charge
Date: Fri, 26 May 2017 15:31:04 -0700
Message-ID: <CAKvHMgTiAC9LTbB3ZjXPCeMEJiVyyMJE2a23Xoh9kack=idQzg@mail.gmail.com>
References: <20170526110413.24836-1-enric.balletbo@collabora.com> <20170526110413.24836-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170526110413.24836-4-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Enric,


On Fri, May 26, 2017 at 4:04 AM, Enric Balletbo i Serra
<enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> Allow the possibility to configure the charge and the current voltage of
> the charger and also the NTC type for battery temperature measurement.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v2:
>  - Requested by Sebastian Reichel
>    - Use the simple-battery framework
>    - Use device_property_read_u32 instead of of_property_read_u32
> Changes since v1:
>  - None
>
>  drivers/power/supply/tps65217_charger.c | 194 ++++++++++++++++++++++++++=
++++--
>  include/linux/mfd/tps65217.h            |   2 +
>  2 files changed, 188 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index 1f52340..5939e77 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -39,6 +39,12 @@
>  #define NUM_CHARGER_IRQS       2
>  #define POLL_INTERVAL          (HZ * 2)
>
> +struct tps65217_charger_platform_data {
> +       int     charge_voltage_uv;
> +       int     charge_current_ua;
> +       int     ntc_type;
> +};
> +

It's not my department, but maybe this should be called devprops or
similar, since platform_data refers to the pre-devicetree config
scheme?


>  struct tps65217_charger {
>         struct tps65217 *tps;
>         struct device *dev;
> @@ -48,16 +54,84 @@ struct tps65217_charger {
>         int     prev_online;
>
>         struct task_struct      *poll_task;
> +       struct tps65217_charger_platform_data *pdata;
>  };
>
>  static enum power_supply_property tps65217_charger_props[] =3D {
>         POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +       POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>  };
>
> -static int tps65217_config_charger(struct tps65217_charger *charger)
> +static int tps65217_set_charge_current(struct tps65217_charger *charger,
> +                                      unsigned int uamp)
> +{
> +       int ret, val;
> +
> +       dev_dbg(charger->dev, "setting charge current to %d uA\n", uamp);
> +
> +       if (uamp =3D=3D 300000)
> +               val =3D 0x00;
> +       else if (uamp =3D=3D 400000)
> +               val =3D 0x01;
> +       else if (uamp =3D=3D 500000)
> +               val =3D 0x02;
> +       else if (uamp =3D=3D 700000)
> +               val =3D 0x03;
> +       else
> +               return -EINVAL;
> +
> +       ret =3D tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG3,
> +                               TPS65217_CHGCONFIG3_ICHRG_MASK,
> +                               val << TPS65217_CHGCONFIG3_ICHRG_SHIFT,
> +                               TPS65217_PROTECT_NONE);
> +       if (ret) {
> +               dev_err(charger->dev,
> +                       "failed to set ICHRG setting to 0x%02x (err: %d)\=
n",
> +                       val, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tps65217_set_charge_voltage(struct tps65217_charger *charger,
> +                                      unsigned int uvolt)
> +{
> +       int ret, val;
> +
> +       dev_dbg(charger->dev, "setting charge voltage to %d uV\n", uvolt)=
;
> +
> +       if (uvolt !=3D 4100000 && uvolt !=3D 4150000 &&
> +           uvolt !=3D 4200000 && uvolt !=3D 4250000)
> +               return -EINVAL;
> +
> +       val =3D (uvolt - 4100000) / 50000;
> +
> +       ret =3D tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG2,
> +                               TPS65217_CHGCONFIG2_VOREG_MASK,
> +                               val << TPS65217_CHGCONFIG2_VOREG_SHIFT,
> +                               TPS65217_PROTECT_NONE);
> +       if (ret) {
> +               dev_err(charger->dev,
> +                       "failed to set VOCHG setting to 0x%02x (err: %d)\=
n",
> +                       val, ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tps65217_set_ntc_type(struct tps65217_charger *charger,
> +                                unsigned int ntc)
>  {
>         int ret;
>
> +       dev_dbg(charger->dev, "setting NTC type to %d\n", ntc);
> +
> +       if (ntc !=3D 0 && ntc !=3D 1)
> +               return -EINVAL;
> +
>         /*
>          * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
>          *
> @@ -74,14 +148,57 @@ static int tps65217_config_charger(struct tps65217_c=
harger *charger)
>          * NTC TYPE (for battery temperature measurement)
>          *   0 =E2=80=93 100k (curve 1, B =3D 3960)
>          *   1 =E2=80=93 10k  (curve 2, B =3D 3480) (default on reset)
> -        *
>          */
> -       ret =3D tps65217_clear_bits(charger->tps, TPS65217_REG_CHGCONFIG1=
,
> -                                 TPS65217_CHGCONFIG1_NTC_TYPE,
> -                                 TPS65217_PROTECT_NONE);
> +       if (ntc) {
> +               ret =3D tps65217_set_bits(charger->tps, TPS65217_REG_CHGC=
ONFIG1,
> +                                       TPS65217_CHGCONFIG1_NTC_TYPE,
> +                                       TPS65217_CHGCONFIG1_NTC_TYPE,
> +                                       TPS65217_PROTECT_NONE);
> +               if (ret) {
> +                       dev_err(charger->dev,
> +                               "failed to set NTC type to 10K: %d\n", re=
t);
> +                       return ret;
> +               }
> +       } else {
> +               ret =3D tps65217_clear_bits(charger->tps, TPS65217_REG_CH=
GCONFIG1,
> +                                         TPS65217_CHGCONFIG1_NTC_TYPE,
> +                                         TPS65217_PROTECT_NONE);
> +               if (ret) {
> +                       dev_err(charger->dev,
> +                               "failed to set NTC type to 100K: %d\n", r=
et);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int tps65217_config_charger(struct tps65217_charger *charger)
> +{
> +       int ret;
> +       struct tps65217_charger_platform_data *pdata =3D charger->pdata;
> +
> +       if (!charger->pdata)
> +               return -EINVAL;
> +
> +       ret =3D tps65217_set_charge_voltage(charger, pdata->charge_voltag=
e_uv);
> +       if (ret) {
> +               dev_err(charger->dev,
> +                       "failed to set charge voltage setting: %d\n", ret=
);
> +               return ret;
> +       }
> +
> +       ret =3D tps65217_set_charge_current(charger, pdata->charge_curren=
t_ua);
> +       if (ret) {
> +               dev_err(charger->dev,
> +                       "failed to set charge current setting: %d\n", ret=
);
> +               return ret;
> +       }
> +
> +       ret =3D tps65217_set_ntc_type(charger, pdata->ntc_type);
>         if (ret) {
>                 dev_err(charger->dev,
> -                       "failed to set 100k NTC setting: %d\n", ret);
> +                       "failed to set NTC type setting: %d\n", ret);
>                 return ret;
>         }
>
> @@ -118,11 +235,23 @@ static int tps65217_charger_get_property(struct pow=
er_supply *psy,
>                                          union power_supply_propval *val)
>  {
>         struct tps65217_charger *charger =3D power_supply_get_drvdata(psy=
);
> +       struct tps65217_charger_platform_data *pdata =3D charger->pdata;
>
>         if (psp =3D=3D POWER_SUPPLY_PROP_ONLINE) {
>                 val->intval =3D charger->online;
>                 return 0;
>         }
> +
> +       if (psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE) {
> +               val->intval =3D pdata->charge_voltage_uv;
> +               return 0;
> +       }
> +
> +       if (psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT) {
> +               val->intval =3D pdata->charge_current_ua;
> +               return 0;
> +       }
> +
>         return -EINVAL;
>  }
>
> @@ -185,6 +314,49 @@ static int tps65217_charger_poll_task(void *data)
>         return 0;
>  }
>
> +#ifdef CONFIG_OF
> +static struct tps65217_charger_platform_data *tps65217_charger_pdata_ini=
t(
> +               struct tps65217_charger *charger)
> +{
> +       struct tps65217_charger_platform_data *pdata;
> +       struct power_supply_battery_info info =3D {};
> +       int ret;
> +
> +       pdata =3D devm_kzalloc(charger->dev, sizeof(*pdata), GFP_KERNEL);
> +       if (!pdata)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /*
> +        * If battery info is not supplied just ignore and program defaul=
t
> +        * values.
> +        */
> +       power_supply_get_battery_info(charger->psy, &info);
> +
> +       if (info.charge_voltage_uv > 0)
> +               pdata->charge_voltage_uv =3D info.charge_voltage_uv;
> +       else
> +               pdata->charge_voltage_uv =3D 4100000;
> +

Maybe dev.warn() here if input won't take effect due to incorrect
value, and leave pdata->* in a valid state, instead of checking input
in set_charge_*(). That also makes get_property() correct in all cases
(alternatively get_property should obtain values from chip).

> +       if (info.charge_current_ua > 0)
> +               pdata->charge_current_ua =3D info.charge_current_ua;
> +       else
> +               pdata->charge_current_ua =3D 500000;
> +

Same here.

> +       ret =3D device_property_read_u32(charger->dev, "ti,ntc-type",
> +                                      &pdata->ntc_type);
> +       if (ret)
> +               pdata->ntc_type =3D 1;    /* 10k  (curve 2, B =3D 3480) *=
/
> +
> +       return pdata;
> +}
> +#else /* CONFIG_OF */
> +static struct tps65217_charger_platform_data *tps65217_charger_pdata_ini=
t(
> +               struct tps65217_charger *charger)
> +{
> +       return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
>  static const struct power_supply_desc tps65217_charger_desc =3D {
>         .name                   =3D "tps65217-charger",
>         .type                   =3D POWER_SUPPLY_TYPE_MAINS,
> @@ -222,8 +394,11 @@ static int tps65217_charger_probe(struct platform_de=
vice *pdev)
>                 return PTR_ERR(charger->psy);
>         }
>
> -       irq[0] =3D platform_get_irq_byname(pdev, "USB");
> -       irq[1] =3D platform_get_irq_byname(pdev, "AC");
> +       charger->pdata =3D tps65217_charger_pdata_init(charger);
> +       if (IS_ERR(charger->pdata)) {
> +               dev_err(charger->dev, "failed: getting platform data\n");
> +               return PTR_ERR(charger->pdata);
> +       }
>
>         ret =3D tps65217_config_charger(charger);
>         if (ret < 0) {
> @@ -231,6 +406,9 @@ static int tps65217_charger_probe(struct platform_dev=
ice *pdev)
>                 return ret;
>         }
>
> +       irq[0] =3D platform_get_irq_byname(pdev, "USB");
> +       irq[1] =3D platform_get_irq_byname(pdev, "AC");
> +
>         /* Create a polling thread if an interrupt is invalid */
>         if (irq[0] < 0 || irq[1] < 0) {
>                 poll_task =3D kthread_run(tps65217_charger_poll_task,
> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
> index eac2857..d040062 100644
> --- a/include/linux/mfd/tps65217.h
> +++ b/include/linux/mfd/tps65217.h
> @@ -103,8 +103,10 @@
>  #define TPS65217_CHGCONFIG2_DYNTMR     BIT(7)
>  #define TPS65217_CHGCONFIG2_VPREGHG    BIT(6)
>  #define TPS65217_CHGCONFIG2_VOREG_MASK 0x30
> +#define TPS65217_CHGCONFIG2_VOREG_SHIFT        4
>
>  #define TPS65217_CHGCONFIG3_ICHRG_MASK 0xC0
> +#define TPS65217_CHGCONFIG3_ICHRG_SHIFT        6
>  #define TPS65217_CHGCONFIG3_DPPMTH_MASK        0x30
>  #define TPS65217_CHGCONFIG2_PCHRGT     BIT(3)
>  #define TPS65217_CHGCONFIG2_TERMIF     0x06
> --
> 2.9.3
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
