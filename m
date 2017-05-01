From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Mon, 1 May 2017 11:18:23 -0700
Message-ID: <CAKvHMgTqxvBEKRREPTZtkWVCPC+UoTFyXBNOMwdy=aNiv5L3BQ@mail.gmail.com>
References: <20170430203801.32357-1-contact@paulk.fr> <20170430203801.32357-5-contact@paulk.fr>
 <CAKvHMgQ+uS=xw+TD_raPECG1psVWF_=M-35cpbDtNUChQYWhnw@mail.gmail.com> <1493635153.6493.7.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34549 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdEASSY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 14:18:24 -0400
Received: by mail-it0-f66.google.com with SMTP id c26so12956992itd.1
        for <linux-pm@vger.kernel.org>; Mon, 01 May 2017 11:18:24 -0700 (PDT)
In-Reply-To: <1493635153.6493.7.camel@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>

Hi Paul,

On Mon, May 1, 2017 at 3:39 AM, Paul Kocialkowski <contact@paulk.fr> wrote:
> Hi,
>
> Le dimanche 30 avril 2017 =C3=A0 15:35 -0700, Liam Breck a =C3=A9crit :
>> Hi Paul,
>>
>> On Sun, Apr 30, 2017 at 1:38 PM, Paul Kocialkowski <contact@paulk.fr> wr=
ote:
>> > The status reported directly by the battery controller is not always
>> > reliable and should be corrected based on the current draw information=
.
>>
>> I have noticed incorrect status on bq27425. On which chip/s did you
>> find this? It might not be a flaw across the whole family...
>
> I got this with a BQ27541 on a veyron_minnie (Chromebook Flip C100PA).
>
> From my experience with batteries in general, it seems that flags are not
> updated as often and are often not as accurate as what the current info t=
ells.
> So I think it's best to rely on the current info rather than the chip-pro=
vided
> flags.
>
> This makes a big difference during actual use: current can tell almost in=
stantly
>  that a supply was plugged-in/unplugged while the charging/full flags tak=
e a lot
> longer to be updated. Also, the full flag is never set in my case (perhap=
s it
> still expects the initial full charge value) even though it should be.
>
> I don't think that will cause a problem for other chips of the family any=
way:
> they should only benefit from this!
>
>> > This implements such a correction with a dedicated function, called
>> > when retrieving the supply status.
>> >
>> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>> > ---
>> >  drivers/power/supply/bq27xxx_battery.c | 28 +++++++++++++++++++++++++=
+++
>> >  1 file changed, 28 insertions(+)
>> >
>> > diff --git a/drivers/power/supply/bq27xxx_battery.c
>> > b/drivers/power/supply/bq27xxx_battery.c
>> > index cade00df6162..f7694e775e68 100644
>> > --- a/drivers/power/supply/bq27xxx_battery.c
>> > +++ b/drivers/power/supply/bq27xxx_battery.c
>> > @@ -1171,8 +1171,22 @@ static int bq27xxx_battery_status(struct
>> > bq27xxx_device_info *di,
>> >                                   union power_supply_propval *val)
>> >  {
>> >         int status;
>> > +       int curr;
>> > +       int flags;
>> > +
>> > +       curr =3D bq27xxx_read(di, BQ27XXX_REG_AI, false);
>> > +       if (curr < 0) {
>> > +               dev_err(di->dev, "error reading current\n");
>> > +               return curr;
>> > +       }
>>
>> Maybe read current (then sign-flip, *=3D 1000) above the status fix?
>
> From what I understood of the rest of the driver (see bq27xxx_battery_cur=
rent),
> sign flip is done differently in bq27000/bq27010 and others, so since we =
already
> have specific instruction blocks, I think it's best to put the current
> calculation in each.

It's Andrew's call, but to my eye a single block of code for current
calc is more readable.

> Also, since we only test the current against 0 I thought it didn't matter=
 that
> the scale is not the same for both values. I could add the following for =
the
> bq27000/bq27010: * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS
> but it won't change a thing.
>
>> >         if (di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ27010) {
>> > +               flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
>> > +               if (flags & BQ27000_FLAG_CHGS) {
>> > +                       dev_dbg(di->dev, "negative current!\n");
>> > +                       curr =3D -curr;
>> > +               }
>> > +
>> >                 if (di->cache.flags & BQ27000_FLAG_FC)
>> >                         status =3D POWER_SUPPLY_STATUS_FULL;
>> >                 else if (di->cache.flags & BQ27000_FLAG_CHGS)
>> > @@ -1182,6 +1196,8 @@ static int bq27xxx_battery_status(struct
>> > bq27xxx_device_info *di,
>> >                 else
>> >                         status =3D POWER_SUPPLY_STATUS_DISCHARGING;
>> >         } else {
>> > +               curr =3D (int)((s16)curr) * 1000;
>> > +

Why truncate to s16?

>> >                 if (di->cache.flags & BQ27XXX_FLAG_FC)
>> >                         status =3D POWER_SUPPLY_STATUS_FULL;
>> >                 else if (di->cache.flags & BQ27XXX_FLAG_DSC)
>> > @@ -1190,6 +1206,18 @@ static int bq27xxx_battery_status(struct
>> > bq27xxx_device_info *di,
>> >                         status =3D POWER_SUPPLY_STATUS_CHARGING;
>> >         }
>> >
>> > +
>> > +       if (curr =3D=3D 0 && status !=3D POWER_SUPPLY_STATUS_NOT_CHARG=
ING)
>> > +               status =3D POWER_SUPPLY_STATUS_FULL;
>> > +
>> > +       if (status =3D=3D POWER_SUPPLY_STATUS_FULL) {
>> > +               /* Drawing or providing current when full */
>> > +               if (curr > 0)
>> > +                       status =3D POWER_SUPPLY_STATUS_CHARGING;
>> > +               else if (curr < 0)
>> > +                       status =3D POWER_SUPPLY_STATUS_DISCHARGING;
>> > +       }
>> > +
>> >         if (di->status_retry =3D=3D 0 && di->status_change_reference !=
=3D status)
>> > {
>> >                 di->status_change_reference =3D status;
>> >                 power_supply_changed(di->bat);
>> > --
>> > 2.12.2
>> >
> --
> Paul Kocialkowski, developer of free digital technology and hardware supp=
ort
>
> Website: https://www.paulk.fr/
> Coding blog: https://code.paulk.fr/
> Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
