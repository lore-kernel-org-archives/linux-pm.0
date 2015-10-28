From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/5] cpufreq: ondemand: queue work for policy->cpus
 together
Date: Wed, 28 Oct 2015 14:04:24 +0530
Message-ID: <20151028083424.GF30039@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <1864040.ba6Ezq0vlE@vostro.rjw.lan>
 <20151028064635.GC30039@ubuntu>
 <1726178.nnqopTm3i6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1726178.nnqopTm3i6@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28-10-15, 08:33, Rafael J. Wysocki wrote:
> It looks like we shouldn't be using delayed works for this, really.
> 
> We should be using timer functions and normal work items.  Schedule the
> timer function on all CPUs sharing the policy and then queue up the
> work item from the first one that executes the timer.  Then make the
> timer function bail out immediately until the work has completed and
> re-schedule the timers from the work item.

Okay, I will try to get some code out for that then.

-- 
viresh
