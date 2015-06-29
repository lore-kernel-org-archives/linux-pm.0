From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 2/4] cpufreq: introduce cpufreq_driver_might_sleep
Date: Mon, 29 Jun 2015 09:56:55 -0700
Message-ID: <CAEG3pNCDWeOhRDZNQfH4QHj3KWUM829C8C0=CULns3gJwy57sQ@mail.gmail.com>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
 <1435362824-26734-3-git-send-email-mturquette@linaro.org> <20150627004831.GB19347@saruman.tx.rr.com>
 <20150629162621.9112.4040@quantum> <20150629163944.GA32758@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150629163944.GA32758@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten Rasmussen <Morten.Rasmussen@arm.com>, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Amit Kucheria <amit.kucheria@linaro.org>, Juri Lelli <juri.lelli@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 29, 2015 at 9:39 AM, Felipe Balbi <balbi@ti.com> wrote:
>
> Hi,
>
> On Mon, Jun 29, 2015 at 09:26:21AM -0700, Michael Turquette wrote:
> > Quoting Felipe Balbi (2015-06-26 17:48:31)
> > > Hi,
> > >
> > > On Fri, Jun 26, 2015 at 04:53:42PM -0700, Michael Turquette wrote:
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 28e59a4..e5296c0 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -112,6 +112,12 @@ bool have_governor_per_policy(void)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(have_governor_per_policy);
> > > >
> > > > +bool cpufreq_driver_might_sleep(void)
> > > > +{
> > > > +     return !(cpufreq_driver->flags & CPUFREQ_DRIVER_WILL_NOT_SLEEP);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cpufreq_driver_might_sleep);
> > > > +
> > > >  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
> > > >  {
> > > >       if (have_governor_per_policy())
> > > > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > > > index 2ee4888..1f2c9a1 100644
> > > > --- a/include/linux/cpufreq.h
> > > > +++ b/include/linux/cpufreq.h
> > > > @@ -157,6 +157,7 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
> > > >  int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
> > > >  int cpufreq_update_policy(unsigned int cpu);
> > > >  bool have_governor_per_policy(void);
> > > > +bool cpufreq_driver_might_sleep(void);
> > > >  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
> > > >  #else
> > > >  static inline unsigned int cpufreq_get(unsigned int cpu)
> > > > @@ -314,6 +315,14 @@ struct cpufreq_driver {
> > > >   */
> > > >  #define CPUFREQ_NEED_INITIAL_FREQ_CHECK      (1 << 5)
> > > >
> > > > +/*
> > > > + * Set by drivers that will never block or sleep during their frequency
> > > > + * transition. Used to indicate when it is safe to call cpufreq_driver_target
> > > > + * from non-interruptable context. Drivers must opt-in to this flag, as the
> > > > + * safe default is that they might sleep.
> > > > + */
> > > > +#define CPUFREQ_DRIVER_WILL_NOT_SLEEP        (1 << 6)
> > >
> > > don't you need to update current drivers and pass this flag where
> > > necessary ?
> >
> > Felipe,
> >
> > Thanks for the review.
> >
> > Setting the flag can be done, but it is an opt-in feature. First, none
> > of the legacy cpufreq governors would actually make use of this flag.
> > Everything they do is in process context. The first potential user of it
> > is in patch #3.
> >
> > Secondly, the governor in patch #3 will work without this flag set for a
> > cpufreq driver. It will just defer the dvfs transition to a kthread
> > instead of performing it in the hot path of the scheduler.
> >
> > Finally, the only hardware I am aware of that can make use of this flag
> > is Intel hardware. I know nothing about it and am happy for someone more
> > knowledgeable than myself submit a patch enabling this flag for that
> > architecture.
>
> the follow-up question would be: then why introduce the flag at all ?
> :-p

I included it at Rafael's request:

http://lkml.kernel.org/r/<49407954.UBSF2FlX46@vostro.rjw.lan>

Regards,
Mike

>
> --
> balbi




-- 
Michael Turquette
CEO
BayLibre - At the Heart of Embedded Linux
http://baylibre.com/
