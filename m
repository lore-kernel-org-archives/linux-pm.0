From: Willy Wolff <willy.mh.wolff.ml@gmail.com>
Subject: Re: [PATCH] thermal: power_allocator: remove early break
Date: Wed, 26 Sep 2018 23:24:39 +0100
Message-ID: <CACfOrNd=1_YqUqr_sKp4DnKR8DQe8k-e8fKU7ogpi0MgaxXBxA@mail.gmail.com>
References: <20180921130609.j3esni6xwhi2ew7d@inc028000032.lancs.ac.uk> <20180924164531.GB4988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924164531.GB4988@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This function is called at initialization when power_allocator
governor is set, and used to parametrize how the thermal
manager shoud work.
By reading its documentation, this function fix a switch_on
trip point (i.e. first passive trip point seen during a scan of
all trip points for that thermal_zone_device) and a
max_desired_temperature trip point (i. e. last seen passive
or active trip point during the scan). At last, if there is neither
a passive nor an active trip point, the governor does nothing.

If a critical trip point is defined before a passive trip point, the
governor will not work, even if there is a
passive or active trip point declared after the critical point.
For instance, on an Odroid-XU3/4 with a Samsung Exynos
5422 CPU, trip points are set as "active" first, "critical", then
"passive". https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi?h=linux-4.18.y#n53
There is no documentation constraining to an order in the
definition of trip points neither in the thermal manager nor in
power_allocator.
Thus, dts contributors could choose any order to define a
thermal-zones, and set the "critical" trip point first, breaking this
thermal governor.
On Mon, 24 Sep 2018 at 17:45, Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hey,
>
> On Fri, Sep 21, 2018 at 02:06:09PM +0100, Willy Wolff wrote:
> > If a trip of type critical is defined before any trip of passive
> > or active type, power_allocator governor will not switch on.
>
>
> But, if a critical trip is reached, the expectation is to perform a
> thermal shutdown. Why would you expect to have power allocator
> to be activated during the process of a shutdown?
>
> >
> > Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> > ---
> >  drivers/thermal/power_allocator.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> > index 3055f9a12a17..6544b68e3ebf 100644
> > --- a/drivers/thermal/power_allocator.c
> > +++ b/drivers/thermal/power_allocator.c
> > @@ -496,8 +496,6 @@ static void get_governor_trips(struct thermal_zone_device *tz,
> >                       }
> >               } else if (type == THERMAL_TRIP_ACTIVE) {
> >                       last_active = i;
> > -             } else {
> > -                     break;
> >               }
> >       }
> >
> > --
> > 2.11.0
> >
