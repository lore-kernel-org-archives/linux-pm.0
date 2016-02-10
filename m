From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 4/6] power: cros_usbpd-charger: Add EC-based USB PD
 charger driver
Date: Wed, 10 Feb 2016 16:49:44 +0000
Message-ID: <20160210164944.GN3782@x1>
References: <1454679181-8949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1454679181-8949-5-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454679181-8949-5-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Benson Leung <bleung@chromium.org>, Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On Fri, 05 Feb 2016, Tomeu Vizoso wrote:

> From: Sameer Nanda <snanda@chromium.org>
>=20
> This driver exposes the charger functionality in the PD EC to userspa=
ce.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Sameer Nanda <snanda@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Shawn Nematbakhsh <shawnn@chromium.org>
> ---
>=20
>  drivers/platform/chrome/cros_ec_proto.c |  37 ++
>  drivers/power/Kconfig                   |  10 +
>  drivers/power/Makefile                  |   1 +
>  drivers/power/cros_usbpd-charger.c      | 907 ++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/cros_ec.h             |  28 +
>  include/linux/mfd/cros_ec_commands.h    | 324 +++++++++++-
>  6 files changed, 1302 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/power/cros_usbpd-charger.c

A 1300 line patch crossing 3 subsystems is not the way you should be
submitting code.  Please split these up into separate commits.  The
only time you should squash all this functionality into a single patch
is to mitigate otherwise unavoidable build issues.  I do not believe
that's the case here.

> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platfo=
rm/chrome/cros_ec_proto.c
> index 6e138e2333f3..083a32461f2d 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -482,3 +482,40 @@ int cros_ec_get_next_event(struct cros_ec_device=
 *ec_dev)
>  		return get_keyboard_state_event(ec_dev);
>  }
>  EXPORT_SYMBOL(cros_ec_get_next_event);
> +
> +int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> +			    struct cros_ec_command *msg)
> +{
> +	int ret =3D cros_ec_cmd_xfer(ec_dev, msg);
> +
> +	if (ret < 0)
> +		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> +	else if (msg->result)
> +		return -EECRESULT - msg->result;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
> +
> +u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
> +{
> +	u32 host_event;
> +
> +	if (!ec_dev->mkbp_event_supported) {
> +		dev_warn(ec_dev->dev,
> +			 "This EC does not support EC_MKBP_EVENT_HOST_EVENT");
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	if (ec_dev->event_data.event_type !=3D EC_MKBP_EVENT_HOST_EVENT)
> +		return 0;
> +
> +	if (ec_dev->event_size !=3D sizeof(host_event)) {
> +		dev_warn(ec_dev->dev, "Invalid host event size\n");
> +		return 0;
> +	}
> +
> +	host_event =3D get_unaligned_le32(&ec_dev->event_data.data.host_eve=
nt);
> +	return host_event;
> +}
> +EXPORT_SYMBOL(cros_ec_get_host_event);
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 1ddd13cc0c07..26355850d91b 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -502,6 +502,16 @@ config AXP20X_POWER
>  	  This driver provides support for the power supply features of
>  	  AXP20x PMIC.
> =20
> +config CHARGER_CROS_USB_PD
> +	tristate "Chrome OS EC based USB PD charger"
> +	depends on MFD_CROS_EC
> +	default y
> +	help
> +	  Say Y here to enable Chrome OS EC based USB PD charger driver. Th=
is
> +	  driver gets various bits of information about what is connected t=
o
> +	  USB PD ports from the EC and converts that into power_supply
> +	  properties.
> +
>  endif # POWER_SUPPLY
> =20
>  source "drivers/power/reset/Kconfig"
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 0e4eab55f8d7..b83685bfae61 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -73,3 +73,4 @@ obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charge=
r.o
>  obj-$(CONFIG_POWER_RESET)	+=3D reset/
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> +obj-$(CONFIG_CHARGER_CROS_USB_PD)	+=3D cros_usbpd-charger.o
> diff --git a/drivers/power/cros_usbpd-charger.c b/drivers/power/cros_=
usbpd-charger.c
> new file mode 100644
> index 000000000000..72c427554b56
> --- /dev/null
> +++ b/drivers/power/cros_usbpd-charger.c
> @@ -0,0 +1,907 @@
> +/*
> + * Power supply driver for ChromeOS EC based USB PD Charger.
> + *
> + * Copyright (c) 2014 Google, Inc
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
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
> +#define APPEND_STRING(buf, len, str, ...) ((len) +=3D \
> +	snprintf((buf) + (len), max(BUF_SIZE - (len), 0), (str), ##__VA_ARG=
S__))
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
> +
> +static enum power_supply_property cros_usb_pd_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +/* Current external voltage/current limit in mV/mA. Default to none.=
 */
> +static uint16_t ext_voltage_lim =3D EC_POWER_LIMIT_NONE;
> +static uint16_t ext_current_lim =3D EC_POWER_LIMIT_NONE;
> +
> +static int ec_command(struct cros_ec_dev *ec_dev, int version, int c=
ommand,
> +		      uint8_t *outdata, int outsize, uint8_t *indata,
> +		      int insize)
> +{
> +	struct cros_ec_device *ec_device =3D ec_dev->ec_dev;
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg =3D kmalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version =3D version;
> +	msg->command =3D ec_dev->cmd_offset + command;
> +	msg->outsize =3D outsize;
> +	msg->insize =3D insize;
> +
> +	memcpy(msg->data, outdata, outsize);
> +	ret =3D cros_ec_cmd_xfer_status(ec_device, msg);
> +	memcpy(indata, msg->data, insize);
> +
> +	kfree(msg);
> +
> +	return ret;
> +}
> +
> +static int set_ec_usb_pd_override_ports(struct charger_data *charger=
,
> +					int port_num)
> +{
> +	struct device *dev =3D charger->dev;
> +	struct ec_params_charge_port_override req;
> +	int ret;
> +
> +	req.override_port =3D port_num;
> +
> +	ret =3D ec_command(charger->ec_dev, 0, EC_CMD_PD_CHARGE_PORT_OVERRI=
DE,
> +			 (uint8_t *)&req, sizeof(req),
> +			 NULL, 0);
> +	if (ret < 0) {
> +		dev_info(dev, "Port Override command returned 0x%x\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_ec_num_ports(struct charger_data *charger, int *num_p=
orts)
> +{
> +	struct device *dev =3D charger->dev;
> +	struct ec_response_usb_pd_ports *resp =3D
> +	    (struct ec_response_usb_pd_ports *)ec_inbuf;
> +	int ret;
> +
> +	*num_ports =3D 0;
> +	ret =3D ec_command(charger->ec_dev, 0, EC_CMD_USB_PD_PORTS,
> +			 NULL, 0, ec_inbuf, EC_MAX_IN_SIZE);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to query PD ports (err:0x%x)\n", ret);
> +		return ret;
> +	}
> +	*num_ports =3D resp->num_ports;
> +	dev_dbg(dev, "Num ports =3D %d\n", *num_ports);
> +
> +	return 0;
> +}
> +
> +static int get_ec_usb_pd_discovery_info(struct port_data *port)
> +{
> +	struct charger_data *charger =3D port->charger;
> +	struct device *dev =3D charger->dev;
> +	struct ec_params_usb_pd_info_request req;
> +	struct ec_params_usb_pd_discovery_entry resp;
> +	int ret;
> +
> +	req.port =3D port->port_number;
> +
> +	ret =3D ec_command(charger->ec_dev, 0, EC_CMD_USB_PD_DISCOVERY,
> +			 (uint8_t *)&req, sizeof(req),
> +			 (uint8_t *)&resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to query Discovery info (err:0x%x)\n",
> +			 ret);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "Port %d: VID =3D 0x%x, PID=3D0x%x, PTYPE=3D0x%x\n",
> +		port->port_number, resp.vid, resp.pid, resp.ptype);
> +
> +	snprintf(port->manufacturer, MANUFACTURER_MODEL_LENGTH, "%x", resp.=
vid);
> +	snprintf(port->model_name, MANUFACTURER_MODEL_LENGTH, "%x", resp.pi=
d);
> +
> +	return 0;
> +}
> +
> +static int get_ec_usb_pd_power_info(struct port_data *port)
> +{
> +	struct charger_data *charger =3D port->charger;
> +	struct device *dev =3D charger->dev;
> +	struct ec_params_usb_pd_power_info req;
> +	struct ec_response_usb_pd_power_info resp;
> +	char role_str[80];
> +	int ret, last_psy_status, last_psy_type;
> +
> +	req.port =3D port->port_number;
> +	ret =3D ec_command(charger->ec_dev, 0, EC_CMD_USB_PD_POWER_INFO,
> +			 (uint8_t *)&req, sizeof(req),
> +			 (uint8_t *)&resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to query PD power info (err:0x%x)\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	last_psy_status =3D port->psy_status;
> +	last_psy_type =3D port->psy_type;
> +
> +	switch (resp.role) {
> +	case USB_PD_PORT_POWER_DISCONNECTED:
> +		snprintf(role_str, sizeof(role_str), "%s", "DISCONNECTED");
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 0;
> +		break;
> +	case USB_PD_PORT_POWER_SOURCE:
> +		snprintf(role_str, sizeof(role_str), "%s", "SOURCE");
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 0;
> +		break;
> +	case USB_PD_PORT_POWER_SINK:
> +		snprintf(role_str, sizeof(role_str), "%s", "SINK");
> +		port->psy_status =3D POWER_SUPPLY_STATUS_CHARGING;
> +		port->psy_online =3D 1;
> +		break;
> +	case USB_PD_PORT_POWER_SINK_NOT_CHARGING:
> +		snprintf(role_str, sizeof(role_str), "%s", "NOT CHARGING");
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 1;
> +		break;
> +	default:
> +		snprintf(role_str, sizeof(role_str), "%s", "UNKNOWN");
> +		dev_err(dev, "Unknown role %d\n", resp.role);
> +		break;
> +	}
> +
> +	port->psy_voltage_max_design =3D resp.meas.voltage_max;
> +	port->psy_voltage_now =3D resp.meas.voltage_now;
> +	port->psy_current_max =3D resp.meas.current_max;
> +	port->psy_power_max =3D resp.max_power;
> +
> +	switch (resp.type) {
> +	case USB_CHG_TYPE_BC12_SDP:
> +	case USB_CHG_TYPE_VBUS:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB;
> +		break;
> +	case USB_CHG_TYPE_NONE:
> +		/*
> +		 * For dual-role devices when we are a source, the firmware
> +		 * reports the type as NONE. Report such chargers as type
> +		 * USB_PD_DRP.
> +		 */
> +		if (resp.role =3D=3D USB_PD_PORT_POWER_SOURCE && resp.dualrole)
> +			port->psy_type =3D POWER_SUPPLY_TYPE_USB_PD_DRP;
> +		else
> +			port->psy_type =3D POWER_SUPPLY_TYPE_USB;
> +		break;
> +	case USB_CHG_TYPE_PROPRIETARY:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_MAINS;
> +		break;
> +	case USB_CHG_TYPE_C:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB_TYPE_C;
> +		break;
> +	case USB_CHG_TYPE_BC12_DCP:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB_DCP;
> +		break;
> +	case USB_CHG_TYPE_BC12_CDP:
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB_CDP;
> +		break;
> +	case USB_CHG_TYPE_PD:
> +		if (resp.dualrole)
> +			port->psy_type =3D POWER_SUPPLY_TYPE_USB_PD_DRP;
> +		else
> +			port->psy_type =3D POWER_SUPPLY_TYPE_USB_PD;
> +		break;
> +	case USB_CHG_TYPE_UNKNOWN:
> +		/*
> +		 * While the EC is trying to determine the type of charger that
> +		 * has been plugged in, it will report the charger type as
> +		 * unknown. Treat this case as a dedicated charger since we
> +		 * don't know any better just yet. Additionally since the power
> +		 * capabilities are unknown, report the max current and voltage
> +		 * as zero.
> +		 */
> +		port->psy_type =3D POWER_SUPPLY_TYPE_MAINS;
> +		port->psy_voltage_max_design =3D 0;
> +		port->psy_current_max =3D 0;
> +		break;
> +	default:
> +		dev_err(dev, "Port %d: default case!\n",
> +			port->port_number);
> +		port->psy_type =3D POWER_SUPPLY_TYPE_USB;
> +	}
> +
> +	port->psy_desc.type =3D port->psy_type;
> +
> +	dev_dbg(dev,
> +		"Port %d: %s type=3D%d=3Dvmax=3D%d vnow=3D%d cmax=3D%d clim=3D%d p=
max=3D%d\n",
> +		port->port_number, role_str, resp.type,
> +		resp.meas.voltage_max, resp.meas.voltage_now,
> +		resp.meas.current_max, resp.meas.current_lim,
> +		resp.max_power);
> +
> +	/*
> +	 * If power supply type or status changed, explicitly call
> +	 * power_supply_changed. This results in udev event getting generat=
ed
> +	 * and allows user mode apps to react quicker instead of waiting fo=
r
> +	 * their next poll of power supply status.
> +	 */
> +	if (last_psy_type !=3D port->psy_type ||
> +	    last_psy_status !=3D port->psy_status) {
> +		dev_dbg(dev, "Port %d: Calling power_supply_changed\n",
> +			port->port_number);
> +		power_supply_changed(port->psy);
> +	}
> +
> +	return 0;
> +}
> +
> +static int get_ec_port_status(struct port_data *port, bool ratelimit=
)
> +{
> +	int ret;
> +
> +	if (ratelimit &&
> +	    time_is_after_jiffies(port->last_update +
> +				  CROS_USB_PD_CACHE_UPDATE_DELAY))
> +		return 0;
> +
> +	ret =3D get_ec_usb_pd_power_info(port);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D get_ec_usb_pd_discovery_info(port);
> +	port->last_update =3D jiffies;
> +
> +	return ret;
> +}
> +
> +static void cros_usb_pd_charger_power_changed(struct power_supply *p=
sy)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +	struct charger_data *charger =3D port->charger;
> +	struct device *dev =3D charger->dev;
> +	int i;
> +
> +	dev_dbg(dev, "cros_usb_pd_charger_power_changed\n");
> +	for (i =3D 0; i < charger->num_registered_psy; i++)
> +		get_ec_port_status(charger->ports[i], false);
> +}
> +
> +static int cros_usb_pd_charger_get_prop(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    union power_supply_propval *val)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +	struct charger_data *charger =3D port->charger;
> +	struct device *dev =3D charger->dev;
> +	int ret;
> +
> +
> +	/* Only refresh ec_port_status for dynamic properties */
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		ret =3D get_ec_port_status(port, true);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to get port status (err:0x%x)\n",
> +				ret);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D port->psy_online;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D port->psy_status;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval =3D port->psy_current_max * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D port->psy_voltage_max_design * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D port->psy_voltage_now * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		/* TODO: send a TBD host command to the EC. */
> +		val->intval =3D 0;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D port->model_name;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D port->manufacturer;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_usb_pd_charger_set_prop(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    const union power_supply_propval *val)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +	struct charger_data *charger =3D port->charger;
> +	int port_number;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		/*
> +		 * A value of -1 implies switching to battery as the power
> +		 * source. Any other value implies using this port as the
> +		 * power source.
> +		 */
> +		port_number =3D val->intval;
> +		if (port_number !=3D -1)
> +			port_number =3D port->port_number;
> +		return set_ec_usb_pd_override_ports(charger, port_number);
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int cros_usb_pd_charger_is_writeable(struct power_supply *psy=
,
> +		enum power_supply_property psp)
> +{
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		ret =3D 1;
> +		break;
> +	default:
> +		ret =3D 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static void cros_usb_pd_print_log_entry(struct ec_response_pd_log *r=
,
> +					ktime_t tstamp)
> +{
> +	static const char * const fault_names[] =3D {
> +		"---", "OCP", "fast OCP", "OVP", "Discharge"
> +	};
> +	static const char * const role_names[] =3D {
> +		"Disconnected", "SRC", "SNK", "SNK (not charging)"
> +	};
> +	static const char * const chg_type_names[] =3D {
> +		"None", "PD", "Type-C", "Proprietary",
> +		"DCP", "CDP", "SDP", "Other", "VBUS"
> +	};
> +	int i;
> +	int role_idx, type_idx;
> +	const char *fault, *role, *chg_type;
> +	struct usb_chg_measures *meas;
> +	struct mcdp_info *minfo;
> +	struct rtc_time rt;
> +	int len =3D 0;
> +	char buf[BUF_SIZE + 1];
> +
> +	/* the timestamp is the number of 1024th of seconds in the past */
> +	tstamp =3D ktime_sub_us(tstamp,
> +		 (uint64_t)r->timestamp << PD_LOG_TIMESTAMP_SHIFT);
> +	rt =3D rtc_ktime_to_tm(tstamp);
> +
> +	switch (r->type) {
> +	case PD_EVENT_MCU_CHARGE:
> +		if (r->data & CHARGE_FLAGS_OVERRIDE)
> +			APPEND_STRING(buf, len, "override ");
> +		if (r->data & CHARGE_FLAGS_DELAYED_OVERRIDE)
> +			APPEND_STRING(buf, len, "pending_override ");
> +		role_idx =3D r->data & CHARGE_FLAGS_ROLE_MASK;
> +		role =3D role_idx < ARRAY_SIZE(role_names) ?
> +			role_names[role_idx] : "Unknown";
> +		type_idx =3D (r->data & CHARGE_FLAGS_TYPE_MASK)
> +			 >> CHARGE_FLAGS_TYPE_SHIFT;
> +		chg_type =3D type_idx < ARRAY_SIZE(chg_type_names) ?
> +			chg_type_names[type_idx] : "???";
> +
> +		if ((role_idx =3D=3D USB_PD_PORT_POWER_DISCONNECTED) ||
> +		    (role_idx =3D=3D USB_PD_PORT_POWER_SOURCE)) {
> +			APPEND_STRING(buf, len, "%s", role);
> +			break;
> +		}
> +
> +		meas =3D (struct usb_chg_measures *)r->payload;
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
> +		fault =3D r->data < ARRAY_SIZE(fault_names) ? fault_names[r->data]
> +							  : "???";
> +		APPEND_STRING(buf, len, "Power supply fault: %s", fault);
> +		break;
> +	case PD_EVENT_VIDEO_DP_MODE:
> +		APPEND_STRING(buf, len, "DP mode %sabled",
> +			      (r->data =3D=3D 1) ? "en" : "dis");
> +		break;
> +	case PD_EVENT_VIDEO_CODEC:
> +		minfo =3D (struct mcdp_info *)r->payload;
> +		APPEND_STRING(buf, len,
> +			      "HDMI info: family:%04x chipid:%04x irom:%d.%d.%d fw:%d.%d.=
%d",
> +			      MCDP_FAMILY(minfo->family),
> +			      MCDP_CHIPID(minfo->chipid),
> +			      minfo->irom.major, minfo->irom.minor,
> +			      minfo->irom.build, minfo->fw.major,
> +			      minfo->fw.minor, minfo->fw.build);
> +		break;
> +	default:
> +		APPEND_STRING(buf, len,
> +			"Event %02x (%04x) [", r->type, r->data);
> +		for (i =3D 0; i < PD_LOG_SIZE(r->size_port); i++)
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
> +}
> +
> +static void cros_usb_pd_log_check(struct work_struct *work)
> +{
> +	struct charger_data *charger =3D container_of(to_delayed_work(work)=
,
> +		struct charger_data, log_work);
> +	struct device *dev =3D charger->dev;
> +	union {
> +		struct ec_response_pd_log r;
> +		uint32_t words[8]; /* space for the payload */
> +	} u;
> +	int ret;
> +	int entries =3D 0;
> +	ktime_t now;
> +
> +	if (charger->suspended) {
> +		dev_dbg(dev, "Suspended...bailing out\n");
> +		return;
> +	}
> +
> +	while (entries++ < CROS_USB_PD_MAX_LOG_ENTRIES) {
> +		ret =3D ec_command(charger->ec_dev, 0, EC_CMD_PD_GET_LOG_ENTRY,
> +				 NULL, 0, (uint8_t *)&u, sizeof(u));
> +		now =3D ktime_get_real();
> +		if (ret < 0) {
> +			dev_dbg(dev, "Cannot get PD log %d\n", ret);
> +			break;
> +		}
> +		if (u.r.type =3D=3D PD_EVENT_NO_ENTRY)
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
> +	charger =3D container_of(nb, struct charger_data, notifier);
> +	dev =3D charger->dev;
> +	ec_device =3D charger->ec_device;
> +
> +	host_event =3D cros_ec_get_host_event(ec_device);
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> +		cros_usb_pd_charger_power_changed(charger->ports[0]->psy);
> +		return NOTIFY_OK;
> +	} else {
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static char *charger_supplied_to[] =3D {"cros-usb_pd-charger"};
> +
> +static int cros_usb_pd_charger_probe(struct platform_device *pd)
> +{
> +	struct device *dev =3D &pd->dev;
> +	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(pd->dev.parent);
> +	struct cros_ec_device *ec_device;
> +	struct charger_data *charger;
> +	struct port_data *port;
> +	struct power_supply_desc *psy_desc;
> +	struct power_supply_config psy_cfg =3D {};
> +	int i;
> +	int ret =3D -EINVAL;
> +
> +	dev_dbg(dev, "cros_usb_pd_charger_probe\n");
> +	if (!ec_dev) {
> +		WARN(1, "%s: No EC dev found\n", dev_name(dev));
> +		return -EINVAL;
> +	}
> +
> +	ec_device =3D ec_dev->ec_dev;
> +	if (!ec_device) {
> +		WARN(1, "%s: No EC device found\n", dev_name(dev));
> +		return -EINVAL;
> +	}
> +
> +	charger =3D devm_kzalloc(dev, sizeof(struct charger_data),
> +				    GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->dev =3D dev;
> +	charger->ec_dev =3D ec_dev;
> +	charger->ec_device =3D ec_device;
> +
> +	platform_set_drvdata(pd, charger);
> +
> +	if (!charger->num_charger_ports) {
> +		/*
> +		 * This can happen on a system that doesn't support USB PD.
> +		 * Log a message, but no need to warn.
> +		 */
> +		dev_info(dev, "No charging ports found\n");
> +		ret =3D -ENODEV;
> +		goto fail_nowarn;
> +	}
> +
> +	for (i =3D 0; i < charger->num_charger_ports; i++) {
> +		port =3D devm_kzalloc(dev, sizeof(struct port_data), GFP_KERNEL);
> +		if (!port) {
> +			dev_err(dev, "Failed to alloc port structure\n");
> +			ret =3D -ENOMEM;
> +			goto fail;
> +		}
> +
> +		port->charger =3D charger;
> +		port->port_number =3D i;
> +		sprintf(port->name, CHARGER_DIR_NAME, i);
> +
> +		psy_desc =3D &port->psy_desc;
> +		psy_desc->name =3D port->name;
> +		psy_desc->type =3D POWER_SUPPLY_TYPE_USB;
> +		psy_desc->get_property =3D cros_usb_pd_charger_get_prop;
> +		psy_desc->set_property =3D cros_usb_pd_charger_set_prop;
> +		psy_desc->property_is_writeable =3D
> +			cros_usb_pd_charger_is_writeable;
> +		psy_desc->external_power_changed =3D
> +			cros_usb_pd_charger_power_changed;
> +		psy_desc->properties =3D cros_usb_pd_charger_props;
> +		psy_desc->num_properties =3D ARRAY_SIZE(
> +			cros_usb_pd_charger_props);
> +
> +		psy_cfg.drv_data =3D port;
> +		psy_cfg.supplied_to =3D charger_supplied_to;
> +		psy_cfg.num_supplicants =3D ARRAY_SIZE(charger_supplied_to);
> +
> +		port->psy =3D power_supply_register_no_ws(dev, psy_desc,
> +							&psy_cfg);
> +		if (IS_ERR(port->psy)) {
> +			dev_err(dev, "Failed to register power supply: %ld\n",
> +				PTR_ERR(port->psy));
> +			continue;
> +		}
> +
> +		charger->ports[charger->num_registered_psy++] =3D port;
> +	}
> +
> +	if (!charger->num_registered_psy) {
> +		ret =3D -ENODEV;
> +		dev_err(dev, "No power supplies registered\n");
> +		goto fail;
> +	}
> +
> +	if (ec_device->mkbp_event_supported) {
> +		/* Get PD events from the EC */
> +		charger->notifier.notifier_call =3D cros_usb_pd_ec_event;
> +		ret =3D blocking_notifier_chain_register(
> +			&ec_device->event_notifier, &charger->notifier);
> +		if (ret < 0)
> +			dev_warn(dev, "failed to register notifier\n");
> +	}
> +
> +	/* Retrieve PD event logs periodically */
> +	INIT_DELAYED_WORK(&charger->log_work, cros_usb_pd_log_check);
> +	charger->log_workqueue =3D
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
> +		for (i =3D 0; i < charger->num_registered_psy; i++) {
> +			port =3D charger->ports[i];
> +			power_supply_unregister(port->psy);
> +			devm_kfree(dev, port);
> +		}
> +		platform_set_drvdata(pd, NULL);
> +		devm_kfree(dev, charger);
> +	}
> +
> +	dev_info(dev, "Failing probe (err:0x%x)\n", ret);
> +	return ret;
> +}
> +
> +static int cros_usb_pd_charger_remove(struct platform_device *pd)
> +{
> +	struct charger_data *charger =3D platform_get_drvdata(pd);
> +	struct device *dev =3D charger->dev;
> +	struct port_data *port;
> +	int i;
> +
> +	if (charger) {
> +		for (i =3D 0; i < charger->num_registered_psy; i++) {
> +			port =3D charger->ports[i];
> +			power_supply_unregister(port->psy);
> +			devm_kfree(dev, port);
> +		}
> +		flush_delayed_work(&charger->log_work);
> +		platform_set_drvdata(pd, NULL);
> +		devm_kfree(dev, charger);
> +	}
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cros_usb_pd_charger_resume(struct device *dev)
> +{
> +	struct charger_data *charger =3D dev_get_drvdata(dev);
> +	int i;
> +
> +	if (!charger)
> +		return 0;
> +
> +	charger->suspended =3D false;
> +
> +	dev_dbg(dev, "cros_usb_pd_charger_resume: updating power supplies\n=
");
> +	for (i =3D 0; i < charger->num_registered_psy; i++) {
> +		power_supply_changed(charger->ports[i]->psy);
> +		charger->ports[i]->last_update =3D
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
> +	struct charger_data *charger =3D dev_get_drvdata(dev);
> +
> +	charger->suspended =3D true;
> +
> +	if (charger)
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
> +	req.current_lim =3D current_lim;
> +	req.voltage_lim =3D voltage_lim;
> +
> +	ret =3D ec_command(ec, 0, EC_CMD_EXT_POWER_CURRENT_LIMIT,
> +			 (uint8_t *)&req, sizeof(req), NULL, 0);
> +	if (ret < 0) {
> +		dev_warn(ec->dev,
> +			 "External power limit command returned 0x%x\n",
> +			 ret);
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
> +	struct cros_ec_dev *ec =3D container_of(
> +			dev, struct cros_ec_dev, class_dev);
> +
> +	if (kstrtou16(buf, 0, &tmp_val) < 0)
> +		return -EINVAL;
> +
> +	ret =3D set_ec_ext_power_limit(ec, tmp_val, ext_voltage_lim);
> +	if (ret < 0)
> +		return ret;
> +
> +	ext_current_lim =3D tmp_val;
> +	if (ext_current_lim =3D=3D EC_POWER_LIMIT_NONE)
> +		dev_info(ec->dev, "External current limit removed\n");
> +	else
> +		dev_info(ec->dev, "External current limit set to %dmA\n",
> +			 ext_current_lim);
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
> +	struct cros_ec_dev *ec =3D container_of(
> +			dev, struct cros_ec_dev, class_dev);
> +
> +	if (kstrtou16(buf, 0, &tmp_val) < 0)
> +		return -EINVAL;
> +
> +	ret =3D set_ec_ext_power_limit(ec, ext_current_lim, tmp_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ext_voltage_lim =3D tmp_val;
> +	if (ext_voltage_lim =3D=3D EC_POWER_LIMIT_NONE)
> +		dev_info(ec->dev, "External voltage limit removed\n");
> +	else
> +		dev_info(ec->dev, "External voltage limit set to %dmV\n",
> +			 ext_voltage_lim);
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
> +
> +static struct attribute *__ext_power_cmds_attrs[] =3D {
> +	&dev_attr_ext_current_lim.attr,
> +	&dev_attr_ext_voltage_lim.attr,
> +	NULL,
> +};
> +
> +struct attribute_group cros_usb_pd_charger_attr_group =3D {
> +	.name =3D "usb-pd-charger",
> +	.attrs =3D __ext_power_cmds_attrs,
> +};
> +
> +static SIMPLE_DEV_PM_OPS(cros_usb_pd_charger_pm_ops,
> +	cros_usb_pd_charger_suspend, cros_usb_pd_charger_resume);
> +
> +static struct platform_driver cros_usb_pd_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "cros-usb-pd-charger",
> +		.owner =3D THIS_MODULE,
> +		.pm =3D &cros_usb_pd_charger_pm_ops,
> +	},
> +	.probe =3D cros_usb_pd_charger_probe,
> +	.remove =3D cros_usb_pd_charger_remove,
> +};
> +
> +module_platform_driver(cros_usb_pd_charger_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Chrome USB PD charger");
> +MODULE_ALIAS("power_supply:cros-usb-pd-charger");
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.=
h
> index 8a8fa75178c6..c21583411ba0 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -40,6 +40,9 @@
>  #define EC_MAX_REQUEST_OVERHEAD		1
>  #define EC_MAX_RESPONSE_OVERHEAD	2
> =20
> +/* ec_command return value for non-success result from EC */
> +#define EECRESULT 1000
> +
>  /*
>   * Command interface between EC and AP, for LPC, I2C and SPI interfa=
ces.
>   */
> @@ -250,6 +253,21 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_d=
ev,
>  		     struct cros_ec_command *msg);
> =20
>  /**
> + * cros_ec_cmd_xfer_status - Send a command to the ChromeOS EC
> + *
> + * This function is identical to cros_ec_cmd_xfer, except it returns=
 succes
> + * status only if both the command was transmitted successfully and =
the EC
> + * replied with success status. It's not necessary to check msg->res=
ult when
> + * using this function.
> + *
> + * @ec_dev: EC device
> + * @msg: Message to write
> + * @return: Num. of bytes transferred on success, <0 on failure
> + */
> +int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> +			    struct cros_ec_command *msg);
> +
> +/**
>   * cros_ec_remove - Remove a ChromeOS EC
>   *
>   * Call this to deregister a ChromeOS EC, then clean up any private =
data.
> @@ -286,6 +304,16 @@ int cros_ec_query_all(struct cros_ec_device *ec_=
dev);
>   */
>  int cros_ec_get_next_event(struct cros_ec_device *ec_dev);
> =20
> +/**
> + * cros_ec_get_host_event - Return a mask of event set by the EC.
> + *
> + * Returns the mask of the event that caused the last interrupt to b=
e raised.
> + *
> + * @ec_dev: Device to fetch event from
> + * @return event mask, 0 on error
> + */
> +uint32_t cros_ec_get_host_event(struct cros_ec_device *ec_dev);
> +
>  /* sysfs stuff */
>  extern struct attribute_group cros_ec_attr_group;
>  extern struct attribute_group cros_ec_lightbar_attr_group;
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd=
/cros_ec_commands.h
> index d86526f0bd8e..4f056d2747ff 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -286,6 +286,9 @@ enum host_event_code {
>  	/* Hang detect logic detected a hang and warm rebooted the AP */
>  	EC_HOST_EVENT_HANG_REBOOT =3D 21,
> =20
> +	/* PD MCU triggering host event */
> +	EC_HOST_EVENT_PD_MCU =3D 22,
> +
>  	/*
>  	 * The high bit of the event mask is not used as a host event code.=
  If
>  	 * it reads back as set, then the entire event mask should be
> @@ -2273,6 +2276,13 @@ struct ec_params_ext_power_current_limit {
>  	uint32_t limit; /* in mA */
>  } __packed;
> =20
> +struct ec_params_external_power_limit_v1 {
> +	uint16_t current_lim; /* in mA, or EC_POWER_LIMIT_NONE to clear lim=
it */
> +	uint16_t voltage_lim; /* in mV, or EC_POWER_LIMIT_NONE to clear lim=
it */
> +} __packed;
> +
> +#define EC_POWER_LIMIT_NONE 0xffff
> +
>  /*******************************************************************=
**********/
>  /* Smart battery pass-through */
> =20
> @@ -2527,8 +2537,6 @@ struct ec_params_reboot_ec {
>   */
>  #define EC_CMD_VERSION0 0xdc
> =20
> -#endif  /* !__ACPI__ */
> -
>  /*******************************************************************=
**********/
>  /*
>   * PD commands
> @@ -2538,16 +2546,51 @@ struct ec_params_reboot_ec {
> =20
>  /* EC to PD MCU exchange status command */
>  #define EC_CMD_PD_EXCHANGE_STATUS 0x100
> +#define EC_VER_PD_EXCHANGE_STATUS 2
> +
> +enum pd_charge_state {
> +	PD_CHARGE_NO_CHANGE =3D 0, /* Don't change charge state */
> +	PD_CHARGE_NONE,          /* No charging allowed */
> +	PD_CHARGE_5V,            /* 5V charging only */
> +	PD_CHARGE_MAX            /* Charge at max voltage */
> +};
> =20
>  /* Status of EC being sent to PD */
> +#define EC_STATUS_HIBERNATING	(1 << 0)
> +
>  struct ec_params_pd_status {
> -	int8_t batt_soc; /* battery state of charge */
> +	uint8_t status;       /* EC status */
> +	int8_t batt_soc;      /* battery state of charge */
> +	uint8_t charge_state; /* charging state (from enum pd_charge_state)=
 */
>  } __packed;
> =20
>  /* Status of PD being sent back to EC */
> +#define PD_STATUS_HOST_EVENT      (1 << 0) /* Forward host event to =
AP */
> +#define PD_STATUS_IN_RW           (1 << 1) /* Running RW image */
> +#define PD_STATUS_JUMPED_TO_IMAGE (1 << 2) /* Current image was jump=
ed to */
> +#define PD_STATUS_TCPC_ALERT_0    (1 << 3) /* Alert active in port 0=
 TCPC */
> +#define PD_STATUS_TCPC_ALERT_1    (1 << 4) /* Alert active in port 1=
 TCPC */
> +#define PD_STATUS_TCPC_ALERT_2    (1 << 5) /* Alert active in port 2=
 TCPC */
> +#define PD_STATUS_TCPC_ALERT_3    (1 << 6) /* Alert active in port 3=
 TCPC */
> +#define PD_STATUS_EC_INT_ACTIVE  (PD_STATUS_TCPC_ALERT_0 | \
> +				      PD_STATUS_TCPC_ALERT_1 | \
> +				      PD_STATUS_HOST_EVENT)
>  struct ec_response_pd_status {
> -	int8_t status;        /* PD MCU status */
> -	uint32_t curr_lim_ma; /* input current limit */
> +	uint32_t curr_lim_ma;       /* input current limit */
> +	uint16_t status;            /* PD MCU status */
> +	int8_t active_charge_port;  /* active charging port */
> +} __packed;
> +
> +/* AP to PD MCU host event status command, cleared on read */
> +#define EC_CMD_PD_HOST_EVENT_STATUS 0x104
> +
> +/* PD MCU host event status bits */
> +#define PD_EVENT_UPDATE_DEVICE     (1 << 0)
> +#define PD_EVENT_POWER_CHANGE      (1 << 1)
> +#define PD_EVENT_IDENTITY_RECEIVED (1 << 2)
> +#define PD_EVENT_DATA_SWAP         (1 << 3)
> +struct ec_response_host_event_status {
> +	uint32_t status;      /* PD MCU host event status */
>  } __packed;
> =20
>  /* Set USB type-C port role and muxes */
> @@ -2559,6 +2602,7 @@ enum usb_pd_control_role {
>  	USB_PD_CTRL_ROLE_TOGGLE_OFF =3D 2,
>  	USB_PD_CTRL_ROLE_FORCE_SINK =3D 3,
>  	USB_PD_CTRL_ROLE_FORCE_SOURCE =3D 4,
> +	USB_PD_CTRL_ROLE_COUNT
>  };
> =20
>  enum usb_pd_control_mux {
> @@ -2568,14 +2612,284 @@ enum usb_pd_control_mux {
>  	USB_PD_CTRL_MUX_DP =3D 3,
>  	USB_PD_CTRL_MUX_DOCK =3D 4,
>  	USB_PD_CTRL_MUX_AUTO =3D 5,
> +	USB_PD_CTRL_MUX_COUNT
> +};
> +
> +enum usb_pd_control_swap {
> +	USB_PD_CTRL_SWAP_NONE =3D 0,
> +	USB_PD_CTRL_SWAP_DATA =3D 1,
> +	USB_PD_CTRL_SWAP_POWER =3D 2,
> +	USB_PD_CTRL_SWAP_VCONN =3D 3,
> +	USB_PD_CTRL_SWAP_COUNT
>  };
> =20
>  struct ec_params_usb_pd_control {
>  	uint8_t port;
>  	uint8_t role;
>  	uint8_t mux;
> +	uint8_t swap;
> +} __packed;
> +
> +#define PD_CTRL_RESP_ENABLED_COMMS      (1 << 0) /* Communication en=
abled */
> +#define PD_CTRL_RESP_ENABLED_CONNECTED  (1 << 1) /* Device connected=
 */
> +#define PD_CTRL_RESP_ENABLED_PD_CAPABLE (1 << 2) /* Partner is PD ca=
pable */
> +
> +#define PD_CTRL_RESP_ROLE_POWER         (1 << 0) /* 0=3DSNK/1=3DSRC =
*/
> +#define PD_CTRL_RESP_ROLE_DATA          (1 << 1) /* 0=3DUFP/1=3DDFP =
*/
> +#define PD_CTRL_RESP_ROLE_VCONN         (1 << 2) /* Vconn status */
> +#define PD_CTRL_RESP_ROLE_DR_POWER      (1 << 3) /* Partner is dualr=
ole power */
> +#define PD_CTRL_RESP_ROLE_DR_DATA       (1 << 4) /* Partner is dualr=
ole data */
> +#define PD_CTRL_RESP_ROLE_USB_COMM      (1 << 5) /* Partner USB comm=
 capable */
> +#define PD_CTRL_RESP_ROLE_EXT_POWERED   (1 << 6) /* Partner external=
ly powerd */
> +
> +struct ec_response_usb_pd_control {
> +	uint8_t enabled;
> +	uint8_t role;
> +	uint8_t polarity;
> +	uint8_t state;
> +} __packed;
> +
> +struct ec_response_usb_pd_control_v1 {
> +	uint8_t enabled;
> +	uint8_t role;
> +	uint8_t polarity;
> +	char state[32];
> +} __packed;
> +
> +#define EC_CMD_USB_PD_PORTS 0x102
> +
> +struct ec_response_usb_pd_ports {
> +	uint8_t num_ports;
> +} __packed;
> +
> +#define EC_CMD_USB_PD_POWER_INFO 0x103
> +
> +#define PD_POWER_CHARGING_PORT 0xff
> +struct ec_params_usb_pd_power_info {
> +	uint8_t port;
> +} __packed;
> +
> +enum usb_chg_type {
> +	USB_CHG_TYPE_NONE,
> +	USB_CHG_TYPE_PD,
> +	USB_CHG_TYPE_C,
> +	USB_CHG_TYPE_PROPRIETARY,
> +	USB_CHG_TYPE_BC12_DCP,
> +	USB_CHG_TYPE_BC12_CDP,
> +	USB_CHG_TYPE_BC12_SDP,
> +	USB_CHG_TYPE_OTHER,
> +	USB_CHG_TYPE_VBUS,
> +	USB_CHG_TYPE_UNKNOWN,
> +};
> +enum usb_power_roles {
> +	USB_PD_PORT_POWER_DISCONNECTED,
> +	USB_PD_PORT_POWER_SOURCE,
> +	USB_PD_PORT_POWER_SINK,
> +	USB_PD_PORT_POWER_SINK_NOT_CHARGING,
> +};
> +
> +struct usb_chg_measures {
> +	uint16_t voltage_max;
> +	uint16_t voltage_now;
> +	uint16_t current_max;
> +	uint16_t current_lim;
> +} __packed;
> +
> +struct ec_response_usb_pd_power_info {
> +	uint8_t role;
> +	uint8_t type;
> +	uint8_t dualrole;
> +	uint8_t reserved1;
> +	struct usb_chg_measures meas;
> +	uint32_t max_power;
> +} __packed;
> +
> +/* Write USB-PD device FW */
> +#define EC_CMD_USB_PD_FW_UPDATE 0x110
> +
> +enum usb_pd_fw_update_cmds {
> +	USB_PD_FW_REBOOT,
> +	USB_PD_FW_FLASH_ERASE,
> +	USB_PD_FW_FLASH_WRITE,
> +	USB_PD_FW_ERASE_SIG,
> +};
> +
> +struct ec_params_usb_pd_fw_update {
> +	uint16_t dev_id;
> +	uint8_t cmd;
> +	uint8_t port;
> +	uint32_t size;     /* Size to write in bytes */
> +	/* Followed by data to write */
> +} __packed;
> +
> +/* Write USB-PD Accessory RW_HASH table entry */
> +#define EC_CMD_USB_PD_RW_HASH_ENTRY 0x111
> +/* RW hash is first 20 bytes of SHA-256 of RW section */
> +#define PD_RW_HASH_SIZE 20
> +struct ec_params_usb_pd_rw_hash_entry {
> +	uint16_t dev_id;
> +	uint8_t dev_rw_hash[PD_RW_HASH_SIZE];
> +	uint8_t reserved;        /* For alignment of current_image */
> +	uint32_t current_image;  /* One of ec_current_image */
> +} __packed;
> +
> +/* Read USB-PD Accessory info */
> +#define EC_CMD_USB_PD_DEV_INFO 0x112
> +
> +struct ec_params_usb_pd_info_request {
> +	uint8_t port;
> +} __packed;
> +
> +/* Read USB-PD Device discovery info */
> +#define EC_CMD_USB_PD_DISCOVERY 0x113
> +struct ec_params_usb_pd_discovery_entry {
> +	uint16_t vid;  /* USB-IF VID */
> +	uint16_t pid;  /* USB-IF PID */
> +	uint8_t ptype; /* product type (hub,periph,cable,ama) */
> +} __packed;
> +
> +/* Override default charge behavior */
> +#define EC_CMD_PD_CHARGE_PORT_OVERRIDE 0x114
> +
> +/* Negative port parameters have special meaning */
> +enum usb_pd_override_ports {
> +	OVERRIDE_DONT_CHARGE =3D -2,
> +	OVERRIDE_OFF =3D -1,
> +	/* [0, CONFIG_USB_PD_PORT_COUNT): Port# */
> +};
> +
> +struct ec_params_charge_port_override {
> +	int16_t override_port; /* Override port# */
> +} __packed;
> +
> +/* Read (and delete) one entry of PD event log */
> +#define EC_CMD_PD_GET_LOG_ENTRY 0x115
> +
> +struct ec_response_pd_log {
> +	uint32_t timestamp; /* relative timestamp in milliseconds */
> +	uint8_t type;       /* event type : see PD_EVENT_xx below */
> +	uint8_t size_port;  /* [7:5] port number [4:0] payload size in byte=
s */
> +	uint16_t data;      /* type-defined data payload */
> +	uint8_t payload[0]; /* optional additional data payload: 0..16 byte=
s */
> +} __packed;
> +
> +
> +/* The timestamp is the microsecond counter shifted to get about a m=
s. */
> +#define PD_LOG_TIMESTAMP_SHIFT 10 /* 1 LSB =3D 1024us */
> +
> +#define PD_LOG_SIZE_MASK  0x1f
> +#define PD_LOG_PORT_MASK  0xe0
> +#define PD_LOG_PORT_SHIFT    5
> +#define PD_LOG_PORT_SIZE(port, size) (((port) << PD_LOG_PORT_SHIFT) =
| \
> +				      ((size) & PD_LOG_SIZE_MASK))
> +#define PD_LOG_PORT(size_port) ((size_port) >> PD_LOG_PORT_SHIFT)
> +#define PD_LOG_SIZE(size_port) ((size_port) & PD_LOG_SIZE_MASK)
> +
> +/* PD event log : entry types */
> +/* PD MCU events */
> +#define PD_EVENT_MCU_BASE       0x00
> +#define PD_EVENT_MCU_CHARGE             (PD_EVENT_MCU_BASE+0)
> +#define PD_EVENT_MCU_CONNECT            (PD_EVENT_MCU_BASE+1)
> +/* Reserved for custom board event */
> +#define PD_EVENT_MCU_BOARD_CUSTOM       (PD_EVENT_MCU_BASE+2)
> +/* PD generic accessory events */
> +#define PD_EVENT_ACC_BASE       0x20
> +#define PD_EVENT_ACC_RW_FAIL   (PD_EVENT_ACC_BASE+0)
> +#define PD_EVENT_ACC_RW_ERASE  (PD_EVENT_ACC_BASE+1)
> +/* PD power supply events */
> +#define PD_EVENT_PS_BASE        0x40
> +#define PD_EVENT_PS_FAULT      (PD_EVENT_PS_BASE+0)
> +/* PD video dongles events */
> +#define PD_EVENT_VIDEO_BASE     0x60
> +#define PD_EVENT_VIDEO_DP_MODE (PD_EVENT_VIDEO_BASE+0)
> +#define PD_EVENT_VIDEO_CODEC   (PD_EVENT_VIDEO_BASE+1)
> +/* Returned in the "type" field, when there is no entry available */
> +#define PD_EVENT_NO_ENTRY       0xff
> +
> +/*
> + * PD_EVENT_MCU_CHARGE event definition :
> + * the payload is "struct usb_chg_measures"
> + * the data field contains the port state flags as defined below :
> + */
> +/* Port partner is a dual role device */
> +#define CHARGE_FLAGS_DUAL_ROLE         (1 << 15)
> +/* Port is the pending override port */
> +#define CHARGE_FLAGS_DELAYED_OVERRIDE  (1 << 14)
> +/* Port is the override port */
> +#define CHARGE_FLAGS_OVERRIDE          (1 << 13)
> +/* Charger type */
> +#define CHARGE_FLAGS_TYPE_SHIFT               3
> +#define CHARGE_FLAGS_TYPE_MASK       (0xf << CHARGE_FLAGS_TYPE_SHIFT=
)
> +/* Power delivery role */
> +#define CHARGE_FLAGS_ROLE_MASK         (7 <<  0)
> +
> +/*
> + * PD_EVENT_PS_FAULT data field flags definition :
> + */
> +#define PS_FAULT_OCP                          1
> +#define PS_FAULT_FAST_OCP                     2
> +#define PS_FAULT_OVP                          3
> +#define PS_FAULT_DISCH                        4
> +
> +/*
> + * PD_EVENT_VIDEO_CODEC payload is "struct mcdp_info".
> + */
> +struct mcdp_version {
> +	uint8_t major;
> +	uint8_t minor;
> +	uint16_t build;
>  } __packed;
> =20
> +struct mcdp_info {
> +	uint8_t family[2];
> +	uint8_t chipid[2];
> +	struct mcdp_version irom;
> +	struct mcdp_version fw;
> +} __packed;
> +
> +/* struct mcdp_info field decoding */
> +#define MCDP_CHIPID(chipid) ((chipid[0] << 8) | chipid[1])
> +#define MCDP_FAMILY(family) ((family[0] << 8) | family[1])
> +
> +/* Get/Set USB-PD Alternate mode info */
> +#define EC_CMD_USB_PD_GET_AMODE 0x116
> +struct ec_params_usb_pd_get_mode_request {
> +	uint16_t svid_idx; /* SVID index to get */
> +	uint8_t port;      /* port */
> +} __packed;
> +
> +struct ec_params_usb_pd_get_mode_response {
> +	uint16_t svid;   /* SVID */
> +	uint16_t opos;    /* Object Position */
> +	uint32_t vdo[6]; /* Mode VDOs */
> +} __packed;
> +
> +#define EC_CMD_USB_PD_SET_AMODE 0x117
> +
> +enum pd_mode_cmd {
> +	PD_EXIT_MODE =3D 0,
> +	PD_ENTER_MODE =3D 1,
> +	/* Not a command.  Do NOT remove. */
> +	PD_MODE_CMD_COUNT,
> +};
> +
> +struct ec_params_usb_pd_set_mode_request {
> +	uint32_t cmd;  /* enum pd_mode_cmd */
> +	uint16_t svid; /* SVID to set */
> +	uint8_t opos;  /* Object Position */
> +	uint8_t port;  /* port */
> +} __packed;
> +
> +/* Ask the PD MCU to record a log of a requested type */
> +#define EC_CMD_PD_WRITE_LOG_ENTRY 0x118
> +
> +struct ec_params_pd_write_log_entry {
> +	uint8_t type; /* event type : see PD_EVENT_xx above */
> +	uint8_t port; /* port#, or 0 for events unrelated to a given port *=
/
> +} __packed;
> +
> +#endif  /* !__ACPI__ */
> +
>  /*******************************************************************=
**********/
>  /*
>   * Passthru commands

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
