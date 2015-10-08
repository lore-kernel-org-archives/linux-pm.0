From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Thu, 08 Oct 2015 13:55:24 +0100
Message-ID: <1444308924.2847.35.camel@linaro.org>
References: <1443807532.2845.25.camel@linaro.org>
	 <20151007173920.GG4557@linux> <1444296229.2847.9.camel@linaro.org>
	 <20151008112454.GE18898@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smarthost01d.mail.zen.net.uk ([212.23.1.7]:34943 "EHLO
	smarthost01d.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756751AbbJHMz2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 08:55:28 -0400
In-Reply-To: <20151008112454.GE18898@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2015-10-08 at 16:54 +0530, Viresh Kumar wrote:
> On 08-10-15, 10:23, Jon Medhurst (Tixy) wrote:
> > On Wed, 2015-10-07 at 23:09 +0530, Viresh Kumar wrote:
[...]
> > > @@ -140,9 +140,11 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
> > >  		per_cpu(physical_cluster, cpu) = new_cluster;
> > >  
> > >  		new_rate = find_cluster_maxfreq(new_cluster);
> > > +		target_rate = new_rate;
> 
> This is still a virtual freq ...
> 
> > >  		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
> 
> And new_rate is the actual freq..
> 
> > >  	} else {
> > >  		new_rate = rate;
> > > +		target_rate = new_rate;
> 
> Here both are actual freqs, and no virtual freq.
> 
> > >  	}
> > >  
> > >  	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
> > > @@ -196,7 +198,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
> > >  	 * be reading only the cached value anyway. This needs to  be removed
> > >  	 * once clk core is fixed.
> > >  	 */
> > > -	if (bL_cpufreq_get_rate(cpu) != new_rate)
> > > +	if (bL_cpufreq_get_rate(cpu) != target_rate)
> > >  		return -EIO;
> > >  	return 0;
> > >  }
> > 
> > You call that a proper fix? ;-) It's comparing an 'virtual' frequency to
> > an 'actual' frequency.
> 
> So, why do you say so? I thought both are virtual freqs only.

You are right, I had misread the code. I guess my problem is that I'm
actually running the code then when it doesn't work (which it doesn't)
going back to try and work out why not.

Looking a bit more carefully, the reason your fix doesn't work is that
bL_cpufreq_get_rate returns the last requested rate for this CPU,
whereas target_rate/new_rate is the maximum rate requested by any CPU on
the cluster (which is what we want the hardware set to).
> 
> > If the real intent is to check that clk_set_rate works I would have
> > thought the patch below would be correct. But I didn't propose that as
> > it's the obvious implementation and I assumed the original patch didn't
> > do it that way for a reason.
> 
> Maybe yes. Only Sudeep can tell why he didn't do it that way. But
> yeah, the intent was only what the comment says.

So sounds like my alternative fix of checking the 'actual' frequency
immediately after setting it is probably the way forward, unless Sudeep
chimes in with additional info about the issue he was trying to address.

-- 
Tixy

