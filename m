From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 2/4] thermal: power_allocator: relax the requirement
 of two passive trip points
Date: Wed, 12 Aug 2015 17:46:48 +0100
Message-ID: <20150812164648.GD2695@e104805>
References: <1439222692-3535-1-git-send-email-javi.merino@arm.com>
 <1439288493-19740-1-git-send-email-javi.merino@arm.com>
 <1439288493-19740-3-git-send-email-javi.merino@arm.com>
 <CAGS+omAKfHQJDZC0gqvyGN8W3RpgF7tX+ZZ-rCcXnHnpLkehMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:41585 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753234AbbHLQqz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 12:46:55 -0400
Content-Disposition: inline
In-Reply-To: <CAGS+omAKfHQJDZC0gqvyGN8W3RpgF7tX+ZZ-rCcXnHnpLkehMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chung-yih Wang <cywang@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Wed, Aug 12, 2015 at 12:13:09PM +0100, Daniel Kurtz wrote:
> Hi Javi,

Hi Daniel,

> On Tue, Aug 11, 2015 at 6:21 PM, Javi Merino <javi.merino@arm.com> wrote:
> > The power allocator governor currently requires that the thermal zone
> > has at least two passive trip points.  If there aren't, the governor
> > refuses to bind to the thermal zone.
> >
> > This commit relaxes that requirement.  Now the governor will bind to all
> > thermal zones regardless of how many trip points they have.
> >
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  Documentation/thermal/power_allocator.txt |  2 +-
> >  drivers/thermal/power_allocator.c         | 91 +++++++++++++++++--------------
> >  2 files changed, 52 insertions(+), 41 deletions(-)
> >
> > diff --git a/Documentation/thermal/power_allocator.txt b/Documentation/thermal/power_allocator.txt
> > index c3797b529991..a1ce2235f121 100644
> > --- a/Documentation/thermal/power_allocator.txt
> > +++ b/Documentation/thermal/power_allocator.txt
> > @@ -4,7 +4,7 @@ Power allocator governor tunables
> >  Trip points
> >  -----------
> >
> > -The governor requires the following two passive trip points:
> > +The governor works optimally with the following two passive trip points:
> >
> >  1.  "switch on" trip point: temperature above which the governor
> >      control loop starts operating.  This is the first passive trip
> > diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> > index f78836c2da26..257c9af20f22 100644
> > --- a/drivers/thermal/power_allocator.c
> > +++ b/drivers/thermal/power_allocator.c
> > @@ -24,6 +24,8 @@
> >
> >  #include "thermal_core.h"
> >
> > +#define INVALID_TRIP -1
> > +
> >  #define FRAC_BITS 10
> >  #define int_to_frac(x) ((x) << FRAC_BITS)
> >  #define frac_to_int(x) ((x) >> FRAC_BITS)
> > @@ -61,6 +63,8 @@ static inline s64 div_frac(s64 x, s64 y)
> >   *             Used to calculate the derivative term.
> >   * @trip_switch_on:    first passive trip point of the thermal zone.  The
> >   *                     governor switches on when this trip point is crossed.
> > + *                     If the thermal zone only has one passive trip point,
> > + *                     @trip_switch_on should be INVALID_TRIP.
> >   * @trip_max_desired_temperature:      last passive trip point of the thermal
> >   *                                     zone.  The temperature we are
> >   *                                     controlling for.
> > @@ -378,43 +382,66 @@ unlock:
> >         return ret;
> >  }
> >
> > -static int get_governor_trips(struct thermal_zone_device *tz,
> > -                             struct power_allocator_params *params)
> > +/**
> > + * get_governor_trips() - get the number of the two trip points that are key for this governor
> > + * @tz:        thermal zone to operate on
> > + * @params:    pointer the private data for this governor
>                   ^
>                   pointer to private data

Fixed

> > + *
> > + * The power allocator governor works optimally with two trips points:
> > + * a "switch on" trip point and a "maximum desired temperature".  These
> > + * are defined as the first and last passive trip points.
> > + *
> > + * If there is only one trip point, then that's considered to be the
> > + * "maximum desired temperature" trip point and the governor is always
> > + * on.  If there are no passive or active trip points, then the
> > + * governor won't do anything.  In fact, its throttle function
> > + * shouldn't be called at all.
>       ^
>       "shouldn't" or "won't" ?

"won't".  Sometimes I'm overly cautious.  You know "never say never" ;-)

> [snip]
> 
> >  static void power_allocator_unbind(struct thermal_zone_device *tz)
> > @@ -544,13 +561,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
> >
> >         ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
> >                                      &switch_on_temp);
> > -       if (ret) {
> > -               dev_warn(&tz->device,
> > -                        "Failed to get switch on temperature: %d\n", ret);
> > -               return ret;
> > -       }
> > -
> > -       if (current_temp < switch_on_temp) {
> > +       if ((!ret) && (current_temp < switch_on_temp)) {
> 
> nit: I think the inner pair of () are not necessary.

They are not necessary, but I prefer the parenthesis around the
comparison.  It makes it clearer to me.  I've dropped the () around
!ret.

Thanks for the comments here and in the first patch.
Javi
