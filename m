From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/2] cpufreq / sched: Rework of cpufreq_update_util()
 arguments
Date: Tue, 16 Aug 2016 15:21:27 +0530
Message-ID: <20160816095127.GF21099@ubuntu>
References: <6346523.ZooER3FGDH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6346523.ZooER3FGDH@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12-08-16, 02:01, Rafael J. Wysocki wrote:
> Hi,
> 
> There were some comments on the "cpufreq / sched: cpufreq_update_util() flags
> and iowait boosting" series I sent some time ago and I wanted to address them,
> but for this purpose I had to combine patches [1-2,4/7] from that series
> into one and make some changes on top of that.
> 
> Then I thought it would be better to send that separately from the iowait
> boost part of that series, so here it goes.
> 
> [1/2] Removes the util and max args from cpufreq_update_util() and governor
>       callbacks and adds a flags argument instead of them.  That argument
>       is then used to handle RT and DL in schedutil and the utilization data
>       are accessed by it directly (so it is non-modular now to avoid exporting
>       the scheduler internals to modules).
> [2/2] Replaces the time argument of cpufreq_update_util() with an rq pointer
>       which allows some simplifications to be made.
> 
> There should be no changes in behavior as a result of this.
> 
> The v2 is to address comments from Steve.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
