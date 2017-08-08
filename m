From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 15/18] power: supply: bq24190_charger: Get
 input_current_limit from our supplier
Date: Tue, 8 Aug 2017 11:11:37 +0200
Message-ID: <5c531a6b-70a0-8651-20ac-57fd7648bc4f@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-16-hdegoede@redhat.com>
 <CAKvHMgQiEBPpWS9xQQbW94Pz27wZ7ND-tLOCvmkURK0hg2Ptmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKvHMgQiEBPpWS9xQQbW94Pz27wZ7ND-tLOCvmkURK0hg2Ptmw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 08-08-17 10:24, Liam Breck wrote:
> Hallo Hans :-)
> 
> 
> On Sun, Aug 6, 2017 at 5:35 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On some devices the USB Type-C port power (USB PD 2.0) negotiation is
>> done by a separate port-controller IC, while the current limit is
>> controlled through another (charger) IC.
>>
>> It has been decided to model this by modelling the external Type-C
>> power brick (adapter/charger) as a power-supply class device which
>> supplies the charger-IC, with its voltage-now and current-max representing
>> the negotiated voltage and max current draw.
>>
>> This commit adds support for this to the bq24190_charger driver by calling
>> power_supply_set_input_current_limit_from_supplier helper if the
>> "input-current-limit-from-supplier" device-property is set.
>>
>> Note this replaces the functionality to get the current-limit from an
>> extcon device, which will be removed in a follow-up commit.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/power/supply/bq24190_charger.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index d78e2c6dc127..1f6424f0772f 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -161,6 +161,7 @@ struct bq24190_dev_info {
>>          char                            model_name[I2C_NAME_SIZE];
>>          bool                            initialized;
>>          bool                            irq_event;
>> +       bool                            input_current_limit_from_supplier;
>>          struct mutex                    f_reg_lock;
>>          u8                              f_reg;
>>          u8                              ss_reg;
>> @@ -1137,6 +1138,14 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
>>          return ret;
>>   }
>>
>> +static void bq24190_charger_external_power_changed(struct power_supply *psy)
>> +{
>> +       struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
>> +
>> +       if (bdi->input_current_limit_from_supplier)
>> +               power_supply_set_input_current_limit_from_supplier(psy);
>> +}
>> +
>>   static enum power_supply_property bq24190_charger_properties[] = {
>>          POWER_SUPPLY_PROP_CHARGE_TYPE,
>>          POWER_SUPPLY_PROP_HEALTH,
>> @@ -1165,6 +1174,7 @@ static const struct power_supply_desc bq24190_charger_desc = {
>>          .get_property           = bq24190_charger_get_property,
>>          .set_property           = bq24190_charger_set_property,
>>          .property_is_writeable  = bq24190_charger_property_is_writeable,
>> +       .external_power_changed = bq24190_charger_external_power_changed,
>>   };
>>
>>   /* Battery power supply property routines */
>> @@ -1654,6 +1664,10 @@ static int bq24190_probe(struct i2c_client *client,
>>                  return -EINVAL;
>>          }
>>
>> +       bdi->input_current_limit_from_supplier =
>> +               device_property_read_bool(dev,
>> +                                         "input-current-limit-from-supplier");
> 
> Since this invokes the new power_supply_class function, should this be
> a devicetree property, not just a driver-to-driver switch? If so, the
> property name should probably be defined in
> Doc...bindings/power/supply/power_supply.txt.

Well this is a kernel internal thing, specifying a supplier through devicetree
should already be documented, this tells a driver to set its input-current-limit
based on the max-current of its supplier.

So we could documented it, but I think it should probably be prefixed with
"linux," then.

Anyways first lets see what Sebastian thinks of this approach if he nacks
it we don't have to worry about documenting it either :)

Regards,

Hans
