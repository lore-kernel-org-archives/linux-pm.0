From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 01/46] arm: Frequency invariant scheduler
 load-tracking support
Date: Tue, 11 Aug 2015 11:27:54 +0200
Message-ID: <20150811092754.GS19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53726 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933700AbbHKJ2M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 05:28:12 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-2-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Tue, Jul 07, 2015 at 07:23:44PM +0100, Morten Rasmussen wrote:
> +static DEFINE_PER_CPU(atomic_long_t, cpu_max_freq);
> +DEFINE_PER_CPU(atomic_long_t, cpu_freq_capacity);

> +	atomic_long_set(&per_cpu(cpu_freq_capacity, cpu), capacity);
> +	unsigned long max = atomic_long_read(&per_cpu(cpu_max_freq, cpu));
> +		atomic_long_set(&per_cpu(cpu_max_freq, i), policy->max);
> +	unsigned long curr = atomic_long_read(&per_cpu(cpu_freq_capacity, cpu));

The use of atomic_long_t here is entirely pointless.

In fact (and someone needs to go fix this), its worse than
WRITE_ONCE()/READ_ONCE().
