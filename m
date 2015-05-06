From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v3] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Wed, 6 May 2015 14:40:03 +0300
Message-ID: <20150506114003.GM10973@lpalcu-linux>
References: <1430843530-26252-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44034 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbbEFLkI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 May 2015 07:40:08 -0400
Content-Disposition: inline
In-Reply-To: <1430843530-26252-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Tue, May 05, 2015 at 07:32:10PM +0300, Anda-Maria Nicolae wrote:
> Based on the datasheet found here:
> http://www.richtek.com/download_ds.jsp?p=RT9455
> 
> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
> ---
> 
> Updates from v2 version:
> - removed unused masks and keep the used ones. I have tried to access mask field
> from struct regmap_field, but I have received the following compilation error:
> "dereferencing pointer to incomplete type". I think this happens because I include
> the file include/linux/regmap.h and in this file struct regmap_field is only declared
> and not defined. Struct regmap_field is defined in drivers/base/regmap/internal.h.
> If I include this file, compilation works. But I do not think it is a good idea
> to include it; I did not find any other driver which includes this file. I also
> could not find any driver that accesses mask field from struct regmap_field.
If you want to go this path, which looks promising since you can get rid
of all mask macros, you don't need regmap_field to compute your masks.
You need reg_field (include/linux/regmap.h). When you setup your fields,
you use:

static const struct reg_field rt9455_reg_fields[] = {...};

Hence, you have access to both msb and lsb of each field and you can
easily compute your mask. Just an idea.

> For instance, drivers/pwm/pwm-sti.c at lines 157, 158, also uses masks.
> 
> - I have also kept REG_FIELD definitions for interrupt registers, since, for instance,
> I use F_BATAB to check battery presence property.
> 
> - cached regs 0x05 and 0x06. Also, I have added rt9455_is_writeable_reg function
> for writeable_reg field of regmap_config.
> 
> - used POWER_STATUS_DISCHARGING, replaced break with and replaced it with return and
> indented it correctly. I spent some time on this and I finally understood what is happening.
> So, if PWR_RDY bit is set, but STAT bits value is 0, the charger may be in one
> of the following cases:                        
> 1. CHG_EN bit is 0.
> 2. CHG_EN bit is 1 but the battery is not connected.
> In any of these cases, POWER_SUPPLY_STATUS_NOT_CHARGING is returned.
> If the PWR_RDY bit is cleared, POWER_SUPPLY_STATUS_DISCHARGING is returned.
> 
> - used VOREG bits value instead of VMREG in functions rt9455_charger_get_voltage_max()/
> rt9455_charger_set_voltage_max(). Although RT9455 charger has VMREG bits which,
> according to the datasheet, represent "Maximum battery regulation voltage", the
> charger never uses VMREG value as maximum threshold for battery voltage. This
> happens because TE and TE_SHDN_EN bits are set during rt9455_probe(), and charging
> operation is terminated when charging current is less than ICHRG x IEOC. When charging
> operation is terminated, battery voltage is almost equal to VOREG. Therefore,
> VMREG value is not taken into account. This is the reason why VOREG value is
> set/returned in these functions.
Something's not right... What happens in the following scenario:
VMREG=4.2V (default value) and user sets VOREG=4.45V? Did you test this
case. I really doubt VMREG field is not used at all. Of course, you can set
VMREG to maximum value in which case VMREG doesn't really matter.

> 
> - corrected comment from rt9455_usb_event_id() function.
> 
> - replaced IS_ERR_OR_NULL() with IS_ERR() to check the result of usb_get_phy()
> function. Also, if usb_register_notifier() fails, since usb_put_phy() is immediately
> called, I have set info->usb_phy to ERR_PTR(-ENODEV) so that in rt9455_remove()
> usb_put_phy is not mistakenly called again.
> 
>  .../devicetree/bindings/power/rt9455_charger.txt   |   43 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  drivers/power/Kconfig                              |    6 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/rt9455_charger.c                     | 1801 ++++++++++++++++++++
>  5 files changed, 1852 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/rt9455_charger.txt
>  create mode 100644 drivers/power/rt9455_charger.c
> 
(...)

> +static int rt9455_charger_get_status(struct rt9455_info *info,
> +				     union power_supply_propval *val)
> +{
> +	unsigned int v, pwr_rdy;
> +	int ret;
> +
> +	ret = regmap_field_read(info->regmap_fields[F_STAT], &v);
> +	if (ret) {
> +		dev_err(&info->client->dev, "Failed to read STAT bits\n");
> +		return ret;
> +	}
> +
> +	switch (v) {
> +	case 0:
> +		ret = regmap_field_read(info->regmap_fields[F_PWR_RDY],
> +					&pwr_rdy);
> +		if (ret) {
> +			dev_err(&info->client->dev, "Failed to read PWR_RDY bit\n");
> +			return ret;
> +		}
> +
> +		if (!pwr_rdy) {
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +			return 0;
> +		}
> +		/*
> +		 * If PWR_RDY bit is set, but STAT bits value is 0, the charger
> +		 * may be in one of the following cases:
> +		 * 1. CHG_EN bit is 0.
> +		 * 2. CHG_EN bit is 1 but the battery is not connected.
> +		 * In any of these cases, POWER_SUPPLY_STATUS_NOT_CHARGING is
> +		 * returned.
> +		 */
> +		val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		return 0;
If STAT is always 0 when charger is removed, I guess this solution is
fine. Though you could do the PWR_RDY check first and, if it's 1, you
could then continue with STAT evaluation.

> +	case 1:
> +		val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		return 0;
> +	case 2:
> +		val->intval = POWER_SUPPLY_STATUS_FULL;
> +		return 0;
> +	default:
> +		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> +		return 0;
> +	}
> +}
> +
(...)
> +
> +static int rt9455_charger_get_voltage(struct rt9455_info *info,
> +				      union power_supply_propval *val)
> +{
> +	int voltage;
> +	int ret;
> +
> +	ret = rt9455_get_field_val(info, F_VOREG,
> +				   rt9455_voreg_values,
> +				   ARRAY_SIZE(rt9455_voreg_values),
> +				   &voltage);
> +	if (ret) {
> +		dev_err(&info->client->dev, "Failed to read VOREG value\n");
> +		return ret;
> +	}
> +
> +	val->intval = voltage;
> +
> +	return 0;
> +}
> +
> +static int rt9455_charger_get_voltage_max(struct rt9455_info *info,
> +					  union power_supply_propval *val)
> +{
> +	/*
> +	 * Although RT9455 charger has VMREG bits which, according to the
> +	 * datasheet, represent "Maximum battery regulation voltage", the
> +	 * charger never uses VMREG value as maximum threshold for battery
> +	 * voltage. This happens because TE and TE_SHDN_EN bits are set during
> +	 * rt9455_probe(), and charging operation is terminated when charging
> +	 * current is less than ICHRG x IEOC. When charging operation is
> +	 * terminated, battery voltage is almost equal to VOREG. Therefore,
> +	 * VMREG value is not taken into account. This is the reason why maximum
> +	 * VOREG value is returned in this function. Also, maximum VOREG value
> +	 * equals maximum VMREG value: 4.45V.
> +	 */
> +	int idx = ARRAY_SIZE(rt9455_voreg_values) - 1;
> +
> +	val->intval = rt9455_voreg_values[idx];
> +
> +	return 0;
> +}
> +
(...)
> +
> +static int rt9455_charger_set_voltage(struct rt9455_info *info,
> +				      const union power_supply_propval *val)
> +{
> +	return rt9455_set_field_val(info, F_VOREG,
> +				    rt9455_voreg_values,
> +				    ARRAY_SIZE(rt9455_voreg_values),
> +				    val->intval);
> +}
> +
> +static int rt9455_charger_set_voltage_max(struct rt9455_info *info,
> +					  const union power_supply_propval *val)
> +{
> +	/*
> +	 * Although RT9455 charger has VMREG bits which, according to the
> +	 * datasheet, represent "Maximum battery regulation voltage", the
> +	 * charger never uses VMREG value as maximum threshold for battery
> +	 * voltage. This happens because TE and TE_SHDN_EN bits are set during
> +	 * rt9455_probe(), and charging operation is terminated when charging
> +	 * current is less than ICHRG x IEOC. When charging operation is
> +	 * terminated, battery voltage is almost equal to VOREG. Therefore,
> +	 * VMREG value is not taken into account. This is the reason why VOREG
> +	 * value is set in this function.
> +	 */
> +	return rt9455_set_field_val(info, F_VOREG,
> +				    rt9455_voreg_values,
> +				    ARRAY_SIZE(rt9455_voreg_values),
> +				    val->intval);
> +}
Apparently, rt9455_charger_set_voltage_max() and
rt9455_charger_set_voltage() do the same thing?

(...)

> +static int rt9455_usb_event_id(struct rt9455_info *info,
> +			       u8 opa_mode, u8 iaicr)
> +{
> +	struct device *dev = &info->client->dev;
> +	int ret;
> +
> +	if (opa_mode == RT9455_CHARGE_MODE) {
> +		/*
> +		 * If the charger is in charge mode, and it has received
> +		 * USB_EVENT_ID, this means a consumer device is connected and
> +		 * it should be powered by the charger.
> +		 * In this case, the charger goes into boost mode.
> +		 */
> +		dev_dbg(dev, "USB_EVENT_ID received, therefore the charger goes into boost mode\n");
> +		ret = regmap_field_write(info->regmap_fields[F_OPA_MODE],
> +					 RT9455_BOOST_MODE);
I missed this previously but, when you switch to boost mode here,
shouldn't you set the boost output voltage somewhere? According to
chip's specification, VOREG is used for both battery regulation and
boost output. So, if the user sets the battery regulation to 4.45
(maximum), when switching to boost mode you'll end up with 5.6V on VBUS
rail. I'm not an expert in USB specifications but a quick google search
revealed that the maximum VBUS voltage is 5.25V.

Perhaps you should add a DT property to let the user choose boost output
voltage.

> +		if (ret) {
> +			dev_err(dev, "Failed to set charger in boost mode\n");
> +			return NOTIFY_DONE;
> +		}
> +	}
> +
> +	dev_dbg(dev, "USB_EVENT_ID received, therefore IAICR is set to its minimum value\n");
> +	if (iaicr != RT9455_IAICR_100MA) {
> +		ret = regmap_field_write(info->regmap_fields[F_IAICR],
> +					 RT9455_IAICR_100MA);
> +		if (ret) {
> +			dev_err(dev, "Failed to set IAICR value\n");
> +			return NOTIFY_DONE;
> +		}
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
(...)
> +
> +static int rt9455_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct device *dev = &client->dev;
> +	struct rt9455_info *info;
> +	struct power_supply_config rt9455_charger_config = {};
> +	/* mandatory device-specific data values */
> +	u32 ichrg, ieoc_percentage, voreg;
> +	/* optional device-specific data values */
> +	u32 mivr = -1, iaicr = -1;
> +	int i, ret;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
> +		return -ENODEV;
> +	}
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->client = client;
> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap = devm_regmap_init_i2c(client,
> +					    &rt9455_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		dev_err(dev, "Failed to initialize register map\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < F_MAX_FIELDS; i++) {
> +		info->regmap_fields[i] =
> +			devm_regmap_field_alloc(dev, info->regmap,
> +						rt9455_reg_fields[i]);
> +		if (IS_ERR(info->regmap_fields[i])) {
> +			dev_err(dev,
> +				"Failed to allocate regmap field = %d\n", i);
> +			return PTR_ERR(info->regmap_fields[i]);
> +		}
> +	}
> +
> +	ret = rt9455_discover_charger(info, &ichrg, &ieoc_percentage,
> +				      &voreg, &mivr, &iaicr);
> +	if (ret) {
> +		dev_err(dev, "Failed to discover charger\n");
> +		return ret;
> +	}
> +
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +	info->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
If you used devm_usb_get_phy() you wouldn't have to worry about
releasing usb_phy(as Krzysztof suggested in the previous mail). It's up
to you.

> +	if (IS_ERR(info->usb_phy)) {
> +		dev_err(dev, "Failed to get USB transceiver\n");
> +	} else {
> +		info->nb.notifier_call = rt9455_usb_event;
> +		ret = usb_register_notifier(info->usb_phy, &info->nb);
> +		if (ret) {
> +			dev_err(dev, "Failed to register USB notifier\n");
> +			usb_put_phy(info->usb_phy);
> +			/*
> +			 * Since usb_put_phy() has been called, info->usb_phy is
> +			 * set to ERR_PTR so that in rt9455_remove()
> +			 * usb_put_phy() is not mistakenly called again.
> +			 */
> +			info->usb_phy = ERR_PTR(-ENODEV);
> +		}
> +	}
> +#endif
> +
> +	INIT_DEFERRABLE_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_callback);
> +	INIT_DEFERRABLE_WORK(&info->max_charging_time_work,
> +			     rt9455_max_charging_time_work_callback);
> +	INIT_DEFERRABLE_WORK(&info->batt_presence_work,
> +			     rt9455_batt_presence_work_callback);
> +
> +	rt9455_charger_config.of_node		= dev->of_node;
> +	rt9455_charger_config.drv_data		= info;
> +	rt9455_charger_config.supplied_to	= rt9455_charger_supplied_to;
> +	rt9455_charger_config.num_supplicants	=
> +					ARRAY_SIZE(rt9455_charger_supplied_to);
> +	ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +					rt9455_irq_handler_thread,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					RT9455_DRIVER_NAME, info);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IRQ handler\n");
> +		return ret;
> +	}
> +
> +	ret = rt9455_hw_init(info, ichrg, ieoc_percentage, voreg, mivr, iaicr);
> +	if (ret) {
> +		dev_err(dev, "Failed to set charger to its default values\n");
> +		return ret;
> +	}
> +
> +	info->charger = power_supply_register(dev, &rt9455_charger_desc,
> +					      &rt9455_charger_config);
> +	if (IS_ERR(info->charger)) {
> +		dev_err(dev, "Failed to register charger\n");
> +		ret = PTR_ERR(info->charger);
> +		goto put_usb_phy;
> +	}
> +
> +	return 0;
> +
> +put_usb_phy:
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +	if (!IS_ERR(info->usb_phy))  {
> +		usb_unregister_notifier(info->usb_phy, &info->nb);
> +		usb_put_phy(info->usb_phy);
> +		info->usb_phy = ERR_PTR(-ENODEV);
> +	}
> +#endif
> +	return ret;
> +}
> +
> +static int rt9455_remove(struct i2c_client *client)
> +{
> +	int ret;
> +	struct rt9455_info *info = i2c_get_clientdata(client);
> +
> +	ret = rt9455_register_reset(info);
> +	if (ret)
> +		dev_err(&info->client->dev, "Failed to set charger to its default values\n");
> +
> +#if IS_ENABLED(CONFIG_USB_PHY)
> +	if (!IS_ERR(info->usb_phy)) {
> +		usb_unregister_notifier(info->usb_phy, &info->nb);
> +		usb_put_phy(info->usb_phy);
> +	}
> +#endif
> +
> +	cancel_delayed_work_sync(&info->pwr_rdy_work);
> +	cancel_delayed_work_sync(&info->max_charging_time_work);
> +	cancel_delayed_work_sync(&info->batt_presence_work);
> +
> +	power_supply_unregister(info->charger);
> +
> +	return ret;
> +}
> +
> +static const struct i2c_device_id rt9455_i2c_id_table[] = {
> +	{ RT9455_DRIVER_NAME, 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
> +
> +static const struct of_device_id rt9455_of_match[] = {
> +	{ .compatible = "richtek,rt9455", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rt9455_of_match);
> +
> +static const struct acpi_device_id rt9455_i2c_acpi_match[] = {
> +	{ "RT945500", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
> +
> +static struct i2c_driver rt9455_driver = {
> +	.probe		= rt9455_probe,
> +	.remove		= rt9455_remove,
> +	.id_table	= rt9455_i2c_id_table,
> +	.driver = {
> +		.name		= RT9455_DRIVER_NAME,
> +		.of_match_table	= of_match_ptr(rt9455_of_match),
> +		.acpi_match_table = ACPI_PTR(rt9455_i2c_acpi_match),
> +	},
> +};
> +module_i2c_driver(rt9455_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Anda-Maria Nicolae <anda-maria.nicolae@intel.com>");
> +MODULE_ALIAS("i2c:rt9455-charger");
> +MODULE_DESCRIPTION("Richtek RT9455 Charger Driver");
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
