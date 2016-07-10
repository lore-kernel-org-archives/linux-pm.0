From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 7/7] hwmon: (core) Document new kernel API
Date: Sun, 10 Jul 2016 16:56:36 +0100
Message-ID: <8e43c607-04d2-120c-555f-48339fd07371@kernel.org>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
 <1466911590-26296-8-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <1466911590-26296-8-git-send-email-linux@roeck-us.net>
Sender: linux-hwmon-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26/06/16 04:26, Guenter Roeck wrote:
> Describe the new registration API function as well as the data
> structures it requires.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Nice docs. Couple of typos inline.

Jonathan
> ---
>  Documentation/hwmon/hwmon-kernel-api.txt | 229 ++++++++++++++++++++++++++++++-
>  1 file changed, 227 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/hwmon-kernel-api.txt b/Documentation/hwmon/hwmon-kernel-api.txt
> index 2ecdbfc85ecf..1a96c36532f2 100644
> --- a/Documentation/hwmon/hwmon-kernel-api.txt
> +++ b/Documentation/hwmon/hwmon-kernel-api.txt
> @@ -34,6 +34,19 @@ devm_hwmon_device_register_with_groups(struct device *dev,
>  				       const char *name, void *drvdata,
>  				       const struct attribute_group **groups);
>  
> +struct device *
> +hwmon_device_register_with_info(struct device *dev,
> +				const char *name, void *drvdata,
> +				const struct hwmon_chip_info *info,
> +				const struct attribute_group **groups);
> +
> +struct device *
> +devm_hwmon_device_register_with_info(struct device *dev,
> +				     const char *name,
> +				     void *drvdata,
> +				     const struct hwmon_chip_info *info,
> +				     const struct attribute_group **groups);
> +
>  void hwmon_device_unregister(struct device *dev);
>  void devm_hwmon_device_unregister(struct device *dev);
>  
> @@ -60,15 +73,227 @@ devm_hwmon_device_register_with_groups is similar to
>  hwmon_device_register_with_groups. However, it is device managed, meaning the
>  hwmon device does not have to be removed explicitly by the removal function.
>  
> +hwmon_device_register_with_info is the most comprehensive and preferred means
> +to register a hardware monitoring device. It creates the standard sysfs
> +attributes in the hardware monitoring core, letting the driver focus on reading
> +from and writing to the chip instead of having to bother with sysfs attributes.
> +Its parameters are described in more detail below.
> +
> +devm_hwmon_device_register_with_info is similar to
> +hwmon_device_register_with_info. However, it is device managed, meaning the
> +hwmon device does not have to be removed explicitly by the removal function.
> +
>  hwmon_device_unregister deregisters a registered hardware monitoring device.
>  The parameter of this function is the pointer to the registered hardware
>  monitoring device structure. This function must be called from the driver
>  remove function if the hardware monitoring device was registered with
> -hwmon_device_register or with hwmon_device_register_with_groups.
> +hwmon_device_register, hwmon_device_register_with_groups, or
> +hwmon_device_register_with_info.
>  
>  devm_hwmon_device_unregister does not normally have to be called. It is only
>  needed for error handling, and only needed if the driver probe fails after
> -the call to devm_hwmon_device_register_with_groups.
> +the call to devm_hwmon_device_register_with_groups and if the automatic
> +(device managed) removal would be too late.
> +
> +Using devm_hwmon_device_register_with_info()
> +--------------------------------------------
> +
> +hwmon_device_register_with_info() registers a hardware monitoring device.
> +The parameters to this function are
> +
> +struct device *dev	Pointer to parent device
> +const char *name	Device name
> +void *drvdata		Driver private data
> +const struct hwmon_chip_info *info
> +			Pointer to chip description.
> +const struct attribute_group **groups
> +			Null-terminated list of additional sysfs attribute
> +			groups.
> +
> +This function returns a pointer to the created hardware monitoring device
> +on success and a negative error code for failure.
> +
> +The hwmon_chip_info structure looks as follows.
> +
> +struct hwmon_chip_info {
> +	const struct hwmon_ops *ops;
> +	const struct hwmon_channel_info **info;
> +};
> +
> +It contains the following fields:
> +
> +* ops:	Pointer to device operations.
> +* info: NULL-terminated list of device channel descriptors.
> +
> +The list of hwmon operations is defined as:
> +
> +struct hwmon_ops {
> +	umode_t (*is_visible)(const void *, enum hwmon_sensor_types type,
> +			      u32 attr, int);
> +	int (*read)(struct device *, enum hwmon_sensor_types type,
> +		    u32 attr, int, long *);
> +	int (*write)(struct device *, enum hwmon_sensor_types type,
> +		     u32 attr, int, long);
> +};
> +
> +It defines the following operations.
> +
> +* is_visible: Pointer to a function to return the file mode for each supported
> +  attribute. This function is mandatory.
> +
> +* read: Pointer to a function for reading a value from the chip. This function
> +  is optional, but must be provided if any readable attributes exist.
> +
> +* write: Pointer to a function for writing a value to the chip. This function is
> +  optional, but must be priovided if any writeable attributes exist.
provided
> +
> +Each sensor channel is described with struct hwmon_channel_info, which is
> +defined as follows.
> +
> +struct hwmon_channel_info {
> +	enum hwmon_sensor_types type;
> +	u32 *config;
> +};
> +
> +It contains following fields:
> +
> +* type: The hardware monitoring sensor type.
> +  Supported sensor types are
> +  * hwmon_chip		A virtual sensor type, used to describe attributes
> +			which apply to the entire chip.
> +  * hwmon_temp		Temperature sensor
> +  * hwmon_in		Voltage sensor
> +  * hwmon_curr		Current sensor
> +  * hwmon_power		Power sensor
> +  * hwmon_energy	Energy sensor
> +  * hwmon_humidity	Humidity sensor
> +  * hwmon_fan		Fan speed sensor
> +
> +* config: Pointer to a 0-terminated list of configuration values for each
> +  sensor of the given type. Each value is a combination of bit values
> +  describing the attributes supposed by a single sensor.
> +
> +As an example, here is the complete description file for a LM75 compatible
> +sensor chip. The chip has a single temperature sensor. The driver wants to
> +register with the thermal subsystem (HWMON_C_REGISTER_TZ), and it supports
> +the update_interval attribute (HWMON_C_UPDATE_INTERVAL). The chip supports
> +reading the temperature (HWMON_T_INPUT), it has a maximum temperature
> +register (HWMON_T_MAX) as well as a maximum temperature hysteresis register
> +(HWMON_T_MAX_HYST).
> +
> +static const u32 lm75_chip_config[] = {
> +	HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL,
> +	0
> +};
> +
> +static const struct hwmon_channel_info lm75_chip = {
> +	.type = hwmon_chip,
> +	.config = lm75_chip_config,
> +};
> +
> +static const u32 lm75_temp_config[] = {
> +	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST,
> +	0
> +};
> +
> +static const struct hwmon_channel_info lm75_temp = {
> +	.type = hwmon_temp,
> +	.config = lm75_temp_config,
> +};
> +
> +static const struct hwmon_channel_info *lm75_info[] = {
> +	&lm75_chip,
> +	&lm75_temp,
> +	NULL
> +};
> +
> +static const struct hwmon_ops lm75_hwmon_ops = {
> +	.is_visible = lm75_is_visible,
> +	.read = lm75_read,
> +	.write = lm75_write,
> +};
> +
> +static const struct hwmon_chip_info lm75_chip_info = {
> +	.ops = &lm75_hwmon_ops,
> +	.info = lm75_info,
> +};
> +
> +A complete list of bit values indicating individual attribute support
> +is defined in include/linux/hwmon.h. Definition prefixes are as follows.
> +
> +HWMON_C_xxxx	Chip attributes, for use with hwmon_chip.
> +HWMON_T_xxxx	Temperature attributes, for use with hwmon_temp.
> +HWMON_I_xxxx	Voltage attributes, for use with hwmon_in.
> +HWMON_C_xxxx	Current attributes, for use with hwmon_curr.
> +		Notice the prefix overlap with chip attributes.
> +HWMON_P_xxxx	Power attributes, for use with hwmon_power.
> +HWMON_E_xxxx	Energy attributes, for use with hwmon_energy.
> +HWMON_H_xxxx	Humidity attributes, for use with hwmon_humidity.
> +HWMON_F_xxxx	Fan speed attributes, for use with hwmon_fan.
> +
> +Driver callback functions
> +-------------------------
> +
> +Each driver provides is_visible, read, and write functions. Parameters
> +and return values for those functions are as follows.
> +
> +umode_t is_visible_func(const void *data, enum hwmon_sensor_types type,
> +			u32 attr, int channel)
> +
> +Parameters:
> +	data:	Pointer to device private data structure.
> +	type:	The sensor type.
> +	attr:	Attribute identifier associated with a specific attribute.
> +		For example, the attribute value for HWMON_T_INPUT would be
> +		hwmon_temp_input. For complete mappings of bit fields to
> +		attribute values please see include/linux/hwmon.h.
> +	channel:The sensor channel number.
> +
> +Return value:
> +	The file mode for this attribute. Typically, this will be 0 (the
> +	attribute will not be created), S_IRUGO, or 'S_IRUGO | S_IWUSR'.
> +
> +int read_func(struct device *dev, enum hwmon_sensor_types type,
> +	      u32 attr, int channel, long *val)
> +
> +Parameters:
> +	dev:	Pointer to the hardware monitoring device.
> +	type:	The sensor type.
> +	attr:	Attribute identifier associated with a specific attribute.
> +		For example, the attribute value for HWMON_T_INPUT would be
> +		hwmon_temp_input. For complete mappings please see
> +		include/linux/hwmon.h.
> +	channel:The sensor channel number.
> +	val:	Pointer to attribute value.
> +
> +Return value:
> +	0 on success, a negative error number otherwise.
> +
> +int write_func(struct device *dev, enum hwmon_sensor_types type,
> +	       u32 attr, int channel, long val)
> +
> +Parameters:
> +	dev:	Pointer to the hardware monitoring device.
> +	type:	The sensor type.
> +	attr:	Attribute identifier associated with a specific attribute.
> +		For example, the attribute value for HWMON_T_INPUT would be
> +		hwmon_temp_input. For complete mappings please see
> +		include/linux/hwmon.h.
> +	channel:The sensor channel number.
> +	val:	The value to write to the chip.
> +
> +Return value:
> +	0 on success, a negative error number otherwise.
> +
> +
> +Driver-provided sysfs attributes
> +--------------------------------
> +
> +If the hardware monitoring device is registered with
> +hwmon_device_register_with_info or devm_hwmon_device_register_with_info,
> +it is most likely not necessary to provide sysfs atributes. Only non-standard
attributes
> +sysfs attributes need to be provided when one of those registration functions
> +is used.
>  
>  The header file linux/hwmon-sysfs.h provides a number of useful macros to
>  declare and use hardware monitoring sysfs attributes.
> 

