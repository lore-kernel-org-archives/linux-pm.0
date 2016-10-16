From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/9] hwmon: (core) New hwmon registration API
Date: Sun, 16 Oct 2016 11:20:21 -0700
Message-ID: <a3b080a0-c929-7e72-3540-e49991512be5@roeck-us.net>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
 <1469417552-9749-3-git-send-email-linux@roeck-us.net>
 <1475570759.3052.22.camel@chaos.suse> <20161004193713.GA26304@roeck-us.net>
 <20161007143213.0ba633fe@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20161007143213.0ba633fe@endymion>
Sender: linux-hwmon-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jean,

On 10/07/2016 05:32 AM, Jean Delvare wrote:
[ ... ]
>
>>>> +		name = (char *)template;
>>>> +	} else {
>>>> +		name = devm_kzalloc(dev, strlen(template) + 16, GFP_KERNEL);
>>>> +		if (!name)
>>>> +			return ERR_PTR(-ENOMEM);
>>>> +		scnprintf(name, strlen(template) + 16, template,
>>>> +			  index + hwmon_attr_base(type));
>>>> +	}
>>>> +
>>>> +	hattr = devm_kzalloc(dev, sizeof(*hattr), GFP_KERNEL);
>>>> +	if (!hattr)
>>>> +		return ERR_PTR(-ENOMEM);
>>>
>>> So basically you are doing 1 or 2 memory allocations for every
>>> attribute? Looks quite bad from a memory fragmentation
>>> perspective :-( Not to mention performance. Given that you have all the
>>> data at hand before you start, can't you preallocate an array with the
>>> right number of hattr and pick from it? That would at least solve half
>>> of the problem.
>
> FTR I took a quick look at the iio code and there seems to be something
> like the idea above implemented in iio_device_register_sysfs(). But
> attributes themselves as instantiated by iio_device_register_sysfs()
> are still allocated individually. But hey I'm not familiar with the iio
> code anyway, I'm sure you know it better than I do.
>
>>> Something similar for string allocation may work too, although it's
>>> somewhat more complex due to the variable length. But I think the
>>> abituguru3 driver is doing it right, so maybe you can too.
>>
>> I'll look into it.
>

Merging name allocation and hattr allocation turned out to be easy by adding
the name to struct hwmon_device_attribute. However, allocating an array of
struct hwmon_device_attribute for all attributes in one go is more difficult.
Main issue is that we _don't_ really know how many attributes are going to be
created; we only know the ceiling, which is calculated in __hwmon_create_attrs().
That number is currently used to allocate the array of attributes. The extra
pointers did not seem that important there (to me). However, allocating an
array of struct hwmon_device_attribute would result in memory being allocated
for non-existing attributes as well (ie those for which is_visible returns 0),
and that would at least potentially be much more. We can either accept that,
or I would have to implement a second pass over the attributes to determine
how many are actually implemented, or we could leave the per-attribute
allocation unchanged.

Thoughts ?

Thanks,
Guenter

