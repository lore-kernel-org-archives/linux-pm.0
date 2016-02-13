From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 6/8] power: cros_usbpd-charger: Add EC-based USB PD
 charger driver
Date: Fri, 12 Feb 2016 16:46:46 -0800
Message-ID: <56BE7CF6.20201@codeaurora.org>
References: <1455281825-23526-1-git-send-email-tomeu.vizoso@collabora.com>
 <1455281825-23526-7-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36253 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbcBMAqu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 19:46:50 -0500
In-Reply-To: <1455281825-23526-7-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org
Cc: Sameer Nanda <snanda@chromium.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=c3=b2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>

On 02/12/2016 04:57 AM, Tomeu Vizoso wrote:
>
>
> diff --git a/drivers/power/cros_usbpd-charger.c b/drivers/power/cros_usbpd-charger.c
> new file mode 100644
> index 000000000000..c1aa58b47f56
> --- /dev/null
> +++ b/drivers/power/cros_usbpd-charger.c
> @@ -0,0 +1,908 @@
> +/*
> + * Power supply driver for ChromeOS EC based USB PD Charger.
> + *
> + * Copyright (c) 2014 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/rtc.h>
> +#include <linux/slab.h>
> +
> +#define CROS_USB_PD_MAX_PORTS		8
> +#define CROS_USB_PD_MAX_LOG_ENTRIES	30
> +
> +#define CROS_USB_PD_LOG_UPDATE_DELAY msecs_to_jiffies(60000)
> +#define CROS_USB_PD_CACHE_UPDATE_DELAY msecs_to_jiffies(500)
> +
> +/* Buffer + macro for building PDLOG string */
> +#define BUF_SIZE 80
> +#define APPEND_STRING(buf, len, str, ...) ((len) += \
> +	snprintf((buf) + (len), max(BUF_SIZE - (len), 0), (str), ##__VA_ARGS__))
> +
> +#define CHARGER_DIR_NAME		"CROS_USB_PD_CHARGER%d"
> +#define CHARGER_DIR_NAME_LENGTH		sizeof(CHARGER_DIR_NAME)
> +
> +#define MANUFACTURER_MODEL_LENGTH	32
> +
> +struct port_data {
> +	int port_number;
> +	char name[CHARGER_DIR_NAME_LENGTH];
> +	char manufacturer[MANUFACTURER_MODEL_LENGTH];
> +	char model_name[MANUFACTURER_MODEL_LENGTH];
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +	int psy_type;
> +	int psy_online;
> +	int psy_status;
> +	int psy_current_max;
> +	int psy_voltage_max_design;
> +	int psy_voltage_now;
> +	int psy_power_max;
> +	struct charger_data *charger;
> +	unsigned long last_update;
> +};
> +
> +struct charger_data {
> +	struct device *dev;
> +	struct cros_ec_dev *ec_dev;
> +	struct cros_ec_device *ec_device;
> +	int num_charger_ports;
> +	int num_registered_psy;
> +	struct port_data *ports[CROS_USB_PD_MAX_PORTS];
> +	struct delayed_work log_work;
> +	struct workqueue_struct *log_workqueue;
> +	struct notifier_block notifier;
> +	bool suspended;
> +};
> +
> +#define EC_MAX_IN_SIZE EC_PROTO2_MAX_REQUEST_SIZE
> +#define EC_MAX_OUT_SIZE EC_PROTO2_MAX_RESPONSE_SIZE
> +uint8_t ec_inbuf[EC_MAX_IN_SIZE];
> +uint8_t ec_outbuf[EC_MAX_OUT_SIZE];

static? Why can't these be part of charger_data?

>
> +
> +static int set_ec_usb_pd_override_ports(struct charger_data *charger,
> +					int port_num)
> +{
> +	struct device *dev = charger->dev;
> +	struct ec_params_charge_port_override req;
> +	int ret;
> +
> +	req.override_port = port_num;
> +
> +	ret = ec_command(charger->ec_dev, 0, EC_CMD_PD_CHARGE_PORT_OVERRIDE,
> +			 (uint8_t *)&req, sizeof(req),
> +			 NULL, 0);
> +	if (ret < 0) {
> +		dev_info(dev, "Port Override command returned 0x%x\n", ret);

dev_err?

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +
[...]
> +
> +static void cros_usb_pd_print_log_entry(struct ec_response_pd_log *r,
> +					ktime_t tstamp)
> +{
> +	static const char * const fault_names[] = {
> +		"---", "OCP", "fast OCP", "OVP", "Discharge"
> +	};
> +	static const char * const role_names[] = {
> +		"Disconnected", "SRC", "SNK", "SNK (not charging)"
> +	};
> +	static const char * const chg_type_names[] = {
> +		"None", "PD", "Type-C", "Proprietary",
> +		"DCP", "CDP", "SDP", "Other", "VBUS"
> +	};
> +	int i;
> +	int role_idx, type_idx;
> +	const char *fault, *role, *chg_type;
> +	struct usb_chg_measures *meas;
> +	struct mcdp_info *minfo;
> +	struct rtc_time rt;
> +	int len = 0;
> +	char buf[BUF_SIZE + 1];
> +
> +	/* the timestamp is the number of 1024th of seconds in the past */
> +	tstamp = ktime_sub_us(tstamp,
> +		 (uint64_t)r->timestamp << PD_LOG_TIMESTAMP_SHIFT);
> +	rt = rtc_ktime_to_tm(tstamp);
> +
> +	switch (r->type) {
> +	case PD_EVENT_MCU_CHARGE:
> +		if (r->data & CHARGE_FLAGS_OVERRIDE)
> +			APPEND_STRING(buf, len, "override ");
> +		if (r->data & CHARGE_FLAGS_DELAYED_OVERRIDE)
> +			APPEND_STRING(buf, len, "pending_override ");
> +		role_idx = r->data & CHARGE_FLAGS_ROLE_MASK;
> +		role = role_idx < ARRAY_SIZE(role_names) ?
> +			role_names[role_idx] : "Unknown";
> +		type_idx = (r->data & CHARGE_FLAGS_TYPE_MASK)
> +			 >> CHARGE_FLAGS_TYPE_SHIFT;
> +		chg_type = type_idx < ARRAY_SIZE(chg_type_names) ?
> +			chg_type_names[type_idx] : "???";
> +
> +		if ((role_idx == USB_PD_PORT_POWER_DISCONNECTED) ||
> +		    (role_idx == USB_PD_PORT_POWER_SOURCE)) {
> +			APPEND_STRING(buf, len, "%s", role);
> +			break;
> +		}
> +
> +		meas = (struct usb_chg_measures *)r->payload;
> +		APPEND_STRING(buf, len, "%s %s %s %dmV max %dmV / %dmA", role,
> +			r->data & CHARGE_FLAGS_DUAL_ROLE ? "DRP" : "Charger",
> +			chg_type,
> +			meas->voltage_now,
> +			meas->voltage_max,
> +			meas->current_max);
> +		break;
> +	case PD_EVENT_ACC_RW_FAIL:
> +		APPEND_STRING(buf, len, "RW signature check failed");
> +		break;
> +	case PD_EVENT_PS_FAULT:
> +		fault = r->data < ARRAY_SIZE(fault_names) ? fault_names[r->data]
> +							  : "???";
> +		APPEND_STRING(buf, len, "Power supply fault: %s", fault);
> +		break;
> +	case PD_EVENT_VIDEO_DP_MODE:
> +		APPEND_STRING(buf, len, "DP mode %sabled",
> +			      (r->data == 1) ? "en" : "dis");
> +		break;
> +	case PD_EVENT_VIDEO_CODEC:
> +		minfo = (struct mcdp_info *)r->payload;
> +		APPEND_STRING(buf, len,
> +			      "HDMI info: family:%04x chipid:%04x irom:%d.%d.%d fw:%d.%d.%d",
> +			      MCDP_FAMILY(minfo->family),
> +			      MCDP_CHIPID(minfo->chipid),
> +			      minfo->irom.major, minfo->irom.minor,
> +			      minfo->irom.build, minfo->fw.major,
> +			      minfo->fw.minor, minfo->fw.build);
> +		break;
> +	default:
> +		APPEND_STRING(buf, len,
> +			"Event %02x (%04x) [", r->type, r->data);
> +		for (i = 0; i < PD_LOG_SIZE(r->size_port); i++)
> +			APPEND_STRING(buf, len, "%02x ", r->payload[i]);
> +		APPEND_STRING(buf, len, "]");
> +		break;
> +	}
> +
> +	pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03d P%d %s\n",
> +		rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
> +		rt.tm_hour, rt.tm_min, rt.tm_sec,
> +		(int)(ktime_to_ms(tstamp) % MSEC_PER_SEC),
> +		PD_LOG_PORT(r->size_port), buf);

Is the kernel log a good place to be putting this information? Maybe
this should go into debugfs?

> +}
> +
> +static void cros_usb_pd_log_check(struct work_struct *work)
> +{
> +	struct charger_data *charger = container_of(to_delayed_work(work),
> +		struct charger_data, log_work);
> +	struct device *dev = charger->dev;
> +	union {
> +		struct ec_response_pd_log r;
> +		uint32_t words[8]; /* space for the payload */
> +	} u;
> +	int ret;
> +	int entries = 0;
> +	ktime_t now;
> +
> +	if (charger->suspended) {
> +		dev_dbg(dev, "Suspended...bailing out\n");
> +		return;
> +	}
> +
> +	while (entries++ < CROS_USB_PD_MAX_LOG_ENTRIES) {
> +		ret = ec_command(charger->ec_dev, 0, EC_CMD_PD_GET_LOG_ENTRY,
> +				 NULL, 0, (uint8_t *)&u, sizeof(u));
> +		now = ktime_get_real();
> +		if (ret < 0) {
> +			dev_dbg(dev, "Cannot get PD log %d\n", ret);
> +			break;
> +		}
> +		if (u.r.type == PD_EVENT_NO_ENTRY)
> +			break;
> +
> +		cros_usb_pd_print_log_entry(&u.r, now);
> +	}
> +
> +	queue_delayed_work(charger->log_workqueue, &charger->log_work,
> +		CROS_USB_PD_LOG_UPDATE_DELAY);
> +}
> +
> +static int cros_usb_pd_ec_event(struct notifier_block *nb,
> +	unsigned long queued_during_suspend, void *_notify)
> +{
> +	struct charger_data *charger;
> +	struct device *dev;
> +	struct cros_ec_device *ec_device;
> +	u32 host_event;
> +
> +	charger = container_of(nb, struct charger_data, notifier);
> +	dev = charger->dev;
> +	ec_device = charger->ec_device;
> +
> +	host_event = cros_ec_get_host_event(ec_device);
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> +		cros_usb_pd_charger_power_changed(charger->ports[0]->psy);
> +		return NOTIFY_OK;
> +	} else {
> +		return NOTIFY_DONE;
> +	}

Simplify to return NOTIFY_DONE without the else.

> +}
> +
> +static char *charger_supplied_to[] = {"cros-usb_pd-charger"};

const?

> +
> +static int cros_usb_pd_charger_probe(struct platform_device *pd)
> +{
> +	struct device *dev = &pd->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> +	struct cros_ec_device *ec_device;
> +	struct charger_data *charger;
> +	struct port_data *port;
> +	struct power_supply_desc *psy_desc;
> +	struct power_supply_config psy_cfg = {};
> +	int i;
> +	int ret = -EINVAL;
> +
> +	dev_dbg(dev, "cros_usb_pd_charger_probe\n");
> +	if (!ec_dev) {
> +		WARN(1, "%s: No EC dev found\n", dev_name(dev));
> +		return -EINVAL;
> +	}
> +
> +	ec_device = ec_dev->ec_dev;
> +	if (!ec_device) {
> +		WARN(1, "%s: No EC device found\n", dev_name(dev));
> +		return -EINVAL;
> +	}
> +
> +	charger = devm_kzalloc(dev, sizeof(struct charger_data),
> +				    GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->dev = dev;
> +	charger->ec_dev = ec_dev;
> +	charger->ec_device = ec_device;
> +
> +	platform_set_drvdata(pd, charger);
> +
> +	if ((get_ec_num_ports(charger, &charger->num_charger_ports) < 0) ||
> +	    !charger->num_charger_ports) {
> +		/*
> +		 * This can happen on a system that doesn't support USB PD.
> +		 * Log a message, but no need to warn.
> +		 */
> +		dev_info(dev, "No charging ports found\n");

dev_err?

> +		ret = -ENODEV;
> +		goto fail_nowarn;
> +	}
> +
> +	for (i = 0; i < charger->num_charger_ports; i++) {
> +		port = devm_kzalloc(dev, sizeof(struct port_data), GFP_KERNEL);
> +		if (!port) {
> +			dev_err(dev, "Failed to alloc port structure\n");

We don't need error messages on allocation failures (checkpatch usually
catches this).

> +			ret = -ENOMEM;
> +			goto fail;
> +		}
> +
> +		port->charger = charger;
> +		port->port_number = i;
> +		sprintf(port->name, CHARGER_DIR_NAME, i);
> +
> +		psy_desc = &port->psy_desc;
> +		psy_desc->name = port->name;
> +		psy_desc->type = POWER_SUPPLY_TYPE_USB;
> +		psy_desc->get_property = cros_usb_pd_charger_get_prop;
> +		psy_desc->set_property = cros_usb_pd_charger_set_prop;
> +		psy_desc->property_is_writeable =
> +			cros_usb_pd_charger_is_writeable;
> +		psy_desc->external_power_changed =
> +			cros_usb_pd_charger_power_changed;
> +		psy_desc->properties = cros_usb_pd_charger_props;
> +		psy_desc->num_properties = ARRAY_SIZE(
> +			cros_usb_pd_charger_props);
> +
> +		psy_cfg.drv_data = port;
> +		psy_cfg.supplied_to = charger_supplied_to;
> +		psy_cfg.num_supplicants = ARRAY_SIZE(charger_supplied_to);
> +
> +		port->psy = power_supply_register_no_ws(dev, psy_desc,
> +							&psy_cfg);
> +		if (IS_ERR(port->psy)) {
> +			dev_err(dev, "Failed to register power supply: %ld\n",
> +				PTR_ERR(port->psy));
> +			continue;
> +		}
> +
> +		charger->ports[charger->num_registered_psy++] = port;
> +	}
> +
> +	if (!charger->num_registered_psy) {
> +		ret = -ENODEV;
> +		dev_err(dev, "No power supplies registered\n");
> +		goto fail;
> +	}
> +
> +	if (ec_device->mkbp_event_supported) {
> +		/* Get PD events from the EC */
> +		charger->notifier.notifier_call = cros_usb_pd_ec_event;
> +		ret = blocking_notifier_chain_register(
> +			&ec_device->event_notifier, &charger->notifier);
> +		if (ret < 0)
> +			dev_warn(dev, "failed to register notifier\n");
> +	}
> +
> +	/* Retrieve PD event logs periodically */
> +	INIT_DELAYED_WORK(&charger->log_work, cros_usb_pd_log_check);
> +	charger->log_workqueue =
> +		create_singlethread_workqueue("cros_usb_pd_log");
> +	queue_delayed_work(charger->log_workqueue, &charger->log_work,
> +		CROS_USB_PD_LOG_UPDATE_DELAY);
> +
> +	return 0;
> +
> +fail:
> +	WARN(1, "%s: Failing probe (err:0x%x)\n", dev_name(dev), ret);
> +
> +fail_nowarn:
> +	if (charger) {

This is always true?

> +		for (i = 0; i < charger->num_registered_psy; i++) {
> +			port = charger->ports[i];
> +			power_supply_unregister(port->psy);
> +			devm_kfree(dev, port);
> +		}
> +		platform_set_drvdata(pd, NULL);
> +		devm_kfree(dev, charger);

Seems like we could let devres take care of this.

> +	}
> +
> +	dev_info(dev, "Failing probe (err:0x%x)\n", ret);

Is this necessary? Doesn't driver core already spew something out for
this case if some debugging flag is enabled?

> +	return ret;
> +}
> +
> +static int cros_usb_pd_charger_remove(struct platform_device *pd)
> +{
> +	struct charger_data *charger = platform_get_drvdata(pd);
> +	struct device *dev = charger->dev;
> +	struct port_data *port;
> +	int i;
> +
> +	if (charger) {

We just derefed charger a few lines up.

> +		for (i = 0; i < charger->num_registered_psy; i++) {
> +			port = charger->ports[i];
> +			power_supply_unregister(port->psy);
> +			devm_kfree(dev, port);

Can't we let driver removal take care of this?

> +		}
> +		flush_delayed_work(&charger->log_work);
> +		platform_set_drvdata(pd, NULL);

This is not needed.

> +		devm_kfree(dev, charger);

Again, driver remove already does this?

> +	}
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cros_usb_pd_charger_resume(struct device *dev)
> +{
> +	struct charger_data *charger = dev_get_drvdata(dev);
> +	int i;
> +
> +	if (!charger)
> +		return 0;

Seems sort of impossible...

> +
> +	charger->suspended = false;
> +
> +	dev_dbg(dev, "cros_usb_pd_charger_resume: updating power supplies\n");
> +	for (i = 0; i < charger->num_registered_psy; i++) {
> +		power_supply_changed(charger->ports[i]->psy);
> +		charger->ports[i]->last_update =
> +				jiffies - CROS_USB_PD_CACHE_UPDATE_DELAY;
> +	}
> +	queue_delayed_work(charger->log_workqueue, &charger->log_work,
> +		CROS_USB_PD_LOG_UPDATE_DELAY);
> +
> +	return 0;
> +}
> +
> +static int cros_usb_pd_charger_suspend(struct device *dev)
> +{
> +	struct charger_data *charger = dev_get_drvdata(dev);
> +
> +	charger->suspended = true;
> +
> +	if (charger)

We just derefed charger so it better be non-NULL

> +		flush_delayed_work(&charger->log_work);
> +	return 0;
> +}
> +#endif
> +
> +static int set_ec_ext_power_limit(struct cros_ec_dev *ec,
> +				  uint16_t current_lim, uint16_t voltage_lim)
> +{
> +	struct ec_params_external_power_limit_v1 req;
> +	int ret;
> +
> +	req.current_lim = current_lim;
> +	req.voltage_lim = voltage_lim;
> +
> +	ret = ec_command(ec, 0, EC_CMD_EXT_POWER_CURRENT_LIMIT,
> +			 (uint8_t *)&req, sizeof(req), NULL, 0);
> +	if (ret < 0) {
> +		dev_warn(ec->dev,
> +			 "External power limit command returned 0x%x\n",
> +			 ret);

dev_err?

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t get_ec_ext_current_lim(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", ext_current_lim);
> +}
> +
> +static ssize_t set_ec_ext_current_lim(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int ret;
> +	uint16_t tmp_val;
> +	struct cros_ec_dev *ec = container_of(
> +			dev, struct cros_ec_dev, class_dev);
> +
> +	if (kstrtou16(buf, 0, &tmp_val) < 0)
> +		return -EINVAL;
> +
> +	ret = set_ec_ext_power_limit(ec, tmp_val, ext_voltage_lim);
> +	if (ret < 0)
> +		return ret;
> +
> +	ext_current_lim = tmp_val;
> +	if (ext_current_lim == EC_POWER_LIMIT_NONE)
> +		dev_info(ec->dev, "External current limit removed\n");
> +	else
> +		dev_info(ec->dev, "External current limit set to %dmA\n",
> +			 ext_current_lim);

Why are we dev_info printing on sysfs writes?

> +
> +	return count;
> +}
> +
> +static ssize_t get_ec_ext_voltage_lim(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", ext_voltage_lim);
> +}
> +
> +static ssize_t set_ec_ext_voltage_lim(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int ret;
> +	uint16_t tmp_val;
> +
> +	struct cros_ec_dev *ec = container_of(
> +			dev, struct cros_ec_dev, class_dev);
> +
> +	if (kstrtou16(buf, 0, &tmp_val) < 0)
> +		return -EINVAL;
> +
> +	ret = set_ec_ext_power_limit(ec, ext_current_lim, tmp_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ext_voltage_lim = tmp_val;
> +	if (ext_voltage_lim == EC_POWER_LIMIT_NONE)
> +		dev_info(ec->dev, "External voltage limit removed\n");
> +	else
> +		dev_info(ec->dev, "External voltage limit set to %dmV\n",
> +			 ext_voltage_lim);

Again...

> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(ext_current_lim, S_IWUSR | S_IWGRP | S_IRUGO,
> +		   get_ec_ext_current_lim,
> +		   set_ec_ext_current_lim);
> +static DEVICE_ATTR(ext_voltage_lim, S_IWUSR | S_IWGRP | S_IRUGO,
> +		   get_ec_ext_voltage_lim,
> +		   set_ec_ext_voltage_lim);

Any documentation for these in Documentation/ABI?

> +
> +static struct attribute *__ext_power_cmds_attrs[] = {
> +	&dev_attr_ext_current_lim.attr,
> +	&dev_attr_ext_voltage_lim.attr,
> +	NULL,
> +};
> +
> +struct attribute_group cros_usb_pd_charger_attr_group = {

static?

> +	.name = "usb-pd-charger",
> +	.attrs = __ext_power_cmds_attrs,
> +};
> +
> +static SIMPLE_DEV_PM_OPS(cros_usb_pd_charger_pm_ops,
> +	cros_usb_pd_charger_suspend, cros_usb_pd_charger_resume);

const?

> +
> +static struct platform_driver cros_usb_pd_charger_driver = {
> +	.driver = {
> +		.name = "cros-usb-pd-charger",
> +		.owner = THIS_MODULE,

This isn't needed anymore.

> +		.pm = &cros_usb_pd_charger_pm_ops,
> +	},
> +	.probe = cros_usb_pd_charger_probe,
> +	.remove = cros_usb_pd_charger_remove,
> +};
> +
> +module_platform_driver(cros_usb_pd_charger_driver);
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

