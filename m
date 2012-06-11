From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 6/12] thermal: introduce active cooling algorithm
Date: Mon, 11 Jun 2012 14:44:50 +0300
Message-ID: <20120611114450.GC3649@besouro>
References: <1339384817.1492.160.camel@rui.sh.intel.com>
 <CAK44p227RorAEGcikmXSYHJizxVvwbQkZY9fSS0MvpsA4XyATQ@mail.gmail.com>
 <1339396704.1492.193.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1339396704.1492.193.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, eduardo <eduardo.valentin@ti.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org


Hello,

On Mon, Jun 11, 2012 at 02:38:24PM +0800, Zhang Rui wrote:
> On =E4=B8=80, 2012-06-11 at 10:21 +0530, Amit Kachhap wrote:
> > On 11 June 2012 08:50, Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > > Introduce thermal_zone_trip_update() to update the cooling state
> > > of all the cooling devices that are binded to an active trip poin=
t.
> > >
> > > This will be used for passive cooling as well, in the future patc=
hes.
> > > as both active and passive cooling can share the same algorithm,
> > > which is
> > >
> > > 1. if the temperature is higher than a trip point,
> > >   a. if the trend is THERMAL_TREND_RAISING, use higher cooling
> > >      state for this trip point
> > >   b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
> > >      state for this trip point
> > >
> > > 2. if the temperature is lower than a trip point, use lower
> > >   cooling state for this trip point.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/acpi/thermal.c        |    7 ++-
> > >  drivers/thermal/thermal_sys.c |   91 +++++++++++++++++++++++++++=
+++------------
> > >  2 files changed, 71 insertions(+), 27 deletions(-)
> > >
> > > Index: rtd3/drivers/thermal/thermal_sys.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- rtd3.orig/drivers/thermal/thermal_sys.c
> > > +++ rtd3/drivers/thermal/thermal_sys.c
> > > @@ -1035,6 +1035,70 @@ void thermal_cooling_device_unregister(s
> > >  }
> > >  EXPORT_SYMBOL(thermal_cooling_device_unregister);
> > >
> > > +/*
> > > + * Cooling algorithm for active trip points
> > > + *
> > > + * 1. if the temperature is higher than a trip point,
> > > + *    a. if the trend is THERMAL_TREND_RAISING, use higher cooli=
ng
> > > + *       state for this trip point
> > > + *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooli=
ng
> > > + *       state for this trip point
> > > + *
> > > + * 2. if the temperature is lower than a trip point, use lower
> > > + *    cooling state for this trip point
> > > + *
> > > + * Note that this behaves the same as the previous passive cooli=
ng
> > > + * algorithm.
> > > + */
> > > +
> > > +static void thermal_zone_trip_update(struct thermal_zone_device =
*tz,
> > > +                                    int trip, long temp)
> > > +{
> > > +       struct thermal_cooling_device_instance *instance;
> > > +       struct thermal_cooling_device *cdev =3D NULL;
> > > +       unsigned long cur_state, max_state;
> > > +       long trip_temp;
> > > +       enum thermal_trend trend;
> > > +
> > > +       tz->ops->get_trip_temp(tz, trip, &trip_temp);
> > > +
> > > +       if (temp >=3D trip_temp) {
> > > +               thermal_get_trend(tz, trip, &trend);
> > > +
> > > +               list_for_each_entry(instance, &tz->cooling_device=
s, node) {
> > > +                       if (instance->trip !=3D trip)
> > > +                               continue;
> > > +
> > > +                       cdev =3D instance->cdev;
> > > +
> > > +                       cdev->ops->get_cur_state(cdev, &cur_state=
);
> > > +                       cdev->ops->get_max_state(cdev, &max_state=
);
> > > +
> > > +                       if (trend =3D=3D THERMAL_TREND_RAISING) {
> > > +                               cur_state =3D cur_state < instanc=
e->upper ?
> > > +                                           (cur_state + 1) : ins=
tance->upper;
> > > +                       } else if (trend =3D=3D THERMAL_TREND_DRO=
PPING) {
> > > +                               cur_state =3D cur_state > instanc=
e->lower ?
> > > +                                   (cur_state - 1) : instance->l=
ower;
> > > +                       }
> > > +                       cdev->ops->set_cur_state(cdev, cur_state)=
;
> > > +               }
> > > +       } else {        /* below trip */
> > > +               list_for_each_entry(instance, &tz->cooling_device=
s, node) {
> > > +                       if (instance->trip !=3D trip)
> > > +                               continue;
> > Can we use the trend callback here even if the current temperature =
is
> > less than the trip temperature. Basically according to trend it sho=
uld
> > deactivate the cooling devices as done for activating cooling devic=
es.
>=20
> yes, this depends on the cooling algorithm we want to use.
> When the temperature is lower than the trip point, if we want to stop
> the fan immediately instead of spinning down step by step, we can do
> this.
>=20
> Actually, what we are discussing right now should be some cooling
> governor stuff. which I'm not sure if we should introduce to the gene=
ric
> thermal manager or not, right now. :)

Rui, this is an interesting point. Do you have plans to have governor l=
ike approach
in the generic thermal fw? Or are you sticking to the zone/cooling bind=
ing?

>=20
> thanks,
> rui
>=20
> > > +
> > > +                       cdev =3D instance->cdev;
> > > +                       cdev->ops->get_cur_state(cdev, &cur_state=
);
> > > +
> > > +                       cur_state =3D cur_state > instance->lower=
 ?
> > > +                                   (cur_state - 1) : instance->l=
ower;
> > > +                       cdev->ops->set_cur_state(cdev, cur_state)=
;
> > > +               }
> > > +       }
> > > +
> > > +       return;
> > > +}
> > >  /**
> > >  * thermal_zone_device_update - force an update of a thermal zone=
's state
> > >  * @ttz:       the thermal zone to update
> > > @@ -1045,9 +1109,6 @@ void thermal_zone_device_update(struct t
> > >        int count, ret =3D 0;
> > >        long temp, trip_temp;
> > >        enum thermal_trip_type trip_type;
> > > -       struct thermal_cooling_device_instance *instance;
> > > -       struct thermal_cooling_device *cdev;
> > > -       unsigned long cur_state, max_state;
> > >
> > >        mutex_lock(&tz->lock);
> > >
> > > @@ -1083,29 +1144,7 @@ void thermal_zone_device_update(struct t
> > >                                        tz->ops->notify(tz, count,=
 trip_type);
> > >                        break;
> > >                case THERMAL_TRIP_ACTIVE:
> > > -                       list_for_each_entry(instance, &tz->coolin=
g_devices,
> > > -                                           node) {
> > > -                               if (instance->trip !=3D count)
> > > -                                       continue;
> > > -
> > > -                               cdev =3D instance->cdev;
> > > -
> > > -                               cdev->ops->get_cur_state(cdev, &c=
ur_state);
> > > -                               cdev->ops->get_max_state(cdev, &m=
ax_state);
> > > -
> > > -                               if (temp >=3D trip_temp)
> > > -                                       cur_state =3D
> > > -                                               cur_state < insta=
nce->upper ?
> > > -                                               (cur_state + 1) :
> > > -                                               instance->upper;
> > > -                               else
> > > -                                       cur_state =3D
> > > -                                               cur_state > insta=
nce->lower ?
> > > -                                               (cur_state - 1) :
> > > -                                               instance->lower;
> > > -
> > > -                               cdev->ops->set_cur_state(cdev, cu=
r_state);
> > > -                       }
> > > +                       thermal_zone_trip_update(tz, count, temp)=
;
> > >                        break;
> > >                case THERMAL_TRIP_PASSIVE:
> > >                        if (temp >=3D trip_temp || tz->passive)
> > > Index: rtd3/drivers/acpi/thermal.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- rtd3.orig/drivers/acpi/thermal.c
> > > +++ rtd3/drivers/acpi/thermal.c
> > > @@ -717,7 +717,12 @@ static int thermal_get_trend(struct ther
> > >        if (thermal_get_trip_type(thermal, trip, &type))
> > >                return -EINVAL;
> > >
> > > -       /* Only PASSIVE trip points need TREND */
> > > +       if (type =3D=3D THERMAL_TRIP_ACTIVE) {
> > > +               /* aggressive active cooling */
> > > +               *trend =3D THERMAL_TREND_RAISING;
> > > +               return 0;
> > > +       }
> > > +
> > >        if (type !=3D THERMAL_TRIP_PASSIVE)
> > >                return -EINVAL;
> > >
> > >
> > >
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
