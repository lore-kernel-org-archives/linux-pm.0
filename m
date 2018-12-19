From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 02/27] PM / Domains: Add support for CPU devices to genpd
Date: Wed, 19 Dec 2018 11:02:05 +0100
Message-ID: <CAPDyKFpPa1u1ouoa2zFzMe2McqEpxu7Vex2zd1nYoQUQtY2s-A@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-3-ulf.hansson@linaro.org> <45ff9a4b-6130-7800-28cc-a2f5f736f44b@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45ff9a4b-6130-7800-28cc-a2f5f736f44b@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Dec 2018 at 10:53, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > To enable a device belonging to a CPU to be attached to a PM domain managed
> > by genpd, let's do a few changes to it, as to make it convenient to manage
> > the specifics around CPUs.
> >
> > To be able to quickly find out what CPUs that are attached to a genpd,
> > which typically becomes useful from a genpd governor as following changes
> > is about to show, let's add a cpumask to the struct generic_pm_domain. At
> > the point when a CPU device gets attached to a genpd, let's update its
> > cpumask. Moreover, let's also propagate changes to the cpumask upwards in
> > the topology to the master PM domains. In this way, the cpumask for a genpd
> > hierarchically reflects all CPUs attached to the topology below it.
> >
> > Finally, let's make this an opt-in feature, to avoid having to manage CPUs
> > and the cpumask for a genpd that doesn't need it. For that reason, let's
> > add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Don't allocate the cpumask when not used.
> >       - Simplify the code that updates the cpumask.
> >       - Document the GENPD_FLAG_CPU_DOMAIN.
> >
> > ---
> >  drivers/base/power/domain.c | 66 ++++++++++++++++++++++++++++++++++++-
> >  include/linux/pm_domain.h   | 13 ++++++++
> >  2 files changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index e27b91d36a2a..c3ff8e395308 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/suspend.h>
> >  #include <linux/export.h>
> > +#include <linux/cpu.h>
> >
> >  #include "power.h"
> >
> > @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
> >  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
> >  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> > +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> >
> >  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
> >               const struct generic_pm_domain *genpd)
> > @@ -1377,6 +1379,56 @@ static void genpd_free_dev_data(struct device *dev,
> >       dev_pm_put_subsys_data(dev);
> >  }
> >
> > +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> > +                                int cpu, bool set, unsigned int depth)
> > +{
> > +     struct gpd_link *link;
> > +
> > +     if (!genpd_is_cpu_domain(genpd))
> > +             return;
>
> With this test, we won't continue updating the cpumask for the other
> masters. Is it done on purpose ?

Correct, and yes it's on purpose.

We are not even allocating the cpumask for the genpd in question,
unless it has the GENPD_FLAG_CPU_DOMAIN set.

[...]

Kind regards
Uffe
