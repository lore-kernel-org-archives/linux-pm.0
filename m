From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Date: Tue, 29 Jan 2019 11:16:10 +0530
Message-ID: <CAP245DVk+Bbkqh5xzNnL+RG3zZDJJR+ZLJqmEhSWjjSK1FH8rw@mail.gmail.com>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
 <20190129053618.laa6nscfvlmhhkb5@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129053618.laa6nscfvlmhhkb5@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 29, 2019 at 11:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 29-01-19, 10:25, Amit Kucheria wrote:
> > All cpufreq drivers do similar things to register as a cooling device.
> > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > to register the cooling device on their behalf. This allows us to get
> > rid of duplicated code in the drivers.
> >
> > In order to allow this, we add a struct thermal_cooling_device pointer
> > to struct cpufreq_policy so that drivers don't need to store it in a
> > private data structure.
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
> >  include/linux/cpufreq.h   |  9 +++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..0f9b50d3ee91 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -19,6 +19,7 @@
> >
> >  #include <linux/cpu.h>
> >  #include <linux/cpufreq.h>
> > +#include <linux/cpu_cooling.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/init.h>
> > @@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
> >       if (cpufreq_driver->ready)
> >               cpufreq_driver->ready(policy);
> >
> > +#if IS_ENABLED(CONFIG_CPU_THERMAL)
> > +     if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
> > +             policy->cdev = of_cpufreq_cooling_register(policy);
> > +#endif
>
> I am not sure if Rafael wanted it this way but maybe something like this:
>
>         if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
>             cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV))
>                 policy->cdev = of_cpufreq_cooling_register(policy);
>
> We never wanted ifdef hackery to be in there :)

OK, that makes more sense. Should I just send out a fixup patch or the
entire series?
