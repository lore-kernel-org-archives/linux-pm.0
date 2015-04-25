From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH] power_supply: Add support for Richtek rt9455 battery charger
Date: Sat, 25 Apr 2015 16:25:31 +0900
Message-ID: <CAJKOXPeyNE3q0-rmUHsmD7eb7u=ZStfQtGgmUw19hdB1iU701w@mail.gmail.com>
References: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f43.google.com ([209.85.216.43]:41291 "EHLO
	mail-vn0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839AbbDYHZd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Apr 2015 03:25:33 -0400
In-Reply-To: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

2015-04-24 16:57 GMT+09:00 Anda-Maria Nicolae <anda-maria.nicolae@intel.com>:
> Based on the datasheet found here:
> http://www.richtek.com/download_ds.jsp?p=RT9455


Hi,
Some comments below.

> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
> ---
>  .../devicetree/bindings/power/rt9455_charger.txt   |   38 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  drivers/power/Kconfig                              |    6 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/rt9455_charger.c                     | 1770 ++++++++++++++++++++
>  5 files changed, 1816 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/rt9455_charger.txt
>  create mode 100644 drivers/power/rt9455_charger.c
>
> diff --git a/Documentation/devicetree/bindings/power/rt9455_charger.txt b/Documentation/devicetree/bindings/power/rt9455_charger.txt
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
> +- rt,IEOC_PERCENTAGE:  integer, the percent of the output charge current (ICHRG).
> +                       When the current in constant-voltage phase drops below
> +                       ICHRG x IEOC_PERCENTAGE, charge is terminated.
> +- rt,VOREG:            integer, battery regulation voltage in uV.
> +
> +Optional properties:
> +- rt,VMIVR:            integer, minimum input voltage regulation in uV.
> +                       Prevents input voltage drop due to insufficient current
> +                       provided by the power source.
> +- rt,IAICR:            integer, input current regulation in uA.

These should be lowercase separated with dash '-'.

> +
> +Example:
> +
> +rt9455@22 {
> +       compatible = "rt,rt9455";
> +       reg = <0x22>;
> +
> +       interrupt-parent = <&gpio1>;
> +       interrupts = <0 1>;
> +
> +       interrupt-gpio = <&gpio1 0 1>;
> +       reset-gpio = <&gpio1 1 1>;
> +
> +       rt,ICHRG = <500000>;
> +       rt,IEOC_PERCENTAGE = <10>;
> +       rt,VOREG = <4200000>;
> +
> +       rt,VMIVR = <4500000>;
> +       rt,IAICR = <500000>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
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

(...)


> +/*
> + * Each array initialised below shows the possible real-world values for a
> + * group of bits belonging to RT9455 registers. The arrays are sorted in
> + * ascending order. The index of each real-world value represents the value
> + * that is encoded in the group of bits belonging to RT9455 registers.
> + */
> +/* REG06[6:4] (ICHRG) in uAh */
> +static const int rt9455_ichrg_values[] = {
> +        500000,  650000,  800000,  950000, 1100000, 1250000, 1400000, 1550000
> +};
> +
> +/* REG02[7:2] (VOREG) in uV */
> +static const int rt9455_voreg_values[] = {
> +       3500000, 3520000, 3540000, 3560000, 3580000, 3600000, 3620000, 3640000,
> +       3660000, 3680000, 3700000, 3720000, 3740000, 3760000, 3780000, 3800000,
> +       3820000, 3840000, 3860000, 3880000, 3900000, 3920000, 3940000, 3960000,
> +       3980000, 4000000, 4020000, 4040000, 4060000, 4080000, 4100000, 4120000,
> +       4140000, 4160000, 4180000, 4200000, 4220000, 4240000, 4260000, 4280000,
> +       4300000, 4330000, 4350000, 4370000, 4390000, 4410000, 4430000, 4450000,
> +       4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000,
> +       4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000
> +};
> +
> +/* REG07[3:0] (VMREG) in uV */
> +static const int rt9455_vmreg_values[] = {
> +       4200000, 4220000, 4240000, 4260000, 4280000, 4300000, 4320000, 4340000,
> +       4360000, 4380000, 4400000, 4430000, 4450000, 4450000, 4450000, 4450000
> +};
> +
> +/* REG05[5:4] (IEOC_PERCENTAGE) */
> +static const int rt9455_ieoc_percentage_values[] = {
> +       10, 30, 20, 30
> +};
> +
> +/* REG05[1:0] (VMIVR) in uV */
> +static const int rt9455_vmivr_values[] = {
> +       4000000, 4250000, 4500000, 5000000
> +};
> +
> +/* REG05[1:0] (IAICR) in uA */
> +static const int rt9455_iaicr_values[] = {
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
> +       ret = i2c_smbus_read_byte_data(info->client, reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       *data = ret;
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
> +       ret = rt9455_read(info, reg, &v);
> +       if (ret < 0)
> +               return ret;
> +
> +       v &= mask;
> +       v >>= shift;
> +       *data = v;
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
> +       ret = rt9455_read(info, reg, &v);
> +       if (ret < 0)
> +               return ret;
> +
> +       v &= ~mask;
> +       v |= ((data << shift) & mask);
> +
> +       return rt9455_write(info, reg, v);
> +}

Maybe just regmap_read(), regmap_write() and regmap_update_bits().

> +
> +/*
> + * Iterate through each element of the 'tbl' array until an element whose value
> + * is greater than v is found. Return the index of the respective element,
> + * or the index of the last element in the array, if no such element is found.
> + */
> +static u8 rt9455_find_idx(const int tbl[], int tbl_size, int v)
> +{
> +       int i;
> +
> +       /* No need to iterate until the last index in the table because
> +        * if no element greater than v is found in the table,
> +        * or if only the last element is greater than v,
> +        * function returns the index of the last element.
> +        */

Here and in other places - please use standard kernel multi-line comment:
/*
 * lorem
 * ipsum
 */

(...)


> +
> +static void rt9455_batt_presence_work_callback(struct work_struct *work)
> +{
> +       struct rt9455_info *info = container_of(work, struct rt9455_info,
> +                                               batt_presence_work.work);
> +       struct device *dev = &info->client->dev;
> +       u8 irq1;
> +       int ret;
> +
> +       ret = rt9455_read(info, RT9455_REG_IRQ1, &irq1);
> +       if (ret) {
> +               dev_err(dev, "Failed to read IRQ1 register\n");
> +               return;
> +       }
> +
> +       /* If the battery is still absent, batt_presence_work is rescheduled.
> +          Otherwise, max_charging_time is scheduled.
> +        */
> +       if (irq1 & RT9455_REG_IRQ1_BATAB_MASK) {
> +               schedule_delayed_work(&info->batt_presence_work,
> +                                     RT9455_BATT_PRESENCE_DELAY * HZ);
> +       } else {
> +               schedule_delayed_work(&info->max_charging_time_work,
> +                                     RT9455_MAX_CHARGING_TIME * HZ);
> +       }

Do all of these schedules have  to be executed on system_wq? Maybe
power efficient workqueue could be used? I don't see any locking so
probably not... but still it is worth investigating.

> +}
> +
> +struct power_supply_desc rt9455_charger_desc = {
> +       .name                   = RT9455_DRIVER_NAME,
> +       .type                   = POWER_SUPPLY_TYPE_USB,
> +       .properties             = rt9455_charger_properties,
> +       .num_properties         = ARRAY_SIZE(rt9455_charger_properties),
> +       .get_property           = rt9455_charger_get_property,
> +       .set_property           = rt9455_charger_set_property,
> +       .property_is_writeable  = rt9455_charger_property_is_writeable,
> +};

This can be "static const".

> +
> +static int rt9455_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +       struct device *dev = &client->dev;
> +       struct rt9455_info *info;
> +       struct power_supply_config rt9455_charger_config = {};
> +       /* mandatory device-specific data values */
> +       u32 ichrg, ieoc_percentage, voreg;
> +       /* optional device-specific data values */
> +       u32 vmivr = -1, iaicr = -1;
> +       int ret;
> +
> +       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +               dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
> +               return -ENODEV;
> +       }
> +       info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       info->client = client;
> +       i2c_set_clientdata(client, info);
> +
> +       ret = rt9455_discover_charger(info, &ichrg, &ieoc_percentage,
> +                                     &voreg, &vmivr, &iaicr);
> +       if (ret) {
> +               dev_err(dev, "Failed to discover charger\n");
> +               return ret;
> +       }
> +
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +       info->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
> +       if (IS_ERR_OR_NULL(info->usb_phy)) {
> +               dev_err(dev, "Failed to get USB transceiver\n");
> +       } else {
> +               info->nb.notifier_call = rt9455_usb_event;
> +               ret = usb_register_notifier(info->usb_phy, &info->nb);
> +               if (ret) {
> +                       dev_err(dev, "Failed to register USB notifier\n");
> +                       usb_put_phy(info->usb_phy);
> +               }
> +       }
> +#endif
> +
> +       INIT_DELAYED_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_callback);
> +       INIT_DELAYED_WORK(&info->max_charging_time_work,
> +                         rt9455_max_charging_time_work_callback);
> +       INIT_DELAYED_WORK(&info->batt_presence_work,
> +                         rt9455_batt_presence_work_callback);

Maybe any of these could be made as DEFERRABLE_WORK? Just thinking out loud...

> +
> +       rt9455_charger_config.of_node           = dev->of_node;
> +       rt9455_charger_config.drv_data          = info;
> +       rt9455_charger_config.supplied_to       = rt9455_charger_supplied_to;
> +       rt9455_charger_config.num_supplicants   =
> +                                       ARRAY_SIZE(rt9455_charger_supplied_to);
> +       ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +                                       rt9455_irq_handler_thread,
> +                                       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +                                       RT9455_DRIVER_NAME, info);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to register IRQ handler\n");
> +               return ret;

goto put_usb_phy;

> +       }
> +
> +       ret = rt9455_hw_init(info, ichrg, ieoc_percentage, voreg, vmivr, iaicr);
> +       if (ret) {
> +               dev_err(dev, "Failed to set charger to its default values\n");
> +               return ret;

Ditto.

> +       }
> +
> +       info->charger = power_supply_register(dev, &rt9455_charger_desc,
> +                                             &rt9455_charger_config);
> +       if (IS_ERR_OR_NULL(info->charger)) {

I think here it cannot be NULL. IS_ERR() is sufficient.

> +               dev_err(dev, "Failed to register charger\n");
> +               ret = PTR_ERR(info->charger);
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
> +       struct rt9455_info *info = i2c_get_clientdata(client);
> +
> +       ret = rt9455_register_reset(info);
> +       if (ret)
> +               dev_err(&info->client->dev, "Failed to set charger to its default values\n");
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
> +static const struct i2c_device_id rt9455_i2c_id_table[] = {
> +       { RT9455_DRIVER_NAME, 0 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
> +
> +static const struct of_device_id rt9455_of_match[] = {
> +       { .compatible = "rt,rt9455", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, rt9455_of_match);
> +
> +static const struct acpi_device_id rt9455_i2c_acpi_match[] = {
> +       {"RTK9455", 0},

To be consistent: spaces after/before brackets.

> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
> +
> +static struct i2c_driver rt9455_driver = {
> +       .probe          = rt9455_probe,
> +       .remove         = rt9455_remove,
> +       .id_table       = rt9455_i2c_id_table,
> +       .driver = {
> +               .name           = RT9455_DRIVER_NAME,
> +               .owner          = THIS_MODULE,

Owner is now set by core and such initialization was removed from drivers.

Best regards,
Krzysztof
