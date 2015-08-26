From: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Subject: RE: [RFC PATCH] power: bq24261_charger: Add support for TI BQ24261
 charger
Date: Wed, 26 Aug 2015 11:03:00 +0000
Message-ID: <D854C92F57B1B347B57E531E78D05EAD578E37B9@BGSMSX104.gar.corp.intel.com>
References: <1439920175-12049-1-git-send-email-ramakrishna.pallala@intel.com>
 <20150818142442.GA11344@borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42646 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756248AbbHZLDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 07:03:13 -0400
In-Reply-To: <20150818142442.GA11344@borg>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "Tc, Jenny" <jenny.tc@intel.com>

Hi Andreas,

I went on a unplanned leave and I came back to office recently. I will go through your comments and get back to you.


> Subject: Re: [RFC PATCH] power: bq24261_charger: Add support for TI BQ24261
> charger
> 
> Hi,
> 
> On Tue, Aug 18, 2015 at 11:19:35PM +0530, Ramakrishna Pallala wrote:
> > Add new charger driver support for BQ24261 charger IC.
> >
> > Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> > ---
> >  drivers/power/Kconfig                 |    6 +
> >  drivers/power/Makefile                |    1 +
> >  drivers/power/bq24261_charger.c       | 1127
> +++++++++++++++++++++++++++++++++
> >  include/linux/power/bq24261_charger.h |   26 +
> >  4 files changed, 1160 insertions(+)
> >  create mode 100644 drivers/power/bq24261_charger.c  create mode
> > 100644 include/linux/power/bq24261_charger.h
.
.
.
 
> Thanks Ram for submitting your driver. I think it's a good base to merge my
> (unplished) work supporting the bq24261M and bq24262.
> 
> Laurentiu and I were having an offline discussion whether to make the above
> constant charge current / voltage writable through sysfs on the
> bq24257_charger.c driver as I'm merging my bq24250/bq24251 work there.
> While helpful for debugging and to empower certain user-space applications
> those properties also are somewhat dangerous to expose at the same time if an
> unskilled user gets hold of them...
> 
> (Thanks Laurentiu for digging up below thread)
> http://marc.info/?l=linux-pm&m=143080413218161&w=2
> 
> In this context I was thinking, what about introducing a DT property for this and
> other charger drivers called "batt_param_write_enable" that by default is OFF
> and controls the writability of above two parameters? I think this would add one
> layer of safety while at the same time allowing more flexibility for where it's
> needed.
> 
> (more comments below)
> 
> > +
> > +static enum power_supply_property bq24261_usb_props[] = {
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_ONLINE,
> > +	POWER_SUPPLY_PROP_TYPE,
> > +	POWER_SUPPLY_PROP_HEALTH,
> > +	POWER_SUPPLY_PROP_STATUS,
> > +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> > +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> > +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> > +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> > +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> > +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> > +	POWER_SUPPLY_PROP_TEMP_MAX,
> > +	POWER_SUPPLY_PROP_TEMP_MIN,
> > +};
> > +
> > +static char *bq24261_charger_supplied_to[] = {
> > +	"main-battery",
> > +};
> > +
> > +static struct power_supply_desc bq24261_charger_desc = {
> > +	.name			= DEV_NAME,
> > +	.type			= POWER_SUPPLY_TYPE_USB,
> > +	.properties		= bq24261_usb_props,
> > +	.num_properties		= ARRAY_SIZE(bq24261_usb_props),
> > +	.get_property		= bq24261_usb_get_property,
> > +	.set_property		= bq24261_usb_set_property,
> > +	.property_is_writeable	= bq24261_property_is_writeable,
> > +};
> > +
> > +static void bq24261_wdt_reset_worker(struct work_struct *work) {
> > +
> > +	struct bq24261_charger *chip = container_of(work,
> > +			    struct bq24261_charger, wdt_work.work);
> > +	int ret;
> > +
> > +	ret = bq24261_reset_wdt_timer(chip);
> > +	if (ret)
> > +		dev_err(&chip->client->dev, "WDT timer reset error(%d)\n",
> ret);
> > +
> > +	schedule_delayed_work(&chip->wdt_work, WDT_RESET_DELAY); }
> > +
> > +static void bq24261_irq_worker(struct work_struct *work) {
> > +	struct bq24261_charger *chip =
> > +	    container_of(work, struct bq24261_charger, irq_work);
> > +	int ret;
> > +
> > +	/*
> > +	 * Lock to ensure that interrupt register readings are done
> > +	 * and processed sequentially. The interrupt Fault registers
> > +	 * are read on clear and without sequential processing double
> > +	 * fault interrupts or fault recovery cannot be handlled propely
> > +	 */
> > +
> > +	mutex_lock(&chip->lock);
> > +
> > +	ret = bq24261_read_reg(chip->client, BQ24261_STAT_CTRL0_ADDR);
> > +	if (ret < 0) {
> > +		dev_err(&chip->client->dev,
> > +			"Error (%d) in reading BQ24261_STAT_CTRL0_ADDR\n",
> ret);
> > +		goto irq_out;
> > +	}
> > +
> > +	if (!chip->cable.boost) {
> > +		bq24261_handle_status(chip, ret);
> > +		bq24261_handle_health(chip, ret);
> > +		power_supply_changed(chip->psy_usb);
> > +	}
> > +
> > +irq_out:
> > +	mutex_unlock(&chip->lock);
> > +}
> > +
> > +static irqreturn_t bq24261_thread_handler(int id, void *data) {
> > +	struct bq24261_charger *chip = (struct bq24261_charger *)data;
> > +
> > +	queue_work(system_highpri_wq, &chip->irq_work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void bq24261_fault_mon_work(struct work_struct *work) {
> > +	struct bq24261_charger *chip = container_of(work,
> > +			struct bq24261_charger, fault_mon_work.work);
> > +	int ret;
> > +
> > +	if ((chip->chg_health == POWER_SUPPLY_HEALTH_OVERVOLTAGE) ||
> > +		(chip->chg_health == POWER_SUPPLY_HEALTH_DEAD)) {
> > +
> > +		mutex_lock(&chip->lock);
> > +		ret = bq24261_read_reg(chip->client,
> BQ24261_STAT_CTRL0_ADDR);
> > +		if (ret < 0) {
> > +			dev_err(&chip->client->dev,
> > +				"Status register read failed(%d)\n", ret);
> > +			goto fault_mon_out;
> > +		}
> > +
> > +		if ((ret & BQ24261_STAT_MASK) == BQ24261_STAT_READY) {
> > +			dev_info(&chip->client->dev,
> > +					"Charger fault recovered\n");
> > +			bq24261_handle_status(chip, ret);
> > +			bq24261_handle_health(chip, ret);
> > +			power_supply_changed(chip->psy_usb);
> > +		}
> > +fault_mon_out:
> > +		mutex_unlock(&chip->lock);
> > +	}
> > +}
> > +
> > +static void bq24261_boost_control(struct bq24261_charger *chip, bool
> > +enable) {
> > +	int ret;
> > +
> > +	if (enable)
> > +		ret = bq24261_write_reg(chip->client,
> BQ24261_STAT_CTRL0_ADDR,
> > +				BQ24261_TMR_RST |
> BQ24261_ENABLE_BOOST);
> > +	else
> > +		ret = bq24261_write_reg(chip->client,
> > +						BQ24261_STAT_CTRL0_ADDR,
> 0x0);
> > +
> > +	if (ret < 0)
> > +		dev_err(&chip->client->dev,
> > +			"stat cntl0 reg access error(%d)\n", ret); }
> > +
> > +static void bq24261_extcon_event_work(struct work_struct *work) {
> > +	struct bq24261_charger *chip =
> > +			container_of(work, struct bq24261_charger,
> cable.work);
> > +	int ret, current_limit = 0;
> > +	bool old_connected = chip->cable.connected;
> > +
> > +	/* Determine cable/charger type */
> > +	if (extcon_get_cable_state(chip->cable.sdp.edev,
> > +					"SLOW-CHARGER") > 0) {
> > +		chip->cable.connected = true;
> > +		current_limit = ILIM_500MA;
> > +		chip->cable.chg_type = POWER_SUPPLY_TYPE_USB;
> > +		dev_dbg(&chip->client->dev, "USB SDP charger is connected");
> > +	} else if (extcon_get_cable_state(chip->cable.cdp.edev,
> > +					"CHARGE-DOWNSTREAM") > 0) {
> > +		chip->cable.connected = true;
> > +		current_limit = ILIM_1500MA;
> > +		chip->cable.chg_type = POWER_SUPPLY_TYPE_USB_CDP;
> > +		dev_dbg(&chip->client->dev, "USB CDP charger is connected");
> > +	} else if (extcon_get_cable_state(chip->cable.dcp.edev,
> > +					"FAST-CHARGER") > 0) {
> > +		chip->cable.connected = true;
> > +		current_limit = ILIM_1500MA;
> > +		chip->cable.chg_type = POWER_SUPPLY_TYPE_USB_DCP;
> > +		dev_dbg(&chip->client->dev, "USB DCP charger is connected");
> > +	} else if (extcon_get_cable_state(chip->cable.otg.edev,
> > +					"USB-Host") > 0) {
> > +		chip->cable.boost = true;
> > +		chip->cable.connected = true;
> > +		dev_dbg(&chip->client->dev, "USB-Host cable is connected");
> > +	} else {
> > +		if (old_connected)
> > +			dev_dbg(&chip->client->dev, "USB Cable
> disconnected");
> > +		chip->cable.connected = false;
> > +		chip->cable.boost = false;
> > +		chip->cable.chg_type = POWER_SUPPLY_TYPE_USB;
> > +	}
> > +
> > +	/* Cable status changed */
> > +	if (old_connected == chip->cable.connected)
> > +		return;
> > +
> > +	mutex_lock(&chip->lock);
> > +	if (chip->cable.connected && !chip->cable.boost) {
> > +		chip->inlmt = current_limit;
> > +		/* Set up charging */
> > +		ret = bq24261_set_cc(chip, chip->cc);
> > +		if (ret < 0)
> > +			dev_err(&chip->client->dev, "set CC failed(%d)", ret);
> > +		ret = bq24261_set_cv(chip, chip->cv);
> > +		if (ret < 0)
> > +			dev_err(&chip->client->dev, "set CV failed(%d)", ret);
> > +		ret = bq24261_set_inlmt(chip, chip->inlmt);
> > +		if (ret < 0)
> > +			dev_err(&chip->client->dev, "set ILIM failed(%d)", ret);
> > +		ret = bq24261_enable_charger(chip, true);
> > +		if (ret < 0)
> > +			dev_err(&chip->client->dev,
> > +					"enable charger failed(%d)", ret);
> > +		ret = bq24261_enable_charging(chip, true);
> > +		if (ret < 0)
> > +			dev_err(&chip->client->dev,
> > +					"enable charging failed(%d)", ret);
> > +
> > +		chip->is_charging_enabled = true;
> > +		chip->present = true;
> > +		chip->online = true;
> > +		schedule_delayed_work(&chip->wdt_work, 0);
> > +	} else if (chip->cable.connected && chip->cable.boost) {
> > +		/* Enable VBUS for Host Mode */
> > +		bq24261_boost_control(chip, true);
> > +		schedule_delayed_work(&chip->wdt_work, 0);
> > +	} else {
> > +		dev_info(&chip->client->dev, "Cable disconnect event\n");
> > +		cancel_delayed_work_sync(&chip->wdt_work);
> > +		cancel_delayed_work_sync(&chip->fault_mon_work);
> > +		bq24261_boost_control(chip, false);
> > +		ret = bq24261_enable_charging(chip, false);
> > +		if (ret < 0)
> > +			dev_err(&chip->client->dev,
> > +					"charger disable failed(%d)", ret);
> > +
> > +		chip->is_charging_enabled = false;
> > +		chip->present = false;
> > +		chip->online = false;
> > +		chip->inlmt = 0;
> > +	}
> > +	bq24261_charger_desc.type = chip->cable.chg_type;
> > +	mutex_unlock(&chip->lock);
> > +	power_supply_changed(chip->psy_usb);
> > +}
> > +
> > +static int bq24261_handle_extcon_events(struct notifier_block *nb,
> > +				   unsigned long event, void *param) {
> > +	struct bq24261_charger *chip =
> > +		container_of(nb, struct bq24261_charger, cable.nb);
> > +
> > +	dev_dbg(&chip->client->dev, "external connector event(%ld)\n",
> > +event);
> > +
> > +	schedule_work(&chip->cable.work);
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static int bq24261_extcon_register(struct bq24261_charger *chip) {
> > +	int ret;
> > +
> > +	INIT_WORK(&chip->cable.work, bq24261_extcon_event_work);
> > +	chip->cable.nb.notifier_call = bq24261_handle_extcon_events;
> > +
> > +	ret = extcon_register_interest(&chip->cable.sdp, NULL,
> > +				"SLOW-CHARGER", &chip->cable.nb);
> > +	if (ret < 0) {
> > +		dev_warn(&chip->client->dev,
> > +				"extcon SDP registration failed(%d)\n", ret);
> > +		goto sdp_reg_failed;
> > +	}
> > +
> > +	ret = extcon_register_interest(&chip->cable.cdp, NULL,
> > +				"CHARGE-DOWNSTREAM", &chip->cable.nb);
> > +	if (ret < 0) {
> > +		dev_warn(&chip->client->dev,
> > +				"extcon CDP registration failed(%d)\n", ret);
> > +		goto cdp_reg_failed;
> > +	}
> > +
> > +	ret = extcon_register_interest(&chip->cable.dcp, NULL,
> > +				"FAST-CHARGER", &chip->cable.nb);
> > +	if (ret < 0) {
> > +		dev_warn(&chip->client->dev,
> > +				"extcon DCP registration failed(%d)\n", ret);
> > +		goto dcp_reg_failed;
> > +	}
> > +
> > +	ret = extcon_register_interest(&chip->cable.otg, NULL,
> > +				"USB-Host", &chip->cable.nb);
> > +	if (ret < 0) {
> > +		dev_warn(&chip->client->dev,
> > +			"extcon USB-Host registration failed(%d)\n", ret);
> > +		goto otg_reg_failed;
> > +	}
> > +
> > +	return 0;
> > +
> > +otg_reg_failed:
> > +	extcon_unregister_interest(&chip->cable.dcp);
> > +dcp_reg_failed:
> > +	extcon_unregister_interest(&chip->cable.cdp);
> > +cdp_reg_failed:
> > +	extcon_unregister_interest(&chip->cable.sdp);
> > +sdp_reg_failed:
> > +	return -EPROBE_DEFER;
> > +}
> > +
> > +static int bq24261_get_model(struct i2c_client *client,
> > +			enum bq2426x_model *model)
> > +{
> > +	int ret;
> > +
> > +	ret = bq24261_read_reg(client, BQ24261_VENDOR_REV_ADDR);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if ((ret & BQ24261_VENDOR_MASK) != VENDOR_BQ2426X)
> > +		return -EINVAL;
> > +
> > +	switch (ret & BQ24261_REV_MASK) {
> > +	case REV_BQ24261:
> > +		*model = BQ24261;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int bq24261_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> > +	struct power_supply_config charger_cfg = {};
> > +	struct bq24261_charger *chip;
> > +	int ret;
> > +	enum bq2426x_model model;
> > +
> > +	adapter = to_i2c_adapter(client->dev.parent);
> > +
> > +	if (!client->dev.platform_data && !id) {
> > +		dev_err(&client->dev, "platform data is null");
> > +		return -EFAULT;
> > +	}
> > +
> > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> > +		dev_err(&client->dev,
> > +			"I2C adapter %s doesn'tsupport BYTE DATA transfer\n",
> > +			adapter->name);
> > +		return -EIO;
> > +	}
> > +
> > +	ret = bq24261_get_model(client, &model);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "chip detection error (%d)\n", ret);
> > +		return -ENODEV;
> > +	}
> > +
> > +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> > +	if (!chip)
> > +		return -ENOMEM;
> > +
> > +	chip->client = client;
> > +	if (client->dev.platform_data)
> > +		chip->pdata = client->dev.platform_data;
> > +	else
> > +		chip->pdata = (struct bq24261_platform_data *)id->driver_data;
> > +	i2c_set_clientdata(client, chip);
> > +	mutex_init(&chip->lock);
> > +	chip->model = model;
> > +
> > +	/* Initialize charger parameters */
> > +	chip->cc = chip->pdata->def_cc;
> > +	chip->cv = chip->pdata->def_cv;
> > +	chip->iterm = chip->pdata->iterm;
> > +	chip->chg_status = BQ24261_CHRGR_STAT_UNKNOWN;
> > +	chip->chg_health = POWER_SUPPLY_HEALTH_UNKNOWN;
> > +
> > +	charger_cfg.drv_data = chip;
> > +	charger_cfg.supplied_to = bq24261_charger_supplied_to;
> > +	charger_cfg.num_supplicants =
> ARRAY_SIZE(bq24261_charger_supplied_to);
> > +	chip->psy_usb = power_supply_register(&client->dev,
> > +				&bq24261_charger_desc, &charger_cfg);
> > +	if (IS_ERR(chip->psy_usb)) {
> > +		dev_err(&client->dev,
> > +			"power supply registration failed(%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	INIT_DELAYED_WORK(&chip->wdt_work, bq24261_wdt_reset_worker);
> > +	INIT_DELAYED_WORK(&chip->fault_mon_work,
> bq24261_fault_mon_work);
> > +
> > +	ret = bq24261_extcon_register(chip);
> > +	if (ret < 0)
> > +		goto extcon_reg_failed;
> > +
> > +	if (chip->client->irq) {
> > +		ret = request_threaded_irq(chip->client->irq,
> > +					   NULL, bq24261_thread_handler,
> > +					   IRQF_SHARED | IRQF_NO_SUSPEND,
> > +					   DEV_NAME, chip);
> > +		if (ret) {
> > +			dev_err(&client->dev,
> > +				"irq request failed (%d)\n", ret);
> > +			goto irq_reg_failed;
> > +		}
> > +		INIT_WORK(&chip->irq_work, bq24261_irq_worker);
> > +	}
> > +
> > +	/* Check for charger connecetd boot case */
> > +	schedule_work(&chip->cable.work);
> > +
> > +	return 0;
> > +
> > +irq_reg_failed:
> > +	extcon_unregister_interest(&chip->cable.sdp);
> > +	extcon_unregister_interest(&chip->cable.cdp);
> > +	extcon_unregister_interest(&chip->cable.dcp);
> > +	extcon_unregister_interest(&chip->cable.otg);
> > +extcon_reg_failed:
> > +	power_supply_unregister(chip->psy_usb);
> > +	return ret;
> > +}
> > +
> > +static int bq24261_remove(struct i2c_client *client) {
> > +	struct bq24261_charger *chip = i2c_get_clientdata(client);
> > +
> > +	free_irq(client->irq, chip);
> > +	flush_scheduled_work();
> > +	extcon_unregister_interest(&chip->cable.sdp);
> > +	extcon_unregister_interest(&chip->cable.cdp);
> > +	extcon_unregister_interest(&chip->cable.dcp);
> > +	extcon_unregister_interest(&chip->cable.otg);
> > +	power_supply_unregister(chip->psy_usb);
> > +	return 0;
> > +}
> > +
> > +static int bq24261_suspend(struct device *dev) {
> > +	struct bq24261_charger *chip = dev_get_drvdata(dev);
> > +
> > +	dev_dbg(&chip->client->dev, "bq24261 suspend\n");
> > +	return 0;
> > +}
> > +
> > +static int bq24261_resume(struct device *dev) {
> > +	struct bq24261_charger *chip = dev_get_drvdata(dev);
> > +
> > +	dev_dbg(&chip->client->dev, "bq24261 resume\n");
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(bq24261_pm_ops, bq24261_suspend,
> > +			bq24261_resume);
> > +
> > +static const struct i2c_device_id bq24261_id[] = {
> > +	{DEV_NAME, 0},
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, bq24261_id);
> > +
> > +static struct i2c_driver bq24261_driver = {
> > +	.driver = {
> > +		   .name = DEV_NAME,
> > +		   .pm = &bq24261_pm_ops,
> > +		   },
> > +	.probe = bq24261_probe,
> > +	.remove = bq24261_remove,
> > +	.id_table = bq24261_id,
> 
> I just noticed this driver doesn't yet support DT which is probably something that
> should be added. When I start merging my work I will certainly need to do that
> but I'm curious if there are plans from your end to add this as well (and I had
> seen Laurentiu's bq24257_charger.c driver uses ACPI for this which seems to be
> some kind of superset of DT
> - forgive my simplification I'm not too familiar with ACPI yet).
> 
> --
> Andreas Dannenberg
> Texas Instruments
> 
> > +};
> > +
> > +module_i2c_driver(bq24261_driver);
> > +
> > +MODULE_AUTHOR("Jenny TC <jenny.tc@intel.com>");
> > +MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
> > +MODULE_DESCRIPTION("BQ24261 Charger Driver"); MODULE_LICENSE("GPL
> > +v2");
> > diff --git a/include/linux/power/bq24261_charger.h
> > b/include/linux/power/bq24261_charger.h
> > new file mode 100644
> > index 0000000..656db58
> > --- /dev/null
> > +++ b/include/linux/power/bq24261_charger.h
> > @@ -0,0 +1,26 @@
> > +/*
> > + * bq24261_charger.h: platform data structure for bq24261 driver
> > + *
> > + * Copyright (C) 2014 Intel Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; version 2
> > + * of the License.
> > + */
> > +
> > +#ifndef __BQ24261_CHARGER_H__
> > +#define __BQ24261_CHARGER_H__
> > +
> > +struct bq24261_platform_data {
> > +	int def_cc;
> > +	int def_cv;
> > +	int iterm;
> > +	int max_cc;
> > +	int max_cv;
> > +	int min_temp;
> > +	int max_temp;
> > +	bool thermal_sensing;
> > +};
> > +
> > +#endif
> > --
> > 1.7.9.5

Thanks,
Ram
