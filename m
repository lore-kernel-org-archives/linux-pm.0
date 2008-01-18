From: Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform
	specific driver
Date: Fri, 18 Jan 2008 11:55:08 +0800
Message-ID: <4790231C.1040805__24673.8428286791$1200672928$gmane$org@cn.fujitsu.com>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>	
	<20080117092030.a9dfe528.randy.dunlap@oracle.com>
	<1200627175.2935.174.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1200627175.2935.174.camel@acpi-sony.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, "Thomas,
	Sujith" <sujith.thomas@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, sam@ravnborg.org
List-Id: linux-pm@vger.kernel.org

Zhang Rui =E5=86=99=E9=81=93:
> Hi, Randy and Sam,
>=20
>>> +             if (result)
>>> +                     goto end;acpi_bus_get_private_data
>>> +     }
>>> +
>>> +      end:
> Hah, Lindent always does this for me,
>> Labels should begin in column 0 or 1.  Only.
> yes, and checkpatch.pl begins to complain about this
> after using Lindent...
> I think we should change one of them, :)
>=20
>>> +     return result;
>>> +}
>>> +
>>> +
>>> +const static struct acpi_device_id intel_menlow_memory_ids[] =3D {
>>> +     {"INT0002", 0},
>>> +     {"", 0},
>> or just {} for the terminating entry, right?
> Yes, I use this just to be consistent with other ACPI device drivers.
>=20
> Thanks for your comments, please review the patch below,
>=20
> From: Thomas Sujith <sujith.thomas@intel.com>
>=20
> Intel menlow platform specific driver for thermal management extension.
>=20
> Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/misc/Kconfig        |    9=20
>  drivers/misc/Makefile       |    1=20
>  drivers/misc/intel_menlow.c |  520 +++++++++++++++++++++++++++++++++++=
+++++++++
>  3 files changed, 530 insertions(+)
>=20
> Index: linux-2.6/drivers/misc/intel_menlow.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6/drivers/misc/intel_menlow.c
> @@ -0,0 +1,520 @@
> +/*
> +*  intel_menlow.c - Intel menlow Driver for thermal management extensi=
on
> +*
> +*  Copyright (C) 2008 Intel Corp
> +*  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
> +*  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
> +*  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> +*
> +*  This program is free software; you can redistribute it and/or modif=
y
> +*  it under the terms of the GNU General Public License as published b=
y
> +*  the Free Software Foundation; version 2 of the License.
> +*
> +*  This program is distributed in the hope that it will be useful, but
> +*  WITHOUT ANY WARRANTY; without even the implied warranty of
> +*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +*  General Public License for more details.
> +*
> +*  You should have received a copy of the GNU General Public License a=
long
> +*  with this program; if not, write to the Free Software Foundation, I=
nc.,
> +*  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> +*
> +* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
> +*
> +*  This driver creates the sys I/F for programming the sensors.
> +*  It also implements the driver for intel menlow memory controller (h=
ardware
> +*  id is INT0002) which makes use of the platform specific ACPI method=
s
> +*  to get/set bandwidth.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <linux/pm.h>
> +
> +#include <linux/thermal.h>
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +
> +MODULE_AUTHOR("Thomas Sujith");
> +MODULE_AUTHOR("Zhang Rui");
> +MODULE_DESCRIPTION("Intel Menlow platform specific driver");
> +MODULE_LICENSE("GPL");
> +
> +/*
> + * Memory controller device control
> + */
> +
> +#define MEMORY_GET_BANDWIDTH "GTHS"
> +#define MEMORY_SET_BANDWIDTH "STHS"
> +#define MEMORY_ARG_CUR_BANDWIDTH 1
> +#define MEMORY_ARG_MAX_BANDWIDTH 0
> +
> +static int memory_get_int_max_bandwidth(struct thermal_cooling_device =
*cdev,
> +					unsigned long *max_state)
> +{
> +	struct acpi_device *device =3D cdev->devdata;
> +	acpi_handle handle =3D device->handle;
> +	unsigned long value;
> +	struct acpi_object_list arg_list;
> +	union acpi_object arg;
> +	acpi_status status =3D AE_OK;
> +
> +	arg_list.count =3D 1;
> +	arg_list.pointer =3D &arg;
> +	arg.type =3D ACPI_TYPE_INTEGER;
> +	arg.integer.value =3D MEMORY_ARG_MAX_BANDWIDTH;
> +	status =3D acpi_evaluate_integer(handle, MEMORY_GET_BANDWIDTH,
> +				       &arg_list, &value);
> +	if (ACPI_FAILURE(status))
> +		return -EFAULT;
> +
> +	*max_state =3D value - 1;
> +	return 0;
> +}
> +
> +static int memory_get_max_bandwidth(struct thermal_cooling_device *cde=
v,
> +				    char *buf)
> +{
> +	unsigned long value;
> +	if (memory_get_int_max_bandwidth(cdev, &value))
> +		return -EINVAL;
> +
> +	return sprintf(buf, "%ld\n", value);
> +}
> +

<...>

> +static int memory_get_cur_bandwidth(struct thermal_cooling_device *cde=
v,
> +				    char *buf)
> +{
> +	struct acpi_device *device =3D cdev->devdata;
> +	acpi_handle handle =3D device->handle;
> +	unsigned long value;
> +	struct acpi_object_list arg_list;
> +	union acpi_object arg;
> +	acpi_status status =3D AE_OK;
> +
> +	arg_list.count =3D 1;
> +	arg_list.pointer =3D &arg;
> +	arg.type =3D ACPI_TYPE_INTEGER;
> +	arg.integer.value =3D MEMORY_ARG_CUR_BANDWIDTH;
> +	status =3D acpi_evaluate_integer(handle, MEMORY_GET_BANDWIDTH,
> +				       &arg_list, &value);
> +	if (ACPI_FAILURE(status))
> +		return -EFAULT;
> +
> +	return sprintf(buf, "%ld\n", value);
> +}
> +
> +static int memory_set_cur_bandwidth(struct thermal_cooling_device *cde=
v,
> +				    unsigned int state)
> +{
> +	struct acpi_device *device =3D cdev->devdata;
> +	acpi_handle handle =3D device->handle;
> +	struct acpi_object_list arg_list;
> +	union acpi_object arg;
> +	acpi_status status;
> +	int temp;
> +	unsigned long max_state;
> +
> +	if (memory_get_int_max_bandwidth(cdev, &max_state))
> +		return -EFAULT;
> +
> +	if (max_state < 0 || state > max_state)
> +		return -EINVAL;
> +
> +	arg_list.count =3D 1;
> +	arg_list.pointer =3D &arg;
> +	arg.type =3D ACPI_TYPE_INTEGER;
> +	arg.integer.value =3D state;
> +
> +	status =3D
> +	    acpi_evaluate_integer(handle, MEMORY_SET_BANDWIDTH, &arg_list,
> +				  (unsigned long *)&temp);
> +
> +	printk(KERN_INFO
> +	       "Bandwidth value was %d: status is %d\n", state, status);
> +	if (ACPI_FAILURE(status))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static struct thermal_cooling_device_ops memory_cooling_ops =3D {
> +	.get_max_state =3D memory_get_max_bandwidth,
> +	.get_cur_state =3D memory_get_cur_bandwidth,
> +	.set_cur_state =3D memory_set_cur_bandwidth,
> +};
> +

<...>

> +/*
> + * Memory Device Management
> + */
> +static int intel_menlow_memory_add(struct acpi_device *device)
> +{
> +	int result =3D -ENODEV;
> +	acpi_status status =3D AE_OK;
> +	acpi_handle dummy;
> +	struct thermal_cooling_device *cdev;
> +
> +	if (!device)
> +		return -EINVAL;
> +
> +	status =3D acpi_get_handle(device->handle, MEMORY_GET_BANDWIDTH, &dum=
my);
> +	if (ACPI_FAILURE(status))
> +		goto end;
> +
> +	status =3D acpi_get_handle(device->handle, MEMORY_SET_BANDWIDTH, &dum=
my);
> +	if (ACPI_FAILURE(status))
> +		goto end;
> +
> +	cdev =3D thermal_cooling_device_register("Memory controller", device,
> +					       &memory_cooling_ops);
> +	acpi_driver_data(device) =3D cdev;
> +	if (!cdev)
> +		result =3D -ENODEV;
> +	else {
> +		result =3D
> +		    sysfs_create_link(&device->dev.kobj, &cdev->device.kobj,
> +				      "thermal_cooling");
> +		if (result)
> +			goto end;
> +		result =3D
> +		    sysfs_create_link(&cdev->device.kobj, &device->dev.kobj,
> +				      "device");
> +		if (result)
> +			goto end;

This if condition is needless.

> +	}
> +
> + end:
> +	return result;

No need to call thermal_cooling_device_unregister() and sysfs_remove_link=
() in
some error routines ?

> +}
> +
> +static int intel_menlow_memory_remove(struct acpi_device *device, int =
type)
> +{
> +	struct thermal_cooling_device *cdev =3D acpi_driver_data(device);
> +
> +	if (!device || !cdev)
> +		return -EINVAL;
> +
> +	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> +	sysfs_remove_link(&cdev->device.kobj, "device");
> +	thermal_cooling_device_unregister(cdev);
> +
> +	return 0;
> +}
> +
> +const static struct acpi_device_id intel_menlow_memory_ids[] =3D {
> +	{"INT0002", 0},
> +	{"", 0},
> +};
> +
> +static struct acpi_driver intel_menlow_memory_driver =3D {
> +	.name =3D "intel_menlow_thermal_control",
> +	.ids =3D intel_menlow_memory_ids,
> +	.ops =3D {
> +		.add =3D intel_menlow_memory_add,
> +		.remove =3D intel_menlow_memory_remove,
> +		},
> +};
> +
> +/*
> + * Sensor control on menlow platform
> + */
> +
> +#define THERMAL_AUX0 0
> +#define THERMAL_AUX1 1
> +#define GET_AUX0 "GAX0"
> +#define GET_AUX1 "GAX1"
> +#define SET_AUX0 "SAX0"
> +#define SET_AUX1 "SAX1"
> +
> +struct intel_menlow_attribute {
> +	struct device_attribute attr;
> +	struct device *device;
> +	acpi_handle handle;
> +	struct list_head node;
> +};
> +
> +static LIST_HEAD(intel_menlow_attr_list);
> +static DEFINE_MUTEX(intel_menlow_attr_lock);
> +
> +/*
> + * sensor_get_auxtrip - get the current auxtrip value from sensor
> + * @name: Thermalzone name
> + * @auxtype : AUX0/AUX1
> + * @buf: syfs buffer
> + */
> +static int sensor_get_auxtrip(acpi_handle handle, int index, int *valu=
e)
> +{
> +	acpi_status status;
> +
> +	if ((index !=3D 0 && index !=3D 1) || !value)
> +		return -EINVAL;
> +
> +	status =3D acpi_evaluate_integer(handle, index ? GET_AUX1 : GET_AUX0,
> +				       NULL, (unsigned long *)value);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +}
> +

<...>

> +/*
> + * sensor_set_auxtrip - set the new auxtrip value to sensor
> + * @name: Thermalzone name
> + * @auxtype : AUX0/AUX1
> + * @buf: syfs buffer
> + */
> +static int sensor_set_auxtrip(acpi_handle handle, int index, int value=
)
> +{
> +	acpi_status status;
> +	union acpi_object arg =3D {
> +		ACPI_TYPE_INTEGER
> +	};
> +	struct acpi_object_list args =3D {
> +		1, &arg
> +	};
> +	int temp;
> +
> +	if (index !=3D 0 && index !=3D 1)
> +		return -EINVAL;
> +
> +	status =3D acpi_evaluate_integer(handle, index ? GET_AUX0 : GET_AUX1,
> +				       NULL, (unsigned long *)&temp);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +	if ((index && value < temp) || (!index && value > temp))
> +		return -EINVAL;
> +
> +	arg.integer.value =3D value;
> +	status =3D acpi_evaluate_integer(handle, index ? SET_AUX1 : SET_AUX0,
> +				       &args, (unsigned long *)&temp);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	/* do we need to check the return value of SAX0/SAX1 ? */
> +
> +	return 0;
> +}
> +
> +#define to_intel_menlow_attr(_attr)	\
> +	container_of(_attr, struct intel_menlow_attribute, attr)
> +
> +static ssize_t aux0_show(struct device *dev,
> +			 struct device_attribute *dev_attr, char *buf)
> +{
> +	struct intel_menlow_attribute *attr =3D to_intel_menlow_attr(dev_attr=
);
> +	int value;
> +	int result;
> +
> +	result =3D sensor_get_auxtrip(attr->handle, 0, &value);
> +
> +	return result ? result : sprintf(buf, "%lu", KELVIN_TO_CELSIUS(value)=
);
> +}
> +
> +static ssize_t aux1_show(struct device *dev,
> +			 struct device_attribute *dev_attr, char *buf)
> +{
> +	struct intel_menlow_attribute *attr =3D to_intel_menlow_attr(dev_attr=
);
> +	int value;
> +	int result;
> +
> +	result =3D sensor_get_auxtrip(attr->handle, 1, &value);
> +
> +	return result ? result : sprintf(buf, "%lu", KELVIN_TO_CELSIUS(value)=
);
> +}
> +
> +static ssize_t aux0_store(struct device *dev,
> +			  struct device_attribute *dev_attr,
> +			  const char *buf, size_t count)
> +{
> +	struct intel_menlow_attribute *attr =3D to_intel_menlow_attr(dev_attr=
);
> +	int value;
> +	int result;
> +
> +	/*Sanity check; should be a positive integer */
> +	if (!sscanf(buf, "%d", &value))
> +		return -EINVAL;
> +
> +	if (value < 0)
> +		return -EINVAL;
> +
> +	result =3D sensor_set_auxtrip(attr->handle, 0, CELSIUS_TO_KELVIN(valu=
e));
> +	return result ? result : count;
> +}
> +

<...>

> +static ssize_t aux1_store(struct device *dev,
> +			  struct device_attribute *dev_attr,
> +			  const char *buf, size_t count)
> +{
> +	struct intel_menlow_attribute *attr =3D to_intel_menlow_attr(dev_attr=
);
> +	int value;
> +	int result;
> +
> +	/*Sanity check; should be a positive integer */
> +	if (!sscanf(buf, "%d", &value))
> +		return -EINVAL;
> +
> +	if (value < 0)
> +		return -EINVAL;
> +
> +	result =3D sensor_set_auxtrip(attr->handle, 1, CELSIUS_TO_KELVIN(valu=
e));
> +	return result ? result : count;
> +}
> +
> +/* BIOS can enable/disable the thermal user application in dabney plat=
form */
> +#define BIOS_ENABLED "\\_TZ.GSTS"
> +static ssize_t bios_enabled_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	acpi_status status;
> +	unsigned long bios_enabled;
> +
> +	status =3D acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &bios_enab=
led);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	return sprintf(buf, "%s\n", bios_enabled ? "enabled" : "disabled");
> +}
> +
> +static int intel_menlow_add_one_attribute(char *name, int mode, void *=
show,
> +					  void *store, struct device *dev,
> +					  acpi_handle handle)
> +{
> +	struct intel_menlow_attribute *attr;
> +	int result;
> +
> +	attr =3D kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
> +	if (!attr)
> +		return -ENOMEM;
> +
> +	attr->attr.attr.name =3D name;
> +	attr->attr.attr.mode =3D mode;
> +	attr->attr.show =3D show;
> +	attr->attr.store =3D store;
> +	attr->device =3D dev;
> +	attr->handle =3D handle;
> +
> +	result =3D device_create_file(dev, &attr->attr);
> +	if (result)
> +		return result;
> +
> +	mutex_lock(&intel_menlow_attr_lock);
> +	list_add_tail(&attr->node, &intel_menlow_attr_list);
> +	mutex_unlock(&intel_menlow_attr_lock);
> +
> +	return 0;
> +}
> +

<...>

> +static acpi_status intel_menlow_register_sensor(acpi_handle handle, u3=
2 lvl,
> +						void *context, void **rv)
> +{
> +	acpi_status status;
> +	acpi_handle dummy;
> +	struct thermal_zone_device *thermal;
> +	int result;
> +
> +	result =3D acpi_bus_get_private_data(handle, (void **)&thermal);
> +	if (result)
> +		return 0;
> +
> +	/* _TZ must have the AUX0/1 methods */
> +	status =3D acpi_get_handle(handle, GET_AUX0, &dummy);
> +	if (ACPI_FAILURE(status))
> +		goto not_found;
> +
> +	status =3D acpi_get_handle(handle, SET_AUX0, &dummy);
> +	if (ACPI_FAILURE(status))
> +		goto not_found;
> +
> +	result =3D intel_menlow_add_one_attribute("aux0", 0644,
> +						aux0_show, aux0_store,
> +						&thermal->device, handle);
> +	if (result)
> +		return AE_ERROR;
> +
> +	status =3D acpi_get_handle(handle, GET_AUX1, &dummy);
> +	if (ACPI_FAILURE(status))
> +		goto not_found;
> +
> +	status =3D acpi_get_handle(handle, SET_AUX1, &dummy);
> +	if (ACPI_FAILURE(status))
> +		goto not_found;
> +
> +	result =3D intel_menlow_add_one_attribute("aux1", 0644,
> +						aux1_show, aux1_store,
> +						&thermal->device, handle);
> +	if (result)
> +		return AE_ERROR;
> +
> +	/*
> +	 * create the "dabney_enabled" attribute which means the user app
> +	 * should be loaded or not
> +	 */
> +
> +	result =3D intel_menlow_add_one_attribute("bios_enabled", 0444,
> +						bios_enabled_show, NULL,
> +						&thermal->device, handle);
> +	if (result)
> +		return AE_ERROR;
> +
> + not_found:
> +	if (status =3D=3D AE_NOT_FOUND)
> +		return AE_OK;
> +	else
> +		return status;
> +}
> +
> +static void intel_menlow_unregister_sensor(void)
> +{
> +	struct intel_menlow_attribute *pos, *next;
> +
> +	mutex_lock(&intel_menlow_attr_lock);
> +	list_for_each_entry_safe(pos, next, &intel_menlow_attr_list, node) {
> +		list_del(&pos->node);
> +		device_remove_file(pos->device, &pos->attr);
> +		kfree(pos);
> +	}
> +	mutex_unlock(&intel_menlow_attr_lock);
> +
> +	return;
> +}
> +
> +static int __init intel_menlow_module_init(void)
> +{
> +	int result =3D -ENODEV;
> +	acpi_status status;
> +	unsigned long enable;
> +
> +	if (acpi_disabled)
> +		return result;
> +
> +	/* Looking for the \_TZ.GSTS method */
> +	status =3D acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL, &enable);
> +	if (ACPI_FAILURE(status) || !enable)
> +		return -ENODEV;
> +
> +	/* Looking for ACPI device MEM0 with hardware id INT0002 */
> +	result =3D acpi_bus_register_driver(&intel_menlow_memory_driver);
> +	if (result)
> +		return result;
> +
> +	/* Looking for sensors in each ACPI thermal zone */
> +	status =3D acpi_walk_namespace(ACPI_TYPE_THERMAL, ACPI_ROOT_OBJECT,
> +				     ACPI_UINT32_MAX,
> +				     intel_menlow_register_sensor, NULL, NULL);
> +	if (ACPI_FAILURE(status))
> +		result =3D -ENODEV;
> +

It seems to me this should be 'return -ENODEV;'

You can just eliminate variable result, because result will be
-ENODEV only.

> +	return 0;
> +}
> +
> +static void __exit intel_menlow_module_exit(void)
> +{
> +	acpi_bus_unregister_driver(&intel_menlow_memory_driver);
> +	intel_menlow_unregister_sensor();
> +}
> +
> +module_init(intel_menlow_module_init);
> +module_exit(intel_menlow_module_exit);
> Index: linux-2.6/drivers/misc/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/misc/Kconfig
> +++ linux-2.6/drivers/misc/Kconfig
> @@ -232,4 +232,13 @@ config ATMEL_SSC
> =20
>  	  If unsure, say N.
> =20
> +config INTEL_MENLOW
> +	tristate "Thermal Management driver for Intel menlow platform"
> +	depends on ACPI_THERMAL
> +	---help---
> +	  ACPI thermal management enhancement driver on
> +	  Intel Menlow platform.
> +
> +	  If unsure, say N.
> +
>  endif # MISC_DEVICES
> Index: linux-2.6/drivers/misc/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/misc/Makefile
> +++ linux-2.6/drivers/misc/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_SONY_LAPTOP)	+=3D sony-laptop
>  obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>  obj-$(CONFIG_FUJITSU_LAPTOP)	+=3D fujitsu-laptop.o
>  obj-$(CONFIG_EEPROM_93CX6)	+=3D eeprom_93cx6.o
> +obj-$(CONFIG_INTEL_MENLOW)	+=3D intel_menlow.o
>=20
>=20
