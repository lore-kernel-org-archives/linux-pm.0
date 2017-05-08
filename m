From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v13 08/11] power: supply: bq27xxx_battery: Add
 power_supply_battery_info support
Date: Mon, 8 May 2017 14:50:44 -0500
Message-ID: <e0df1cd5-8496-590d-90ff-dd95a3601b05@ti.com>
References: <20170504061811.18107-1-liam@networkimprov.net>
 <20170504061811.18107-9-liam@networkimprov.net>
 <f0121e38-9159-2bb4-26ca-1a4a72ba6ace@ti.com>
 <CAKvHMgSWCW5g3L2PtEa6Yg_LWRU_ByDDO_NVJqQqzvoHgXO=GQ@mail.gmail.com>
 <CAKvHMgS6XtrJDWgq=J_dnOBYUXLWG-zwBOaa3FHybEfkCDicvA@mail.gmail.com>
 <d1d93ce1-5c6c-ada8-2917-a9d592a9e1cd@ti.com>
 <CAKvHMgQ_1VL29u2Z1E63ekHdha22coaCBNSCccUgBLzVE6LvMw@mail.gmail.com>
 <f941faae-efa8-5e86-e7e6-8ab97755d238@ti.com>
 <CAKvHMgQHjXM_sY4s7SQbZYNxQFqQNMukgR4DG2zKn-1Szifc1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:35863 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754862AbdEHTuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 15:50:50 -0400
In-Reply-To: <CAKvHMgQHjXM_sY4s7SQbZYNxQFqQNMukgR4DG2zKn-1Szifc1A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On 05/08/2017 02:31 PM, Liam Breck wrote:
> On Mon, May 8, 2017 at 11:42 AM, Andrew F. Davis <afd@ti.com> wrote:
>> On 05/08/2017 01:39 PM, Liam Breck wrote:
>>> On Mon, May 8, 2017 at 7:54 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>> On 05/08/2017 01:16 AM, Liam Breck wrote:
>>>>> On Thu, May 4, 2017 at 11:40 AM, Liam Breck <liam@networkimprov.net> wrote:
>>>>>> On Thu, May 4, 2017 at 9:52 AM, Andrew F. Davis <afd@ti.com> wrote:
>>>>>>> On 05/04/2017 01:18 AM, Liam Breck wrote:
>>>>>>>> From: Liam Breck <kernel@networkimprov.net>
>>>>>>>>
>>>>>>>> Previously there was no way to configure these chips in the event that the
>>>>>>>> defaults didn't match the battery in question.
>>>>>>>>
>>>>>>>> For chips with RAM data memory (and also those with flash/NVM data memory
>>>>>>>> if CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is defined and the user has not
>>>>>>>> set module param dt_monitored_battery_updates_nvm=0) we now call
>>>>>>>> power_supply_get_battery_info(), check its values, and write battery
>>>>>>>> properties to chip data memory if there is a dm_regs table for the chip.
>>>>>>>>
>>>>>>>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>>>>>>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>>>>>>> ---
>>>>>>>>  drivers/power/supply/Kconfig           |   9 ++
>>>>>>>>  drivers/power/supply/bq27xxx_battery.c | 199 ++++++++++++++++++++++++++++++++-
>>>>>>>>  include/linux/power/bq27xxx_battery.h  |   2 +
>>>>>>>>  3 files changed, 209 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
>>>>>>>> index 76806a0..85e2fb2 100644
>>>>>>>> --- a/drivers/power/supply/Kconfig
>>>>>>>> +++ b/drivers/power/supply/Kconfig
>>>>>>>> @@ -178,6 +178,15 @@ config BATTERY_BQ27XXX_I2C
>>>>>>>>         Say Y here to enable support for batteries with BQ27xxx chips
>>>>>>>>         connected over an I2C bus.
>>>>>>>>
>>>>>>>> +config BATTERY_BQ27XXX_DT_UPDATES_NVM
>>>>>>>> +     bool "BQ27xxx support for update of NVM/flash data memory"
>>>>>>>> +     depends on BATTERY_BQ27XXX_I2C
>>>>>>>> +     help
>>>>>>>> +       Say Y here to enable devicetree monitored-battery config to update
>>>>>>>> +       NVM/flash data memory. Only enable this option for devices with a
>>>>>>>> +       fuel gauge mounted on the circuit board, and a battery that cannot
>>>>>>>> +       be replaced with one of a different type.
>>>>>>>> +
>>>>>>>>  config BATTERY_DA9030
>>>>>>>>       tristate "DA9030 battery driver"
>>>>>>>>       depends on PMIC_DA903X
>>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>> index 8ab184c..06f15da 100644
>>>>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>>>>> @@ -805,6 +805,13 @@ static LIST_HEAD(bq27xxx_battery_devices);
>>>>>>>>
>>>>>>>>  #define BQ27XXX_DM_SZ        32
>>>>>>>>
>>>>>>>> +struct bq27xxx_dm_reg {
>>>>>>>> +     u8 subclass_id;
>>>>>>>> +     u8 offset;
>>>>>>>> +     u8 bytes;
>>>>>>>> +     u16 min, max;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>  /**
>>>>>>>>   * struct bq27xxx_dm_buf - chip data memory buffer
>>>>>>>>   * @class: data memory subclass_id
>>>>>>>> @@ -822,6 +829,43 @@ struct bq27xxx_dm_buf {
>>>>>>>>       bool has_data, dirty;
>>>>>>>>  };
>>>>>>>>
>>>>>>>> +#define BQ27XXX_DM_BUF(di, i) { \
>>>>>>>> +     .class = (di)->dm_regs[i].subclass_id, \
>>>>>>>> +     .block = (di)->dm_regs[i].offset / BQ27XXX_DM_SZ, \
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static inline u16 *bq27xxx_dm_reg_ptr(struct bq27xxx_dm_buf *buf,
>>>>>>>> +                                   struct bq27xxx_dm_reg *reg)
>>>>>>>> +{
>>>>>>>> +     if (buf->class == reg->subclass_id &&
>>>>>>>> +         buf->block == reg->offset / BQ27XXX_DM_SZ)
>>>>>>>> +             return (u16 *) (buf->data + reg->offset % BQ27XXX_DM_SZ);
>>>>>>>> +
>>>>>>>> +     return NULL;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +enum bq27xxx_dm_reg_id {
>>>>>>>> +     BQ27XXX_DM_DESIGN_CAPACITY = 0,
>>>>>>>> +     BQ27XXX_DM_DESIGN_ENERGY,
>>>>>>>> +     BQ27XXX_DM_TERMINATE_VOLTAGE,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static const char * const bq27xxx_dm_reg_name[] = {
>>>>>>>> +     [BQ27XXX_DM_DESIGN_CAPACITY] = "design-capacity",
>>>>>>>> +     [BQ27XXX_DM_DESIGN_ENERGY] = "design-energy",
>>>>>>>> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] = "terminate-voltage",
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM
>>>>>>>> +static bool bq27xxx_dt_to_nvm = true;
>>>>>>>> +
>>>>>>>> +module_param_named(dt_monitored_battery_updates_nvm, bq27xxx_dt_to_nvm, bool, 0444);
>>>>>>>> +MODULE_PARM_DESC(dt_monitored_battery_updates_nvm,
>>>>>>>> +     "Devicetree monitored-battery config updates NVM/flash data memory, if present. Default is 1/y.");
>>>>>>>
>>>>>>> As before, the default should not be y, this is a rare case and I can't
>>>>>>> see it being useful or wanted by anyone but device manufacturers. I
>>>>>>> don't want everyones chip's factory programmed NVM overwritten by
>>>>>>> accident when someone compiles and ships a kernel with
>>>>>>> BATTERY_BQ27XXX_DT_UPDATES_NVM=y
>>>>>>
>>>>>> Right, the point of the config option is to let a device vendor ship a
>>>>>> kernel + dtb which can field-upgrade NVM. (Setting the option does
>>>>>> nothing absent the necessary dtb.)
>>>>>>
>>>>>> Module params are for end-user config; we can't require a device
>>>>>> vendor to ship /etc/modprobe.d/xyz. And we certainly don't want a
>>>>>> kernel package update to defeat the end-user config of
>>>>>> dt_monitored_battery_updates_nvm=0 !!
>>>>>>
>>>>>> I believe Sebastian agrees, given that he queued this patch :-)
>>>>>
>>>>> I clarified the rationale for module param default =1 above; could you ack?
>>>>>
>>>>> That prevents this scenario:
>>>>> 1) user changes battery type, sets dt_monitored_battery_updates_nvm=0
>>>>> 2) vendor ships kernel package with dtb update and
>>>>> dt_monitored_battery_updates_nvm=1
>>>>> 3) gauge stops working correctly
>>>>>
>>>>
>>>> Leaving it =1 will encourage this situation, not prevent it. Updating
>>>> NVM is a non-standard operation for these parts. It should only be done
>>>> once ideally. It is nice being able to update the NVM, and we have
>>>> user-space tools for this, but this is a dangerous operation, improperly
>>>> programming can brick the chip, as you have found out.
>>>>
>>>> If you want to add this function into the kernel driver that is fine,
>>>> but you *cannot* have this be the default, it needs to be a hidden away
>>>> option for people who know what they are doing, else you will end up
>>>> accidentally causing damage to countless users' hardware.
>>>
>>> I don't think you followed my logic.... It *is* hidden behind a
>>> dedicated kernel config option which only device vendors (and
>>> tinkerers :-) would use. A kernel package with that option and
>>> suitable dtb has to perform the update without manipulation of the
>>> module param. The module param is to let the user prevent any future
>>> update by such a kernel package, since only he knows that he changed
>>> the battery type.
>>>
>>> What is your evidence for the assertion of "encourage this situation"?
>>>
>>
>> It is the default value, what more evidence do you want? Someone should
>> have to enable the functionality in Kconfig *and* enable it as a
>> module_param. Leaving either on by default will cause it to be
>> accidentally left enabled.
> 
> We could add a second config option to eliminate the possibility of
> the first one being set by mistake.
> 
> You can't trivially enable a config option. If you set it, you'd
> obviously set the module param if that were necessary, so that's no
> extra protection against "accidentally left enabled". (And the config
> option does nothing without a suitable dtb.)
> 

Why would you "obviously set the module param"? If this config option is
enabled then you still have to set the module param to make this write
to your device's NVM, that is two things vs one. The people who use
kernels often don't build them. Both should need to be set to update the
devices NVM.

> My scenario is a clear and likely threat. You haven't described a
> threat scenario.
> 

Easy, kernel is built with the config option enabled and their DT has
invalid option for their battery. Now everyone bricks their hardware.

Vs. your three step situation that the two people who will ever use this
will never actually find themselves in, that results in a minor
inconvenience as they have to turn a module param back off.

Lets take the safe route and leave this default off.

> The docs for the config option describe its correct use, and I will
> mention the risk of overwriting a smart battery. No general purpose
> distro will enable it.
> 

How can you know this, I'm pretty sure Ubuntu ships with a randconfig
kernel :)
