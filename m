From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 12/15] i2c: core: Add new i2c_acpi_new_device helper
 function
Date: Wed, 22 Mar 2017 16:59:17 +0100
Message-ID: <5a03b65d-6c33-5a1f-abdc-86608943b798@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <20170317095527.10487-13-hdegoede@redhat.com>
 <1489772231.19767.78.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1489772231.19767.78.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 17-03-17 18:37, Andy Shevchenko wrote:
> On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
>> By default the i2c subsys creates an i2c-client for the first
>> I2cSerialBus
>> resource of an acpi_device, but some acpi_devices have multiple
>> I2cSerialBus resources and the driver may need access to the others.
>>
>> This commit adds a new i2c_acpi_new_device function which can be used
>> by
>> drivers to create an i2c-client for any (other) I2cSerialBus resource
>> of
>> an acpi_device.
>>
>> Note that the other resources may even be on a different i2c bus, so
>> just
>> retrieving the client address is not enough.
>>
>
> Looks sane to me:
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Nevertheless, one nit, can you update commit message with real excerpt
> of DSDT?

Sure, will do for v2.

Regards,

Hans


>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/i2c/i2c-core.c | 48
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/i2c.h    |  5 +++++
>>  2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 32b58fb..fd45207 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -421,6 +421,54 @@ static int i2c_acpi_notify(struct notifier_block
>> *nb, unsigned long value,
>>  static struct notifier_block i2c_acpi_notifier = {
>>  	.notifier_call = i2c_acpi_notify,
>>  };
>> +
>> +/**
>> + * i2c_acpi_new_device - Create i2c client for the Nth acpi resource
>> of dev
>> + * @dev:     Device owning the acpi resources to get the client from
>> + * @index:   Index of acpi resource to get
>> + *
>> + * By default the i2c subsys creates an i2c-client for the first
>> I2cSerialBus
>> + * resource of an acpi_device, but some acpi_devices have multiple
>> + * I2cSerialBus resources and the driver may need access to the
>> others.
>> + * This function can be used by drivers to create an i2c-client for
>> any
>> + * resource of an acpi_device.
>> + *
>> + * Returns a pointer to the new i2c-client, or NULL if the resource
>> or
>> + * adapter were not found.
>> + */
>> +struct i2c_client *i2c_acpi_new_device(struct device *dev, int index)
>> +{
>> +	struct i2c_acpi_lookup lookup;
>> +	struct i2c_board_info info;
>> +	struct i2c_adapter *adapter;
>> +	struct acpi_device *adev;
>> +	LIST_HEAD(resource_list);
>> +	int ret;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return NULL;
>> +
>> +	memset(&info, 0, sizeof(info));
>> +	memset(&lookup, 0, sizeof(lookup));
>> +	lookup.info = &info;
>> +	lookup.device_handle = acpi_device_handle(adev);
>> +	lookup.index = index;
>> +
>> +	ret = acpi_dev_get_resources(adev, &resource_list,
>> +				     i2c_acpi_fill_info, &lookup);
>> +	acpi_dev_free_resource_list(&resource_list);
>> +
>> +	if (ret < 0 || !info.addr)
>> +		return NULL;
>> +
>> +	adapter =
>> i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
>> +	if (!adapter)
>> +		return NULL;
>> +
>> +	return i2c_new_device(adapter, &info);
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
>>  #else /* CONFIG_ACPI */
>>  static inline void i2c_acpi_register_devices(struct i2c_adapter
>> *adap) { }
>>  extern struct notifier_block i2c_acpi_notifier;
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index 6b18352..369ebfa 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -824,11 +824,16 @@ static inline const struct of_device_id
>>
>>  #if IS_ENABLED(CONFIG_ACPI)
>>  u32 i2c_acpi_find_bus_speed(struct device *dev);
>> +struct i2c_client *i2c_acpi_new_device(struct device *dev, int
>> index);
>>  #else
>>  static inline u32 i2c_acpi_find_bus_speed(struct device *dev)
>>  {
>>  	return 0;
>>  }
>> +static inline struct i2c_client *i2c_acpi_new_device(struct device
>> *d, int i)
>> +{
>> +	return NULL;
>> +}
>>  #endif /* CONFIG_ACPI */
>>
>>  #endif /* _LINUX_I2C_H */
>
