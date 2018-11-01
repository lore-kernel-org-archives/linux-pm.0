From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v6 4/6] power: supply: core: Add some helpers to use the
 battery OCV capacity table
Date: Thu, 1 Nov 2018 15:22:18 +0800
Message-ID: <CAMz4kuJm5eO1QwW7L+QyD_5VcTWqtq4gz9m_QDpQ-zn4zzukvQ@mail.gmail.com>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <f1529c567a340e4d31354a4b117954eeebf89942.1540189330.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f1529c567a340e4d31354a4b117954eeebf89942.1540189330.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, maxime.ripard@bootlin.com, Hans de Goede <hdegoede@redhat.com>, icenowy@aosc.io
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

On 29 October 2018 at 22:48, Quentin Schulz <quentin.schulz@bootlin.com> wrote:
> Hi all,
>
> Just chiming in, hopefully I got the message header fine as I don't have
> the original of the mail.
>
>>
>> We have introduced some battery properties to present the OCV table
>> temperatures and OCV capacity table values. Thus this patch add OCV
>> temperature and OCV table for battery information, as well as providing
>> some helper functions to use the OCV capacity table for users.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes from v5:
>>  - None.
>>
>> Changes from v4:
>>  - None.
>>
>> Changes from v3:
>>  - Split core modification into one separate patch.
>>  - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.
>>
>> Changes from v2:
>>  - Use type __be32 to calculate the table length.
>>  - Update error messages.
>>  - Add some helper functions.
>>
>> Changes from v1:
>>  - New patch in v2.
>> ---
>>  drivers/power/supply/power_supply_core.c |  123 +++++++++++++++++++++++++++++-
>>  include/linux/power_supply.h             |   19 +++++
>>  2 files changed, 141 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index 307e0995..58c4309 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -570,7 +570,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>  {
>>       struct device_node *battery_np;
>>       const char *value;
>> -     int err;
>> +     int err, len, index;
>
> index can be an unsigned int or even a u8 given the size of
> POWER_SUPPLY_OCV_TEMP_MAX which is the maximum allowed.

Sure.

>
>>
>>       info->energy_full_design_uwh         = -EINVAL;
>>       info->charge_full_design_uah         = -EINVAL;
>> @@ -581,6 +581,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>       info->constant_charge_voltage_max_uv = -EINVAL;
>>       info->factory_internal_resistance_uohm  = -EINVAL;
>>
>> +     for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
>> +             info->ocv_table[index]       = NULL;
>> +             info->ocv_temp[index]        = -EINVAL;
>> +             info->ocv_table_size[index]  = -EINVAL;
>> +     }
>> +
>>       if (!psy->of_node) {
>>               dev_warn(&psy->dev, "%s currently only supports devicetree\n",
>>                        __func__);
>> @@ -620,10 +626,125 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>       of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
>>                            &info->factory_internal_resistance_uohm);
>>
>> +     len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
>> +     if (len < 0 && len != -EINVAL) {
>
> You may want to separate the case for -EINVAL to display something at
> boot at least.

-EINVAL means we did not set the "ocv-capacity-celsius" property, then
we should not return errors, since the "ocv-capacity-celsius" property
is optional.

>
>> +             return len;
>> +     } else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
>> +             dev_err(&psy->dev, "Too many temperature values\n");
>> +             return -EINVAL;
>> +     } else if (len > 0) {
>> +             of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
>> +                                        info->ocv_temp, len);
>> +     }
>> +
>> +     for (index = 0; index < len; index++) {
>
> This won't work as intended as we can reach this part of the code with
> len = -EINVAL;

No, the condition (index < len) is false if len = -EINVAL, maybe one
reason keep index as 'int' type.

> If you had a separate condition for len == -EINVAL, you could reset len
> to 0 and bypass this loop for example.
>
>> +             struct power_supply_battery_ocv_table *table;
>> +             char *propname;
>> +             const __be32 *list;
>> +             int i, tab_len, size;
>> +
>> +             propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
>> +             list = of_get_property(battery_np, propname, &size);
>> +             if (!list || !size) {
>> +                     dev_err(&psy->dev, "failed to get %s\n", propname);
>> +                     kfree(propname);
>> +                     power_supply_put_battery_info(psy, info);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             kfree(propname);
>> +             tab_len = size / (2 * sizeof(__be32));
>> +             info->ocv_table_size[index] = tab_len;
>> +
>> +             table = info->ocv_table[index] =
>> +                     devm_kzalloc(&psy->dev, tab_len * sizeof(*table),
>> +                                  GFP_KERNEL);
>
> If you name `index` `j` or anything short enough, you can remove the
> temp variable table and not worry about the 80char limit.
>
> If I'm not mistaken, you should use devm_kzalloc_array here.

Sure.

>
>> +             if (!info->ocv_table[index]) {
>> +                     power_supply_put_battery_info(psy, info);
>> +                     return -ENOMEM;
>> +             }
>> +
>> +             for (i = 0; i < tab_len; i++) {
>> +                     table[i].ocv = be32_to_cpu(*list++);
>> +                     table[i].capacity = be32_to_cpu(*list++);
>
> Please check these are valid values.

Um, It is hard to validate the values for OCV and capacity, because
now we do not know each battery's parameters. Any good suggestion?

>
>> +             }
>> +     }
>> +
>>       return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
>>
>> +void power_supply_put_battery_info(struct power_supply *psy,
>> +                                struct power_supply_battery_info *info)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++)
>> +             kfree(info->ocv_table[i]);
>> +}
>> +EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
>> +
>
> Do we really need this? Won't this mess with the reference used by the
> devm_ function?

Yes, I should change to use devm_kfree().

>
> What is the use case for letting a user call this function? I can
> understand you want to delete the arrays if they're invalid in the
> get_function, which could be done thanks to a goto statement or with
> this function if you really want (if it does not mess with refs) but I
> don't see why you want to export this function.

Cause some drivers will copy the OCV tables into their own structures,
one helper function to help to free memory of battery information. In
future, this can be expanded to clean up more resources of battery
information.

>> +int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
>> +                             int table_len, int ocv)
>> +{
>> +     int i, cap, tmp;
>> +
>> +     for (i = 0; i < table_len; i++)
>> +             if (ocv > table[i].ocv)
>> +                     break;
>> +
>
> It is NOT stated in the DT binding that you want the array to be ordered
> AND ordered descending. You should fix that either in the DT binding or
> here.

Sure. Will add some function description for this simple helper.

>
>> +     if (i > 0 && i < table_len) {
>> +             tmp = (table[i - 1].capacity - table[i].capacity) *
>> +                     (ocv - table[i].ocv);
>> +             tmp /= table[i - 1].ocv - table[i].ocv;
>> +             cap = tmp + table[i].capacity;
>> +     } else if (i == 0) {
>> +             cap = table[0].capacity;
>> +     } else {
>> +             cap = table[table_len - 1].capacity;
>> +     }
>> +
>> +     return cap;
>> +}
>> +EXPORT_SYMBOL_GPL(power_supply_ocv2cap_simple);
>> +
>> +struct power_supply_battery_ocv_table *
>> +power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
>> +                             int temp, int *table_len)
>> +{
>> +     int best_temp_diff = INT_MAX, best_index = 0, temp_diff, i;
>> +
>
> i and best index can be unsigned (and even a u8).

Sure.

>
>> +     if (!info->ocv_table[0])
>> +             return NULL;
>> +
>> +     for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
>> +             temp_diff = abs(info->ocv_temp[i] - temp);
>> +
>> +             if (temp_diff < best_temp_diff) {
>> +                     best_temp_diff = temp_diff;
>> +                     best_index = i;
>> +             }
>> +     }
>> +
>> +     *table_len = info->ocv_table_size[best_index];
>> +     return info->ocv_table[best_index];
>> +}
>> +EXPORT_SYMBOL_GPL(power_supply_find_ocv2cap_table);
>> +
>> +int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
>> +                              int ocv, int temp)
>> +{
>> +     struct power_supply_battery_ocv_table *table;
>> +     int table_len;
>> +
>> +     table = power_supply_find_ocv2cap_table(info, temp, &table_len);
>> +     if (!table)
>> +             return -EINVAL;
>> +
>> +     return power_supply_ocv2cap_simple(table, table_len, ocv);
>> +}
>> +EXPORT_SYMBOL_GPL(power_supply_batinfo_ocv2cap);
>> +
>>  int power_supply_get_property(struct power_supply *psy,
>>                           enum power_supply_property psp,
>>                           union power_supply_propval *val)
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index d089566..84fe93f 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -309,6 +309,13 @@ struct power_supply_info {
>>       int use_for_apm;
>>  };
>>
>> +struct power_supply_battery_ocv_table {
>> +     int ocv;        /* microVolts */
>> +     int capacity;   /* percent */
>> +};
>> +
>> +#define POWER_SUPPLY_OCV_TEMP_MAX 20
>> +
>
> Why limiting to 20? What if I want something more precise?

We have not so much temperature values until now, so I think 20 can be
covered most cases. If you need more precise temperature values, then
I think we can expand the number.
Hint, the number 20 is for temperature values, each temperature can
have one corresponding OCV table, please see the dt-bindings.
https://lore.kernel.org/patchwork/patch/1002350/

>
> That's it for my review of this patch.
>
> Thanks for the patch, I'm sure many people are interested by this
> feature!

Thanks for your comments.

>
> [...]
>
> I would like to give my specific use case of the OCV on X-Powers PMICs
> so that hopefully we can get things sorted out before it's too late to
> make modifications that might be needed.
>
> I'm adding a few people on Cc that work on the X-Power PMICs so that
> hopefully we can have all the correct pieces of information and go
> towards the right solution.
>
> In the AXP818/AXP288 datasheet[1] (p.57), we have access to OCV values
> and battery RDC register.
>
> The hardware learns from the battery or from the given OCV and RDC
> values and then updates the returned battery capacity accordingly (in
> another register).
> I've 32 values (see the issue with a max of 20 values?) to be written in

I think you misunderstood the 20, it is means we can have max 20 OCV tables now.

> different registers that represent the battery capacity at a given
> voltage. I do not have to do any computation on the kernel side, I just
> have to set the registers with the correct values and the battery
> capacity will be auto-updated by the PMIC. With this patch series,
> should I just call power_supply_get_battery_info, get the OCV tables and

I think so.

> do my thing in the driver? Could we have a more generic way to do it
> (does it make sense to have a generic one?)?

Sorry, maybe I did not follow you here. You said your hardware will
help to get the capacity automatically if you set the register, so
what generic way you want to introduce? Could you elaborate on?

>
> We also definitely need a sysfs entry so that the user can enter the new
> values of the RDC/OCV since it changes during the life cycle of the
> battery IIRC.

Why it changed? Due to different temperatures or other factors? If the
factor is temperature, I think we have supplied one generic way:
https://lore.kernel.org/patchwork/patch/1002350/

>
> I already know of the POWER_SUPPLY_PROP_VOLTAGE_OCV property but it
> doesn't seem to be very appropriate as of today.
>
> Other PMICs from X-Powers have more or less the same mechanism according
> to the BSP even though it's not documented anywhere.
>
> Is everything clear enough? What are your thoughts?
>
> Thanks,
> Quentin
>
> [1] http://linux-sunxi.org/images/7/73/AXP818_datasheet_Revision1.0.pdf



-- 
Baolin Wang
Best Regards
