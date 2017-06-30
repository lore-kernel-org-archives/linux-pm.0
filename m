From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Fri, 30 Jun 2017 14:49:51 +0200
Message-ID: <d9f36a46-e082-54bb-55be-5016e428c62c@redhat.com>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
 <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdF3Mt5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Jun 2017 08:49:57 -0400
In-Reply-To: <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On 29-06-17 16:22, Andy Shevchenko wrote:
> +Cc: Hans (he might give some advice regarding to the below)

Thank you for the Cc, so here we have the opposite situation as
with the devices with the AXP288 PMIC and the Cherry Trail
Whiskey Cove PMIC combined with the TI bq24292i charger and max17042
fuel-gauge. In those cases we have well working native drivers
for the used chips and we don't know the API of the custom ACPI
OpRegion the ACPI battery and ac interface implementing ACPI nodes
want. So for these devices we've disabled the ACPI battery and
ac drivers and are using power_supply drivers for the used chips
directly.

Here we've a similar setup where the ACPI nodes implementing the
ACPI battery and ac interfaces require a custom OpRegion, but
Benjamin has more or less figured out what the expected Opregion
API is (and implemented it) and we do not know which chips are
actually used.

Judging from the above I believe that implementing the ACPI
OpRegion support for the MSHW0011 devices is a good solution
in this case.

> On Thu, Jun 29, 2017 at 3:10 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> MSHW0011 replaces the battery firmware by using ACPI operation regions.
>> The values have been obtained by reverse engineering, and are subject to
>> errors. Looks like it works on overall pretty well.

<snip>

>> +/*
>> + * Further findings regarding the 2 chips declared in the MSHW0011 are:
>> + * - there are 2 chips declared:
>> + *   . 0x22 seems to control the ADP1 line status (and probably the charger)
>> + *   . 0x55 controls the battery directly
>> + * - the battery chip uses a SMBus protocol (using plain SMBus allows non
>> + *   destructive commands):
>> + *   . the commands/registers used are in the range 0x00..0x7F
>> + *   . if bit 8 (0x80) is set in the SMBus command, the returned value is the
>> + *     same as when it is not set. There is a high chance this bit is the
>> + *     read/write
>> + *   . the various registers semantic as been deduced by observing the register
>> + *     dumps.
> 
> All of this sounds familiar if look at what Hans discovered while was
> doing INT33FE support.
> Hans, does above ring any bell to you?

Familiar yes, but I actually already looked at this rev-eng driver while working
on my INT33FE support and it is for different chips, and I don't know for
which models exactly.

<snip>

>> +static int acpi_find_i2c(struct acpi_resource *ares, void *data)
>> +{
>> +       struct mshw0011_lookup *lookup = data;
>> +
>> +       if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
>> +               return 1;
>> +
>> +       if (lookup->n++ == lookup->index && !lookup->addr)
>> +               lookup->addr = ares->data.i2c_serial_bus.slave_address;
>> +
>> +       return 1;
>> +}
>> +
>> +static int mshw0011_i2c_resource_lookup(struct mshw0011_data *cdata,
>> +                                       unsigned int index)
>> +{
>> +       struct i2c_client *client = cdata->adp1;
>> +       struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>> +       struct mshw0011_lookup lookup = {
>> +               .cdata = cdata,
>> +               .index = index,
>> +       };
>> +       struct list_head res_list;
>> +       int ret;
>> +
>> +       INIT_LIST_HEAD(&res_list);
>> +
>> +       ret = acpi_dev_get_resources(adev, &res_list, acpi_find_i2c, &lookup);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       acpi_dev_free_resource_list(&res_list);
>> +
>> +       if (!lookup.addr)
>> +               return -ENOENT;
>> +
>> +       return lookup.addr;
>> +}
> 
> Strange you have above functions here. It's a copy paste from I2C > core. Please, think about way of deduplicating it.

Right, this is something I can actually help with. When implementing the
INT33FE support (*) I also was dealing with an ACPI node with more then 1
I2cSerialBus type resource and I needed not just an i2c-client for the
first one (which the i2c-core gives us) but also for the others.

In 4.12 there is an i2c_acpi_new_device function which you can use
to create an i2c-client for the second i2c address you want to communicate
with, here is an example usage:

struct i2c_board_info board_info;

memset(&board_info, 0, sizeof(board_info));
strlcpy(board_info.type, "MSHW0011-bat0", I2C_NAME_SIZE);
bat0 = i2c_acpi_new_device(dev, 1, &board_info);

And then you can use bat0 to communicate to the other address,
as before, while dropping a whole bunch of copy-pasted code :)

Regards,

Hans



*) Well an implementation of INT33FE support really since there seem to be many
different INT33FE devices, each one for a different charger / fuel-gauge combi
and you can only differentiate which one you're actually dealing with by
checking the PTYPE APCI Object and my implementation only supports PTYPE 4
