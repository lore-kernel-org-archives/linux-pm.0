From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity values for bq27421
Date: Fri, 8 Sep 2017 19:38:37 +0200
Message-ID: <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com> <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com> <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com> <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com> <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com> <CAKvHMgT6AHfjnXvD5jeWP_9wAm_GQNJxm=Nm1jH32NeaVZjdYw@mail.gmail.com> <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com> <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:25704 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbdIHRin (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 13:38:43 -0400
In-Reply-To: <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com

Hi Liam,
I finally continues testing on OpenPandora.

> Am 31.08.2017 um 22:19 schrieb Liam Breck <liam@networkimprov.net>:
>=20
> Hi,
>=20
> This may be a fix that allows >0 input from DT, but won't try to
> program the register since the first 3 fields aren't compatible:
>=20
> ... bq27500_dm_regs[] =3D {
> ...
>  [bq27xxx_dm_design_energy] =3D {  0,  0, 0,    0, 65535 }, /* missing =
on chip */
> NB: align columns with other rows

I have tried with this DT

	bat: battery {
		compatible =3D "simple-battery", "openpandora-battery";
		voltage-min-design-microvolt =3D <3250000>;
		energy-full-design-microwatt-hours =3D <14800000>;
		charge-full-design-microamp-hours =3D <4100000>;
	};

and here is the result:

> root@letux:~# dmesg|fgrep bq27
> [   10.391235] bq27xxx_battery_setup
> [   10.391265] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
> [   10.393798] (NULL device *): hwmon: 'bq27500-1-0' is not a valid =
name attribute, please fix
> [   10.432678] bq27xxx_battery_settings
> [   10.432952] bq27xxx_battery_set_config
> [   10.432952] bq27xxx_battery_unseal
> [   10.485168] bq27xxx_battery_update_dm_block
> [   10.485198] bq27xxx-battery 2-0055: update design-capacity to 4100

looks good

> [   10.485229] bq27xxx_battery_update_dm_block
> [   10.485229] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec

ok, ignored

> [   10.511718] bq27xxx_battery_update_dm_block
> [   10.511749] bq27xxx-battery 2-0055: update terminate-voltage to =
3250

looks good

> [   10.826446] bq27xxx_battery_seal
> [   12.150939] bq27xxx_battery_platform_probe
> [   12.151031] bq27xxx_battery_setup
> [   12.151062] bq27xxx_battery_setup: dm_regs=3D  (null)
> [   12.153411] (NULL device *): hwmon: 'bq27000-battery' is not a =
valid name attribute, please fix
> [   12.154327] bq27xxx_battery_settings
> [   12.154357] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
> [   12.154388] bq27xxx_battery_settings: power_supply_get_battery_info =
failed ret=3D-6

... login:

> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
> POWER_SUPPLY_NAME=3Dbq27500-1-0
> POWER_SUPPLY_STATUS=3DDischarging
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_VOLTAGE_NOW=3D3892000
> POWER_SUPPLY_CURRENT_NOW=3D-317000
> POWER_SUPPLY_CAPACITY=3D0

oops.

> POWER_SUPPLY_CAPACITY_LEVEL=3DLow
> POWER_SUPPLY_TEMP=3D223
> POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D0
> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> POWER_SUPPLY_CHARGE_FULL=3D1147000
> POWER_SUPPLY_CHARGE_NOW=3D2665000
> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
> POWER_SUPPLY_CYCLE_COUNT=3D6
> POWER_SUPPLY_ENERGY_NOW=3D0
> POWER_SUPPLY_POWER_AVG=3D64395
> POWER_SUPPLY_HEALTH=3DDead

oops. But maybe the bq27500 needs a full cycle first

> POWER_SUPPLY_MANUFACTURER=3DTexas Instruments

vvv after plugging in charger

> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
> POWER_SUPPLY_NAME=3Dbq27500-1-0
> POWER_SUPPLY_STATUS=3DCharging
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_VOLTAGE_NOW=3D3923000
> POWER_SUPPLY_CURRENT_NOW=3D204000
> POWER_SUPPLY_CAPACITY=3D0
> POWER_SUPPLY_CAPACITY_LEVEL=3DLow
> POWER_SUPPLY_TEMP=3D249
> POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D0
> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> POWER_SUPPLY_CHARGE_FULL=3D1147000
> POWER_SUPPLY_CHARGE_NOW=3D2665000
> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
> POWER_SUPPLY_CYCLE_COUNT=3D6
> POWER_SUPPLY_ENERGY_NOW=3D0
> POWER_SUPPLY_POWER_AVG=3D800
> POWER_SUPPLY_HEALTH=3DDead
> POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
> root@letux:~#=20

Now a reboot after removing charger and battery for several minutes:

> root@letux:~# dmesg|fgrep bq27
> [   10.482818] bq27xxx_battery_setup
> [   12.179687] bq27xxx_battery_platform_probe
> [   12.179779] bq27xxx_battery_setup
> [   12.179809] bq27xxx_battery_setup: dm_regs=3D  (null)
> [   12.182495] (NULL device *): hwmon: 'bq27000-battery' is not a =
valid name attribute, please fix
> [   12.183502] bq27xxx_battery_settings
> [   12.183532] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
> [   12.183563] bq27xxx_battery_settings: power_supply_get_battery_info =
failed ret=3D-6
> [   15.145812] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
> [   15.152618] (NULL device *): hwmon: 'bq27500-1-0' is not a valid =
name attribute, please fix
> [   15.346557] bq27xxx_battery_settings
> [   15.350585] bq27xxx_battery_set_config
> [   15.354553] bq27xxx_battery_unseal
> [   15.576538] bq27xxx_battery_update_dm_block
> [   15.580993] bq27xxx-battery 2-0055: design-capacity has 4100

^^^ ok, no change needed

> [   15.676818] bq27xxx_battery_update_dm_block
> [   15.681243] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
> [   15.798675] bq27xxx_battery_update_dm_block
> [   15.803100] bq27xxx-battery 2-0055: update terminate-voltage to =
3250

^^^ looks as if this is not stored in NVM. Should it be?

BTW: it would be nice if all "update" messages could tell the old value =
as well.

> [   16.011169] bq27xxx_battery_seal
> root@letux:~# cat /sys/class/power_supply/bq27500-1-0/uevent=20
> POWER_SUPPLY_NAME=3Dbq27500-1-0
> POWER_SUPPLY_STATUS=3DDischarging
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_VOLTAGE_NOW=3D3894000
> POWER_SUPPLY_CURRENT_NOW=3D-291000
> POWER_SUPPLY_CAPACITY=3D71

^^^ looks as if the bq27500 did recover from reprogramming

> POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> POWER_SUPPLY_TEMP=3D223
> POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D31200
> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> POWER_SUPPLY_CHARGE_FULL=3D3748000
> POWER_SUPPLY_CHARGE_NOW=3D2713000
> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D4100000
> POWER_SUPPLY_CYCLE_COUNT=3D6
> POWER_SUPPLY_ENERGY_NOW=3D9930000
> POWER_SUPPLY_POWER_AVG=3D64407
> POWER_SUPPLY_HEALTH=3DGood

^^^ same here

> POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
> root@letux:~#=20


>=20
> Pls CC me on patch posts. You left me off your last series.

Sorry, did copy the address list around and dropped off some :(

BR,
Nikolaus
