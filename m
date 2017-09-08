From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity
 values for bq27421
Date: Fri, 8 Sep 2017 13:19:21 -0700
Message-ID: <CAKvHMgRKO4wSWr_XU5wCM6-yadz4kY++zq96w-RSRrzBjQF1zQ@mail.gmail.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
 <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
 <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com> <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com>
 <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com> <CAKvHMgT6AHfjnXvD5jeWP_9wAm_GQNJxm=Nm1jH32NeaVZjdYw@mail.gmail.com>
 <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com> <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com>
 <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:37038 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdIHUTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 16:19:23 -0400
In-Reply-To: <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com

Hi Nikolaus,

On Fri, Sep 8, 2017 at 10:38 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> Hi Liam,
> I finally continues testing on OpenPandora.
>
>> Am 31.08.2017 um 22:19 schrieb Liam Breck <liam@networkimprov.net>:
>>
>> Hi,
>>
>> This may be a fix that allows >0 input from DT, but won't try to
>> program the register since the first 3 fields aren't compatible:
>>
>> ... bq27500_dm_regs[] = {
>> ...
>>  [bq27xxx_dm_design_energy] = {  0,  0, 0,    0, 65535 }, /* missing on chip */
>> NB: align columns with other rows
>
> I have tried with this DT
>
>         bat: battery {
>                 compatible = "simple-battery", "openpandora-battery";
>                 voltage-min-design-microvolt = <3250000>;
>                 energy-full-design-microwatt-hours = <14800000>;
>                 charge-full-design-microamp-hours = <4100000>;
>         };
>
> and here is the result:
>
>> root@letux:~# dmesg|fgrep bq27
>> [   10.391235] bq27xxx_battery_setup
>> [   10.391265] bq27xxx_battery_setup: dm_regs=bf0520e0
>> [   10.393798] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name attribute, please fix
>> [   10.432678] bq27xxx_battery_settings
>> [   10.432952] bq27xxx_battery_set_config
>> [   10.432952] bq27xxx_battery_unseal
>> [   10.485168] bq27xxx_battery_update_dm_block
>> [   10.485198] bq27xxx-battery 2-0055: update design-capacity to 4100
>
> looks good
>
>> [   10.485229] bq27xxx_battery_update_dm_block
>> [   10.485229] bq27xxx-battery 2-0055: buffer does not match design-energy dm spec
>
> ok, ignored
>
>> [   10.511718] bq27xxx_battery_update_dm_block
>> [   10.511749] bq27xxx-battery 2-0055: update terminate-voltage to 3250
>
> looks good
>
>> [   10.826446] bq27xxx_battery_seal
>> [   12.150939] bq27xxx_battery_platform_probe
>> [   12.151031] bq27xxx_battery_setup
>> [   12.151062] bq27xxx_battery_setup: dm_regs=  (null)
>> [   12.153411] (NULL device *): hwmon: 'bq27000-battery' is not a valid name attribute, please fix
>> [   12.154327] bq27xxx_battery_settings
>> [   12.154357] power_supply bq27000-battery: power_supply_get_battery_info currently only supports devicetree
>> [   12.154388] bq27xxx_battery_settings: power_supply_get_battery_info failed ret=-6

Is there also a bq27000 chip on this device, or a battery with it
embedded? If so, it doesn't appear to have a DT node (correct for
embedded), hence that warning, which isn't useful in that case. Prob
battery_settings() should do:
    if (!di->dev->of_node || power_supply_get_battery_info(...) < 0) return;
altho that would be wrong once get_battery_info() supports ACPI config...

> ... login:
>
>> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent
>> POWER_SUPPLY_NAME=bq27500-1-0
>> POWER_SUPPLY_STATUS=Discharging
>> POWER_SUPPLY_PRESENT=1
>> POWER_SUPPLY_VOLTAGE_NOW=3892000
>> POWER_SUPPLY_CURRENT_NOW=-317000
>> POWER_SUPPLY_CAPACITY=0
>
> oops.
>
>> POWER_SUPPLY_CAPACITY_LEVEL=Low
>> POWER_SUPPLY_TEMP=223
>> POWER_SUPPLY_TIME_TO_EMPTY_NOW=0
>> POWER_SUPPLY_TECHNOLOGY=Li-ion
>> POWER_SUPPLY_CHARGE_FULL=1147000
>> POWER_SUPPLY_CHARGE_NOW=2665000
>> POWER_SUPPLY_CHARGE_FULL_DESIGN=4100000
>> POWER_SUPPLY_CYCLE_COUNT=6
>> POWER_SUPPLY_ENERGY_NOW=0
>> POWER_SUPPLY_POWER_AVG=64395
>> POWER_SUPPLY_HEALTH=Dead
>
> oops. But maybe the bq27500 needs a full cycle first

I wouldn't guess that the above state is due to the DM update
sequence, but I suppose that's possible. Another update pass might
clarify that.

>> POWER_SUPPLY_MANUFACTURER=Texas Instruments
>
> vvv after plugging in charger
>
>> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent
>> POWER_SUPPLY_NAME=bq27500-1-0
>> POWER_SUPPLY_STATUS=Charging
>> POWER_SUPPLY_PRESENT=1
>> POWER_SUPPLY_VOLTAGE_NOW=3923000
>> POWER_SUPPLY_CURRENT_NOW=204000
>> POWER_SUPPLY_CAPACITY=0
>> POWER_SUPPLY_CAPACITY_LEVEL=Low
>> POWER_SUPPLY_TEMP=249
>> POWER_SUPPLY_TIME_TO_EMPTY_NOW=0
>> POWER_SUPPLY_TECHNOLOGY=Li-ion
>> POWER_SUPPLY_CHARGE_FULL=1147000
>> POWER_SUPPLY_CHARGE_NOW=2665000
>> POWER_SUPPLY_CHARGE_FULL_DESIGN=4100000
>> POWER_SUPPLY_CYCLE_COUNT=6
>> POWER_SUPPLY_ENERGY_NOW=0
>> POWER_SUPPLY_POWER_AVG=800
>> POWER_SUPPLY_HEALTH=Dead
>> POWER_SUPPLY_MANUFACTURER=Texas Instruments
>> root@letux:~#
>
> Now a reboot after removing charger and battery for several minutes:
>
>> root@letux:~# dmesg|fgrep bq27
>> [   10.482818] bq27xxx_battery_setup
>> [   12.179687] bq27xxx_battery_platform_probe
>> [   12.179779] bq27xxx_battery_setup
>> [   12.179809] bq27xxx_battery_setup: dm_regs=  (null)
>> [   12.182495] (NULL device *): hwmon: 'bq27000-battery' is not a valid name attribute, please fix
>> [   12.183502] bq27xxx_battery_settings
>> [   12.183532] power_supply bq27000-battery: power_supply_get_battery_info currently only supports devicetree
>> [   12.183563] bq27xxx_battery_settings: power_supply_get_battery_info failed ret=-6
>> [   15.145812] bq27xxx_battery_setup: dm_regs=bf0520e0
>> [   15.152618] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name attribute, please fix
>> [   15.346557] bq27xxx_battery_settings
>> [   15.350585] bq27xxx_battery_set_config
>> [   15.354553] bq27xxx_battery_unseal
>> [   15.576538] bq27xxx_battery_update_dm_block
>> [   15.580993] bq27xxx-battery 2-0055: design-capacity has 4100
>
> ^^^ ok, no change needed
>
>> [   15.676818] bq27xxx_battery_update_dm_block
>> [   15.681243] bq27xxx-battery 2-0055: buffer does not match design-energy dm spec
>> [   15.798675] bq27xxx_battery_update_dm_block
>> [   15.803100] bq27xxx-battery 2-0055: update terminate-voltage to 3250
>
> ^^^ looks as if this is not stored in NVM. Should it be?

Oh dear. I imagine this is due to a flaw in the multi-block DM update
logic. It could be that one of the pauses between calls should be
longer The terminate-voltage spec comes from this datasheet:
page 19, http://www.ti.com/lit/ds/symlink/bq27500.pdf

It's possible that this second pass did update it. What does the next
reboot show?

> BTW: it would be nice if all "update" messages could tell the old value as well.

We have the orig values in memory since we read the block before
updating. Feel free to patch that in :-)

>> [   16.011169] bq27xxx_battery_seal
>> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent
>> POWER_SUPPLY_NAME=bq27500-1-0
>> POWER_SUPPLY_STATUS=Discharging
>> POWER_SUPPLY_PRESENT=1
>> POWER_SUPPLY_VOLTAGE_NOW=3894000
>> POWER_SUPPLY_CURRENT_NOW=-291000
>> POWER_SUPPLY_CAPACITY=71
>
> ^^^ looks as if the bq27500 did recover from reprogramming
>
>> POWER_SUPPLY_CAPACITY_LEVEL=Normal
>> POWER_SUPPLY_TEMP=223
>> POWER_SUPPLY_TIME_TO_EMPTY_NOW=31200
>> POWER_SUPPLY_TECHNOLOGY=Li-ion
>> POWER_SUPPLY_CHARGE_FULL=3748000
>> POWER_SUPPLY_CHARGE_NOW=2713000
>> POWER_SUPPLY_CHARGE_FULL_DESIGN=4100000
>> POWER_SUPPLY_CYCLE_COUNT=6
>> POWER_SUPPLY_ENERGY_NOW=9930000
>> POWER_SUPPLY_POWER_AVG=64407
>> POWER_SUPPLY_HEALTH=Good
>
> ^^^ same here
>
>> POWER_SUPPLY_MANUFACTURER=Texas Instruments
>> root@letux:~#

For general use on OpenPandora, you wouldn't have
config...dt_updates_nvm option set, so the driver should report what
the chip settings are and whether they aren't what the DT spec'd.
Let's verify that too...

Thanks!
