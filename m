From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/3] cpufreq: avoid redundant driver calls in schedutil
Date: Thu, 21 Jul 2016 13:01:12 -0700
Message-ID: <20160721200112.GG3122@ubuntu>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 13-07-16, 13:25, Steve Muckle wrote:
> Invoking the cpufreq driver to set a frequency can be expensive. On platforms
> with a cpufreq driver that does not support fast switching a thread must be
> woken to complete the operation. IPIs will also occur if and when support to
> process remote task wakeups is added in schedutil.
> 
> Currently schedutil calculates a raw frequency request from scheduler
> utilization data. This raw frequency request does not correlate to supported
> cpufreq driver frequencies aside from being capped by the CPU's maximum
> frequency. Consequently, there may be many consecutive requests for different
> raw frequency values which all translate to the same driver-supported
> frequency. For example on a platform with 3 supported frequencies 200MHz,
> 400MHz, and 600MHz, raw requests for 257MHz, 389MHz, and 307MHz all map to a
> driver-supported frequency of 400MHz in schedutil. Assuming these requests were
> consecutive and there were no changes in policy limits (min/max), there is no
> need to issue the second or third request.
> 
> In order to resolve a raw frequency request to a driver-supported one a new
> cpufreq API is added, cpufreq_driver_resolve_freq(). This API relies on a new
> cpufreq driver callback in the case of ->target() style drivers. Otherwise it
> uses the existing frequency table operations.
> 
> Lookups are cached both in cpufreq_driver_resolve_freq() (for the benefit of the
> driver) and in schedutil.
> 
> Changes since v2:
> - incorporated feedback from Viresh to use resolve_freq driver callbacks
>   only for ->target() style drivers, to use cpufreq's freq table operations,
>   and move freq mapping caching into cpufreq policy

Sorry for the delay buddy :(

I have some concerns for the first patch. The second and third patch
look fine.  Feel free to add my 

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

for them.

-- 
viresh
