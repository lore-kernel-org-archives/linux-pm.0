From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Thu, 14 Jan 2016 13:52:24 +0000
Message-ID: <20160114135224.GH18603@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
 <20160113063148.GJ6050@ubuntu>
 <20160113182131.1168.45753@quark.deferred.io>
 <20160114103221.GB6078@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46449 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685AbcANNwB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jan 2016 08:52:01 -0500
Content-Disposition: inline
In-Reply-To: <20160114103221.GB6078@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 14/01/16 16:02, Viresh Kumar wrote:
> On 13-01-16, 10:21, Michael Turquette wrote:
> > Quoting Viresh Kumar (2016-01-12 22:31:48)
> > > On 12-01-16, 16:54, Michael Turquette wrote:
> > > > __cpufreq_driver_target should be using a per-policy lock.
> > > 
> > > It doesn't :)
> > 
> > It should.
> 
> I thought we wanted the routine doing DVFS to not sleep as it will be
> called from scheduler ?
> 
> Looks fine otherwise. But yeah, the series is still incomplete in the
> sense that there is no lock today around __cpufreq_driver_target().
> 

I was under the impression that the purpose of having
__cpufreq_driver_target() exported outside cpufreq.c was working due to
the fact that users implement their own locking.

That's why I put the following comment in this patch.

 /*
  * Callers must ensure proper mutual exclusion on policy (for transition_
  * ongoing/transition_task handling). While holding policy->rwsem is
  * sufficient, other schemes might work as well (e.g., cpufreq_governor.c
  * holds timer_mutex while entering the path that generates transitions).
  */

>From what I can see ondemand and conservative (via governor) seem to use
timer_mutex; userspace userspace_mutex instead. Do they serve different
purposes instead? How do we currently serialize operations on policy
when using __cpufreq_driver_target() directly otherwise?

Thanks,

- Juri
