From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v2 11/14] power: supply: bq24190_charger: Get
 input_current_limit from our supplier
Date: Mon, 28 Aug 2017 10:02:02 -0700
Message-ID: <CAKvHMgQvxUKOm+yeHVOivih7D99A9Gp6zHzWaG3bBceebaaN7g@mail.gmail.com>
References: <20170815200502.17339-1-hdegoede@redhat.com> <20170815200502.17339-12-hdegoede@redhat.com>
 <CAKvHMgQMgkA=b_jGFMhs7-Ta=+WYjh2u8YNjON3MapA8tTju9w@mail.gmail.com> <3c3c65dd-fb5f-becd-0d04-f22f103baeb0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3c3c65dd-fb5f-becd-0d04-f22f103baeb0@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Hi Hans,

On Mon, Aug 28, 2017 at 9:04 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 16-08-17 22:28, Liam Breck wrote:
>>
>> Hi Hans,
>>
>> On Tue, Aug 15, 2017 at 1:04 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> On some devices the USB Type-C port power (USB PD 2.0) negotiation is
>>> done by a separate port-controller IC, while the current limit is
>>> controlled through another (charger) IC.
>>>
>>> It has been decided to model this by modelling the external Type-C
>>> power brick (adapter/charger) as a power-supply class device which
>>> supplies the charger-IC, with its voltage-now and current-max
>>> representing
>>> the negotiated voltage and max current draw.
>>>
>>> This commit adds support for this to the bq24190_charger driver by
>>> calling
>>> power_supply_set_input_current_limit_from_supplier helper if the
>>> "input-current-limit-from-supplier" device-property is set.
>>>
>>> Note this replaces the functionality to get the current-limit from an
>>> extcon device, which will be removed in a follow-up commit.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> -Wait a bit before applying current-max from our supplier as
>>> input-current-limit
>>>   the bq24190 may still be in its power-good wait-state while our
>>> supplier is
>>>   done negotating current-max and if we apply the limit to early then the
>>>   input-current-limit will be reset to 0.5A by the bq24190 after its
>>>   power-good wait is done.
>>> ---
>>>   drivers/power/supply/bq24190_charger.c | 35
>>> ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>> b/drivers/power/supply/bq24190_charger.c
>>> index f13f892..6f75c8e 100644
>>> --- a/drivers/power/supply/bq24190_charger.c
>>> +++ b/drivers/power/supply/bq24190_charger.c
>>> @@ -159,9 +159,11 @@ struct bq24190_dev_info {
>>>          struct extcon_dev               *extcon;
>>>          struct notifier_block           extcon_nb;
>>>          struct delayed_work             extcon_work;
>>> +       struct delayed_work             input_current_limit_work;
>>>          char                            model_name[I2C_NAME_SIZE];
>>>          bool                            initialized;
>>>          bool                            irq_event;
>>> +       bool
>>> input_current_limit_from_supplier;
>>>          struct mutex                    f_reg_lock;
>>>          u8                              f_reg;
>>>          u8                              ss_reg;
>>> @@ -1142,6 +1144,32 @@ static int
>>> bq24190_charger_property_is_writeable(struct power_supply *psy,
>>>          return ret;
>>>   }
>>>
>>> +static void bq24190_input_current_limit_work(struct work_struct *work)
>>> +{
>>> +       struct bq24190_dev_info *bdi =
>>> +               container_of(work, struct bq24190_dev_info,
>>> +                            input_current_limit_work.work);
>>> +
>>> +       power_supply_set_input_current_limit_from_supplier(bdi->charger);
>>> +}
>>> +
>>> +static void bq24190_charger_external_power_changed(struct power_supply
>>> *psy)
>>> +{
>>> +       struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
>>> +
>>> +       /*
>>> +        * The Power-Good detection may take up to 220ms, sometimes
>>> +        * the external charger detection is quicker, and the bq24190
>>> will
>>> +        * reset to iinlim based on its own charger detection (which is
>>> not
>>> +        * hooked up when using external charger detection) resulting in
>>> a
>>> +        * too low default 500mA iinlim. Delay setting the
>>> input-current-limit
>>> +        * for 300ms to avoid this.
>>> +        */
>>> +       if (bdi->input_current_limit_from_supplier)
>>> +               queue_delayed_work(system_wq,
>>> &bdi->input_current_limit_work,
>>> +                                  msecs_to_jiffies(300));
>>> +}
>>> +
>>>   static enum power_supply_property bq24190_charger_properties[] = {
>>>          POWER_SUPPLY_PROP_CHARGE_TYPE,
>>>          POWER_SUPPLY_PROP_HEALTH,
>>> @@ -1170,6 +1198,7 @@ static const struct power_supply_desc
>>> bq24190_charger_desc = {
>>>          .get_property           = bq24190_charger_get_property,
>>>          .set_property           = bq24190_charger_set_property,
>>>          .property_is_writeable  = bq24190_charger_property_is_writeable,
>>> +       .external_power_changed = bq24190_charger_external_power_changed,
>>>   };
>>>
>>>   /* Battery power supply property routines */
>>> @@ -1651,6 +1680,8 @@ static int bq24190_probe(struct i2c_client *client,
>>>          mutex_init(&bdi->f_reg_lock);
>>>          bdi->f_reg = 0;
>>>          bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state
>>> */
>>> +       INIT_DELAYED_WORK(&bdi->input_current_limit_work,
>>> +                         bq24190_input_current_limit_work);
>>>
>>>          i2c_set_clientdata(client, bdi);
>>>
>>> @@ -1659,6 +1690,10 @@ static int bq24190_probe(struct i2c_client
>>> *client,
>>>                  return -EINVAL;
>>>          }
>>>
>>> +       bdi->input_current_limit_from_supplier =
>>> +               device_property_read_bool(dev,
>>> +
>>> "input-current-limit-from-supplier");
>>> +
>>
>>
>> Maybe
>>    if (device_property_read_bool(dev,
>> "linux,input-current-limit-from-supplier")) {
>>         INIT_DELAYED_WORK(&bdi->input_current_limit_work,
>>                           bq24190_input_current_limit_work);
>>        bdi->input_current_limit_from_supplier = true; // or use a field
>> in bdi->input_current_limit_work as the flag?
>>     }
>
>
> Done, except for making the flag a field in input_current_limit_work,
> input_current_limit_work is of type struct delayed_work so I cannot just
> add a field.

What I meant was you could check an existing field in delayed_work to
see if it was init'd.

>> Also should document property for DT use assuming Sebastian is ok with
>> new power_supply method.
>
> Also done for v3 of this patch.
>
>> And can you rebase to my pending series in next pass? There's nothing
>> controversial in it :-)
>
>
> I've cherry-picked v3 of the patch adding the dt-binding-doc to my tree so
> that I could add the documentation for the property on top. I will make sure
> to rebase on top of the rest once the rest is merged by Sebastian (otherwise
> I need to rebase after each revision of the patch-set).

Sounds good.
