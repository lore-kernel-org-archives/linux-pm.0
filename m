From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Fri, 30 Jun 2017 19:37:34 +0200
Message-ID: <7d8201bf-b05e-6235-7eb0-54b1a393f99f@redhat.com>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
 <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
 <20170630155706.GL26073@mail.corp.redhat.com>
 <CAHp75VdLU57x2YuDH+SkB1jR3rSpqcVNszhq5fDUVZZt+sqxyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdLU57x2YuDH+SkB1jR3rSpqcVNszhq5fDUVZZt+sqxyQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 30-06-17 18:37, Andy Shevchenko wrote:
> On Fri, Jun 30, 2017 at 6:57 PM, Benjamin Tissoires

<snip>

>>>> +static const struct i2c_device_id mshw0011_id[] = {
>>>> +       { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(i2c, mshw0011_id);
>>>
>>> ->probe_new(), please.
>>
>> Correct
>>
>>>
>>> If I2C framework is _still_ broken we need to fix that part.
>>
>> I haven't check, so let's see for v3.
> 
> Cc: Wolfram for v3 and ask him directly. Last time I checked it looks
> like I2C core doesn't care about ACPI when ->probe_new() is used.

ACPI i2c drivers still need an empty i2c_device_id table I've
fixing this on my TODO but it has been buried in other stuff.

Benjamin if (not saying you should, but if) you want to take a look at
this, fixing the need for the empty table for ACPI devices should be
easy. The problem is these lines in drivers/i2c/i2c-core.c:
i2c_device_probe():

         /*
          * An I2C ID table is not mandatory, if and only if, a suitable Device
          * Tree match table entry is supplied for the probing device.
          */
         if (!driver->id_table &&
             !i2c_of_match_device(dev->driver->of_match_table, client))
                 return -ENODEV;

Which needs to be extended to also check for an ACPI match AFAIK
you can NOT just replace this with i2c_device_match because that would
break manually binding a driver through sysfs.

Regards,

Hans

