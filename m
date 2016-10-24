From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH 1/2] power: bq27xxx_battery: add configurable
 poll_interval by sysfs
Date: Sun, 23 Oct 2016 20:08:22 -0700
Message-ID: <CAKzfze95nJMcRU2=FivDa72MX4P0md1VoWbUjUnt-75Vs_ektQ@mail.gmail.com>
References: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
 <1474083775-30185-2-git-send-email-matt@ranostay.consulting> <20161007184910.GF19976@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161007184910.GF19976@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 7, 2016 at 11:49 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2016-09-16 20:42:54, Matt Ranostay wrote:
>> Allow the poll_interval to be runtime configurable via an sysfs entry.
>> This is needed for udev control of the poll interval.
>>
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>
> working mail address would be nice here.
>
> sysfs files should be documented.
>

Ok can do in next revision

> Also... what is it good for?
>
> Do you have a device that needs non-standard interval?

Basically we need to have the ability to dynamically change the
intervals. So closer to a battery drain we need to up the reporting
intervals.

Thanks,

Matt

>                                                                         Pavel
>
>> ---
>>  drivers/power/supply/bq27xxx_battery.c | 48 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index 3f57dd54803a..955424e10ae2 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -395,6 +395,36 @@ module_param(poll_interval, uint, 0644);
>>  MODULE_PARM_DESC(poll_interval,
>>                "battery poll interval in seconds - 0 disables polling");
>>
>> +
>> +static ssize_t show_poll_interval(struct device *dev,
>> +                               struct device_attribute *attr, char *buf)
>> +{
>> +     return sprintf(buf, "%d\n", poll_interval);
>> +}
>> +
>> +static ssize_t store_poll_interval(struct device *dev,
>> +                                struct device_attribute *attr,
>> +                                const char *buf, size_t size)
>> +{
>> +     struct bq27xxx_device_info *di = dev_get_drvdata(dev);
>> +     int tmp = poll_interval;
>> +
>> +     if (sscanf(buf, "%d\n", &poll_interval) != 1)
>> +             return -EINVAL;
>> +
>> +     if (poll_interval < 0)
>> +             return -EINVAL;
>> +
>> +     if (tmp != poll_interval) {
>> +             cancel_delayed_work_sync(&di->work);
>> +             schedule_delayed_work(&di->work, 0);
>> +     }
>> +
>> +     return size;
>> +}
>> +
>> +static DEVICE_ATTR(poll_interval, 0644, show_poll_interval, store_poll_interval);
>> +
>>  /*
>>   * Common code for BQ27xxx devices
>>   */
>> @@ -946,6 +976,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>  {
>>       struct power_supply_desc *psy_desc;
>>       struct power_supply_config psy_cfg = { .drv_data = di, };
>> +     int ret;
>>
>>       INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>>       mutex_init(&di->lock);
>> @@ -961,11 +992,19 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>       psy_desc->num_properties = bq27xxx_battery_props[di->chip].size;
>>       psy_desc->get_property = bq27xxx_battery_get_property;
>>       psy_desc->external_power_changed = bq27xxx_external_power_changed;
>> +     dev_set_drvdata(di->dev, di);
>> +
>> +     ret = sysfs_create_file(&di->dev->kobj, &dev_attr_poll_interval.attr);
>> +     if (ret) {
>> +             dev_err(di->dev, "failed to register poll_interval sysfs entry");
>> +             return ret;
>> +     }
>>
>>       di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
>>       if (IS_ERR(di->bat)) {
>>               dev_err(di->dev, "failed to register battery\n");
>> -             return PTR_ERR(di->bat);
>> +             ret = PTR_ERR(di->bat);
>> +             goto err_out;
>>       }
>>
>>       dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
>> @@ -973,6 +1012,11 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>>       bq27xxx_battery_update(di);
>>
>>       return 0;
>> +
>> +err_out:
>> +     sysfs_remove_file(&di->dev->kobj, &dev_attr_poll_interval.attr);
>> +
>> +     return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
>>
>> @@ -988,6 +1032,8 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
>>
>>       cancel_delayed_work_sync(&di->work);
>>
>> +     sysfs_remove_file(&di->dev->kobj, &dev_attr_poll_interval.attr);
>> +
>>       power_supply_unregister(di->bat);
>>
>>       mutex_destroy(&di->lock);
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
