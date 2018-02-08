From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v13 3/4] thinkpad_acpi: Add support for battery thresholds
Date: Thu, 8 Feb 2018 23:03:23 +0100
Message-ID: <20180208220323.cr6j2kcozekwbzo6@earth.universe>
References: <20180207145844.bd567c36juvlkjvz@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d5c36ll62wzo52ke"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180207145844.bd567c36juvlkjvz@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org


--d5c36ll62wzo52ke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 07, 2018 at 03:58:44PM +0100, Ognjen Galic wrote:
> 1) Charge start threshold
> /sys/class/power_supply/BATN/charge_start_threshold
>=20
> Valid values are [0, 99]. A value of 0 turns off the
> start threshold wear control.
>=20
> 2) Charge stop threshold
> /sys/class/power_supply/BATN/charge_stop_threshold
>=20
> Valid values are [1, 100]. A value of 100 turns off
> the stop threshold wear control. This must be
> configured first.

This is a new sysfs file, that should be documented. Also this
looks pretty generic. Just introduce new POWER_SUPPLY_PROP_
entries for start/stop charging threshold and use them.

-- Sebastian

> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> ---
>=20
> Notes:
>     v2:
>     * Re-write the patch to make the changes in
>     battery.c generic as suggested by Rafael
>    =20
>     v3:
>     * Fixed a bug where you could not set the stop
>     threshold to 100% when the start threshold is 0%
>     * Fixed the "Not Charging" quirk to match Lenovo's
>     BIOS Firmware specification
>    =20
>     v4:
>     * Fixed a bug where you could not set the start
>     threshold to >stop if stop was 100%
>    =20
>     v5:
>     * Migrated from symbol_get to native linking,
>     to fix module dependencies
>     * Fixed a bug where unloading the module would
>     cause a BUG inside battery
>     * Fixed a bug where you could unload battery
>     before unloading thinkpad_acpi
>    =20
>     v6:
>     * Fixed all the style and naming issues pointed
>     out by Andy Shevchenko
>    =20
>     v7:
>     * No changes in this patch in v7
>    =20
>     v8:
>     * No changes in this patch in v8
>    =20
>     v9:
>     * Use DEVICE_ATTR_RW instead of DEVICE_ATTR
>     * Use bitopts.h instead of raw operators
>     * Remove redundant whitespaces
>     * Remove redundant comments
>     * Move the power_supply changes to separate patch
>     * Fix other various styling issues pointed out by
>     Andy Shevchenko
>    =20
>     v10:
>     * Fix a pasting error from v6 that prevents the setting
>     of the start threshold with EINVAL
>    =20
>     v11:
>     * Fix formatting of changelog
>    =20
>     v12:
>     * Remove most whitespaces between ifs
>     * Change int to acpi_status in tpacpi_battery_acpi_eval
>    =20
>     v13:
>     * Change if (!tpacpi_... to if ACPI_FAILURE(...
>=20
>  drivers/platform/x86/Kconfig         |   1 +
>  drivers/platform/x86/thinkpad_acpi.c | 389 +++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 389 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 9a8f96465..0d13d30c1 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -425,6 +425,7 @@ config SURFACE3_WMI
>  config THINKPAD_ACPI
>  	tristate "ThinkPad ACPI Laptop Extras"
>  	depends on ACPI
> +	depends on ACPI_BATTERY
>  	depends on INPUT
>  	depends on RFKILL || RFKILL =3D n
>  	depends on ACPI_VIDEO || ACPI_VIDEO =3D n
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index d5eaf3b1e..1c57ee2b6 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -23,7 +23,7 @@
> =20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
> -#define TPACPI_VERSION "0.25"
> +#define TPACPI_VERSION "0.26"
>  #define TPACPI_SYSFS_VERSION 0x030000
> =20
>  /*
> @@ -66,6 +66,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/sysfs.h>
>  #include <linux/backlight.h>
> +#include <linux/bitops.h>
>  #include <linux/fb.h>
>  #include <linux/platform_device.h>
>  #include <linux/hwmon.h>
> @@ -78,11 +79,13 @@
>  #include <linux/workqueue.h>
>  #include <linux/acpi.h>
>  #include <linux/pci_ids.h>
> +#include <linux/power_supply.h>
>  #include <linux/thinkpad_acpi.h>
>  #include <sound/core.h>
>  #include <sound/control.h>
>  #include <sound/initval.h>
>  #include <linux/uaccess.h>
> +#include <acpi/battery.h>
>  #include <acpi/video.h>
> =20
>  /* ThinkPad CMOS commands */
> @@ -335,6 +338,7 @@ static struct {
>  	u32 sensors_pdev_attrs_registered:1;
>  	u32 hotkey_poll_active:1;
>  	u32 has_adaptive_kbd:1;
> +	u32 battery:1;
>  } tp_features;
> =20
>  static struct {
> @@ -9209,6 +9213,385 @@ static struct ibm_struct mute_led_driver_data =3D=
 {
>  	.resume =3D mute_led_resume,
>  };
> =20
> +/*
> + * Battery Wear Control Driver
> + * Contact: Ognjen Galic <smclt30p@gmail.com>
> + */
> +
> +/* Metadata */
> +
> +#define GET_START	"BCTG"
> +#define SET_START	"BCCS"
> +#define GET_STOP	"BCSG"
> +#define SET_STOP	"BCSS"
> +
> +#define START_ATTR "charge_start_threshold"
> +#define STOP_ATTR  "charge_stop_threshold"
> +
> +enum {
> +	BAT_ANY =3D 0,
> +	BAT_PRIMARY =3D 1,
> +	BAT_SECONDARY =3D 2
> +};
> +
> +enum {
> +	/* Error condition bit */
> +	METHOD_ERR =3D BIT(31),
> +};
> +
> +enum {
> +	/* This is used in the get/set helpers */
> +	THRESHOLD_START,
> +	THRESHOLD_STOP,
> +};
> +
> +struct tpacpi_battery_data {
> +	int charge_start;
> +	int start_support;
> +	int charge_stop;
> +	int stop_support;
> +};
> +
> +struct tpacpi_battery_driver_data {
> +	struct tpacpi_battery_data batteries[3];
> +	int individual_addressing;
> +};
> +
> +static struct tpacpi_battery_driver_data battery_info;
> +
> +/* ACPI helpers/functions/probes */
> +
> +/**
> + * This evaluates a ACPI method call specific to the battery
> + * ACPI extension. The specifics are that an error is marked
> + * in the 32rd bit of the response, so we just check that here.
> + */
> +static acpi_status tpacpi_battery_acpi_eval(char *method, int *ret, int =
param)
> +{
> +	int response;
> +
> +	if (!acpi_evalf(hkey_handle, &response, method, "dd", param)) {
> +		acpi_handle_err(hkey_handle, "%s: evaluate failed", method);
> +		return AE_ERROR;
> +	}
> +	if (response & METHOD_ERR) {
> +		acpi_handle_err(hkey_handle,
> +				"%s evaluated but flagged as error", method);
> +		return AE_ERROR;
> +	}
> +	*ret =3D response;
> +	return AE_OK;
> +}
> +
> +static int tpacpi_battery_get(int what, int battery, int *ret)
> +{
> +	switch (what) {
> +	case THRESHOLD_START:
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, ret, battery))
> +			return -ENODEV;
> +
> +		/* The value is in the low 8 bits of the response */
> +		*ret =3D *ret & 0xFF;
> +		return 0;
> +	case THRESHOLD_STOP:
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_STOP, ret, battery))
> +			return -ENODEV;
> +		/* Value is in lower 8 bits */
> +		*ret =3D *ret & 0xFF;
> +		/*
> +		 * On the stop value, if we return 0 that
> +		 * does not make any sense. 0 means Default, which
> +		 * means that charging stops at 100%, so we return
> +		 * that.
> +		 */
> +		if (*ret =3D=3D 0)
> +			*ret =3D 100;
> +		return 0;
> +	default:
> +		pr_crit("wrong parameter: %d", what);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int tpacpi_battery_set(int what, int battery, int value)
> +{
> +	int param, ret;
> +	/* The first 8 bits are the value of the threshold */
> +	param =3D value;
> +	/* The battery ID is in bits 8-9, 2 bits */
> +	param |=3D battery << 8;
> +
> +	switch (what) {
> +	case THRESHOLD_START:
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_START, &ret, param)) {
> +			pr_err("failed to set charge threshold on battery %d",
> +					battery);
> +			return -ENODEV;
> +		}
> +		return 0;
> +	case THRESHOLD_STOP:
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_STOP, &ret, param)) {
> +			pr_err("failed to set stop threshold: %d", battery);
> +			return -ENODEV;
> +		}
> +		return 0;
> +	default:
> +		pr_crit("wrong parameter: %d", what);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int tpacpi_battery_probe(int battery)
> +{
> +	int ret =3D 0;
> +
> +	memset(&battery_info, 0, sizeof(struct tpacpi_battery_driver_data));
> +	/*
> +	 * 1) Get the current start threshold
> +	 * 2) Check for support
> +	 * 3) Get the current stop threshold
> +	 * 4) Check for support
> +	 */
> +	if (acpi_has_method(hkey_handle, GET_START)) {
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
> +			pr_err("Error probing battery %d\n", battery);
> +			return -ENODEV;
> +		}
> +		/* Individual addressing is in bit 9 */
> +		if (ret & BIT(9))
> +			battery_info.individual_addressing =3D true;
> +		/* Support is marked in bit 8 */
> +		if (ret & BIT(8))
> +			battery_info.batteries[battery].start_support =3D 1;
> +		else
> +			return -ENODEV;
> +		if (tpacpi_battery_get(THRESHOLD_START, battery,
> +			&battery_info.batteries[battery].charge_start)) {
> +			pr_err("Error probing battery %d\n", battery);
> +			return -ENODEV;
> +		}
> +	}
> +	if (acpi_has_method(hkey_handle, GET_STOP)) {
> +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_STOP, &ret, battery)) {
> +			pr_err("Error probing battery stop; %d\n", battery);
> +			return -ENODEV;
> +		}
> +		/* Support is marked in bit 8 */
> +		if (ret & BIT(8))
> +			battery_info.batteries[battery].stop_support =3D 1;
> +		else
> +			return -ENODEV;
> +		if (tpacpi_battery_get(THRESHOLD_STOP, battery,
> +			&battery_info.batteries[battery].charge_stop)) {
> +			pr_err("Error probing battery stop: %d\n", battery);
> +			return -ENODEV;
> +		}
> +	}
> +	pr_info("battery %d registered (start %d, stop %d)",
> +			battery,
> +			battery_info.batteries[battery].charge_start,
> +			battery_info.batteries[battery].charge_stop);
> +
> +	return 0;
> +}
> +
> +/* General helper functions */
> +
> +static int tpacpi_battery_get_id(const char *battery_name)
> +{
> +
> +	if (strcmp(battery_name, "BAT0") =3D=3D 0)
> +		return BAT_PRIMARY;
> +	if (strcmp(battery_name, "BAT1") =3D=3D 0)
> +		return BAT_SECONDARY;
> +	/*
> +	 * If for some reason the battery is not BAT0 nor is it
> +	 * BAT1, we will assume it's the default, first battery,
> +	 * AKA primary.
> +	 */
> +	pr_warn("unknown battery %s, assuming primary", battery_name);
> +	return BAT_PRIMARY;
> +}
> +
> +/* sysfs interface */
> +
> +static ssize_t tpacpi_battery_store(int what,
> +				    struct device *dev,
> +				    const char *buf, size_t count)
> +{
> +	struct power_supply *supply =3D to_power_supply(dev);
> +	unsigned long value;
> +	int battery, rval;
> +	/*
> +	 * Some systems have support for more than
> +	 * one battery. If that is the case,
> +	 * tpacpi_battery_probe marked that addressing
> +	 * them individually is supported, so we do that
> +	 * based on the device struct.
> +	 *
> +	 * On systems that are not supported, we assume
> +	 * the primary as most of the ACPI calls fail
> +	 * with "Any Battery" as the parameter.
> +	 */
> +	if (battery_info.individual_addressing)
> +		/* BAT_PRIMARY or BAT_SECONDARY */
> +		battery =3D tpacpi_battery_get_id(supply->desc->name);
> +	else
> +		battery =3D BAT_PRIMARY;
> +
> +	rval =3D kstrtoul(buf, 10, &value);
> +	if (rval)
> +		return rval;
> +
> +	switch (what) {
> +	case THRESHOLD_START:
> +		if (!battery_info.batteries[battery].start_support)
> +			return -ENODEV;
> +		/* valid values are [0, 99] */
> +		if (value < 0 || value > 99)
> +			return -EINVAL;
> +		if (value > battery_info.batteries[battery].charge_stop)
> +			return -EINVAL;
> +		if (tpacpi_battery_set(THRESHOLD_START, battery, value))
> +			return -ENODEV;
> +		battery_info.batteries[battery].charge_start =3D value;
> +		return count;
> +
> +	case THRESHOLD_STOP:
> +		if (!battery_info.batteries[battery].stop_support)
> +			return -ENODEV;
> +		/* valid values are [1, 100] */
> +		if (value < 1 || value > 100)
> +			return -EINVAL;
> +		if (value < battery_info.batteries[battery].charge_start)
> +			return -EINVAL;
> +		battery_info.batteries[battery].charge_stop =3D value;
> +		/*
> +		 * When 100 is passed to stop, we need to flip
> +		 * it to 0 as that the EC understands that as
> +		 * "Default", which will charge to 100%
> +		 */
> +		if (value =3D=3D 100)
> +			value =3D 0;
> +		if (tpacpi_battery_set(THRESHOLD_STOP, battery, value))
> +			return -EINVAL;
> +		return count;
> +	default:
> +		pr_crit("Wrong parameter: %d", what);
> +		return -EINVAL;
> +	}
> +	return count;
> +}
> +
> +static ssize_t tpacpi_battery_show(int what,
> +				   struct device *dev,
> +				   char *buf)
> +{
> +	struct power_supply *supply =3D to_power_supply(dev);
> +	int ret, battery;
> +	/*
> +	 * Some systems have support for more than
> +	 * one battery. If that is the case,
> +	 * tpacpi_battery_probe marked that addressing
> +	 * them individually is supported, so we;
> +	 * based on the device struct.
> +	 *
> +	 * On systems that are not supported, we assume
> +	 * the primary as most of the ACPI calls fail
> +	 * with "Any Battery" as the parameter.
> +	 */
> +	if (battery_info.individual_addressing)
> +		/* BAT_PRIMARY or BAT_SECONDARY */
> +		battery =3D tpacpi_battery_get_id(supply->desc->name);
> +	else
> +		battery =3D BAT_PRIMARY;
> +	if (tpacpi_battery_get(what, battery, &ret))
> +		return -ENODEV;
> +	return sprintf(buf, "%d\n", ret);
> +}
> +
> +static ssize_t charge_start_threshold_show(struct device *device,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	return tpacpi_battery_show(THRESHOLD_START, device, buf);
> +}
> +
> +static ssize_t charge_stop_threshold_show(struct device *device,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	return tpacpi_battery_show(THRESHOLD_STOP, device, buf);
> +}
> +
> +static ssize_t charge_start_threshold_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	return tpacpi_battery_store(THRESHOLD_START, dev, buf, count);
> +}
> +
> +static ssize_t charge_stop_threshold_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	return tpacpi_battery_store(THRESHOLD_STOP, dev, buf, count);
> +}
> +
> +static DEVICE_ATTR_RW(charge_start_threshold);
> +static DEVICE_ATTR_RW(charge_stop_threshold);
> +
> +static struct attribute *tpacpi_battery_attrs[] =3D {
> +	&dev_attr_charge_start_threshold.attr,
> +	&dev_attr_charge_stop_threshold.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(tpacpi_battery);
> +
> +/* ACPI battery hooking */
> +
> +static int tpacpi_battery_add(struct power_supply *battery)
> +{
> +	int batteryid =3D tpacpi_battery_get_id(battery->desc->name);
> +
> +	if (tpacpi_battery_probe(batteryid))
> +		return -ENODEV;
> +	if (device_add_groups(&battery->dev, tpacpi_battery_groups))
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +static int tpacpi_battery_remove(struct power_supply *battery)
> +{
> +	device_remove_groups(&battery->dev, tpacpi_battery_groups);
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook battery_hook =3D {
> +	.add_battery =3D tpacpi_battery_add,
> +	.remove_battery =3D tpacpi_battery_remove,
> +	.name =3D "ThinkPad Battery Extension",
> +};
> +
> +/* Subdriver init/exit */
> +
> +static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
> +{
> +	battery_hook_register(&battery_hook);
> +	return 0;
> +}
> +
> +static void tpacpi_battery_exit(void)
> +{
> +	battery_hook_unregister(&battery_hook);
> +}
> +
> +static struct ibm_struct battery_driver_data =3D {
> +	.name =3D "battery",
> +	.exit =3D tpacpi_battery_exit,
> +};
> +
>  /***********************************************************************=
*****
>   ***********************************************************************=
*****
>   *
> @@ -9655,6 +10038,10 @@ static struct ibm_init_struct ibms_init[] __initd=
ata =3D {
>  		.init =3D mute_led_init,
>  		.data =3D &mute_led_driver_data,
>  	},
> +	{
> +		.init =3D tpacpi_battery_init,
> +		.data =3D &battery_driver_data,
> +	},
>  };
> =20
>  static int __init set_ibm_param(const char *val, const struct kernel_par=
am *kp)
> --=20
> 2.14.1
>=20

--d5c36ll62wzo52ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp8ySsACgkQ2O7X88g7
+ppxaA//a1pG7fX8rxb5U2XYtMvVUwxreSnwcVDZ29/kxj0QC5H4cbYrXZjhDkd+
2ty0XjoitjYDbF1d9PtvXR4FRg+iUqqTdxzqG9wv/8v1VmBY0Q9+cSIca3HrFXty
kgqTg8zk2yTYvQPIMkD6yiBsfYi8ZhH46bhvk/QbNKWtpuFfNMkMuljJKULHUruW
y1fMy3eiQSMk/kdhwFbP52FgPpy+gegP3MMtxlkMz3ecFRXjJp55llZdg2+rm9bR
lqOjNj/BCxzJXv8ddaAPB36hzYOCWFAwumnNzJnw75fS0J95EuROIRaSKhvrKIwX
CuGQ29UEe511YB2UBqOqOFs2+6WWrjTCjWQaZW4rUnAWTOQqPgYWNLJQe25KAl74
+9WPrEzMPXqZhZpUIOBzO0nQvnf18he3EmYzun/psgIZUNoXOTnGk8Wb7b9G0/sY
qFnqlNKSd5596O1STrHcGBcWQc3AobNmm6kpvxnlegqQCmER7q2fEfGTzFt+nR6U
cOG+79a8mX+jCsdZT7IeAv3NpzMcVJ02AZDBUBHLJRPz4kMU4U9sYjryVvbEkOwV
Fk0FTahOcDAnVL74VYkhBBKRvQLjtvHBJj5zNaWbOhzw+5wrvCOkzxXShyIGwJtM
JrnYsZ6OblEFbJjba0Z9yj88Z5dLJFDgkqIo3Q85N0EQPR3568Y=
=EVde
-----END PGP SIGNATURE-----

--d5c36ll62wzo52ke--
