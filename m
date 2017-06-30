From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Fri, 30 Jun 2017 17:43:47 +0200
Message-ID: <f0feab26-a71f-522c-9a54-9e6ac03878a7@redhat.com>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
 <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
 <d9f36a46-e082-54bb-55be-5016e428c62c@redhat.com>
 <20170630152645.GK26073@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170630152645.GK26073@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 30-06-17 17:26, Benjamin Tissoires wrote:
> On Jun 30 2017 or thereabouts, Hans de Goede wrote:

<snip>

>>>> +static int mshw0011_i2c_resource_lookup(struct mshw0011_data *cdata,
>>>> +                                       unsigned int index)
>>>> +{
>>>> +       struct i2c_client *client = cdata->adp1;
>>>> +       struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>>>> +       struct mshw0011_lookup lookup = {
>>>> +               .cdata = cdata,
>>>> +               .index = index,
>>>> +       };
>>>> +       struct list_head res_list;
>>>> +       int ret;
>>>> +
>>>> +       INIT_LIST_HEAD(&res_list);
>>>> +
>>>> +       ret = acpi_dev_get_resources(adev, &res_list, acpi_find_i2c, &lookup);
>>>> +       if (ret < 0)
>>>> +               return ret;
>>>> +
>>>> +       acpi_dev_free_resource_list(&res_list);
>>>> +
>>>> +       if (!lookup.addr)
>>>> +               return -ENOENT;
>>>> +
>>>> +       return lookup.addr;
>>>> +}
>>>
>>> Strange you have above functions here. It's a copy paste from I2C > core. Please, think about way of deduplicating it.
>>
>> Right, this is something I can actually help with. When implementing the
>> INT33FE support (*) I also was dealing with an ACPI node with more then 1
>> I2cSerialBus type resource and I needed not just an i2c-client for the
>> first one (which the i2c-core gives us) but also for the others.
>>
>> In 4.12 there is an i2c_acpi_new_device function which you can use
>> to create an i2c-client for the second i2c address you want to communicate
>> with, here is an example usage:
>>
>> struct i2c_board_info board_info;
>>
>> memset(&board_info, 0, sizeof(board_info));
>> strlcpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
>> bat0 = i2c_acpi_new_device(dev, 1, &board_info);
>>
>> And then you can use bat0 to communicate to the other address,
>> as before, while dropping a whole bunch of copy-pasted code :)
> 
> Thanks for the tip. I wrote this code more than a year ago IIRC, and
> there might not be those facilities at the time.

Correct I hit the same problem with the INT33FE device and decided
to fix this properly :)  The i2c_acpi_new_device function is new
in 4.12 .

Regards,

Hans

