From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity values for bq27421 + bq27500
Date: Sat, 9 Sep 2017 22:21:41 +0200
Message-ID: <BFD5E92C-4BF1-4434-BBD5-2ED964EC1017@goldelico.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com> <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com> <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com> <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com> <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com> <CAKvHMgT6AHfjnXvD5jeWP_9wAm_GQNJxm=Nm1jH32NeaVZjdYw@mail.gmail.com> <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com> <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com> <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com> <CAKvHMgRKO4wSWr_XU5wCM6-yadz4kY++zq96w-RSRrzBjQF1zQ@mail.gmail.com> <13B50F41-D8AC-46E5-B57C-274CFB4DAD75@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13B50F41-D8AC-46E5-B57C-274CFB4DAD75@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: kernel@pyra-handheld.com, Linux PM mailing list <linux-pm@vger.kernel.org>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-pm@vger.kernel.org

Hi Liam,

> Am 08.09.2017 um 22:28 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Liam,
>=20
>> Am 08.09.2017 um 22:19 schrieb Liam Breck <liam@networkimprov.net>:
>>=20
>> Hi Nikolaus,
>>=20
>> On Fri, Sep 8, 2017 at 10:38 AM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>> Hi Liam,
>>> I finally continues testing on OpenPandora.
>>>=20
>>>> Am 31.08.2017 um 22:19 schrieb Liam Breck <liam@networkimprov.net>:
>>>>=20
>>>> Hi,
>>>>=20
>>>> This may be a fix that allows >0 input from DT, but won't try to
>>>> program the register since the first 3 fields aren't compatible:
>>>>=20
>>>> ... bq27500_dm_regs[] =3D {
>>>> ...
>>>> [bq27xxx_dm_design_energy] =3D {  0,  0, 0,    0, 65535 }, /* =
missing on chip */
>>>> NB: align columns with other rows
>>>=20
>>> I have tried with this DT
>>>=20
>>>       bat: battery {
>>>               compatible =3D "simple-battery", =
"openpandora-battery";
>>>               voltage-min-design-microvolt =3D <3250000>;
>>>               energy-full-design-microwatt-hours =3D <14800000>;
>>>               charge-full-design-microamp-hours =3D <4100000>;
>>>       };
>>>=20
>>> and here is the result:
>>>=20
>>>> root@letux:~# dmesg|fgrep bq27
>>>> [   10.391235] bq27xxx_battery_setup
>>>> [   10.391265] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
>>>> [   10.393798] (NULL device *): hwmon: 'bq27500-1-0' is not a valid =
name attribute, please fix
>>>> [   10.432678] bq27xxx_battery_settings
>>>> [   10.432952] bq27xxx_battery_set_config
>>>> [   10.432952] bq27xxx_battery_unseal
>>>> [   10.485168] bq27xxx_battery_update_dm_block
>>>> [   10.485198] bq27xxx-battery 2-0055: update design-capacity to =
4100
>>>=20
>>> looks good
>>>=20
>>>> [   10.485229] bq27xxx_battery_update_dm_block
>>>> [   10.485229] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
>>>=20
>>> ok, ignored
>>>=20
>>>> [   10.511718] bq27xxx_battery_update_dm_block
>>>> [   10.511749] bq27xxx-battery 2-0055: update terminate-voltage to =
3250
>>>=20
>>> looks good
>>>=20
>>>> [   10.826446] bq27xxx_battery_seal
>>>> [   12.150939] bq27xxx_battery_platform_probe
>>>> [   12.151031] bq27xxx_battery_setup
>>>> [   12.151062] bq27xxx_battery_setup: dm_regs=3D  (null)
>>>> [   12.153411] (NULL device *): hwmon: 'bq27000-battery' is not a =
valid name attribute, please fix
>>>> [   12.154327] bq27xxx_battery_settings
>>>> [   12.154357] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
>>>> [   12.154388] bq27xxx_battery_settings: =
power_supply_get_battery_info failed ret=3D-6
>>=20
>> Is there also a bq27000 chip on this device, or a battery with it
>> embedded? If so, it doesn't appear to have a DT node (correct for
>> embedded), hence that warning, which isn't useful in that case. Prob
>> battery_settings() should do:
>>   if (!di->dev->of_node || power_supply_get_battery_info(...) < 0) =
return;
>> altho that would be wrong once get_battery_info() supports ACPI =
config...
>=20
> No it is not available, but could be. The bq27000 can be connected =
through
> HDQ to an OMAP3 and therefore there is no auto-detection. If it is =
configured
> the driver will be loaded. Even if there is no battery_info.
>=20
> In fact we use the same defconfig for several devices and there is one =
(GTA04)
> which only has a bq27000 inside the battery.
>=20
>>=20
>>> ... login:
>>>=20
>>>> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent
>>>> POWER_SUPPLY_NAME=3Dbq27500-1-0
>>>> POWER_SUPPLY_STATUS=3DDischarging
>>>> POWER_SUPPLY_PRESENT=3D1
>>>> POWER_SUPPLY_VOLTAGE_NOW=3D3892000
>>>> POWER_SUPPLY_CURRENT_NOW=3D-317000
>>>> POWER_SUPPLY_CAPACITY=3D0
>>>=20
>>> oops.
>>>=20
>>>> POWER_SUPPLY_CAPACITY_LEVEL=3DLow
>>>> POWER_SUPPLY_TEMP=3D223
>>>> POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D0
>>>> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>>>> POWER_SUPPLY_CHARGE_FULL=3D1147000
>>>> POWER_SUPPLY_CHARGE_NOW=3D2665000
>>>> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
>>>> POWER_SUPPLY_CYCLE_COUNT=3D6
>>>> POWER_SUPPLY_ENERGY_NOW=3D0
>>>> POWER_SUPPLY_POWER_AVG=3D64395
>>>> POWER_SUPPLY_HEALTH=3DDead
>>>=20
>>> oops. But maybe the bq27500 needs a full cycle first
>>=20
>> I wouldn't guess that the above state is due to the DM update
>> sequence, but I suppose that's possible. Another update pass might
>> clarify that.
>=20
> Ok, will do tomorrow.

It seems as if the bq27500 needs some time (or a reboot) to recover from =
no battery and
powered off. Here right after powering on again (same device, same SD =
card):

root@letux:~# dmesg|fgrep bq27
[   10.619140] bq27xxx_battery_setup
[   10.619171] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
[   10.621734] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   10.622680] bq27xxx_battery_settings
[   10.622955] bq27xxx_battery_set_config
[   10.622955] bq27xxx_battery_unseal
[   10.756469] bq27xxx_battery_update_dm_block
[   10.756500] bq27xxx-battery 2-0055: design-capacity has 4100
[   10.756500] bq27xxx_battery_update_dm_block
[   10.756530] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
[   10.766723] bq27xxx_battery_update_dm_block
[   10.766754] bq27xxx-battery 2-0055: terminate-voltage has 3250
[   10.766754] bq27xxx_battery_seal
[   12.300842] bq27xxx_battery_platform_probe
[   12.300933] bq27xxx_battery_setup
[   12.300964] bq27xxx_battery_setup: dm_regs=3D  (null)
[   12.303314] (NULL device *): hwmon: 'bq27000-battery' is not a valid =
name attribute, please fix
[   12.304229] bq27xxx_battery_settings
[   12.304260] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
[   12.304290] bq27xxx_battery_settings: power_supply_get_battery_info =
failed ret=3D-6
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DDischarging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3952000
POWER_SUPPLY_CURRENT_NOW=3D-299000
POWER_SUPPLY_CAPACITY=3D0
POWER_SUPPLY_CAPACITY_LEVEL=3DLow
POWER_SUPPLY_TEMP=3D220
POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D0
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3751000
POWER_SUPPLY_CHARGE_NOW=3D0
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
POWER_SUPPLY_CYCLE_COUNT=3D6
POWER_SUPPLY_ENERGY_NOW=3D0
POWER_SUPPLY_POWER_AVG=3D64398
POWER_SUPPLY_HEALTH=3DDead
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#

and another time:

root@letux:~# dmesg|fgrep bq27
[   10.595611] bq27xxx_battery_setup
[   10.599182] bq27xxx_battery_setup: dm_regs=3Dbf05b0e0
[   10.698791] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   10.764831] bq27xxx_battery_settings
[   10.765075] bq27xxx_battery_set_config
[   10.765106] bq27xxx_battery_unseal
[   10.819915] bq27xxx_battery_update_dm_block
[   10.819946] bq27xxx-battery 2-0055: design-capacity has 4100
[   10.819976] bq27xxx_battery_update_dm_block
[   10.819976] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
[   10.831481] bq27xxx_battery_update_dm_block
[   10.831512] bq27xxx-battery 2-0055: terminate-voltage has 3250
[   10.831542] bq27xxx_battery_seal
[   13.000305] bq27xxx_battery_platform_probe
[   13.000396] bq27xxx_battery_setup
[   13.000427] bq27xxx_battery_setup: dm_regs=3D  (null)
[   13.002807] (NULL device *): hwmon: 'bq27000-battery' is not a valid =
name attribute, please fix
[   13.003692] bq27xxx_battery_settings
[   13.003723] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
[   13.003723] bq27xxx_battery_settings: power_supply_get_battery_info =
failed ret=3D-6
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DCharging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3996000
POWER_SUPPLY_CURRENT_NOW=3D211000
POWER_SUPPLY_CAPACITY=3D0
POWER_SUPPLY_CAPACITY_LEVEL=3DLow
POWER_SUPPLY_TEMP=3D270
POWER_SUPPLY_TIME_TO_FULL_NOW=3D94740
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3751000
POWER_SUPPLY_CHARGE_NOW=3D0
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
POWER_SUPPLY_CYCLE_COUNT=3D6
POWER_SUPPLY_ENERGY_NOW=3D0
POWER_SUPPLY_POWER_AVG=3D759
POWER_SUPPLY_HEALTH=3DDead
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

So rebooting is not enough to awake it.

>=20
>>=20
>>>> POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>>>=20
>>> vvv after plugging in charger
>>>=20
>>>> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent
>>>> POWER_SUPPLY_NAME=3Dbq27500-1-0
>>>> POWER_SUPPLY_STATUS=3DCharging
>>>> POWER_SUPPLY_PRESENT=3D1
>>>> POWER_SUPPLY_VOLTAGE_NOW=3D3923000
>>>> POWER_SUPPLY_CURRENT_NOW=3D204000
>>>> POWER_SUPPLY_CAPACITY=3D0
>>>> POWER_SUPPLY_CAPACITY_LEVEL=3DLow
>>>> POWER_SUPPLY_TEMP=3D249
>>>> POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D0
>>>> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>>>> POWER_SUPPLY_CHARGE_FULL=3D1147000
>>>> POWER_SUPPLY_CHARGE_NOW=3D2665000
>>>> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
>>>> POWER_SUPPLY_CYCLE_COUNT=3D6
>>>> POWER_SUPPLY_ENERGY_NOW=3D0
>>>> POWER_SUPPLY_POWER_AVG=3D800
>>>> POWER_SUPPLY_HEALTH=3DDead
>>>> POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>>>> root@letux:~#
>>>=20
>>> Now a reboot after removing charger and battery for several minutes:
>>>=20
>>>> root@letux:~# dmesg|fgrep bq27
>>>> [   10.482818] bq27xxx_battery_setup
>>>> [   12.179687] bq27xxx_battery_platform_probe
>>>> [   12.179779] bq27xxx_battery_setup
>>>> [   12.179809] bq27xxx_battery_setup: dm_regs=3D  (null)
>>>> [   12.182495] (NULL device *): hwmon: 'bq27000-battery' is not a =
valid name attribute, please fix
>>>> [   12.183502] bq27xxx_battery_settings
>>>> [   12.183532] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
>>>> [   12.183563] bq27xxx_battery_settings: =
power_supply_get_battery_info failed ret=3D-6
>>>> [   15.145812] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
>>>> [   15.152618] (NULL device *): hwmon: 'bq27500-1-0' is not a valid =
name attribute, please fix
>>>> [   15.346557] bq27xxx_battery_settings
>>>> [   15.350585] bq27xxx_battery_set_config
>>>> [   15.354553] bq27xxx_battery_unseal
>>>> [   15.576538] bq27xxx_battery_update_dm_block
>>>> [   15.580993] bq27xxx-battery 2-0055: design-capacity has 4100
>>>=20
>>> ^^^ ok, no change needed
>>>=20
>>>> [   15.676818] bq27xxx_battery_update_dm_block
>>>> [   15.681243] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
>>>> [   15.798675] bq27xxx_battery_update_dm_block
>>>> [   15.803100] bq27xxx-battery 2-0055: update terminate-voltage to =
3250
>>>=20
>>> ^^^ looks as if this is not stored in NVM. Should it be?
>>=20
>> Oh dear. I imagine this is due to a flaw in the multi-block DM update
>> logic. It could be that one of the pauses between calls should be
>> longer The terminate-voltage spec comes from this datasheet:
>> page 19, http://www.ti.com/lit/ds/symlink/bq27500.pdf
>>=20
>> It's possible that this second pass did update it. What does the next
>> reboot show?
>=20
> Will boot tomorrow with exactly the same system and report.

This time it did have remembered the terminate-voltage:
(copy from above)

[   10.766754] bq27xxx-battery 2-0055: terminate-voltage has 3250

>=20
>>=20
>>> BTW: it would be nice if all "update" messages could tell the old =
value as well.
>>=20
>> We have the orig values in memory since we read the block before
>> updating. Feel free to patch that in :-)
>=20
> Ok.

Is a one-liner. Will submit a PATCH.

>=20
>>=20
>>>> [   16.011169] bq27xxx_battery_seal
>>>> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent
>>>> POWER_SUPPLY_NAME=3Dbq27500-1-0
>>>> POWER_SUPPLY_STATUS=3DDischarging
>>>> POWER_SUPPLY_PRESENT=3D1
>>>> POWER_SUPPLY_VOLTAGE_NOW=3D3894000
>>>> POWER_SUPPLY_CURRENT_NOW=3D-291000
>>>> POWER_SUPPLY_CAPACITY=3D71
>>>=20
>>> ^^^ looks as if the bq27500 did recover from reprogramming
>>>=20
>>>> POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
>>>> POWER_SUPPLY_TEMP=3D223
>>>> POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D31200
>>>> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>>>> POWER_SUPPLY_CHARGE_FULL=3D3748000
>>>> POWER_SUPPLY_CHARGE_NOW=3D2713000
>>>> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
>>>> POWER_SUPPLY_CYCLE_COUNT=3D6
>>>> POWER_SUPPLY_ENERGY_NOW=3D9930000
>>>> POWER_SUPPLY_POWER_AVG=3D64407
>>>> POWER_SUPPLY_HEALTH=3DGood
>>>=20
>>> ^^^ same here
>>>=20
>>>> POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>>>> root@letux:~#
>>=20
>> For general use on OpenPandora, you wouldn't have
>> config...dt_updates_nvm option set,
>=20
> Yes.
>=20
>> so the driver should report what
>> the chip settings are and whether they aren't what the DT spec'd.
>> Let's verify that too...
>=20
> Ok.

Now here a reboot with a newly built kernel with =
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM disabled
and real battery definition:

root@letux:~# dmesg|fgrep bq27
[   10.339141] bq27xxx_battery_setup
[   10.342712] bq27xxx_battery_setup: dm_regs=3Dbf0520de
[   10.362854] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   11.945251] bq27xxx_battery_platform_probe
[   11.945312] bq27xxx_battery_setup
[   11.945373] bq27xxx_battery_setup: dm_regs=3D  (null)
[   11.947662] (NULL device *): hwmon: 'bq27000-battery' is not a valid =
name attribute, please fix
[   11.948608] bq27xxx_battery_settings
[   11.948608] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
[   11.948638] bq27xxx_battery_settings: power_supply_get_battery_info =
failed ret=3D-6
[   15.036163] bq27xxx_battery_settings
[   15.112274] bq27xxx_battery_set_config
[   15.138916] bq27xxx_battery_unseal
[   15.246124] bq27xxx_battery_update_dm_block
[   15.250579] bq27xxx-battery 2-0055: design-capacity has 4100; update =
to 4000 disallowed for flash/NVM data memory
[   15.418457] bq27xxx_battery_update_dm_block
[   15.423034] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
[   15.569061] bq27xxx_battery_update_dm_block
[   15.573516] bq27xxx-battery 2-0055: terminate-voltage has 3250; =
update to 3200 disallowed for flash/NVM data memory
[   15.664703] bq27xxx_battery_seal
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DCharging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D3996000
POWER_SUPPLY_CURRENT_NOW=3D166000
POWER_SUPPLY_CAPACITY=3D1
POWER_SUPPLY_CAPACITY_LEVEL=3DLow
POWER_SUPPLY_TEMP=3D251
POWER_SUPPLY_TIME_TO_FULL_NOW=3D70560
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3751000
POWER_SUPPLY_CHARGE_NOW=3D7000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
POWER_SUPPLY_CYCLE_COUNT=3D6
POWER_SUPPLY_ENERGY_NOW=3D0
POWER_SUPPLY_POWER_AVG=3D828
POWER_SUPPLY_HEALTH=3DDead
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#


And another reboot (powered up in between):

root@letux:~# dmesg|fgrep bq27
[   10.271545] bq27xxx_battery_setup
[   10.271575] bq27xxx_battery_setup: dm_regs=3Dbf0520de
[   10.274139] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   10.345062] bq27xxx_battery_settings
[   10.345306] bq27xxx_battery_set_config
[   10.345336] bq27xxx_battery_unseal
[   10.382415] bq27xxx_battery_update_dm_block
[   10.382446] bq27xxx-battery 2-0055: design-capacity has 4100; update =
to 4000 disallowed for flash/NVM data memory
[   10.382446] bq27xxx_battery_update_dm_block
[   10.382476] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
[   10.392852] bq27xxx_battery_update_dm_block
[   10.392883] bq27xxx-battery 2-0055: terminate-voltage has 3250; =
update to 3200 disallowed for flash/NVM data memory
[   10.392883] bq27xxx_battery_seal
[   11.832763] bq27xxx_battery_platform_probe
[   11.832855] bq27xxx_battery_setup
[   11.832885] bq27xxx_battery_setup: dm_regs=3D  (null)
[   11.846038] (NULL device *): hwmon: 'bq27000-battery' is not a valid =
name attribute, please fix
[   11.846984] bq27xxx_battery_settings
[   11.847015] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
[   11.847045] bq27xxx_battery_settings: power_supply_get_battery_info =
failed ret=3D-6
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DCharging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D4001000
POWER_SUPPLY_CURRENT_NOW=3D200000
POWER_SUPPLY_CAPACITY=3D1
POWER_SUPPLY_CAPACITY_LEVEL=3DLow
POWER_SUPPLY_TEMP=3D270
POWER_SUPPLY_TIME_TO_FULL_NOW=3D69420
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3751000
POWER_SUPPLY_CHARGE_NOW=3D32000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
POWER_SUPPLY_CYCLE_COUNT=3D6
POWER_SUPPLY_ENERGY_NOW=3D51000
POWER_SUPPLY_POWER_AVG=3D756
POWER_SUPPLY_HEALTH=3DDead
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

And after reenabling CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM

root@letux:~# dmesg|fgrep bq27
[   10.316589] bq27xxx_battery_setup
[   10.320129] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
[   10.440979] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   10.441986] bq27xxx_battery_settings
[   10.442230] bq27xxx_battery_set_config
[   10.442260] bq27xxx_battery_unseal
[   10.503662] bq27xxx_battery_update_dm_block
[   10.503723] bq27xxx-battery 2-0055: update design-capacity from 4100 =
to 4000
[   10.503723] bq27xxx_battery_update_dm_block
[   10.503753] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
[   10.544769] bq27xxx_battery_update_dm_block
[   10.544799] bq27xxx-battery 2-0055: update terminate-voltage from =
3250 to 3200
[   10.866546] bq27xxx_battery_seal
[   11.892913] bq27xxx_battery_platform_probe
[   11.893005] bq27xxx_battery_setup
[   11.893035] bq27xxx_battery_setup: dm_regs=3D  (null)
[   11.913208] (NULL device *): hwmon: 'bq27000-battery' is not a valid =
name attribute, please fix
[   11.914154] bq27xxx_battery_settings
[   11.914184] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
[   11.914215] bq27xxx_battery_settings: power_supply_get_battery_info =
failed ret=3D-6
root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
POWER_SUPPLY_NAME=3Dbq27500-1-0
POWER_SUPPLY_STATUS=3DCharging
POWER_SUPPLY_PRESENT=3D1
POWER_SUPPLY_VOLTAGE_NOW=3D4012000
POWER_SUPPLY_CURRENT_NOW=3D256000
POWER_SUPPLY_CAPACITY=3D3
POWER_SUPPLY_CAPACITY_LEVEL=3DLow
POWER_SUPPLY_TEMP=3D284
POWER_SUPPLY_TIME_TO_FULL_NOW=3D54960
POWER_SUPPLY_TECHNOLOGY=3DLi-ion
POWER_SUPPLY_CHARGE_FULL=3D3751000
POWER_SUPPLY_CHARGE_NOW=3D76000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4000000
POWER_SUPPLY_CYCLE_COUNT=3D6
POWER_SUPPLY_ENERGY_NOW=3D188000
POWER_SUPPLY_POWER_AVG=3D1027
POWER_SUPPLY_HEALTH=3DDead
POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
root@letux:~#=20

This time reprogramming worked and the capacity level is regenerating.

So I'd say everything works as expected.

I'll send my latest patches for review asap.

BR,
Nikolaus
