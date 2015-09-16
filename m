From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Wed, 16 Sep 2015 03:30:13 +0200
Message-ID: <3396868.gayp4sQhTl@vostro.rjw.lan>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org> <20150911161802.GR9650@linux> <20150915073921.GA6350@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41575 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752550AbbIPBCO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 21:02:14 -0400
In-Reply-To: <20150915073921.GA6350@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On Tuesday, September 15, 2015 01:09:21 PM Viresh Kumar wrote:
> On 11-09-15, 21:48, Viresh Kumar wrote:
> > > -/* Only for cpufreq core internal use */
> > >  struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
> > >  {
> > >  	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> > >  
> > >  	return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
> > >  }
> > > +EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
> 
> This routine was recently marked as static and now with your patch it
> results in compilation error. You just need to remove the 'static'
> part from the routine.
> 
> I would have sent a patch for this, but I thought you would like to
> edit the original patch itself to not break git bisect.

I even tried to do that previously, but I made a mistake then.

It should be fixed in my bleeding-edge branch now.

Thanks,
Rafael

