From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity values for bq27421
Date: Sat, 9 Sep 2017 00:08:03 +0200
Message-ID: <BD7B5AE4-ACD7-4255-8D9D-F0987CFF032A@goldelico.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com> <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com> <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com> <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com> <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com> <CAKvHMgT6AHfjnXvD5jeWP_9wAm_GQNJxm=Nm1jH32NeaVZjdYw@mail.gmail.com> <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com> <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com> <9903AE74-6BAA-4051-ADFC-0DB5972AF26E@goldelico.com> <CAKvHMgRKO4wSWr_XU5wCM6-yadz4kY++zq96w-RSRrzBjQF1zQ@mail.gmail.com> <13B50F41-D8AC-46E5-B57C-274CFB4DAD75@goldelico.com> <CAKvHMgSQduvA6MFgNMgaYejep74OfJPUnCGJ3cKeHty=OAabPg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:26200 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753026AbdIHWII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 18:08:08 -0400
In-Reply-To: <CAKvHMgSQduvA6MFgNMgaYejep74OfJPUnCGJ3cKeHty=OAabPg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com


> Am 08.09.2017 um 22:57 schrieb Liam Breck <liam@networkimprov.net>:
>=20
> Howdy,
>=20
> On Fri, Sep 8, 2017 at 1:28 PM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>> Hi Liam,
>>=20
>>> Am 08.09.2017 um 22:19 schrieb Liam Breck <liam@networkimprov.net>:
>>>=20
>>> Hi Nikolaus,
>>>=20
>>> On Fri, Sep 8, 2017 at 10:38 AM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>> Hi Liam,
>>>> I finally continues testing on OpenPandora.
>>>>=20
>>>>> Am 31.08.2017 um 22:19 schrieb Liam Breck =
<liam@networkimprov.net>:
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> This may be a fix that allows >0 input from DT, but won't try to
>>>>> program the register since the first 3 fields aren't compatible:
>>>>>=20
>>>>> ... bq27500_dm_regs[] =3D {
>>>>> ...
>>>>> [bq27xxx_dm_design_energy] =3D {  0,  0, 0,    0, 65535 }, /* =
missing on chip */
>>>>> NB: align columns with other rows
>>>>=20
>>>> I have tried with this DT
>>>>=20
>>>>       bat: battery {
>>>>               compatible =3D "simple-battery", =
"openpandora-battery";
>>>>               voltage-min-design-microvolt =3D <3250000>;
>>>>               energy-full-design-microwatt-hours =3D <14800000>;
>>>>               charge-full-design-microamp-hours =3D <4100000>;
>>>>       };
>>>>=20
>>>> and here is the result:
>>>>=20
>>>>> root@letux:~# dmesg|fgrep bq27
>>>>> [   10.391235] bq27xxx_battery_setup
>>>>> [   10.391265] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
>>>>> [   10.393798] (NULL device *): hwmon: 'bq27500-1-0' is not a =
valid name attribute, please fix
>>>>> [   10.432678] bq27xxx_battery_settings
>>>>> [   10.432952] bq27xxx_battery_set_config
>>>>> [   10.432952] bq27xxx_battery_unseal
>>>>> [   10.485168] bq27xxx_battery_update_dm_block
>>>>> [   10.485198] bq27xxx-battery 2-0055: update design-capacity to =
4100
>>>>=20
>>>> looks good
>>>>=20
>>>>> [   10.485229] bq27xxx_battery_update_dm_block
>>>>> [   10.485229] bq27xxx-battery 2-0055: buffer does not match =
design-energy dm spec
>>>>=20
>>>> ok, ignored
>>>>=20
>>>>> [   10.511718] bq27xxx_battery_update_dm_block
>>>>> [   10.511749] bq27xxx-battery 2-0055: update terminate-voltage to =
3250
>>>>=20
>>>> looks good
>>>>=20
>>>>> [   10.826446] bq27xxx_battery_seal
>>>>> [   12.150939] bq27xxx_battery_platform_probe
>>>>> [   12.151031] bq27xxx_battery_setup
>>>>> [   12.151062] bq27xxx_battery_setup: dm_regs=3D  (null)
>>>>> [   12.153411] (NULL device *): hwmon: 'bq27000-battery' is not a =
valid name attribute, please fix
>>>>> [   12.154327] bq27xxx_battery_settings
>>>>> [   12.154357] power_supply bq27000-battery: =
power_supply_get_battery_info currently only supports devicetree
>>>>> [   12.154388] bq27xxx_battery_settings: =
power_supply_get_battery_info failed ret=3D-6
>>>=20
>>> Is there also a bq27000 chip on this device, or a battery with it
>>> embedded? If so, it doesn't appear to have a DT node (correct for
>>> embedded), hence that warning, which isn't useful in that case. Prob
>>> battery_settings() should do:
>>>   if (!di->dev->of_node || power_supply_get_battery_info(...) < 0) =
return;
>>> altho that would be wrong once get_battery_info() supports ACPI =
config...
>>=20
>> No it is not available, but could be. The bq27000 can be connected =
through
>> HDQ to an OMAP3 and therefore there is no auto-detection. If it is =
configured
>> the driver will be loaded. Even if there is no battery_info.
>>=20
>> In fact we use the same defconfig for several devices and there is =
one (GTA04)
>> which only has a bq27000 inside the battery.
>=20
> Any idea why the driver detects a non-present bq27000 and calls
> probe() for it? defconfig with battery_bq27xxx=3Dy ?

Yes.

The key reason is that hdq can't detect presence of a device
without support of the device driver. Which means as soon as
you have hdq and the battery driver it will be present and
create /sys/class/power entry. Which says "battery not present".

It is the best it can do. Especially for removeable batteries
(which might be installed some time after boot and probing).

If you want to study further, there is some code in the hdq
subsystem to load the bq27000.

BR,
Nikolaus
