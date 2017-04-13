From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 2/3] power: supply: bq24190_charger: Do not reset the
 charger on probe by default
Date: Thu, 13 Apr 2017 13:54:04 +0200
Message-ID: <72abeafe-1378-50a3-69a5-28f9ab837dcc@redhat.com>
References: <20170412181808.31768-1-hdegoede@redhat.com>
 <20170412181808.31768-3-hdegoede@redhat.com>
 <CAKvHMgTxYa7U+u0W5On9+xgViWuGX5PFMi865f_2HojrnLM-aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbdDMLyI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 07:54:08 -0400
In-Reply-To: <CAKvHMgTxYa7U+u0W5On9+xgViWuGX5PFMi865f_2HojrnLM-aQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi,

On 13-04-17 01:06, Liam Breck wrote:
> Hallo Hans,
>
> On Wed, Apr 12, 2017 at 11:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Resetting the charger should never be necessary it should always have
>> sane values programmed. If it is running with invalid values while we
>> are not running (system turned off or suspended) there is a big problem
>> as that may lead to overcharging the battery.
>>
>> The reset in suspend() is meant to put the charger back into default
>> mode, but this is not necessary and not a good idea. If the charger has
>> been programmed with a higher max charge_current / charge_voltage then
>> putting it back in default-mode will reset those to the safe power-on
>> defaults, leading to slower charging, or charging to a lower voltage
>> (and thus not using the full capacity) while suspended which is
>> undesirable. Reprogramming the max charge_current / charge_voltage
>> after the reset will not help here as that will put the charger back
>> in host mode and start the i2c watchdog if the host then does not do
>> anything for 40s (iow if we're suspended for more then 40s) the watchdog
>> expires resetting the device to default-mode, including resetting all
>> the registers to there safe power-on defaults. So the only way to keep
>> using custom charge settings while suspending is to keep the charger in
>> its normal running state with the i2c watchdog disabled. This is fine
>> as the charger will still automatically switch from constant current
>> to constant voltage and stop charging when the battery is full.
>>
>> Besides never being necessary resetting the charger also causes problems
>> on systems where the charge voltage limit is set higher then the reset
>> value, if this is the case and the charger is reset while charging and
>> the battery voltage is between the 2 voltages, then about half the time
>> the charger gets confused and claims to be charging (REG08 contains 0x64)
>> but in reality the charger has decoupled itself from VBUS (Q1 off) and
>> is drawing 0A from VBUS, leaving the system running from the battery.
>
> Could you also mention which charger chip, board/host, and any known
> hw config for the chip by the host?
> Also mention whether or not there is a TI errata doc for the issue?

I will send a v5 with this both added to the commit msg.

>> For all the above reasons this commit disables reset on probe and on
>> suspend / resume. If a specific setup really needs / wants to do a rest
>> in these cases, this can be requested by setting a reset-on-probe device
>> property on the device.
>>
>> Cc: Liam Breck <kernel@networkimprov.net>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -This is a new patch in v2 of this patch-set
>> Changes in v3:
>> -Disable the reset code by default, but leave it around guarded by
>>  a check for a reset-on-probe device-property
>> Changes in v4:
>> -Rebase on top of current power-supply/next
>> ---
>>  drivers/power/supply/bq24190_charger.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
>> index bd9e5c3..ad429b7 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -1382,9 +1382,11 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
>>                 return -ENODEV;
>>         }
>>
>> -       ret = bq24190_register_reset(bdi);
>> -       if (ret < 0)
>> -               return ret;
>> +       if (device_property_read_bool(bdi->dev, "reset-on-probe")) {
>> +               ret = bq24190_register_reset(bdi);
>> +               if (ret < 0)
>> +                       return ret;
>> +       }
>
> Maybe check property and return if true in register_reset(), instead
> of adjusting all the calls. There would be a set_mode_host() in
> resume() which is unnecessary, but it's a no-op to set host mode when
> we're already in it.

i2c transfers are quite slow, so it is better to avoid doing unnecessary
i2c transfers.

> Perhaps device_property_present() since _read_bool() implies we expect
> it to be set T or F?

 From include/linux/property.h:

static inline bool device_property_read_bool(struct device *dev,
                                              const char *propname)
{
         return device_property_present(dev, propname);
}

So nope _read_bool() does not expect true or false, it works
just like devicetree properties

> Let's keep the original reset behavior as the default,

Tony Lindgren suggested to do disable reset by default:

On 04-04-17 02:56, Tony Lindgren wrote:

 > My guess is that the reset is left over from missing handling of
 > clearing of the EN_HIZ on errors. I recall that EN_HIZ error can
 > happen when plugging the cable a little bit sideways to a USB hub
 > with loose tolerance USB connectors.
 >
 > So it should be safe to limit the reset to only happen if something
 > like "reset-on-probe" is specified. Not sure we want to remove it
 > completely, maybe just add notes that reset may misbehave in
 > some conditions.

And I agree that that is the best way, as it simply does not seem
necessary to reset the charger.

> since we only get device props for an ACPI platform.

device_props is a firmware independent method of getting hardware
properties from the firmware, so you can just add "reset-on-probe;"
to the dt node describing the bq24190 in your dts if it turns out
you do need the reset for some reason and it will work as
expected.

Regards,

Hans


p.s.

I thought you were using device_properties for the new battery_properties
stuff too ? If not you really should, that way those properties can be
used on x86 too and it will work just as well for ARM + devicetree.

Hmm, wait I think you were doing a separate node for the battery and
putting them in the charger node, right ? Then device-props won't
work because there is no device to tie them too, so nevermind I guess :)



>
>>         ret = bq24190_set_mode_host(bdi);
>>         if (ret < 0)
>> @@ -1547,7 +1549,8 @@ static int bq24190_remove(struct i2c_client *client)
>>                 pm_runtime_put_noidle(bdi->dev);
>>         }
>>
>> -       bq24190_register_reset(bdi);
>> +       if (device_property_read_bool(bdi->dev, "reset-on-probe"))
>> +               bq24190_register_reset(bdi);
>>         bq24190_sysfs_remove_group(bdi);
>>         power_supply_unregister(bdi->battery);
>>         power_supply_unregister(bdi->charger);
>> @@ -1600,7 +1603,8 @@ static __maybe_unused int bq24190_pm_suspend(struct device *dev)
>>                 pm_runtime_put_noidle(bdi->dev);
>>         }
>>
>> -       bq24190_register_reset(bdi);
>> +       if (device_property_read_bool(bdi->dev, "reset-on-probe"))
>> +               bq24190_register_reset(bdi);
>>
>>         if (error >= 0) {
>>                 pm_runtime_mark_last_busy(bdi->dev);
>> @@ -1625,8 +1629,10 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
>>                 pm_runtime_put_noidle(bdi->dev);
>>         }
>>
>> -       bq24190_register_reset(bdi);
>> -       bq24190_set_mode_host(bdi);
>> +       if (device_property_read_bool(bdi->dev, "reset-on-probe")) {
>> +               bq24190_register_reset(bdi);
>> +               bq24190_set_mode_host(bdi);
>> +       }
>>         bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
>>
>>         if (error >= 0) {
>> --
>> 2.9.3
>>
