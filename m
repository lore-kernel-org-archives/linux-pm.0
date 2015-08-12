From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 18/46] arm: topology: Define TC2 energy and provide
 it to the scheduler
Date: Wed, 12 Aug 2015 12:33:20 +0200
Message-ID: <20150812103320.GW19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-19-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436293469-25707-19-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:01PM +0100, Morten Rasmussen wrote:
> +static struct capacity_state cap_states_cluster_a7[] = {
> +	/* Cluster only power */
> +	 { .cap =  150, .power = 2967, }, /*  350 MHz */
> +	 { .cap =  172, .power = 2792, }, /*  400 MHz */
> +	 { .cap =  215, .power = 2810, }, /*  500 MHz */
> +	 { .cap =  258, .power = 2815, }, /*  600 MHz */
> +	 { .cap =  301, .power = 2919, }, /*  700 MHz */
> +	 { .cap =  344, .power = 2847, }, /*  800 MHz */
> +	 { .cap =  387, .power = 3917, }, /*  900 MHz */
> +	 { .cap =  430, .power = 4905, }, /* 1000 MHz */
> +	};

So can I suggest a SCHED_DEBUG validation of the data provided?

Given the above table, it _never_ makes sense to run at .cap=150, it
equally also doesn't make sense to run at .cap = 301.

So please add a SCHED_DEBUG test on domain creation that validates that
not only is the .cap monotonically increasing, but the .power is too.
