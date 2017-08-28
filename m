From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/5] power: bq24190_charger: Enable devicetree config
Date: Mon, 28 Aug 2017 21:09:52 +0200
Message-ID: <6a445ed6-3f59-0137-255b-469aead8122b@redhat.com>
References: <20170826051413.24569-1-liam@networkimprov.net>
 <20170826051413.24569-4-liam@networkimprov.net>
 <5087e892-e90f-5868-9b3d-01edba6f101b@redhat.com>
 <CAKvHMgRVzG39rbR4_TNOUMqdgA9g1dxXGK2DkngMe_NkRVDPFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbdH1TJz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Aug 2017 15:09:55 -0400
In-Reply-To: <CAKvHMgRVzG39rbR4_TNOUMqdgA9g1dxXGK2DkngMe_NkRVDPFA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

Hi,

On 28-08-17 19:59, Liam Breck wrote:
> Hi Hans, thanks for the input...
> 
> On Mon, Aug 28, 2017 at 5:13 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 26-08-17 07:14, Liam Breck wrote:
>>>
>>> From: Liam Breck <kernel@networkimprov.net>
>>>
>>> Add get_config(). Rename set_mode_host() to set_config().
>>> Call get_config() and hw_init() after power_supply_register().
>>> No functional changes.
>>
>>
>> Doing hw_init after power_supply_register() means that userspace
>> can get/set power_supply properties before hw_init has run, this
>> generally is not a good idea.
> 
> hw_init() needs data from DT, and power_supply_get_battery_info()
> (called by get_config() in later patch) gets the DT data. It takes a
> power_supply argument, hence the new ordering.
> 
> Is there a way to defer availability of a registered power_supply to
> userspace during probe()?

No I don't think so.

> I recall looking into this when I wrote that
> and concluding that it was safe, but I don't recall why :-/

I guess you came to that conclusion because non of the properties
we export really depend on any of the settings which are setup by
hw_init, so doing that after registering, although unusual should
be fine I guess. So lets just keep this as is.

> 
>>
>>>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>>> ---
>>>    drivers/power/supply/bq24190_charger.c | 63
>>> +++++++++++++++++++++++-----------
>>>    1 file changed, 43 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>> b/drivers/power/supply/bq24190_charger.c
>>> index 40b4bba7..c6be00d7 100644
>>> --- a/drivers/power/supply/bq24190_charger.c
>>> +++ b/drivers/power/supply/bq24190_charger.c
>>> @@ -504,15 +504,7 @@ static int bq24190_sysfs_create_group(struct
>>> bq24190_dev_info *bdi)
>>>    static inline void bq24190_sysfs_remove_group(struct bq24190_dev_info
>>> *bdi) {}
>>>    #endif
>>>    -/*
>>> - * According to the "Host Mode and default Mode" section of the
>>> - * manual, a write to any register causes the bq24190 to switch
>>> - * from default mode to host mode.  It will switch back to default
>>> - * mode after a WDT timeout unless the WDT is turned off as well.
>>> - * So, by simply turning off the WDT, we accomplish both with the
>>> - * same write.
>>> - */
>>> -static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
>>> +static int bq24190_set_config(struct bq24190_dev_info *bdi)
>>>    {
>>>          int ret;
>>>          u8 v;
>>> @@ -523,9 +515,22 @@ static int bq24190_set_mode_host(struct
>>> bq24190_dev_info *bdi)
>>>          bdi->watchdog = ((v & BQ24190_REG_CTTC_WATCHDOG_MASK) >>
>>>                                          BQ24190_REG_CTTC_WATCHDOG_SHIFT);
>>> +
>>> +       /*
>>> +        * According to the "Host Mode and default Mode" section of the
>>> +        * manual, a write to any register causes the bq24190 to switch
>>> +        * from default mode to host mode.  It will switch back to default
>>> +        * mode after a WDT timeout unless the WDT is turned off as well.
>>> +        * So, by simply turning off the WDT, we accomplish both with the
>>> +        * same write.
>>> +        */
>>>          v &= ~BQ24190_REG_CTTC_WATCHDOG_MASK;
>>>    -     return bq24190_write(bdi, BQ24190_REG_CTTC, v);
>>> +       ret = bq24190_write(bdi, BQ24190_REG_CTTC, v);
>>> +       if (ret < 0)
>>> +               return ret;
>>> +
>>> +       return 0;
>>>    }
>>>      static int bq24190_register_reset(struct bq24190_dev_info *bdi)
>>> @@ -1456,13 +1461,25 @@ static int bq24190_hw_init(struct bq24190_dev_info
>>> *bdi)
>>>          if (ret < 0)
>>>                  return ret;
>>>    -     ret = bq24190_set_mode_host(bdi);
>>> +       ret = bq24190_set_config(bdi);
>>>          if (ret < 0)
>>>                  return ret;
>>>          return bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
>>>    }
>>>    +static int bq24190_get_config(struct bq24190_dev_info *bdi)
>>> +{
>>> +#ifdef CONFIG_OF
>>> +       int v;
>>
>>
>> This variable is unused (in this patch)
>>
>>> +
>>> +       if (!bdi->dev->of_node)
>>> +               return -EINVAL;
>>
>>
>> I don't think that this is a good idea, at least on ARM
>> (AFAIK) a kernel can be configured to support both DT and
>> ACPI, just having CONFIG_OF enabled as such is not a good
>> reason to fail to probe when there is no of_node.
>>
>> IMHO it would be better to instead put the reading of the
>> "ti,system-minimum-microvolt" property introduced in the next
>> patch inside a: if (bdi->dev->of_node) { ... } block.
> 
> Well that one is read with device_property_read_ so mebbe I should
> drop ifdef config_of and only check dev->of_node before
> _get_battery_info() which requires DT.

Sounds good to me.

Regards,

Hans


> 
>>> +
>>> +#endif
>>> +       return 0;
>>> +}
>>> +
>>>    static int bq24190_probe(struct i2c_client *client,
>>>                  const struct i2c_device_id *id)
>>>    {
>>> @@ -1493,7 +1510,7 @@ static int bq24190_probe(struct i2c_client *client,
>>>          i2c_set_clientdata(client, bdi);
>>>    -     if (!client->irq) {
>>> +       if (client->irq <= 0) {
>>>                  dev_err(dev, "Can't get irq info\n");
>>>                  return -EINVAL;
>>>          }
>>> @@ -1526,12 +1543,6 @@ static int bq24190_probe(struct i2c_client *client,
>>>                  goto out_pmrt;
>>>          }
>>>    -     ret = bq24190_hw_init(bdi);
>>> -       if (ret < 0) {
>>> -               dev_err(dev, "Hardware init failed\n");
>>> -               goto out_pmrt;
>>> -       }
>>> -
>>>          charger_cfg.drv_data = bdi;
>>>          charger_cfg.supplied_to = bq24190_charger_supplied_to;
>>>          charger_cfg.num_supplicants =
>>> ARRAY_SIZE(bq24190_charger_supplied_to),
>>> @@ -1556,8 +1567,20 @@ static int bq24190_probe(struct i2c_client *client,
>>>                  }
>>>          }
>>>    +     ret = bq24190_get_config(bdi);
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "Can't get devicetree config\n");
>>> +               goto out_charger;
>>> +       }
>>> +
>>> +       ret = bq24190_hw_init(bdi);
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "Hardware init failed\n");
>>> +               goto out_charger;
>>> +       }
>>> +
>>>          ret = bq24190_sysfs_create_group(bdi);
>>> -       if (ret) {
>>> +       if (ret < 0) {
>>>                  dev_err(dev, "Can't create sysfs entries\n");
>>>                  goto out_charger;
>>>          }
>>> @@ -1700,7 +1723,7 @@ static __maybe_unused int bq24190_pm_resume(struct
>>> device *dev)
>>>          }
>>>          bq24190_register_reset(bdi);
>>> -       bq24190_set_mode_host(bdi);
>>> +       bq24190_set_config(bdi);
>>>          bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
>>>          if (error >= 0) {
>>>
>>
>> Regards,
>>
>> Hans
