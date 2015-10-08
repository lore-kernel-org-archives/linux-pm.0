From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Thu, 8 Oct 2015 16:54:54 +0530
Message-ID: <20151008112454.GE18898@linux>
References: <1443807532.2845.25.camel@linaro.org>
 <20151007173920.GG4557@linux>
 <1444296229.2847.9.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444296229.2847.9.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mike.turquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 08-10-15, 10:23, Jon Medhurst (Tixy) wrote:
> On Wed, 2015-10-07 at 23:09 +0530, Viresh Kumar wrote:
> [...]
> > And why not fix it properly by doing this:
> > 
> > diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> > index f1e42f8ce0fc..5b36657a76d6 100644
> > --- a/drivers/cpufreq/arm_big_little.c
> > +++ b/drivers/cpufreq/arm_big_little.c
> > @@ -128,7 +128,7 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
> >  static unsigned int
> >  bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
> >  {
> > -	u32 new_rate, prev_rate;
> > +	u32 new_rate, prev_rate, target_rate;
> >  	int ret;
> >  	bool bLs = is_bL_switching_enabled();
> >  
> > @@ -140,9 +140,11 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
> >  		per_cpu(physical_cluster, cpu) = new_cluster;
> >  
> >  		new_rate = find_cluster_maxfreq(new_cluster);
> > +		target_rate = new_rate;

This is still a virtual freq ...

> >  		new_rate = ACTUAL_FREQ(new_cluster, new_rate);

And new_rate is the actual freq..

> >  	} else {
> >  		new_rate = rate;
> > +		target_rate = new_rate;

Here both are actual freqs, and no virtual freq.

> >  	}
> >  
> >  	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
> > @@ -196,7 +198,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
> >  	 * be reading only the cached value anyway. This needs to  be removed
> >  	 * once clk core is fixed.
> >  	 */
> > -	if (bL_cpufreq_get_rate(cpu) != new_rate)
> > +	if (bL_cpufreq_get_rate(cpu) != target_rate)
> >  		return -EIO;
> >  	return 0;
> >  }
> 
> You call that a proper fix? ;-) It's comparing an 'virtual' frequency to
> an 'actual' frequency.

So, why do you say so? I thought both are virtual freqs only.

> If the real intent is to check that clk_set_rate works I would have
> thought the patch below would be correct. But I didn't propose that as
> it's the obvious implementation and I assumed the original patch didn't
> do it that way for a reason.

Maybe yes. Only Sudeep can tell why he didn't do it that way. But
yeah, the intent was only what the comment says.

-- 
viresh
