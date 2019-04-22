From: Wei Wang <wvw@google.com>
Subject: Re: [PATCH] thermal: core: skip update disabled thermal zones after suspend
Date: Mon, 22 Apr 2019 09:44:01 -0700
Message-ID: <CAGXk5yoXgzYyK9eJMHietgqPqyT_QHXAby6+G_fSwXL-tKfd=Q@mail.gmail.com>
References: <20190416170701.50333-1-wvw@google.com> <1555923800.26198.30.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555923800.26198.30.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Wei Wang <wei.vince.wang@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 22, 2019 at 2:03 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On =E4=BA=8C, 2019-04-16 at 10:07 -0700, Wei Wang wrote:
> > It is unnecessary to update disabled thermal zones post suspend and
> > sometimes leads error/warning in bad behaved thermal drivers.
> >
> a good catch, and in fact, there are more issues about thermal handling
> for disabled thermal zones, like we're able to read the temperature of
> disabled thermal zones, either via sysfs or via function calls like
> thermal_zone_device_update.
Thanks Rui for following up. Yes, we noticed the same behavior. Right
now, individual thermal driver can still respect set_mode and present
value meaningful or return error when thermal zone disabled, and
that's what we do locally.
Currently, sysfs-api documents "Preventing kernel thermal zone driver
actions upon trip points so that user application can take full charge
of the thermal management.", so is it intended for some other agents
in kernel or user land polling temperature with function call or sysfs
respectively?

Thanks!
-Wei
> For this patch, I will take it as it fixes one of the problem.
>
> thanks,
> rui
>
> > Signed-off-by: Wei Wang <wvw@google.com>
> > ---
> >  drivers/thermal/thermal_core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 6590bb5cb688..5baf5cfab999 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1494,6 +1494,7 @@ static int thermal_pm_notify(struct
> > notifier_block *nb,
> >                            unsigned long mode, void *_unused)
> >  {
> >       struct thermal_zone_device *tz;
> > +     enum thermal_device_mode tz_mode;
> >
> >       switch (mode) {
> >       case PM_HIBERNATION_PREPARE:
> > @@ -1506,6 +1507,13 @@ static int thermal_pm_notify(struct
> > notifier_block *nb,
> >       case PM_POST_SUSPEND:
> >               atomic_set(&in_suspend, 0);
> >               list_for_each_entry(tz, &thermal_tz_list, node) {
> > +                     tz_mode =3D THERMAL_DEVICE_ENABLED;
> > +                     if (tz->ops->get_mode)
> > +                             tz->ops->get_mode(tz, &tz_mode);
> > +
> > +                     if (tz_mode =3D=3D THERMAL_DEVICE_DISABLED)
> > +                             continue;
> > +
> >                       thermal_zone_device_init(tz);
> >                       thermal_zone_device_update(tz,
> >                                                  THERMAL_EVENT_UNS
> > PECIFIED);
