From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Date: Wed, 23 Jan 2019 11:53:10 +0100
Message-ID: <CAJZ5v0g0syxsHaLOUa+K7YkR0sf0rHQHOL6ytWg_8nhh16ZZMw@mail.gmail.com>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
 <20190123103624.t4b2ij3bfvpezgjf@vireshk-i7> <CAJZ5v0g12U0M3aJOvRgRg3=-6f+2jeG1rT5RjLoSciM0FwFofg@mail.gmail.com>
 <20190123104322.o3whk6rfiaootspn@vireshk-i7> <20190123104403.bl7mdidmvd7c227q@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123104403.bl7mdidmvd7c227q@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Tao Wang <kevin.wangtao@hisilicon.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 23, 2019 at 11:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 23-01-19, 16:13, Viresh Kumar wrote:
> > On 23-01-19, 11:39, Rafael J. Wysocki wrote:
> > > On Wed, Jan 23, 2019 at 11:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 21-01-19, 21:10, Amit Kucheria wrote:
> > > > > @@ -151,6 +152,11 @@ struct cpufreq_policy {
> > > > >
> > > > >       /* For cpufreq driver's internal use */
> > > > >       void                    *driver_data;
> > > > > +
> > > > > +#ifdef CONFIG_CPU_THERMAL
> > > > > +     /* Pointer to the cooling device if used for thermal mitigation */
> > > > > +     struct thermal_cooling_device *cdev;
> > > > > +#endif
> > > > >  };
> > > > >
> > > > >  /* Only for ACPI */
> > > > > @@ -386,6 +392,12 @@ struct cpufreq_driver {
> > > > >   */
> > > > >  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING    BIT(6)
> > > > >
> > > > > +/*
> > > > > + * Set by drivers that want the core to automatically register the cpufreq
> > > > > + * driver as a thermal cooling device.
> > > > > + */
> > > > > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV    BIT(7)
> > > > > +
> > > > >  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
> > > > >  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> > > > >
> > > > > @@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
> > > > >                       policy->cpuinfo.max_freq);
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_CPU_THERMAL
> > > > > +static inline void register_cooling_device(struct cpufreq_policy *policy) {
> > > > > +     policy->cdev = of_cpufreq_cooling_register(policy);
> > > > > +}
> > > > > +
> > > > > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
> > > > > +     cpufreq_cooling_unregister(policy->cdev);
> > > > > +     policy->cdev = NULL;
> > > > > +}
> > > > > +#else
> > > > > +static inline void register_cooling_device(struct cpufreq_policy *policy) {}
> > > > > +static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
> > > > > +#endif
> > > >
> > > > The whole ifdef hackery here saves space for a pointer per policy.
> > > > Just get rid of it, it isn't worth it.
> > >
> > > Is struct thermal_cooling_device defined if CONFIG_THERMAL is unset?
> >
> > No and it is defined in thermal.h without any ifdef stuff.
>
> I meant it is always available and doesn't depend on CONFIG_THERMAL.

OK

I guess we can live with an extra unused pointer per policy on
platforms with CONFIG_CPU_THERMAL unset.
