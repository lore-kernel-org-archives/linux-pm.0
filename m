From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 12/12] OPTIONAL: cpufreq: dt: Register an Energy
 Model
Date: Fri, 6 Jul 2018 11:18:58 +0100
Message-ID: <20180706101858.GC11862@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-13-quentin.perret@arm.com>
 <CAKfTPtAANKzw7QTzKiU_ntiGYMxZD3etd8wMzXtngwUWHXj+Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtAANKzw7QTzKiU_ntiGYMxZD3etd8wMzXtngwUWHXj+Hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Friday 06 Jul 2018 at 12:10:02 (+0200), Vincent Guittot wrote:
> On Thu, 28 Jun 2018 at 13:41, Quentin Perret <quentin.perret@arm.com> wrote:
> > +static int of_est_power(unsigned long *mW, unsigned long *KHz, int cpu)
> > +{
> > +       unsigned long mV, Hz, MHz;
> > +       struct device *cpu_dev;
> > +       struct dev_pm_opp *opp;
> > +       struct device_node *np;
> > +       u32 cap;
> > +       u64 tmp;
> > +
> > +       cpu_dev = get_cpu_device(cpu);
> > +       if (!cpu_dev)
> > +               return -ENODEV;
> > +
> > +       np = of_node_get(cpu_dev->of_node);
> > +       if (!np)
> > +               return -EINVAL;
> > +
> > +       if (of_property_read_u32(np, "dynamic-power-coefficient", &cap))
> > +               return -EINVAL;
> > +
> > +       Hz = *KHz * 1000;
> > +       opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> > +       if (IS_ERR(opp))
> > +               return -EINVAL;
> > +
> > +       mV = dev_pm_opp_get_voltage(opp) / 1000;
> > +       dev_pm_opp_put(opp);
> > +
> > +       MHz = Hz / 1000000;
> > +       tmp = (u64)cap * mV * mV * MHz;
> > +       do_div(tmp, 1000000000);
> 
> Could you explain the formula above ? and especially the 1000000000 it
> seems related to the use of mV and mW instead of uV and uW ...

That's correct, this is just a matter of units. I simply tried to
reproduce here what is currently done for IPA:

https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpu_cooling.c#L252

> 
> Can't you just optimize that into
> tmp = (u64)cap * mV * mV * Hz;
> do_div(tmp, 1000);

I don't think that'll work. If you use Hz instead of MHz you'll need to
divide tmp by 1000000000000000 to get milli-watts, as specified by the
EM framework.

FYI, I don't consider this patch to be ready to be merged. I kept it
self-contained and simple for the example but I actually think that this
of_est_power function should probably be factored-out somewhere else.
scpi-cpufreq could use it as well. Anyway, I guess we can discuss that
later once the APIs of the EM framework are agreed :-)

Thanks,
Quentin
