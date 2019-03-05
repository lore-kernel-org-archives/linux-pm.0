From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: Update max frequency on
 global turbo changes
Date: Tue, 5 Mar 2019 12:55:47 +0100
Message-ID: <CAJZ5v0g8aJf9tf5NJ8sui46=Vjmadibg391apjXSU+h5LYfixA@mail.gmail.com>
References: <1755407.S0oJirvq9V@aspire.rjw.lan> <258653930.nEdAsQ7rt7@aspire.rjw.lan>
 <20190305114252.wu55upnrzb5j2g7j@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190305114252.wu55upnrzb5j2g7j@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 5, 2019 at 12:43 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 05 Mar 2019 at 11:42:06 (+0100), Rafael J. Wysocki wrote:
> > +static void intel_pstate_update_max_freq(unsigned int cpu)
> > +{
> > +     struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
> > +     struct cpufreq_policy new_policy;
> > +     struct cpudata *cpudata;
> > +
> > +     if (!policy)
> > +             return;
> > +
> > +     cpudata = all_cpu_data[cpu];
> > +     policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
> > +                     cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
>
> I'm not too familiar with how the Intel turbo stuff so bear with me but
> is this 'pstate.turbo_freq' constant ?

Yes, it is.

> Why not just write it unconditionally into cpuinfo.max_freq ? It's not
> guaranteed to always be reachable anyways no ? So maybe that's OK to always
> report that one regardless of the boost availability ?

So the concern is that on some systems turbo is disabled permanently
by the platform FW and it doesn't make sense to even take
pstate.turbo_freq into consideration then.
