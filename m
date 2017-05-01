From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 1/5] power: supply: bq27xxx: Pass of_node along to allow
 device-tree supply
Date: Mon, 1 May 2017 11:30:33 -0700
Message-ID: <CAKvHMgQKBSbzbS3sG3A+Yi3X5J=iMxLYDvK1YJjCPXmq_GimZQ@mail.gmail.com>
References: <20170430203801.32357-1-contact@paulk.fr> <CAKvHMgSijN8vQUePoTKRC5nqaW-Shh4_9ZKiKq0Uae3ZLkiDSA@mail.gmail.com>
 <1493635591.6493.10.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36649 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdEASaf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 14:30:35 -0400
Received: by mail-it0-f66.google.com with SMTP id x188so12956309itb.3
        for <linux-pm@vger.kernel.org>; Mon, 01 May 2017 11:30:34 -0700 (PDT)
In-Reply-To: <1493635591.6493.10.camel@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>

On Mon, May 1, 2017 at 3:46 AM, Paul Kocialkowski <contact@paulk.fr> wrote:
> Le dimanche 30 avril 2017 =C3=A0 15:03 -0700, Liam Breck a =C3=A9crit :
>> [dropped some CCs]
>>
>>
>> On Sun, Apr 30, 2017 at 1:37 PM, Paul Kocialkowski <contact@paulk.fr> wr=
ote:
>> > This passes the of_node from the bq27xxx i2c battery driver to the
>> > common code, so that it can be registered and provide external supplie=
s
>> > linked with device-tree.
>> >
>> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>> > ---
>> >  drivers/power/supply/bq27xxx_battery.c     | 5 ++++-
>> >  drivers/power/supply/bq27xxx_battery_i2c.c | 1 +
>> >  include/linux/power/bq27xxx_battery.h      | 1 +
>> >  3 files changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/power/supply/bq27xxx_battery.c
>> > b/drivers/power/supply/bq27xxx_battery.c
>> > index 398801a21b86..6ef95442a918 100644
>> > --- a/drivers/power/supply/bq27xxx_battery.c
>> > +++ b/drivers/power/supply/bq27xxx_battery.c
>> > @@ -1351,7 +1351,10 @@ static void bq27xxx_external_power_changed(stru=
ct
>> > power_supply *psy)
>> >  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>> >  {
>> >         struct power_supply_desc *psy_desc;
>> > -       struct power_supply_config psy_cfg =3D { .drv_data =3D di, };
>> > +       struct power_supply_config psy_cfg =3D {};
>> > +
>> > +       psy_cfg.drv_data =3D di;
>> > +       psy_cfg.of_node =3D di->of_node;
>>
>> I don't think you need di->of_node, just the following -- we do this
>> to obtain data from devicetree via power_supply_get_battery_info()
>> https://patchwork.kernel.org/patch/9692335/
>>
>> struct power_supply_config psy_cfg =3D {
>>   .drv_data =3D di,
>>   .of_node =3D di->dev->of_node,
>> };
>
> That's a good point, thanks! Should I prepare v2 with this or rebase on t=
op of
> the series you mentioned previously?

Looks like Sebastian will queue my series this week (actually he just
did, but there's a later rev coming, so wait for that).

Also it would be nice to have docs in the DT binding on linking an
external power supply to fuel gauge. If you write up an example, I can
incorporate it into the docs patch in my series. Or you can file it as
a separate patch...

>> There is some (gcc?) bug on armv7 or omap which causes separate
>> assignments to corrupt the stack.
>
> That's weird, but definitely good to know.
>
>> >         INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
>> >         mutex_init(&di->lock);
>> > diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c
>> > b/drivers/power/supply/bq27xxx_battery_i2c.c
>> > index c68fbc3fe50a..38a0422a4192 100644
>> > --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>> > +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>> > @@ -96,6 +96,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_clie=
nt
>> > *client,
>> >         di->chip =3D id->driver_data;
>> >         di->name =3D name;
>> >         di->bus.read =3D bq27xxx_battery_i2c_read;
>> > +       di->of_node =3D client->dev.of_node;
>> >
>> >         ret =3D bq27xxx_battery_setup(di);
>> >         if (ret)
>> > diff --git a/include/linux/power/bq27xxx_battery.h
>> > b/include/linux/power/bq27xxx_battery.h
>> > index b312bcef53da..94637b77ecbf 100644
>> > --- a/include/linux/power/bq27xxx_battery.h
>> > +++ b/include/linux/power/bq27xxx_battery.h
>> > @@ -63,6 +63,7 @@ struct bq27xxx_device_info {
>> >         const char *name;
>> >         struct bq27xxx_access_methods bus;
>> >         struct bq27xxx_reg_cache cache;
>> > +       struct device_node *of_node;
>> >         int charge_design_full;
>> >         unsigned long last_update;
>> >         struct delayed_work work;
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
