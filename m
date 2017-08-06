From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 18/18] i2c-cht-wc: Add device-properties for fusb302
 integration
Date: Sun, 6 Aug 2017 17:05:47 +0200
Message-ID: <ae6fcdce-1dd0-d29f-ce04-9d9c77f14730@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-19-hdegoede@redhat.com>
 <9ba933c6-daae-f30d-2c83-e9c2b756d27f@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <9ba933c6-daae-f30d-2c83-e9c2b756d27f@roeck-us.net>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 06-08-17 16:35, Guenter Roeck wrote:
> On 08/06/2017 05:35 AM, Hans de Goede wrote:
>> Add device-properties to make the bq24292i controller connected to
>> the bus get its input-current-limit from the fusb302 Type-C port
>> controller which is used on boards with the cht-wc PMIC.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/i2c/busses/Kconfig      | 5 +++++
>>   drivers/i2c/busses/i2c-cht-wc.c | 5 ++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index f20b1f84013a..6de21a81b00b 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -197,6 +197,11 @@ config I2C_CHT_WC
>>         SMBus controller found in the Intel Cherry Trail Whiskey Cove PMIC
>>         found on some Intel Cherry Trail systems.
>> +      Note this controller is hooked up to a TI bq24292i charger-IC,
>> +      combined with a FUSB302 Type-C port-controller as such it is advised
>> +      to also select CONFIG_CHARGER_BQ24190=m and CONFIG_TYPEC_FUSB302=m
>> +      (the fusb302 driver currently is in drivers/staging).
>> +
> 
> Just wondering - is this always the case ? What if someone builds a system with
> different charger and port controller ICs ?

A very valid question, if another charger is used then hopefully it will
have a different i2c address and if it doesn't it should fail the id-register
check in the bq24190 driver unless we get really unlucky. So if this happens
the bq24190 driver should fail to probe.

The code handling the INT33FE ACPI device, which contains the i2c bus
and address info for the FUSB302 has this check:

         /*
          * We expect the Whiskey Cove PMIC to be paired with a TI bq24292i
          * charger-IC, allowing charging with up to 12V, so we set the fusb302
          * "fcs,max-snk-mv" device property to 12000 mV. Allowing 12V with
          * another charger-IC is not a good idea, so we get the bq24292i vbus
          * regulator here, to ensure that things are as expected.
          * Use regulator_get_optional so that we don't get a dummy-regulator.
          */
         regulator = regulator_get_optional(dev, BQ24292I_REGULATOR);
         if (IS_ERR(regulator)) {
                 ret = PTR_ERR(regulator);
                 return (ret == -ENODEV) ? -EPROBE_DEFER : ret;
         }
         regulator_put(regulator);

So if the bq24190 probe fails and it does not register its regulator, the
i2c-client for the fusb302 will never gets instantiated. Which means that
if a different charger-IC is used the user will get a bunch of errors and
nothing will happen.

If a different port-controller is used, then I would expect there to no
be a INT33FE ACPI device, with PTYP==4 as PTYP==4 seems to be used
to describe the Whiskey Cove PMIC + bq24190 charger + fusb302 combo,
but this is all undocumented, so no guarantees. I've added the above
code because of this, because I really don't want to negotiate a voltage
higher then 5V with an unknown charger-IC.

FWIW all DSTDs I've seen are all copy and paste and all declare a INT33FE ACPI
device with identical i2c client addresses which strongly suggests the
use of the same combo. Note that on most devices this part of the DSTD is
not active (_STA returns 0) because they actually use a different config.

The only extra safe-guard I can come up with is a DMI string check, but that
is sub-optimal since the DMI strings on these devices contain useful values
as "Default String" still we could add it as an extra check.

Since I had the same concern I've done a web search and I've been unable
to find any other devices which seem to use a Whiskey Cove PMIC, but that
does not mean that there aren't any.

Regards,

Hans






> 
>>   config I2C_NFORCE2
>>       tristate "Nvidia nForce2, nForce3 and nForce4"
>>       depends on PCI
>> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
>> index ccf0785bcb75..08229fb12615 100644
>> --- a/drivers/i2c/busses/i2c-cht-wc.c
>> +++ b/drivers/i2c/busses/i2c-cht-wc.c
>> @@ -211,8 +211,11 @@ static const struct irq_chip cht_wc_i2c_irq_chip = {
>>       .name            = "cht_wc_ext_chrg_irq_chip",
>>   };
>> +static const char * const bq24190_suppliers[] = { "fusb302-typec-source" };
>> +
>>   static const struct property_entry bq24190_props[] = {
>> -    PROPERTY_ENTRY_STRING("extcon-name", "cht_wcove_pwrsrc"),
>> +    PROPERTY_ENTRY_STRING_ARRAY("supplied-from", bq24190_suppliers),
>> +    PROPERTY_ENTRY_BOOL("input-current-limit-from-supplier"),
>>       PROPERTY_ENTRY_BOOL("omit-battery-class"),
>>       PROPERTY_ENTRY_BOOL("disable-reset"),
>>       { }
>>
> 
