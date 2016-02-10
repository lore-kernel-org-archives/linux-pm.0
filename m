From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/10] cpufreq: Clean up default and fallback governor
 setup
Date: Wed, 10 Feb 2016 11:18:19 +0530
Message-ID: <20160210054819.GB31787@in.ibm.com>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <7056089.34C11T15Ra@vostro.rjw.lan>
 <20160210051514.GA31787@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160210051514.GA31787@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 10, 2016 at 10:45:14AM +0530, Gautham R Shenoy wrote:
> Hello Rafael,
> 
> On Fri, Feb 05, 2016 at 03:11:54AM +0100, Rafael J. Wysocki wrote:
> [..snip..]
> > Index: linux-pm/drivers/cpufreq/cpufreq_performance.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_performance.c
> > +++ linux-pm/drivers/cpufreq/cpufreq_performance.c
> > @@ -33,10 +33,7 @@ static int cpufreq_governor_performance(
> >  	return 0;
> >  }
> > 
> > -#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
> > -static
> > -#endif
> > -struct cpufreq_governor cpufreq_gov_performance = {
> > +static struct cpufreq_governor cpufreq_gov_performance = {
> >  	.name		= "performance",
> >  	.governor	= cpufreq_governor_performance,
> >  	.owner		= THIS_MODULE,
> > @@ -52,6 +49,19 @@ static void __exit cpufreq_gov_performan
> >  	cpufreq_unregister_governor(&cpufreq_gov_performance);
> >  }
> > 
> > +#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> > +struct cpufreq_governor *cpufreq_default_governor(void)
> > +{
> > +	return &cpufreq_gov_performance;
> > +}
> > +#endif
> > +#ifndef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
> 
> Shouldn't this be #ifdef ?

Never mind! Shouldn't be reviewing patches first thing in the morning!
