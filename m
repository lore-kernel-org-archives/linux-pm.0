From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCHv3 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Date: Fri, 25 Jan 2019 12:45:17 +0100
Message-ID: <CAJZ5v0gA07-MKvXKH690wRF0cE3AAP3kLHtLRJpiT1Dmrs_beA@mail.gmail.com>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
 <73e091e2d56d9fa6eb94feaed9fc2be30bf6da20.1548398851.git.amit.kucheria@linaro.org>
 <20190125103152.7svjfmowgigznipm@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125103152.7svjfmowgigznipm@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 25, 2019 at 11:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 25-01-19, 12:32, Amit Kucheria wrote:
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
> > ---
> >  drivers/cpufreq/cpufreq.c |  6 ++++++
> >  include/linux/cpufreq.h   | 21 +++++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..cf1be057caf4 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1318,6 +1318,9 @@ static int cpufreq_online(unsigned int cpu)
> >       if (cpufreq_driver->ready)
> >               cpufreq_driver->ready(policy);
> >
> > +     if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
> > +             register_cooling_device(policy);
> > +
> >       pr_debug("initialization complete\n");
> >
> >       return 0;
> > @@ -1405,6 +1408,9 @@ static int cpufreq_offline(unsigned int cpu)
> >               goto unlock;
> >       }
> >
> > +     if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
> > +             unregister_cooling_device(policy);
> > +
> >       if (cpufreq_driver->stop_cpu)
> >               cpufreq_driver->stop_cpu(policy);
> >
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index bd7fbd6a4478..c7eb59b8ce94 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -13,6 +13,7 @@
> >
> >  #include <linux/clk.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/cpu_cooling.h>
> >  #include <linux/completion.h>
> >  #include <linux/kobject.h>
> >  #include <linux/notifier.h>
> > @@ -151,6 +152,9 @@ struct cpufreq_policy {
> >
> >       /* For cpufreq driver's internal use */
> >       void                    *driver_data;
> > +
> > +     /* Pointer to the cooling device if used for thermal mitigation */
> > +     struct thermal_cooling_device *cdev;
> >  };
> >
> >  /* Only for ACPI */
> > @@ -386,6 +390,12 @@ struct cpufreq_driver {
> >   */
> >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING    BIT(6)
> >
> > +/*
> > + * Set by drivers that want the core to automatically register the cpufreq
> > + * driver as a thermal cooling device.
> > + */
> > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV    BIT(7)
> > +
> >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> >
> > @@ -415,6 +425,17 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
> >                       policy->cpuinfo.max_freq);
> >  }
> >
> > +static inline void register_cooling_device(struct cpufreq_policy *policy)
> > +{
> > +     policy->cdev = of_cpufreq_cooling_register(policy);
> > +}
> > +
> > +static inline void unregister_cooling_device(struct cpufreq_policy *policy)
> > +{
> > +     cpufreq_cooling_unregister(policy->cdev);
> > +     policy->cdev = NULL;
> > +}
>
> I thought that we discussed over chat that you wouldn't add any
> wrapper routines. How do you see these getting used ? I will suggest
> that this should be open coded in the core itself.

Agreed.
