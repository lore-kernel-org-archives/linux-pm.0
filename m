From: "Nicolae, Anda-maria" <anda-maria.nicolae@intel.com>
Subject: RE: [PATCH] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Mon, 27 Apr 2015 13:06:17 +0000
Message-ID: <11982715D62E664DBACA4351A418B0581437DA51@IRSMSX107.ger.corp.intel.com>
References: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>,<CAJKOXPeyNE3q0-rmUHsmD7eb7u=ZStfQtGgmUw19hdB1iU701w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPeyNE3q0-rmUHsmD7eb7u=ZStfQtGgmUw19hdB1iU701w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-2?Q?Krzysztof_Koz=B3owski?= <k.kozlowski.k@gmail.com>
Cc: "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Krzysztof,

Thanks for feedback :).
More comments inline.

Thanks,
Anda

________________________________________
=46rom: Krzysztof Koz=B3owski [k.kozlowski.k@gmail.com]
Sent: Saturday, April 25, 2015 10:25 AM
To: Nicolae, Anda-maria
Cc: sre@kernel.org; dbaryshkov@gmail.com; robh+dt@kernel.org; pawel.mol=
l@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@c=
odeaurora.org; dwmw2@infradead.org; linux-pm@vger.kernel.org; linux-ker=
nel@vger.kernel.org; devicetree@vger.kernel.org
Subject: Re: [PATCH] power_supply: Add support for Richtek rt9455 batte=
ry charger

2015-04-24 16:57 GMT+09:00 Anda-Maria Nicolae <anda-maria.nicolae@intel=
=2Ecom>:
> Based on the datasheet found here:
> http://www.richtek.com/download_ds.jsp?p=3DRT9455


Hi,
Some comments below.

> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
> ---
>  .../devicetree/bindings/power/rt9455_charger.txt   |   38 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  drivers/power/Kconfig                              |    6 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/rt9455_charger.c                     | 1770 ++++++++++=
++++++++++
>  5 files changed, 1816 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/rt9455_ch=
arger.txt
>  create mode 100644 drivers/power/rt9455_charger.c
>
> diff --git a/Documentation/devicetree/bindings/power/rt9455_charger.t=
xt b/Documentation/devicetree/bindings/power/rt9455_charger.txt
> new file mode 100644
> index 0000000..f716cf6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/rt9455_charger.txt
> @@ -0,0 +1,38 @@
> +Binding for RT rt9455 battery charger
> +
> +Required properties:
> +- compatible: Should contain one of the following:
> + * "rt,rt9455"
> +
> +- reg:                 integer, i2c address of the device.
> +- rt,ICHRG:            integer, output charge current in uA.
> +- rt,IEOC_PERCENTAGE:  integer, the percent of the output charge cur=
rent (ICHRG).
> +                       When the current in constant-voltage phase dr=
ops below
> +                       ICHRG x IEOC_PERCENTAGE, charge is terminated=
=2E
> +- rt,VOREG:            integer, battery regulation voltage in uV.
> +
> +Optional properties:
> +- rt,VMIVR:            integer, minimum input voltage regulation in =
uV.
> +                       Prevents input voltage drop due to insufficie=
nt current
> +                       provided by the power source.
> +- rt,IAICR:            integer, input current regulation in uA.

These should be lowercase separated with dash '-'.

Will rename the properties to be lowercase separated with dash '-'.

> +
> +Example:
> +
> +rt9455@22 {
> +       compatible =3D "rt,rt9455";
> +       reg =3D <0x22>;
> +
> +       interrupt-parent =3D <&gpio1>;
> +       interrupts =3D <0 1>;
> +
> +       interrupt-gpio =3D <&gpio1 0 1>;
> +       reset-gpio =3D <&gpio1 1 1>;
> +
> +       rt,ICHRG =3D <500000>;
> +       rt,IEOC_PERCENTAGE =3D <10>;
> +       rt,VOREG =3D <4200000>;
> +
> +       rt,VMIVR =3D <4500000>;
> +       rt,IAICR =3D <500000>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/=
Documentation/devicetree/bindings/vendor-prefixes.txt
> index 389ca13..dc868ed 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -148,6 +148,7 @@ raidsonic   RaidSonic Technology GmbH
>  ralink Mediatek/Ralink Technology Corp.
>  ramtron        Ramtron International
>  realtek Realtek Semiconductor Corp.
> +rt     Richtek Technology Corporation

Actually I would prefer sticking to "richtek" prefix, sent some time
ago by Beomho Seo:
http://lwn.net/Articles/625133/
"rt" could be easily taken as "Realtek".

Will use richtek.

(...)


> +/*
> + * Each array initialised below shows the possible real-world values=
 for a
> + * group of bits belonging to RT9455 registers. The arrays are sorte=
d in
> + * ascending order. The index of each real-world value represents th=
e value
> + * that is encoded in the group of bits belonging to RT9455 register=
s.
> + */
> +/* REG06[6:4] (ICHRG) in uAh */
> +static const int rt9455_ichrg_values[] =3D {
> +        500000,  650000,  800000,  950000, 1100000, 1250000, 1400000=
, 1550000
> +};
> +
> +/* REG02[7:2] (VOREG) in uV */
> +static const int rt9455_voreg_values[] =3D {
> +       3500000, 3520000, 3540000, 3560000, 3580000, 3600000, 3620000=
, 3640000,
> +       3660000, 3680000, 3700000, 3720000, 3740000, 3760000, 3780000=
, 3800000,
> +       3820000, 3840000, 3860000, 3880000, 3900000, 3920000, 3940000=
, 3960000,
> +       3980000, 4000000, 4020000, 4040000, 4060000, 4080000, 4100000=
, 4120000,
> +       4140000, 4160000, 4180000, 4200000, 4220000, 4240000, 4260000=
, 4280000,
> +       4300000, 4330000, 4350000, 4370000, 4390000, 4410000, 4430000=
, 4450000,
> +       4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000=
, 4450000,
> +       4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000=
, 4450000
> +};
> +
> +/* REG07[3:0] (VMREG) in uV */
> +static const int rt9455_vmreg_values[] =3D {
> +       4200000, 4220000, 4240000, 4260000, 4280000, 4300000, 4320000=
, 4340000,
> +       4360000, 4380000, 4400000, 4430000, 4450000, 4450000, 4450000=
, 4450000
> +};
> +
> +/* REG05[5:4] (IEOC_PERCENTAGE) */
> +static const int rt9455_ieoc_percentage_values[] =3D {
> +       10, 30, 20, 30
> +};
> +
> +/* REG05[1:0] (VMIVR) in uV */
> +static const int rt9455_vmivr_values[] =3D {
> +       4000000, 4250000, 4500000, 5000000
> +};
> +
> +/* REG05[1:0] (IAICR) in uA */
> +static const int rt9455_iaicr_values[] =3D {
> +       100000, 500000, 1000000, 2000000
> +};
> +
> +struct rt9455_info {
> +       struct i2c_client               *client;
> +       struct power_supply             *charger;
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +       struct usb_phy                  *usb_phy;
> +       struct notifier_block           nb;
> +#endif
> +       struct gpio_desc                *gpiod_irq;
> +       unsigned int                    gpio_irq;
> +       struct delayed_work             pwr_rdy_work;
> +       struct delayed_work             max_charging_time_work;
> +       struct delayed_work             batt_presence_work;
> +};
> +
> +/* I2C read/write API */
> +static int rt9455_read(struct rt9455_info *info, u8 reg, u8 *data)
> +{
> +       int ret;
> +
> +       ret =3D i2c_smbus_read_byte_data(info->client, reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       *data =3D ret;
> +       return 0;
> +}
> +
> +static int rt9455_write(struct rt9455_info *info, u8 reg, u8 data)
> +{
> +       return i2c_smbus_write_byte_data(info->client, reg, data);
> +}
> +
> +static int rt9455_read_mask(struct rt9455_info *info, u8 reg,
> +                           u8 mask, u8 shift, u8 *data)
> +{
> +       u8 v;
> +       int ret;
> +
> +       ret =3D rt9455_read(info, reg, &v);
> +       if (ret < 0)
> +               return ret;
> +
> +       v &=3D mask;
> +       v >>=3D shift;
> +       *data =3D v;
> +
> +       return 0;
> +}
> +
> +static int rt9455_write_mask(struct rt9455_info *info, u8 reg,
> +                            u8 mask, u8 shift, u8 data)
> +{
> +       u8 v;
> +       int ret;
> +
> +       ret =3D rt9455_read(info, reg, &v);
> +       if (ret < 0)
> +               return ret;
> +
> +       v &=3D ~mask;
> +       v |=3D ((data << shift) & mask);
> +
> +       return rt9455_write(info, reg, v);
> +}

Maybe just regmap_read(), regmap_write() and regmap_update_bits().
Ok, I will use regmap.

> +
> +/*
> + * Iterate through each element of the 'tbl' array until an element =
whose value
> + * is greater than v is found. Return the index of the respective el=
ement,
> + * or the index of the last element in the array, if no such element=
 is found.
> + */
> +static u8 rt9455_find_idx(const int tbl[], int tbl_size, int v)
> +{
> +       int i;
> +
> +       /* No need to iterate until the last index in the table becau=
se
> +        * if no element greater than v is found in the table,
> +        * or if only the last element is greater than v,
> +        * function returns the index of the last element.
> +        */

Here and in other places - please use standard kernel multi-line commen=
t:
/*
 * lorem
 * ipsum
 */
 Will do.

(...)


> +
> +static void rt9455_batt_presence_work_callback(struct work_struct *w=
ork)
> +{
> +       struct rt9455_info *info =3D container_of(work, struct rt9455=
_info,
> +                                               batt_presence_work.wo=
rk);
> +       struct device *dev =3D &info->client->dev;
> +       u8 irq1;
> +       int ret;
> +
> +       ret =3D rt9455_read(info, RT9455_REG_IRQ1, &irq1);
> +       if (ret) {
> +               dev_err(dev, "Failed to read IRQ1 register\n");
> +               return;
> +       }
> +
> +       /* If the battery is still absent, batt_presence_work is resc=
heduled.
> +          Otherwise, max_charging_time is scheduled.
> +        */
> +       if (irq1 & RT9455_REG_IRQ1_BATAB_MASK) {
> +               schedule_delayed_work(&info->batt_presence_work,
> +                                     RT9455_BATT_PRESENCE_DELAY * HZ=
);
> +       } else {
> +               schedule_delayed_work(&info->max_charging_time_work,
> +                                     RT9455_MAX_CHARGING_TIME * HZ);
> +       }

Do all of these schedules have  to be executed on system_wq? Maybe
power efficient workqueue could be used? I don't see any locking so
probably not... but still it is worth investigating.

Ok, I will use 	queue_delayed_work(system_power_efficient_wq, ...). I'm=
 not sure if I understand exactly what do you mean by "I don't see any =
locking so probably not". I can see that __queue_work() uses spinlocks.=
 And other drivers that use system_power_efficient_wq also do not use a=
dditional locking.
I intend to replace schedule_delayed_work() with queue_delayed_work(sys=
tem_power_efficient_wq, ...), without adding any locking in the driver.=
 Please let me know if I understood correctly what you meant .

> +}
> +
> +struct power_supply_desc rt9455_charger_desc =3D {
> +       .name                   =3D RT9455_DRIVER_NAME,
> +       .type                   =3D POWER_SUPPLY_TYPE_USB,
> +       .properties             =3D rt9455_charger_properties,
> +       .num_properties         =3D ARRAY_SIZE(rt9455_charger_propert=
ies),
> +       .get_property           =3D rt9455_charger_get_property,
> +       .set_property           =3D rt9455_charger_set_property,
> +       .property_is_writeable  =3D rt9455_charger_property_is_writea=
ble,
> +};

This can be "static const".

Will do.=20

> +
> +static int rt9455_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.pa=
rent);
> +       struct device *dev =3D &client->dev;
> +       struct rt9455_info *info;
> +       struct power_supply_config rt9455_charger_config =3D {};
> +       /* mandatory device-specific data values */
> +       u32 ichrg, ieoc_percentage, voreg;
> +       /* optional device-specific data values */
> +       u32 vmivr =3D -1, iaicr =3D -1;
> +       int ret;
> +
> +       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DAT=
A)) {
> +               dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
> +               return -ENODEV;
> +       }
> +       info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       info->client =3D client;
> +       i2c_set_clientdata(client, info);
> +
> +       ret =3D rt9455_discover_charger(info, &ichrg, &ieoc_percentag=
e,
> +                                     &voreg, &vmivr, &iaicr);
> +       if (ret) {
> +               dev_err(dev, "Failed to discover charger\n");
> +               return ret;
> +       }
> +
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +       info->usb_phy =3D usb_get_phy(USB_PHY_TYPE_USB2);
> +       if (IS_ERR_OR_NULL(info->usb_phy)) {
> +               dev_err(dev, "Failed to get USB transceiver\n");
> +       } else {
> +               info->nb.notifier_call =3D rt9455_usb_event;
> +               ret =3D usb_register_notifier(info->usb_phy, &info->n=
b);
> +               if (ret) {
> +                       dev_err(dev, "Failed to register USB notifier=
\n");
> +                       usb_put_phy(info->usb_phy);
> +               }
> +       }
> +#endif
> +
> +       INIT_DELAYED_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_ca=
llback);
> +       INIT_DELAYED_WORK(&info->max_charging_time_work,
> +                         rt9455_max_charging_time_work_callback);
> +       INIT_DELAYED_WORK(&info->batt_presence_work,
> +                         rt9455_batt_presence_work_callback);

Maybe any of these could be made as DEFERRABLE_WORK? Just thinking out =
loud...

I cannot use DEFERRABLE_WORK instead of DELAYED_WORK. DEFERRABLE_WORK r=
uns in interrupt context, while DELAYED_WORK runs in process context. A=
ll handlers for DELAYED_WORK from the driver perform read/write operati=
ons via I2C, which may sleep. This is the reason why DELAYED_WORK is us=
ed.

> +
> +       rt9455_charger_config.of_node           =3D dev->of_node;
> +       rt9455_charger_config.drv_data          =3D info;
> +       rt9455_charger_config.supplied_to       =3D rt9455_charger_su=
pplied_to;
> +       rt9455_charger_config.num_supplicants   =3D
> +                                       ARRAY_SIZE(rt9455_charger_sup=
plied_to);
> +       ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> +                                       rt9455_irq_handler_thread,
> +                                       IRQF_TRIGGER_LOW | IRQF_ONESH=
OT,
> +                                       RT9455_DRIVER_NAME, info);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to register IRQ handler\n");
> +               return ret;

goto put_usb_phy;

> +       }
> +
> +       ret =3D rt9455_hw_init(info, ichrg, ieoc_percentage, voreg, v=
mivr, iaicr);
> +       if (ret) {
> +               dev_err(dev, "Failed to set charger to its default va=
lues\n");
> +               return ret;

Ditto.

> +       }
> +
> +       info->charger =3D power_supply_register(dev, &rt9455_charger_=
desc,
> +                                             &rt9455_charger_config)=
;
> +       if (IS_ERR_OR_NULL(info->charger)) {

I think here it cannot be NULL. IS_ERR() is sufficient.

i checked it and you are right. Will do.

> +               dev_err(dev, "Failed to register charger\n");
> +               ret =3D PTR_ERR(info->charger);
> +               goto put_usb_phy;
> +       }
> +
> +       return 0;
> +
> +put_usb_phy:
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +       if (!IS_ERR_OR_NULL(info->usb_phy))  {
> +               usb_unregister_notifier(info->usb_phy, &info->nb);
> +               usb_put_phy(info->usb_phy);
> +       }
> +#endif
> +       return ret;
> +}
> +
> +static int rt9455_remove(struct i2c_client *client)
> +{
> +       int ret;
> +       struct rt9455_info *info =3D i2c_get_clientdata(client);
> +
> +       ret =3D rt9455_register_reset(info);
> +       if (ret)
> +               dev_err(&info->client->dev, "Failed to set charger to=
 its default values\n");
> +
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +       if (!IS_ERR_OR_NULL(info->usb_phy)) {
> +               usb_unregister_notifier(info->usb_phy, &info->nb);
> +               usb_put_phy(info->usb_phy);
> +       }
> +#endif
> +
> +       cancel_delayed_work_sync(&info->pwr_rdy_work);
> +       cancel_delayed_work_sync(&info->max_charging_time_work);
> +       cancel_delayed_work_sync(&info->batt_presence_work);
> +
> +       power_supply_unregister(info->charger);
> +
> +       return ret;
> +}
> +
> +static const struct i2c_device_id rt9455_i2c_id_table[] =3D {
> +       { RT9455_DRIVER_NAME, 0 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
> +
> +static const struct of_device_id rt9455_of_match[] =3D {
> +       { .compatible =3D "rt,rt9455", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, rt9455_of_match);
> +
> +static const struct acpi_device_id rt9455_i2c_acpi_match[] =3D {
> +       {"RTK9455", 0},

To be consistent: spaces after/before brackets.

Will do.

> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
> +
> +static struct i2c_driver rt9455_driver =3D {
> +       .probe          =3D rt9455_probe,
> +       .remove         =3D rt9455_remove,
> +       .id_table       =3D rt9455_i2c_id_table,
> +       .driver =3D {
> +               .name           =3D RT9455_DRIVER_NAME,
> +               .owner          =3D THIS_MODULE,

Owner is now set by core and such initialization was removed from drive=
rs.

Will remove it.

Best regards,
Krzysztof
