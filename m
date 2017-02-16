From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: govern how frequently we change
 frequency with rate_limit
Date: Thu, 16 Feb 2017 13:36:05 +0100
Message-ID: <20170216123605.GA6515@twins.programming.kicks-ass.net>
References: <4c9afe0a2cda5016b342f777f244c89c03cdc524.1487178939.git.viresh.kumar@linaro.org>
 <6429586.HoWBhxDx3r@aspire.rjw.lan>
 <4960111.i7trI6xaX7@aspire.rjw.lan>
 <4471954.l6hp2TNC2v@aspire.rjw.lan>
 <20170216101210.GD21911@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170216101210.GD21911@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 16, 2017 at 03:42:10PM +0530, Viresh Kumar wrote:
> But when I discussed this with Vincent, he suggested that it may not be required
> at all as the scheduler (with the helped of "decayed") doesn't call into
> schedutil too often, i.e. at least 1 ms. And if the CPUs are stable enough (i.e.
> no interruptions to the running task), we wouldn't reevaluate before the next
> tick.

There are still the attach/detach callers to cfs_rq_util_change() that
kick in for fork/exit and migration.

But yes, barring those we shouldn't end up calling it at silly rates.
