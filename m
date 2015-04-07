From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH] [RFC] PM / Domains: multiple states
Date: Tue, 7 Apr 2015 16:24:38 +0200
Message-ID: <CAKXjFTNQ2q2=Q6YqJQnaQOe_TX7NSQX3Mv7MwnRTBoS2q2=T-w@mail.gmail.com>
References: <1427963699-2638-1-git-send-email-ahaslam@baylibre.com>
	<7hvbh8sswu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36315 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbbDGOYn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2015 10:24:43 -0400
Received: by obbeb7 with SMTP id eb7so18450627obb.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2015 07:24:43 -0700 (PDT)
In-Reply-To: <7hvbh8sswu.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, Ulf Hansson <ulf.hansson@linaro.org>, Benoit Cousson <bcousson@baylibre.com>

Hi Kevin,


>
> ...the most common of these being a "retention" state, where clocks are
> gated, and voltage is lowered to a retention voltage so the domain is
> not technically "off" (as in zero volts) but is in a low-power state,
> with all or part of the logic/memory retained.
>
> For those more familiar with ACPI, you might also mention the simliarity
> to ACPI D states:
> http://en.wikipedia.org/wiki/Advanced_Configuration_and_Power_Interface#Device_states
>

ok, i can add more info here.


>
> The unfortunate problem here is that the underlying framework (runtime
> PM) doesn't yet know about multiple power states, so I'm not sure (yet)
> how to make this work at the genpd level without also changing runtime
> PM understand the concept of multiple power states.
>
> So, maybe I'm missing something, but I'm not yet sure how this would be
> useful without the underlying support in runtime PM also.


The way i had imagined it was that runtime pm would suspend
the devices, and based on the latency constraint of all devices
on the genpd, the genpd governor would pick the most restrictive
constraint and decide what state to go into.


>
> > States should be declared in ascending order from shallowest
> > to deepest, deepest meaning the state which takes longer
> > to enter and exit. The declaration would look something like:
> >
> >       struct genpd_power_state states[3] = {
> >               {
> >                       .name= "LOW_POWER_1",
> >                       .power_off = arch_callback_lp1,
> >                       .power_on = arch_callback_lp1,
> >                       .power_off_latency_ns = 1000000,
> >                       .power_on_latency_ns = 1000000,
> >
> >               },
> >               {
> >                       .name= "LOW_POWER_2",
> >                       .power_off = arch_callback_lp2,
> >                       .power_on = arch_callback_lp2,
> >                       .power_off_latency_ns = 2000000,
> >                       .power_on_latency_ns = 2000000,
> >
> >               },
> >               {
> >                       .name= "OFF",
> >                       .power_off = arch_callback_off,
> >                       .power_on = arch_callback_off,
> >                       .power_off_latency_ns = 4000000,
> >                       .power_on_latency_ns = 4000000,
> >
> >               },
> >       };
>
> We might also need a per-state flag stating whether context is lost, so
> we know whether the save/restore state stuff actually needs to be
> called.


The patch adds the "state" parameter on the save/restore callback,
i thought the callbacks can use this to decide if they need to
restore, and which registers to restore. (maybe there could be only a subset
to restore depending on the state)


>
>
> [...]
>
> > @@ -118,14 +120,33 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
> >                       link->master->max_off_time_changed = true;
> >
> >               genpd->max_off_time_changed = false;
> > -             genpd->cached_power_down_ok = false;
> > -             genpd->max_off_time_ns = -1;
> > +             /*
> > +              * invalidate the cached values for every state
> > +              */
> > +             for (i = 0; i < genpd->state_count; i++) {
> > +                     genpd->states[i].cached_power_down_ok =
> > +                             GPD_CACHED_UNKNOWN;
> > +                     genpd->max_off_time_ns = -1;
> > +             }
> > +
>
> I'm not quite understanding the need for these new GPD_CACHED_* flags,
> and this change isn't described in the changelog.
>

sorry, i should have added a few lines about this.

Currently, the decision to use the cached value relies only on
the flag "max_off_time_changed". if the flag is set when
default_power_down_ok is called,
it is turned off and the value of cached_power_down_ok is calculated
and saved to be used
on subsequent calls until max_off_time_changed is set again after a
device constraint
is changed or a save/restore on/off latency is changed.

With multiple states, cached_power_down_ok is a per-state flag and
tells if the genpd can enter into that particular state.
The default_power_down_ok function becomes a loop that calls
default_power_down_ok_state until the deepest valid state is found, if
the found state is not the shallowest, cached_power_down_ok  will not be
calculated for the shallower states. thats why i thought of making
cached_power_down_ok a tri state flag.

in hindsight,  it may not even be relevant, since we are only
interested in the deepest
state we can go into.  i think that the cached logic could be moved out of the
default_power_down_ok_state function and back into default_power_down_ok,
And the governor should save the deepest state allowed so that if the
max_off_time_changed flag does not change, we could return without even
looping through the states. i can repost with this change if it makes
more sense.

thanks for the review!
Regards,
Axel


> Kevin
