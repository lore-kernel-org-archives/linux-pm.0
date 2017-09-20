From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/7] cpufreq: make cpufreq_generic_init
 transition_latency default to CPUFREQ_ETERNAL
Date: Wed, 20 Sep 2017 07:45:38 -0700
Message-ID: <20170920144538.GK30848@ubuntu>
References: <1503504610-12880-1-git-send-email-aisheng.dong@nxp.com>
 <1503504610-12880-7-git-send-email-aisheng.dong@nxp.com>
 <20170919231007.GJ30848@ubuntu>
 <20170920070450.GB32187@b29396-OptiPlex-7040>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170920070450.GB32187@b29396-OptiPlex-7040>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org, vireshk@kernel.org, nm@ti.com, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, ping.bai@nxp.com
List-Id: linux-pm@vger.kernel.org

On 20-09-17, 15:04, Dong Aisheng wrote:
> On Tue, Sep 19, 2017 at 04:10:07PM -0700, Viresh Kumar wrote:
> > On 24-08-17, 00:10, Dong Aisheng wrote:
> > > If no valid transition_latency specified, let's make it default to
> > > CPUFREQ_ETERNAL which is consistent with its definition.
> > > 
> > > This can save some of the same checkings like this:
> > >         transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
> > > -       if (!transition_latency)
> > > -               transition_latency = CPUFREQ_ETERNAL;
> > >         ret = cpufreq_generic_init(policy, freq_table, transition_latency);
> > > 
> > > Cc: Viresh Kumar <vireshk@kernel.org>
> > > Cc: Nishanth Menon <nm@ti.com>
> > > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 9bf97a3..da07de6 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -180,6 +180,8 @@ int cpufreq_generic_init(struct cpufreq_policy *policy,
> > >  		return ret;
> > >  	}
> > >  
> > > +	if (!transition_latency)
> > > +		transition_latency = CPUFREQ_ETERNAL;
> > >  	policy->cpuinfo.transition_latency = transition_latency;
> > >  
> > >  	/*
> > 
> > Can you update all the existing drivers as well (in the same patch)
> > who can benefit from it?
> 
> Yes, of course.
> Will do it in the updated version later.

Perhaps you can send it separately if you want as your series is
surely going to take some time to get merged.

-- 
viresh
