From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Tue, 15 Sep 2015 13:09:21 +0530
Message-ID: <20150915073921.GA6350@linux>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org>
 <11470100.cEo24Tpcgr@vostro.rjw.lan>
 <20150910012222.GN5266@linux>
 <1725227.VMGKuhRxma@vostro.rjw.lan>
 <20150911161802.GR9650@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33053 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbIOHj1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 03:39:27 -0400
Received: by pacex6 with SMTP id ex6so169332984pac.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2015 00:39:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150911161802.GR9650@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On 11-09-15, 21:48, Viresh Kumar wrote:
> > -/* Only for cpufreq core internal use */
> >  struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
> >  {
> >  	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> >  
> >  	return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);

This routine was recently marked as static and now with your patch it
results in compilation error. You just need to remove the 'static'
part from the routine.

I would have sent a patch for this, but I thought you would like to
edit the original patch itself to not break git bisect.

-- 
viresh
