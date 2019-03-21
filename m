From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 1/4] PM / Domains: Add a generic data pointer to the
 genpd_power_state struct
Date: Thu, 21 Mar 2019 10:36:25 +0100
Message-ID: <CAPDyKFoz8d2DTKTtBPn7+1wf_gGsANwU12++Wkb_KKndqGwWZQ@mail.gmail.com>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-2-ulf.hansson@linaro.org> <11aa2536-9f9c-059d-a4d6-3f683be7caeb@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11aa2536-9f9c-059d-a4d6-3f683be7caeb@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Mar 2019 at 08:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 27/02/2019 20:58, Ulf Hansson wrote:
> > Let's add a data pointer to the genpd_power_state struct, to allow a genpd
> > backend driver to store per state specific data. To introduce the pointer,
> > we need to change the way genpd deals with freeing of the corresponding
> > allocated data.
> >
> > More precisely, let's clarify the responsibility of whom that shall free
> > the data, by adding a ->free_states() callback to the struct
> > generic_pm_domain. The one allocating the data shall assign the callback,
> > to allow genpd to invoke it from genpd_remove().
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v12:
> >       - None.
> >
> > ---
> >  drivers/base/power/domain.c | 12 ++++++++++--
> >  include/linux/pm_domain.h   |  4 +++-
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 2c334c01fc43..03885c003c6a 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1685,6 +1685,12 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> >  }
> >  EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
> >
> > +static void genpd_free_default_power_state(struct genpd_power_state *states,
> > +                                        unsigned int state_count)
> > +{
> > +     kfree(states);
> > +}
> > +
> >  static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >  {
> >       struct genpd_power_state *state;
> > @@ -1695,7 +1701,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >
> >       genpd->states = state;
> >       genpd->state_count = 1;
> > -     genpd->free = state;
> > +     genpd->free_states = genpd_free_default_power_state;
> >
> >       return 0;
> >  }
> > @@ -1811,7 +1817,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> >       list_del(&genpd->gpd_list_node);
> >       genpd_unlock(genpd);
> >       cancel_work_sync(&genpd->power_off_work);
> > -     kfree(genpd->free);
> > +     if (genpd->free_states)
>
> Is this test necessary as the free_states function is initialized with
> the genpd_set_default_power_state() in any case?

That's the case when the genpd provider did not allocate states, so
then we know genpd deals with this properly for us.

In the other case, when genpd provider has allocates states, then we
need to check that the provider has assigned the ->free_states()
callback before we invokes it, as there is no guarantees that it had.

I was initially tempted to do this check already at pm_genpd_init(),
as it would allow us to check for the error condition and return an
error code if it's not been assigned. However, that requires me to
change all providers that currently "allocates" their states, so that
isn't really a smooth way forward. Perhaps, we should simply print a
message to the log about this condition in pm_genpd_init(), as to
start with!? I can add a patch on top doing that.

>
> > +             genpd->free_states(genpd->states, genpd->state_count);
> > +
> >       pr_debug("%s: removed %s\n", __func__, genpd->name);
> >

[...]

Kind regards
Uffe
