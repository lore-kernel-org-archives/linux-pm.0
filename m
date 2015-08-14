From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv5 PATCH 01/46] arm: Frequency invariant scheduler
 load-tracking support
Date: Fri, 14 Aug 2015 17:08:28 +0100
Message-ID: <20150814160828.GE29326@e105550-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
 <20150811092754.GS19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39168 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683AbbHNQFJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Aug 2015 12:05:09 -0400
Content-Disposition: inline
In-Reply-To: <20150811092754.GS19282@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Tue, Aug 11, 2015 at 11:27:54AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:23:44PM +0100, Morten Rasmussen wrote:
> > +static DEFINE_PER_CPU(atomic_long_t, cpu_max_freq);
> > +DEFINE_PER_CPU(atomic_long_t, cpu_freq_capacity);
> 
> > +	atomic_long_set(&per_cpu(cpu_freq_capacity, cpu), capacity);
> > +	unsigned long max = atomic_long_read(&per_cpu(cpu_max_freq, cpu));
> > +		atomic_long_set(&per_cpu(cpu_max_freq, i), policy->max);
> > +	unsigned long curr = atomic_long_read(&per_cpu(cpu_freq_capacity, cpu));
> 
> The use of atomic_long_t here is entirely pointless.

Yes, I will get rid of those.
