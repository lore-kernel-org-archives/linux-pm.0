From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 18/27] drivers: firmware: psci: Add support for PM
 domains using genpd
Date: Thu, 20 Dec 2018 22:09:58 +0100
Message-ID: <CAPDyKFo5Qf-fODAugZK4CqOL81-r0uUjZVmoD2h+M8_b+-_95A@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-19-ulf.hansson@linaro.org> <fa99b1a9-2e4d-e97c-9478-43b4d3ef9819@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa99b1a9-2e4d-e97c-9478-43b4d3ef9819@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[...]

> > -obj-$(CONFIG_ARM_PSCI_FW)    += psci.o
> > +obj-$(CONFIG_ARM_PSCI_FW)    += psci.o psci_pm_domain.o
>
> Same comment as 17/27.
>
> +obj-$(CONFIG_PSCI_IDLE) += psci_pm_domain.o

Let's discuss that in patch 17 to agree on the way forward.

[...]

> > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > +{
> > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > +     u32 *pd_state;
> > +     u32 composite_pd_state;
> > +
> > +     /* If we have failed to enable OSI mode, then abort power off. */
> > +     if (psci_has_osi_support() && !osi_mode_enabled)
> > +             return -EBUSY;
>
> I'm not sure EBUSY is the best error code to describe this situation.
> May be ENOTSUP ?

I see your point. However, -EBUSY is the correct code for this case as
it tells genpd that the PM domain could not power off, but needs to
stay powered on.

To be clear, genpd treat -EBUSY, in a bit special way.

>
> However, how possible is it to pass in this function if the OSI mode was
> not enabled ?

If we fail to enable OSI mode, we keep having the CPUs attached to
PSCI PM PM domains. Although, as we are then running in platform
coordinated mode, there is no point allowing a cluster idle state.

The option would be to convert to the flattened model in case we fail
to enable OSI mode, but that error path is going to be rather
complicated (we need to detach CPUs, unregister domains and providers,
etc). Instead the assumption is that it simply shouldn't fail when we
decide to try. If it does, it's likely something need to be fixed
anyways.

>
> > +     if (!state->data)
> > +             return 0;
> > +
> > +     /* When OSI mode is enabled, set the corresponding domain state. */
> > +     pd_state = state->data;
> > +     composite_pd_state = *pd_state | psci_get_domain_state();
> > +     psci_set_domain_state(composite_pd_state);
> > +
> > +     return 0;
> > +}
> > +
> > +static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
> > +                             int state_count)
>
> __init ?

Yes, probably. I will check and see if/where it could makes sense.
Thanks for pointing it out!

[...]

Kind regards
Uffe
