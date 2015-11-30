From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH V2 06/10] cpufreq: governor: Keep single copy of
 information common to policy->cpus
Date: Mon, 30 Nov 2015 11:34:32 +0100
Message-ID: <1448879672.8275.15.camel@pengutronix.de>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
	 <efd892126475600e751c0e1206553270ebba5c00.1434713657.git.viresh.kumar@linaro.org>
	 <1448625400.3689.103.camel@pengutronix.de> <20151130051915.GH3373@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50872 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbbK3Ken (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 05:34:43 -0500
In-Reply-To: <20151130051915.GH3373@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

Am Montag, den 30.11.2015, 10:49 +0530 schrieb Viresh Kumar:
> On 27-11-15, 12:56, Lucas Stach wrote:
> > Sorry for being late to the party, as this has long been applied, but I
> > stumbled upon this while looking at other stuff and wanted to express my
> > finding.
> 
> No issues, we can still fix things if they have gone wrong.
> 
> > From a short look this change is totally bogus.
> 
> That's a bit shocking, after two people reviewed and tested it :)
> 
> > The *_dbs_timer functions are called from a workqueue on each CPU.
> 
> Right.
> 
> > Moving the time_stamp and the timer_mutex to a shared structure now
> > causes a thundering herd issue on multicore systems.
> 
> You faced an issue or you just think that something is wrong ?

The timer_mutex is one of the top contended locks already on a quad core
system. That really doesn't look right, as the timer is quite low
frequency. It's causing excessive wake ups, as all 4 CPUs wake up to
handle the WQ, 3 of them directly go back to sleep waiting for the mutex
to be released, then same thing happens for CPUs-1 until we rippled down
to a single CPU.

> 
> > All workqueues wake
> > up at the same time with all but one of the worker bouncing on the
> > contended mutex.
> 
> This is exactly what used to be done earlier, but it was designed
> badly. For example, for ondemand governor, each CPU had a
> struct od_cpu_dbs_info_s and we only used the od_cpu_dbs_info_s for
> the 'policy->cpu'. So, even if all CPUs had this structure (i.e. the
> time_stamp and the lock), we only used structure for policy->cpu.
> 
Ok, so this patch isn't actually at fault. My apologies. It was just the
first thing down the git history that catched my eye when looking into
why the timer mutex is this badly contended.
I would say it's still worth fixing. Perhaps by not waking all the
workqueues at the same time, but spreading the wake times out over a
jiffy.

> > Also sharing the time_stamp causes all but the first worker to acquire
> > the mutex to not properly update their sampling information, I guess.
> 
> Yeah, that's what we want per-policy.
> 
That I still don't really understand. If we only sample a single CPU,
why do we also wake all the others? Also if we serialize on the
timer_mutex and only the first CPU to acquire it updates the sampling
information, is it ok that essentially a random CPU will do the work?

Again, I didn't really take the time to understand the code in depth,
hoping that you could provide the answers to those questions more
easily. :)

Thanks,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

