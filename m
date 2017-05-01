From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH 4/5] power: supply: bq27xxx: Look for status change on
 external power change
Date: Mon, 1 May 2017 11:22:38 -0700
Message-ID: <CAKvHMgTLi1bkhOPuzErp_JmvA23uGB_N4N3_Te_MxY=+asm7zw@mail.gmail.com>
References: <20170430203801.32357-1-contact@paulk.fr> <20170430203801.32357-4-contact@paulk.fr>
 <CAKvHMgRxC7VuU=_w10D4iu0zUC26gM=VgbA+6N-4abPskCEOww@mail.gmail.com> <1493635513.6493.9.camel@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34638 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdEASWj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 14:22:39 -0400
Received: by mail-io0-f194.google.com with SMTP id h41so23707702ioi.1
        for <linux-pm@vger.kernel.org>; Mon, 01 May 2017 11:22:39 -0700 (PDT)
In-Reply-To: <1493635513.6493.9.camel@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-pm@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>

On Mon, May 1, 2017 at 3:45 AM, Paul Kocialkowski <contact@paulk.fr> wrote:
> Hi,
>
> Le dimanche 30 avril 2017 =C3=A0 15:13 -0700, Liam Breck a =C3=A9crit :
>> Hi Paul,
>>
>> On Sun, Apr 30, 2017 at 1:38 PM, Paul Kocialkowski <contact@paulk.fr> wr=
ote:
>> > This introduces a dedicated status change work to look for power
>> > status change. It is triggered by external power change notifications
>> > and periodically retries detecting a power status change for 5 seconds=
.
>> >
>> > This is largely inspired by a similar mechanism from the sbs-battery
>> > driver.
>>
>> Maybe give an example which needs this? What can issue a notification,
>> under what circumstances?
>
> The external_power_change function is called when a supplier to the batte=
ry (in
> most cases, an external charger) detected a status change (e.g. plug/unpl=
ug)
> which will affect the battery (the state should change from charging/full=
 to
> discharging).
>
> For the best user experience, we need to detect that change ASAP. Retriev=
ing the
> status in the function directly is a bit too early, so a dedicated work i=
s
> called a second after the change and it tries to detect a status change A=
SAP.
>
> With that mechanism, battery status changes due to plug/unplug take a few
> seconds to be reflected.
>
>> Also why should poll_work no longer be rescheduled on notify?
>
> poll_work only updates the current charge, it's not in charge of detectin=
g
> status changes. The important point here is that the status change detect=
ion
> work must be called seconds after the external power change (and actually=
, it
> must keep running for a few seconds to detect quick charging->full transi=
tions).
>
> Is that a bit more clear?

Yes, can you add that to patch description?


>> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>> > ---
>> >  drivers/power/supply/bq27xxx_battery.c | 38
>> > ++++++++++++++++++++++++++++++++--
>> >  include/linux/power/bq27xxx_battery.h  |  3 +++
>> >  2 files changed, 39 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/power/supply/bq27xxx_battery.c
>> > b/drivers/power/supply/bq27xxx_battery.c
>> > index 926bd58344d9..cade00df6162 100644
>> > --- a/drivers/power/supply/bq27xxx_battery.c
>> > +++ b/drivers/power/supply/bq27xxx_battery.c
>> > @@ -1190,6 +1190,11 @@ static int bq27xxx_battery_status(struct
>> > bq27xxx_device_info *di,
>> >                         status =3D POWER_SUPPLY_STATUS_CHARGING;
>> >         }
>> >
>> > +       if (di->status_retry =3D=3D 0 && di->status_change_reference !=
=3D status)
>> > {
>> > +               di->status_change_reference =3D status;
>> > +               power_supply_changed(di->bat);
>> > +       }
>> > +
>> >         val->intval =3D status;
>> >
>> >         return 0;
>> > @@ -1340,12 +1345,38 @@ static int bq27xxx_battery_get_property(struct
>> > power_supply *psy,
>> >         return ret;
>> >  }
>> >
>> > +static void bq27xxx_status_change(struct work_struct *work)
>> > +{
>> > +       struct bq27xxx_device_info *di =3D
>> > +                       container_of(work, struct bq27xxx_device_info,
>> > +                                    status_work.work);
>> > +       union power_supply_propval val;
>> > +       int ret;
>> > +
>> > +       bq27xxx_battery_update(di);
>> > +
>> > +       ret =3D bq27xxx_battery_status(di, &val);
>> > +       if (ret < 0)
>> > +               return;
>> > +
>> > +       if (di->status_change_reference !=3D val.intval) {
>> > +               di->status_change_reference =3D val.intval;
>> > +               power_supply_changed(di->bat);
>> > +       }
>> > +
>> > +       if (di->status_retry > 0) {
>> > +               di->status_retry--;
>> > +               schedule_delayed_work(&di->status_work, HZ);
>> > +       }
>> > +}
>> > +
>> >  static void bq27xxx_external_power_changed(struct power_supply *psy)
>> >  {
>> >         struct bq27xxx_device_info *di =3D power_supply_get_drvdata(ps=
y);
>> >
>> > -       cancel_delayed_work_sync(&di->poll_work);
>> > -       schedule_delayed_work(&di->poll_work, 0);
>> > +       cancel_delayed_work_sync(&di->status_work);
>> > +       schedule_delayed_work(&di->status_work, HZ);
>> > +       di->status_retry =3D 5;
>> >  }
>> >
>> >  int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
>> > @@ -1357,8 +1388,10 @@ int bq27xxx_battery_setup(struct bq27xxx_device=
_info
>> > *di)
>> >         psy_cfg.of_node =3D di->of_node;
>> >
>> >         INIT_DELAYED_WORK(&di->poll_work, bq27xxx_battery_poll);
>> > +       INIT_DELAYED_WORK(&di->status_work, bq27xxx_status_change);
>> >         mutex_init(&di->lock);
>> >         di->regs =3D bq27xxx_regs[di->chip];
>> > +       di->status_change_reference =3D POWER_SUPPLY_STATUS_UNKNOWN;
>> >
>> >         psy_desc =3D devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERN=
EL);
>> >         if (!psy_desc)
>> > @@ -1400,6 +1433,7 @@ void bq27xxx_battery_teardown(struct
>> > bq27xxx_device_info *di)
>> >         poll_interval =3D 0;
>> >
>> >         cancel_delayed_work_sync(&di->poll_work);
>> > +       cancel_delayed_work_sync(&di->status_work);
>> >
>> >         power_supply_unregister(di->bat);
>> >
>> > diff --git a/include/linux/power/bq27xxx_battery.h
>> > b/include/linux/power/bq27xxx_battery.h
>> > index 0a9af513165a..16d604681ace 100644
>> > --- a/include/linux/power/bq27xxx_battery.h
>> > +++ b/include/linux/power/bq27xxx_battery.h
>> > @@ -67,6 +67,9 @@ struct bq27xxx_device_info {
>> >         int charge_design_full;
>> >         unsigned long last_update;
>> >         struct delayed_work poll_work;
>> > +       struct delayed_work status_work;
>> > +       int status_retry;
>> > +       int status_change_reference;
>> >         struct power_supply *bat;
>> >         struct list_head list;
>> >         struct mutex lock;
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
