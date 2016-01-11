From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 04/19] cpufreq: bring data structures close to their
 locks
Date: Mon, 11 Jan 2016 23:05:28 +0100
Message-ID: <20160111220528.GJ6344@twins.programming.kicks-ass.net>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41149 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759691AbcAKWFc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 17:05:32 -0500
Content-Disposition: inline
In-Reply-To: <1452533760-13787-5-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Mon, Jan 11, 2016 at 05:35:45PM +0000, Juri Lelli wrote:
> +/**
> + * The "cpufreq driver" - the arch- or hardware-dependent low
> + * level driver of CPUFreq support, and its spinlock (cpufreq_driver_lock).
> + * This lock also protects cpufreq_cpu_data array and cpufreq_policy_list.
> + */
> +static struct cpufreq_driver *cpufreq_driver;
> +static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static LIST_HEAD(cpufreq_policy_list);
> +static DEFINE_RWLOCK(cpufreq_driver_lock);

Part of my suggestion was to fold the per-cpu data of cpufreq_cpu_data
into struct cpufreq_driver.

That way each cpufreq_driver will have its own copy and there'd be only
the one global pointer to swizzle. Something very well suited to RCU.


