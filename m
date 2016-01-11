From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their
 locks
Date: Mon, 11 Jan 2016 23:07:09 +0100
Message-ID: <20160111220708.GK6344@twins.programming.kicks-ass.net>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 11, 2016 at 05:35:45PM +0000, Juri Lelli wrote:
> +/**
> + * Iterate over governors
> + *
> + * cpufreq_governor_list is protected by cpufreq_governor_mutex.
> + */
> +static LIST_HEAD(cpufreq_governor_list);
> +static DEFINE_MUTEX(cpufreq_governor_mutex);
> +#define for_each_governor(__governor)				\
> +	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)

So you could stuff the lockdep_assert_held() you later add intididually
into the for_each_governor macro, impossible to forget that way.
