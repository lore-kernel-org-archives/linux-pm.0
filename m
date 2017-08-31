From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity values for bq27421
Date: Thu, 31 Aug 2017 08:58:36 +0200
Message-ID: <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com> <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com> <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com> <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:34066 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdHaG6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2017 02:58:42 -0400
In-Reply-To: <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com

Hi Liam,

> Am 30.08.2017 um 13:24 schrieb Liam Breck <liam@networkimprov.net>:
>=20
> Hi Nikolaus,
>=20
> On Wed, Aug 30, 2017 at 2:30 AM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>> Hi Liam and Sebastian,
>>=20
>>> Am 29.08.2017 um 22:20 schrieb Liam Breck <liam@networkimprov.net>:
>>>=20
>>> Hi Nikolaus, thanks for the patch...
>>>=20
>>> On Tue, Aug 29, 2017 at 1:10 PM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>>> Tested on Pyra prototype with bq27421.
>>>>=20
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> drivers/power/supply/bq27xxx_battery.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c =
b/drivers/power/supply/bq27xxx_battery.c
>>>> index b6c3120ca5ad..e3c878ef7c7e 100644
>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>> @@ -688,7 +688,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] =
=3D {
>>>> #define bq27545_dm_regs 0
>>>> #endif
>>>>=20
>>>> -#if 0 /* not yet tested */
>>>> +#if 1 /* tested on Pyra */
>>>> static struct bq27xxx_dm_reg bq27421_dm_regs[] =3D {
>>>=20
>>> I think we can drop the #if and #else...#endif so it's just the
>>> dm_regs table, as with bq27425.
>>=20
>> I have fixed that and did take the chance to update my OpenPandora
>> kernel so that I also could test and make the bq27500 working.
>=20
> Is this gauge on the board or in the battery?

It is on the board.

> If in the battery,
> monitored-battery should not be used.
>=20
> For a gauge on the board, if a user changes the battery to a different
> type, they need to update the dtb.

Well, that is a little difficult to control, but here we have only
one standard Pandora cell. There may exist replacements with different
capacity, but that should not be our problem...

>=20
> I assume you built with config_battery_bq27xxx_dt_updates_nvm?

Yes.

>=20
>> The biggest hurdle was to find out that I have to change the
>> compatible string to "ti,bq27500-1" to get non-NULL dm_regs...
>>=20
>> [   12.765930] bq27xxx_battery_i2c_probe name=3Dbq27500-1-0
>> [   12.771392] bq27xxx_battery_i2c_probe call setup
>> [   12.874816] bq27xxx_battery_setup
>> [   12.904266] bq27xxx_battery_setup: dm_regs=3Dbf0520e0
>> [   12.933380] (NULL device *): hwmon: 'bq27500-1-0' is not a valid =
name attribute, please fix
>> [   13.234893] bq27xxx_battery_settings
>> [   13.238891] bq27xxx-battery 2-0055: invalid =
battery:energy-full-design-microwatt-hours 14800000
>=20
> The chip does not support this param, so it should be zero, as it has
> to be set if charge-full-design-* is set. Can you try that?

Hm. IMHO the DT should describe what the battery has and the driver =
should simply ignore
values it can't handle or reject them but do the best out of it. Telling =
the driver to ignore
a value by setting to 0 would IMHO be the wrong approach.

We are also working on the generic-adc-battery driver that makes use of =
the same battery DT
node so that people can choose if they want to configure a kernel for =
fuel gauge or
g-a-b or even both.

>=20
>> [   13.312469] bq27xxx_battery_set_config
>> [   13.407745] bq27xxx_battery_unseal
>> [   13.455993] bq27xxx_battery_update_dm_block
>> [   13.460418] bq27xxx-battery 2-0055: update terminate-voltage to =
3200
>> [   13.694885] bq27xxx_battery_seal
>=20
> We need to see output after a reboot.

This was the value after first boot with the new driver enabled.

A second boot after removing and reinserting battery shows:

[   11.256713] bq27xxx_battery_setup
[   11.256744] bq27xxx_battery_setup: dm_regs=3Dbf05b0e0
[   11.257690] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name =
attribute, please fix
[   11.258056] bq27xxx_battery_settings
[   11.258300] bq27xxx-battery 2-0055: invalid =
battery:energy-full-design-microwatt-hours 14800000
[   11.258300] bq27xxx_battery_set_config
[   11.258331] bq27xxx_battery_unseal

> Note that this chip has NVM so
> these settings persist without power.

Yes I know. Up to now the bq27500 has been programmed during production =
test
by some special flashing tool. Now as the kernel driver has this =
capability,
we should make (optionally) use of it.

>=20
>> Does this look ok for
>>=20
>>        bat: battery {
>>                compatible =3D "simple-battery", =
"openpandora-battery";
>>                voltage-min-design-microvolt =3D <3200000>;
>>                energy-full-design-microwatt-hours =3D <14800000>;
>>                charge-full-design-microamp-hours =3D <4000000>;
>>        };
>>=20
>> ?

I mainly had some initial doubts that it did not tell something like
"update design-capacity" to 4000 or "design-capacity has 4000"

Ah, I see:

		/* assume design energy & capacity are in same block */

This means the bq27500 never programs capacity because we can't specify =
energy.
So I't suggest to revise this rule and coupling of energy and capacity =
setting.

>>=20
>> I will send a patch for enabling both fuel gauges and the =
omap3-pandora-common.dtsi asap.
>=20
> You probably don't want this in upstream dts, as it only programs the
> gauge if the kernel has the above config option. If the box runs a
> stock distro, it won't work. A custom-built kernel with the above dts
> programs the gauge unless the user sets the module param
> dt_monitored_battery_updates_nvm=3D0. The requisite dtb should be
> packaged with the custom-built kernel, and deployed with awareness of
> the actual battery present.

Imho, DT can and should describe all properties of the standard =
OpenPandora
battery (and not missing registers of the bq27500).

Using this information or not should be defined by different defconfigs.

Anyways I have now collected my patches into a patch set for further
review and cherry-picking.

BR,
Nikolaus
