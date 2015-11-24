From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] SKL intel_pstate update MSR values when changing
 governors
Date: Tue, 24 Nov 2015 08:27:32 -0800
Message-ID: <1448382452.3070.6.camel@linux.intel.com>
References: <1447887520-10399-1-git-send-email-alexandra.yates@linux.intel.com>
	 <8282537.nh6Mqkv7tq@vostro.rjw.lan>
	 <1448380662.3070.3.camel@linux.intel.com>
	 <1471027.NasRT9McKq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471027.NasRT9McKq@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alexandra Yates <alexandra.yates@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-11-24 at 17:36 +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 24, 2015 07:57:42 AM Srinivas Pandruvada wrote:
> > On Tue, 2015-11-24 at 15:28 +0100, Rafael J. Wysocki wrote:
> > > On Monday, November 23, 2015 05:17:36 PM Srinivas Pandruvada
> > > wrote:
> > > > On Tue, 2015-11-24 at 02:09 +0100, Rafael J. Wysocki wrote:
> > > > > Hi,
> > > > > 
> > > > > On Sat, Nov 21, 2015 at 1:16 AM, Srinivas Pandruvada
> > > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > > > 
> > > 
> > > [cut]
> > > 
> > > > > 
> > > > > > > For more information on the MSR values for SKL please
> > > > > > > visit
> > > > > > > ISDM under Managing HWP.
> > > > > > > 
> > > > > > > Signed-off-by: Alexandra Yates <
> > > > > > > alexandra.yates@linux.intel.com>
> > > > > > 
> > > > > > Acked-by: Srinivas Pandruvada <
> > > > > > srinivas.pandruvada@linux.intel.com>
> > > > > > > 
> > > > > > > ---
> > > > > > >   drivers/cpufreq/intel_pstate.c | 2 ++
> > > > > > >   1 file changed, 2 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > > > > b/drivers/cpufreq/intel_pstate.c
> > > > > > > index 2e31d09..0eeb7da 100644
> > > > > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > > > > @@ -1242,6 +1242,8 @@ static int
> > > > > > > intel_pstate_set_policy(struct
> > > > > > > cpufreq_policy *policy)
> > > > > > >             policy->max >= policy->cpuinfo.max_freq) {
> > > > > > >                 pr_debug("intel_pstate: set
> > > > > > > performance\n");
> > > > > > >                 limits = &performance_limits;
> > > > > > > +               if (hwp_active)
> > > > > > > +                       intel_pstate_hwp_set();
> > > > > 
> > > > > Honestly, I'm not really sure how this is matching the
> > > > > changelog.
> > > > > 
> > > > > What it does is to ensure that the correct limits are used
> > > > > when
> > > > > in the
> > > > > HWP mode too as far as I can say.  Is my understanding
> > > > > correct
> > > > > here?
> > > > Yes.
> > > 
> > > OK
> > > 
> > > But if we make the "performance" limits take effect here, it will
> > > effectively
> > > make HWP use min = max = 100%, right?  Is that what we want to
> > > happen
> > > here?
> > Yes. intel_pstate_hwp_set() uses limits->min_perf_pct and limits
> > ->max_perf_pct to set HWP limits. Here these will be set to 100%.
> 
> OK, so that's the intended behavior of "performance" in the HWP case,
> right?
> 
Yes.
> I'll apply this patch, but I'm going to write a new changelog for it,
> then.
Sure.

Thanks,
Srinivas

> 
> Thanks,
> Rafael
> 
