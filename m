From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 2/4] power: supply: core: Introduce properties to
 present the battery OCV table
Date: Thu, 27 Sep 2018 09:10:05 +0800
Message-ID: <CAMz4kuK0PGonikK=pH50p=7NFXZHRuMZ+Aq9ZYT+8q8giKZCAQ@mail.gmail.com>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <b78ff03ecd251b63430f05b505e02b19e196364e.1537930252.git.baolin.wang@linaro.org>
 <20180926135150.fla2r4ilfco3atws@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926135150.fla2r4ilfco3atws@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 26 September 2018 at 21:51, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Sep 26, 2018 at 10:59:12AM +0800, Baolin Wang wrote:
>> Some battery driver will use the open circuit voltage (OCV) value to look
>> up the corresponding battery capacity percent in one certain degree Celsius.
>> Thus this patch provides some battery properties to present the OCV table
>> temperatures and OCV capacity table values.
>>
>> Suggested-by: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v1:
>>  - New patch in v2.
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   |   14 +++++
>>  drivers/power/supply/power_supply_core.c           |   63 +++++++++++++++++++-
>>  include/linux/power_supply.h                       |   11 ++++
>>  3 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> index 25b9d2e..ac2b303 100644
>> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -23,6 +23,16 @@ Optional Properties:
>>   - constant-charge-current-max-microamp: maximum constant input current
>>   - constant-charge-voltage-max-microvolt: maximum constant input voltage
>>   - internal-resistance-micro-ohms: battery internal resistance
>> + - ocv-capacity-table-0: An array providing the battery capacity percent
>> +   with corresponding open circuit voltage (OCV) of the battery, which
>> +   is used to look up battery capacity according to current OCV value.
>> + - ocv-capacity-table-1: Same as ocv-capacity-table-0
>> + ......
>> + - ocv-capacity-table-n: Same as ocv-capacity-table-0
>> + - ocv-capacity-table-temperatures: An array containing the temperature
>> +   in degree Celsius, for each of the battery capacity lookup table.
>> +   The first temperature value specifies the OCV table 0, and the second
>> +   temperature value specifies the OCV table 1, and so on.
>>
>>  Battery properties are named, where possible, for the corresponding
>>  elements in enum power_supply_property, defined in
>> @@ -44,6 +54,10 @@ Example:
>>               constant-charge-current-max-microamp = <900000>;
>>               constant-charge-voltage-max-microvolt = <4200000>;
>>               internal-resistance-micro-ohms = <250000>;
>> +             ocv-capacity-table-temperatures = <(-10) 0 10>;
>> +             ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
>> +             ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
>> +             ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
>>       };
>>
>>       charger: charger@11 {
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index 9f3452f..151ff03 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -570,7 +570,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>  {
>>       struct device_node *battery_np;
>>       const char *value;
>> -     int err;
>> +     int err, len, index;
>>
>>       info->energy_full_design_uwh         = -EINVAL;
>>       info->charge_full_design_uah         = -EINVAL;
>> @@ -581,6 +581,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>       info->constant_charge_voltage_max_uv = -EINVAL;
>>       info->internal_resistance_uohm       = -EINVAL;
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
>> @@ -620,10 +626,65 @@ int power_supply_get_battery_info(struct power_supply *psy,
>>       of_property_read_u32(battery_np, "internal-resistance-micro-ohms",
>>                            &info->internal_resistance_uohm);
>>
>> +     len = of_property_count_u32_elems(battery_np,
>> +                                       "ocv-capacity-table-temperatures");
>> +     if (len < 0 && len != -EINVAL) {
>> +             return len;
>> +     } else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
>> +             dev_err(&psy->dev, "Too many temperature values\n");
>> +             return -EINVAL;
>> +     } else if (len > 0) {
>> +             of_property_read_u32_array(battery_np,
>> +                                        "ocv-capacity-table-temperatures",
>> +                                        info->ocv_temp, len);
>> +     }
>> +
>> +     for (index = 0; index < len; index++) {
>> +             struct power_supply_battery_ocv_table *table;
>> +             char *propname;
>> +             const __be32 *list;
>> +             int i, tab_len, size;
>> +
>> +             propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
>> +             list = of_get_property(battery_np, propname, &size);
>> +             kfree(propname);
>> +             if (!list || !size) {
>> +                     dev_err(&psy->dev, "failed to get ocv capacity table\n");
>
> I think it's better to replace "ocv capacity table" with %s / propname.

Yes.

>
>> +                     power_supply_put_battery_info(psy, info);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             tab_len = size / sizeof(*table);
>
> I think this should be
>
> tab_len = size / (2 * sizeof(__be32));
>
> which decouples DT memory layout from kernel memory layout.

Sure.

>
>> +             info->ocv_table_size[index] = tab_len;
>> +
>> +             table = info->ocv_table[index] = devm_kzalloc(&psy->dev,
>> +                                             tab_len * sizeof(*table),
>> +                                             GFP_KERNEL);
>> +             if (!info->ocv_table[index]) {
>> +                     power_supply_put_battery_info(psy, info);
>> +                     return -ENOMEM;
>> +             }
>> +
>> +             for (i = 0; i < tab_len; i++) {
>> +                     table[i].ocv = be32_to_cpu(*list++);
>> +                     table[i].capacity = be32_to_cpu(*list++);
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
>>  int power_supply_get_property(struct power_supply *psy,
>>                           enum power_supply_property psp,
>>                           union power_supply_propval *val)
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index 019452d..b0a2768 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -309,6 +309,12 @@ struct power_supply_info {
>>       int use_for_apm;
>>  };
>>
>> +struct power_supply_battery_ocv_table {
>> +     int ocv;        /* microVolts */
>> +     int capacity;   /* percent */
>> +};
>> +
>> +#define POWER_SUPPLY_OCV_TEMP_MAX 20
>>  /*
>>   * This is the recommended struct to manage static battery parameters,
>>   * populated by power_supply_get_battery_info(). Most platform drivers should
>> @@ -327,6 +333,9 @@ struct power_supply_battery_info {
>>       int constant_charge_current_max_ua; /* microAmps */
>>       int constant_charge_voltage_max_uv; /* microVolts */
>>       int internal_resistance_uohm;       /* microOhms */
>> +     int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];  /* celsius */
>> +     struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
>> +     int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
>>  };
>>
>>  extern struct atomic_notifier_head power_supply_notifier;
>> @@ -350,6 +359,8 @@ extern struct power_supply *devm_power_supply_get_by_phandle(
>>
>>  extern int power_supply_get_battery_info(struct power_supply *psy,
>>                                        struct power_supply_battery_info *info);
>> +extern void power_supply_put_battery_info(struct power_supply *psy,
>> +                                       struct power_supply_battery_info *info);
>>  extern void power_supply_changed(struct power_supply *psy);
>>  extern int power_supply_am_i_supplied(struct power_supply *psy);
>>  extern int power_supply_set_input_current_limit_from_supplier(
>
> Looks good to me. Technically this can result in existing users of
> power_supply_get_battery_info leaking memory, if they have an OCV
> table in DT.

Fortunately existing users did not have an OCV table. Moreover once
this patch merged, I will send patches to add
power_supply_put_battery_info() for existing users of battery info.

-- 
Baolin Wang
Best Regards
