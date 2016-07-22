From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: export cpufreq_driver_resolve_freq()
Date: Fri, 22 Jul 2016 14:05:08 +0200
Message-ID: <1725760.m6ucNt3ELb@vostro.rjw.lan>
References: <1469154278-7373-1-git-send-email-smuckle@linaro.org> <20160722033044.GO3122@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160722033044.GO3122@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 21, 2016 08:30:44 PM Viresh Kumar wrote:
> On 21-07-16, 19:24, Steve Muckle wrote:
> > Export cpufreq_driver_resolve_freq() since governors may be compiled as
> > modules.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Steve Muckle <smuckle@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index b696baeb249d..fa0a92d6121e 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -514,6 +514,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> >  					       CPUFREQ_RELATION_L);
> >  	return policy->freq_table[policy->cached_resolved_idx].frequency;
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
> >  
> >  /*********************************************************************
> >   *                          SYSFS INTERFACE                          *
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied (after a bit of rebasing).

Thanks,
Rafael
