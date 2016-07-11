From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1/7] hwmon: (core) New hwmon registration API
Date: Sun, 10 Jul 2016 18:31:44 -0700
Message-ID: <5782F700.7050304@roeck-us.net>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
 <1466911590-26296-2-git-send-email-linux@roeck-us.net>
 <286a9004-b40c-67d0-1408-4c601e43667f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <286a9004-b40c-67d0-1408-4c601e43667f-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Jonathan,

On 07/10/2016 08:51 AM, Jonathan Cameron wrote:
> On 26/06/16 04:26, Guenter Roeck wrote:
>> Up to now, each hwmon driver has to implement its own sysfs attributes.
>> This requires a lot of template code, and distracts from the driver's core
>> function to read and write chip registers.
>>
>> To be able to reduce driver complexity, move sensor attribute handling
>> and thermal zone registration into hwmon core. By using the new API,
>> driver size is typically reduced by 20-50% depending on driver complexity
>> and the number of sysfs attributes supported.
>>
>> With this patch, the new API only supports thermal sensors. Support for
>> other sensor types will be added with subsequent patches.
>>
>> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Hi Guenter.
>
> Sorry it took me so long to get to this....
>
> Anyhow, mostly looks clean, effective and consise to me.
> Various bits and pieces inline.  There are a few bits I might (when time
> allows) lift over to iio as they are nicer than what we have.
>
> My one lesson learned from IIO is always be wary of space in bitmaps.  We
> haven't run out yet but are getting close.  You may end up in a similar
> state here a few years down the line.
>
Yes, I spend a lot of time arguing with myself over u32 vs. u64. I decided
to stick with u32 for now, reasons being that there are multiple number spaces
and that the bit mask is only really used for registration (and thus relatively
easy to change).

More comments inline.

> Jonathan
>> ---
>>   drivers/hwmon/hwmon.c | 485 ++++++++++++++++++++++++++++++++++++++++++++++----
>>   include/linux/hwmon.h | 122 +++++++++++++
>>   2 files changed, 574 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>> index a26c385a435b..9530644ae297 100644
>> --- a/drivers/hwmon/hwmon.c
>> +++ b/drivers/hwmon/hwmon.c
>> @@ -12,17 +12,16 @@
>>
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>> -#include <linux/module.h>
>> +#include <linux/bitops.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>> -#include <linux/slab.h>
>> -#include <linux/kdev_t.h>
>> -#include <linux/idr.h>
>>   #include <linux/hwmon.h>
>> -#include <linux/gfp.h>
>> -#include <linux/spinlock.h>
>> +#include <linux/idr.h>
>> +#include <linux/module.h>
> Some unconnected changes in this.  Arguably reordering is good and
> all but should be in a precursor patch so it's obvious what has
> been added or removed here.
>
Split into a separate patch.

>>   #include <linux/pci.h>
>> +#include <linux/slab.h>
>>   #include <linux/string.h>
>> +#include <linux/thermal.h>
>>
>>   #define HWMON_ID_PREFIX "hwmon"
>>   #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
>> @@ -30,9 +29,33 @@
>>   struct hwmon_device {
>>   	const char *name;
>>   	struct device dev;
>> +	const struct hwmon_chip_info *chip;
>> +
>> +	struct attribute_group group;
>> +	const struct attribute_group **groups;
>>   };
>>   #define to_hwmon_device(d) container_of(d, struct hwmon_device, dev)
>>
>> +struct hwmon_device_attribute {
>> +	struct device_attribute dev_attr;
>> +	const struct hwmon_ops *ops;
>> +	enum hwmon_sensor_types type;
>> +	u32 attr;
>> +	int index;
>> +};
>> +#define to_hwmon_attr(d) \
>> +	container_of(d, struct hwmon_device_attribute, dev_attr)
>> +
>> +/*
>> + * Thermal zone information
>> + * In addition to the reference to the hwmon device,
>> + * also provides the sensor index.
>> + */
>> +struct hwmon_thermal_data {
>> +	struct hwmon_device *hwdev;	/* Reference to hwmon device */
>> +	int index;			/* sensor index */
>> +};
>> +
>>   static ssize_t
>>   show_name(struct device *dev, struct device_attribute *attr, char *buf)
>>   {
>> @@ -80,25 +103,280 @@ static struct class hwmon_class = {
>>
>>   static DEFINE_IDA(hwmon_ida);
>>
>> -/**
>> - * hwmon_device_register_with_groups - register w/ hwmon
>> - * @dev: the parent device
>> - * @name: hwmon name attribute
>> - * @drvdata: driver data to attach to created device
>> - * @groups: List of attribute groups to create
>> - *
>> - * hwmon_device_unregister() must be called when the device is no
>> - * longer needed.
>> - *
>> - * Returns the pointer to the new device.
>> - */
>> -struct device *
>> -hwmon_device_register_with_groups(struct device *dev, const char *name,
>> -				  void *drvdata,
>> -				  const struct attribute_group **groups)
>> +/* Thermal zone handling */
>> +
>> +static int hwmon_thermal_get_temp(void *data, int *temp)
>> +{
>> +	struct hwmon_thermal_data *tdata = data;
>> +	struct hwmon_device *hwdev = tdata->hwdev;
>> +	int ret;
>> +	long t;
>> +
>> +	ret = hwdev->chip->ops->read(&hwdev->dev, hwmon_temp, hwmon_temp_input,
>> +				     tdata->index, &t);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*temp = t;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct thermal_zone_of_device_ops hwmon_thermal_ops = {
>> +	.get_temp = hwmon_thermal_get_temp,
>> +};
>> +
>> +static int hwmon_thermal_add_sensor(struct device *dev,
>> +				    struct hwmon_device *hwdev,
>> +				    int index)
>> +{
>> +	struct hwmon_thermal_data *tdata;
>> +
>> +	tdata = devm_kzalloc(dev, sizeof(*tdata), GFP_KERNEL);
>> +	if (!tdata)
>> +		return -ENOMEM;
>> +
>> +	tdata->hwdev = hwdev;
>> +	tdata->index = index;
>> +
>> +	devm_thermal_zone_of_sensor_register(&hwdev->dev, index, tdata,
>> +					     &hwmon_thermal_ops);
>> +
>> +	return 0;
>> +}
>> +
>> +/* sysfs attribute management */
>> +
>> +static ssize_t hwmon_attr_show(struct device *dev,
>> +			       struct device_attribute *devattr, char *buf)
>> +{
>> +	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
>> +	long val;
>> +	int ret;
>> +
>> +	ret = hattr->ops->read(dev, hattr->type, hattr->attr, hattr->index,
>> +			       &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return sprintf(buf, "%ld\n", val);
>> +}
>> +
>> +static ssize_t hwmon_attr_store(struct device *dev,
>> +				struct device_attribute *devattr,
>> +				const char *buf, size_t count)
>> +{
>> +	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
>> +	long val;
>> +	int ret;
>> +
>> +	ret = kstrtol(buf, 10, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = hattr->ops->write(dev, hattr->type, hattr->attr, hattr->index,
>> +				val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>> +static int hwmon_attr_base(enum hwmon_sensor_types type)
>> +{
>> +	if (type == hwmon_in)
>> +		return 0;
>> +	return 1;
>> +}
>> +
>> +static struct attribute *hwmon_genattr(struct device *dev,
>> +				       const void *drvdata,
>> +				       enum hwmon_sensor_types type,
>> +				       u32 attr,
>> +				       int index,
>> +				       const char *template,
>> +				       const struct hwmon_ops *ops)
>> +{
>> +	struct hwmon_device_attribute *hattr;
>> +	struct device_attribute *dattr;
>> +	struct attribute *a;
>> +	umode_t mode;
>> +	char *name;
>> +
>> +	if (!template)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	mode = ops->is_visible(drvdata, type, attr, index);
>> +	if (!mode)
>> +		return ERR_PTR(-ENOENT);
>> +
> I've been wondering about doing something similar to this in IIO for a while
> as our attributes are far to often rw when they should only be one or the
> other. This is much more elegant.  We could get away with it (nasty as it is)
> on the basis of no previous ABI to match where as you have to have this...
> Can see this is_visible callback might get a little messy in some cases.
>
So far it wasn't that bad. For chips supporting multiple sensor types,
I found it useful to have per-type functions in the driver. I also thought about
using per-type callbacks, but decided against it to avoid large (and mostly
empty) data structures in the driver. Also, hwmon drivers always had to deal with
this situation, so the code to determine sensor visibility is already there
(either by implementing the is_visible callback in struct attribute_group,
or by dynamically selecting which attribute groups are needed in the probe
function).

> Actually, is is_visible a good name?  I'd think that would control whether
> we can see the attribute at all.  Perhaps something like
> get_filemode would be a better callback naming?
>
I picked is_visible because that is the name used in struct attribute_group,
and it has the same functionality there.

>> +	if ((mode & S_IRUGO) && !ops->read)
>> +		return ERR_PTR(-EINVAL);
>> +	if ((mode & S_IWUGO) && !ops->write)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (type == hwmon_chip) {
>> +		name = (char *)template;
>> +	} else {
>> +		name = devm_kzalloc(dev, strlen(template) + 16, GFP_KERNEL);
>> +		if (!name)
>> +			return ERR_PTR(-ENOMEM);
>> +		scnprintf(name, strlen(template) + 16, template,
>> +			  index + hwmon_attr_base(type));
>> +	}
>> +
>> +	hattr = devm_kzalloc(dev, sizeof(*hattr), GFP_KERNEL);
>> +	if (!hattr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	hattr->type = type;
>> +	hattr->attr = attr;
>> +	hattr->index = index;
>> +	hattr->ops = ops;
>> +
>> +	dattr = &hattr->dev_attr;
>> +	if (mode & S_IRUGO)
>> +		dattr->show = hwmon_attr_show;
>> +	if (mode & S_IWUGO)
>> +		dattr->store = hwmon_attr_store;
> Technically I think there is no need to worry about setting the store / show
> when they aren't needed.  Maybe, not worth the really small savings though...

Yes, you are right. Not to save some code, but the if statements are really not
necessary and don't add any value.

>> +
>> +	a = &dattr->attr;
>> +	sysfs_attr_init(a);
>> +	a->name = name;
>> +	a->mode = mode;
>> +
>> +	return a;
>> +}
>> +
>> +static const char * const hwmon_chip_attr_templates[] = {
>> +	[hwmon_chip_temp_reset_history] = "temp_reset_history",
>> +	[hwmon_chip_update_interval] = "update_interval",
>> +	[hwmon_chip_alarms] = "alarms",
>> +};
>> +
>> +static const char * const hwmon_temp_attr_templates[] = {
>> +	[hwmon_temp_input] = "temp%d_input",
>> +	[hwmon_temp_type] = "temp%d_type",
>> +	[hwmon_temp_lcrit] = "temp%d_lcrit",
>> +	[hwmon_temp_lcrit_hyst] = "temp%d_lcrit_hyst",
>> +	[hwmon_temp_min] = "temp%d_min",
>> +	[hwmon_temp_min_hyst] = "temp%d_min_hyst",
>> +	[hwmon_temp_max] = "temp%d_max",
>> +	[hwmon_temp_max_hyst] = "temp%d_max_hyst",
>> +	[hwmon_temp_crit] = "temp%d_crit",
>> +	[hwmon_temp_crit_hyst] = "temp%d_crit_hyst",
>> +	[hwmon_temp_emergency] = "temp%d_emergency",
>> +	[hwmon_temp_emergency_hyst] = "temp%d_emergency_hyst",
>> +	[hwmon_temp_alarm] = "temp%d_alarm",
>> +	[hwmon_temp_lcrit_alarm] = "temp%d_lcrit_alarm",
>> +	[hwmon_temp_min_alarm] = "temp%d_min_alarm",
>> +	[hwmon_temp_max_alarm] = "temp%d_max_alarm",
>> +	[hwmon_temp_crit_alarm] = "temp%d_crit_alarm",
>> +	[hwmon_temp_emergency_alarm] = "temp%d_emergency_alarm",
>> +	[hwmon_temp_fault] = "temp%d_fault",
>> +	[hwmon_temp_offset] = "temp%d_offset",
>> +	[hwmon_temp_label] = "temp%d_label",
>> +	[hwmon_temp_lowest] = "temp%d_lowest",
>> +	[hwmon_temp_highest] = "temp%d_highest",
>> +	[hwmon_temp_reset_history] = "temp%d_reset_history",
>> +};
>> +
>> +static const char * const *__templates[] = {
>> +	[hwmon_chip] = hwmon_chip_attr_templates,
>> +	[hwmon_temp] = hwmon_temp_attr_templates,
>> +};
>> +
>> +static const int __templates_size[] = {
>> +	[hwmon_chip] = ARRAY_SIZE(hwmon_chip_attr_templates),
>> +	[hwmon_temp] = ARRAY_SIZE(hwmon_temp_attr_templates),
>> +};
>> +
>> +static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
>> +{
>> +	int i, n;
>> +
>> +	for (i = n = 0; info->config[i]; i++)
>> +		n += hweight32(info->config[i]);
>> +
>> +	return n;
>> +}
>> +
>> +static int hwmon_genattrs(struct device *dev,
>> +			  const void *drvdata,
>> +			  struct attribute **attrs,
>> +			  const struct hwmon_ops *ops,
>> +			  const struct hwmon_channel_info *info)
>> +{
>> +	const char * const *templates;
>> +	int template_size;
>> +	int i, aindex = 0;
>> +
>> +	if (info->type >= ARRAY_SIZE(__templates))
>> +		return -EINVAL;
>> +
>> +	templates = __templates[info->type];
>> +	template_size = __templates_size[info->type];
>> +
>> +	for (i = 0; info->config[i]; i++) {
>> +		u32 attr_mask = info->config[i];
>> +		u32 attr;
>> +
>> +		while (attr_mask) {
>> +			struct attribute *a;
>> +
>> +			attr = __ffs(attr_mask);
>> +			attr_mask &= ~BIT(attr);
> loop instead using the for_each_bit_set?  Tiny bit cleaner perhaps...

A bit, maybe, though not much. I changed it, but since for_each_set_bit() requires
a pointer to an unsigned long as argument, I still need attr_mask as temporary
variable (I don't want to use unsigned long for the config bit mask since
its size is not well defined). Hmm ... that also means that switching to u64
in the future will be tricky. I'll need to think about that some more.

>> +			if (attr >= template_size)
>> +				return -EINVAL;
>> +			a = hwmon_genattr(dev, drvdata, info->type, attr, i,
>> +					  templates[attr], ops);
>> +			if (IS_ERR(a)) {
>> +				if (PTR_ERR(a) != -ENOENT)
>> +					return PTR_ERR(a);
>> +				continue;
>> +			}
>> +			attrs[aindex++] = a;
>> +		}
>> +	}
>> +	return aindex;
>> +}
>> +
>> +static struct attribute **
>> +__hwmon_create_attrs(struct device *dev, const void *drvdata,
>> +		     const struct hwmon_chip_info *chip)
>> +{
>> +	int ret, i, aindex = 0, nattrs = 0;
>> +	struct attribute **attrs;
>> +
>> +	for (i = 0; chip->info[i]; i++)
>> +		nattrs += hwmon_num_channel_attrs(chip->info[i]);
>> +
>> +	if (nattrs == 0)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	attrs = devm_kcalloc(dev, nattrs + 1, sizeof(*attrs), GFP_KERNEL);
>> +	if (attrs == NULL)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	for (i = 0; chip->info[i]; i++) {
>> +		ret = hwmon_genattrs(dev, drvdata, &attrs[aindex], chip->ops,
>> +				     chip->info[i]);
>> +		if (ret < 0)
>> +			return ERR_PTR(ret);
>> +		aindex += ret;
>> +	}
>> +
>> +	return attrs;
>> +}
>> +
>> +static struct device *
>> +__hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>> +			const struct hwmon_chip_info *chip,
>> +			const struct attribute_group **groups)
>>   {
>>   	struct hwmon_device *hwdev;
>> -	int err, id;
>> +	struct device *hdev;
>> +	int i, j, err, id;
>>
>>   	/* Do not accept invalid characters in hwmon name attribute */
>>   	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
>> @@ -114,28 +392,128 @@ hwmon_device_register_with_groups(struct device *dev, const char *name,
>>   		goto ida_remove;
>>   	}
>>
>> +	hdev = &hwdev->dev;
>> +
>> +	if (chip && chip->ops->is_visible) {
>> +		struct attribute **attrs;
>> +		int ngroups = 2;
>> +
>> +		if (groups)
>> +			for (i = 0; groups[i]; i++)
>> +				ngroups++;
>> +
>> +		hwdev->groups = devm_kcalloc(dev, ngroups, sizeof(*groups),
>> +					     GFP_KERNEL);
>> +		if (hwdev->groups == NULL)
>> +			return ERR_PTR(-ENOMEM);
>> +
>> +		attrs = __hwmon_create_attrs(dev, drvdata, chip);
>> +		if (IS_ERR(attrs)) {
>> +			err = PTR_ERR(attrs);
>> +			goto free_hwmon;
>> +		}
>> +
>> +		hwdev->group.attrs = attrs;
>> +		ngroups = 0;
>> +		hwdev->groups[ngroups++] = &hwdev->group;
>> +
>> +		if (groups) {
>> +			for (i = 0; groups[i]; i++)
>> +				hwdev->groups[ngroups++] = groups[i];
>> +		}
>> +
>> +		hdev->groups = hwdev->groups;
>> +	} else {
>> +		hdev->groups = groups;
>> +	}
>> +
>>   	hwdev->name = name;
>> -	hwdev->dev.class = &hwmon_class;
>> -	hwdev->dev.parent = dev;
>> -	hwdev->dev.groups = groups;
>> -	hwdev->dev.of_node = dev ? dev->of_node : NULL;
>> -	dev_set_drvdata(&hwdev->dev, drvdata);
>> -	dev_set_name(&hwdev->dev, HWMON_ID_FORMAT, id);
>> -	err = device_register(&hwdev->dev);
>> +	hdev->class = &hwmon_class;
>> +	hdev->parent = dev;
>> +	hdev->of_node = dev ? dev->of_node : NULL;
>> +	hwdev->chip = chip;
>> +	dev_set_drvdata(hdev, drvdata);
>> +	dev_set_name(hdev, HWMON_ID_FORMAT, id);
>> +	err = device_register(hdev);
>>   	if (err)
>> -		goto free;
>> +		goto free_hwmon;
>> +
>> +	if (chip && chip->ops->is_visible && chip->ops->read &&
>> +	    chip->info[0]->type == hwmon_chip &&
>> +	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
>> +		const struct hwmon_channel_info **info = chip->info;
>> +
>> +		for (i = 1; info[i]; i++) {
>> +			if (info[i]->type != hwmon_temp)
>> +				continue;
>> +
>> +			for (j = 0; info[i]->config[j]; j++) {
>> +				if (!chip->ops->is_visible(drvdata, hwmon_temp,
>> +							   hwmon_temp_input, j))
>> +					continue;
>> +				if (info[i]->config[j] & HWMON_T_INPUT)
>> +					hwmon_thermal_add_sensor(dev, hwdev, j);
>> +			}
>> +		}
>> +	}
>>
>> -	return &hwdev->dev;
>> +	return hdev;
>>
>> -free:
>> +free_hwmon:
>>   	kfree(hwdev);
>>   ida_remove:
>>   	ida_simple_remove(&hwmon_ida, id);
>>   	return ERR_PTR(err);
>>   }
>> +
>> +/**
>> + * hwmon_device_register_with_groups - register w/ hwmon
>> + * @dev: the parent device
>> + * @name: hwmon name attribute
>> + * @drvdata: driver data to attach to created device
>> + * @groups: List of attribute groups to create
>> + *
>> + * hwmon_device_unregister() must be called when the device is no
>> + * longer needed.
>> + *
>> + * Returns the pointer to the new device.
>> + */
>> +struct device *
>> +hwmon_device_register_with_groups(struct device *dev, const char *name,
>> +				  void *drvdata,
>> +				  const struct attribute_group **groups)
>> +{
>> +	return __hwmon_device_register(dev, name, drvdata, NULL, groups);
>> +}
>>   EXPORT_SYMBOL_GPL(hwmon_device_register_with_groups);
>>
>>   /**
>> + * hwmon_device_register_with_info - register w/ hwmon
>> + * @dev: the parent device
>> + * @name: hwmon name attribute
>> + * @drvdata: driver data to attach to created device
>> + * @info: Pointer to hwmon chip information
>> + * @groups - pointer to list of driver specific attribute groups
>> + *
>> + * hwmon_device_unregister() must be called when the device is no
>> + * longer needed.
>> + *
>> + * Returns the pointer to the new device.
>> + */
>> +struct device *
>> +hwmon_device_register_with_info(struct device *dev, const char *name,
>> +				  void *drvdata,
>> +				  const struct hwmon_chip_info *chip,
>> +				  const struct attribute_group **groups)
>> +{
>> +	if (chip && (!chip->ops || !chip->info))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	return __hwmon_device_register(dev, name, drvdata, chip, groups);
>> +}
>> +EXPORT_SYMBOL_GPL(hwmon_device_register_with_info);
>> +
>> +/**
>>    * hwmon_device_register - register w/ hwmon
>>    * @dev: the device to register
>>    *
>> @@ -213,6 +591,47 @@ error:
>>   }
>>   EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_groups);
>>
>> +/**
>> + * devm_hwmon_device_register_with_info - register w/ hwmon
>> + * @dev: the parent device
>> + * @name: hwmon name attribute
>> + * @drvdata: driver data to attach to created device
>> + * @info: Pointer to hwmon chip information
>> + * @groups - pointer to list of driver specific attribute groups
>> + *
>> + * Returns the pointer to the new device. The new device is automatically
>> + * unregistered with the parent device.
>> + */
>> +struct device *
>> +devm_hwmon_device_register_with_info(struct device *dev, const char *name,
>> +				     void *drvdata,
>> +				     const struct hwmon_chip_info *chip,
>> +				     const struct attribute_group **groups)
>> +{
>> +	struct device **ptr, *hwdev;
>> +
>> +	if (!dev)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	ptr = devres_alloc(devm_hwmon_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	hwdev = hwmon_device_register_with_info(dev, name, drvdata, chip,
>> +						groups);
>> +	if (IS_ERR(hwdev))
>> +		goto error;
>> +
>> +	*ptr = hwdev;
>> +	devres_add(dev, ptr);
> Perhaps a blank line here? (really tiny improvement in readability?
>> +	return hwdev;
>> +
>> +error:
>> +	devres_free(ptr);
>> +	return hwdev;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_info);
>> +
>>   static int devm_hwmon_match(struct device *dev, void *res, void *data)
>>   {
>>   	struct device **hwdev = res;
>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> index 09354f6c1d63..99250ad092fd 100644
>> --- a/include/linux/hwmon.h
>> +++ b/include/linux/hwmon.h
>> @@ -14,9 +14,121 @@
>>   #ifndef _HWMON_H_
>>   #define _HWMON_H_
>>
>> +#include <linux/bitops.h>
>> +
>>   struct device;
>>   struct attribute_group;
>>
>> +enum hwmon_sensor_types {
>> +	hwmon_chip,
>> +	hwmon_temp,
>> +	hwmon_in,
>> +	hwmon_curr,
>> +	hwmon_power,
>> +	hwmon_energy,
>> +};
>> +
>> +enum hwmon_chip_attributes {
>> +	hwmon_chip_temp_reset_history,
>> +	hwmon_chip_register_tz,
>> +	hwmon_chip_update_interval,
>> +	hwmon_chip_alarms,
>> +};
>> +
>> +#define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
>> +#define HWMON_C_IN_RESET_HISTORY	BIT(hwmon_chip_in_reset_history)
>> +#define HWMON_C_REGISTER_TZ		BIT(hwmon_chip_register_tz)
>> +#define HWMON_C_UPDATE_INTERVAL		BIT(hwmon_chip_update_interval)
>> +#define HWMON_C_ALARMS			BIT(hwmon_chip_alarms)
>> +
>> +enum hwmon_temp_attributes {
>> +	hwmon_temp_input = 0,
>> +	hwmon_temp_type,
>> +	hwmon_temp_lcrit,
>> +	hwmon_temp_lcrit_hyst,
>> +	hwmon_temp_min,
>> +	hwmon_temp_min_hyst,
>> +	hwmon_temp_max,
>> +	hwmon_temp_max_hyst,
>> +	hwmon_temp_crit,
>> +	hwmon_temp_crit_hyst,
>> +	hwmon_temp_emergency,
>> +	hwmon_temp_emergency_hyst,
>> +	hwmon_temp_alarm,
>> +	hwmon_temp_lcrit_alarm,
>> +	hwmon_temp_min_alarm,
>> +	hwmon_temp_max_alarm,
>> +	hwmon_temp_crit_alarm,
>> +	hwmon_temp_emergency_alarm,
>> +	hwmon_temp_fault,
>> +	hwmon_temp_offset,
>> +	hwmon_temp_label,
>> +	hwmon_temp_lowest,
>> +	hwmon_temp_highest,
>> +	hwmon_temp_reset_history,
>> +};
>> +
>> +#define HWMON_T_INPUT		BIT(hwmon_temp_input)
>> +#define HWMON_T_TYPE		BIT(hwmon_temp_type)
>> +#define HWMON_T_LCRIT		BIT(hwmon_temp_lcrit)
>> +#define HWMON_T_LCRIT_HYST	BIT(hwmon_temp_lcrit_hyst)
>> +#define HWMON_T_MIN		BIT(hwmon_temp_min)
>> +#define HWMON_T_MIN_HYST	BIT(hwmon_temp_min_hyst)
>> +#define HWMON_T_MAX		BIT(hwmon_temp_max)
>> +#define HWMON_T_MAX_HYST	BIT(hwmon_temp_max_hyst)
>> +#define HWMON_T_CRIT		BIT(hwmon_temp_crit)
>> +#define HWMON_T_CRIT_HYST	BIT(hwmon_temp_crit_hyst)
>> +#define HWMON_T_EMERGENCY	BIT(hwmon_temp_emergency)
>> +#define HWMON_T_EMERGENCY_HYST	BIT(hwmon_temp_emergency_hyst)
>> +#define HWMON_T_MIN_ALARM	BIT(hwmon_temp_min_alarm)
>> +#define HWMON_T_MAX_ALARM	BIT(hwmon_temp_max_alarm)
>> +#define HWMON_T_CRIT_ALARM	BIT(hwmon_temp_crit_alarm)
>> +#define HWMON_T_EMERGENCY_ALARM	BIT(hwmon_temp_emergency_alarm)
>> +#define HWMON_T_FAULT		BIT(hwmon_temp_fault)
>> +#define HWMON_T_OFFSET		BIT(hwmon_temp_offset)
>> +#define HWMON_T_LABEL		BIT(hwmon_temp_label)
>> +#define HWMON_T_LOWEST		BIT(hwmon_temp_lowest)
>> +#define HWMON_T_HIGHEST		BIT(hwmon_temp_highest)
>> +#define HWMON_T_RESET_HISTORY	BIT(hwmon_temp_reset_history)
>> +
>> +/**
>> + * struct hwmon_ops - hwmon device operations
>> + * @is_visible: Callback to return attribute visibility.
>> + *		Optional.
>> + * @read:       Read callback. Optional.
> I'd like to see a little more expansion in this comment on the form of the
> callbacks.  What are the parameters etc?  I'd expect to look here first
> to find that out rather than diving into docs.

Done.

>> + * @write:	Write callback. Optional.
>> + */
>> +struct hwmon_ops {
>> +	umode_t (*is_visible)(const void *, enum hwmon_sensor_types type,
>> +			      u32 attr, int);
>> +	int (*read)(struct device *, enum hwmon_sensor_types type,
>> +		    u32 attr, int, long *);
>> +	int (*write)(struct device *, enum hwmon_sensor_types type,
>> +		     u32 attr, int, long);
>> +};
>> +
>> +/**
>> + * Channel information
>> + * @type:	Channel type.
>> + * @config:	Pointer to NULL-terminated list of channel parameters.
>> + *		Use for per-channel attributes.
>> + */
>> +struct hwmon_channel_info {
>> +	enum hwmon_sensor_types type;
>> +	const u32 *config;
> Hmm. Be very careful about running out of space. I did much the same
> in IIO as you know and am somewhat regretting it now a using a bitmap is
> lovely and efficient, but really annoying once you run out of bits
> if you've used a fixed (short) length..
>
> Using a bitmap as defined in bitmap.h doesn't work as there is no elegant
> way of statically defining them beyond the first long.  I really wish
> there was a way of doing this but can't figure out how..
>
Me not either, which is why I did not use it.

> Maybe just go for a u64 from the start (though that then complicates the
> use of some of the bitops stuff) I suspect we'll be jumping to
> that in IIO fairly soon and it'd be a lot less painful to start there
> perhaps...
>
My solution trying to avoid that was to use separate number spaces
for the different sensor types. If/when we hit the limit (temperatures
are getting close), we would have two options: Define a new sensor type
to handle the overflow, or switch to u64. Ultimately I decided to stick
with u32 for now because u64 seemed overkill. On the other side, I made
that decision when the read/write/is_visible API to the drivers included
the bit mask, which is no longer the case. Maybe I'll try with u64 to see
its impact on code size.

>
>> +};
>> +
>> +/**
>> + * Chip configuration
>> + * @ops:	Pointer to hwmon operations.
>> + * @info:	Null-terminated list of channel information.
> Drop the bonus blank line.
>
> We tossed up in IIO for a long time on whether to use a null terminated list
> of our equivalent info elements, or an explict count.  Ended up with count
> as it often allows sharing of the big array of channel info structures
> between different parts where one part adds more hardware over the other..
>
> I'm not saying that the gain by doing that was all that signficant, but
> I thought I'd mention the trade offs.

I went through the same thinking process. At the end, I decided to go with
the terminated list since passing it around seemed to be simpler.
The core has to walk through the list anyway, and the hwmon code does not
require big data structures to describe the channels.

> Here I think you have made the right decision.

Thanks for the feedback, and thanks a lot for your time!

Guenter
