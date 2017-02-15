From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: schedutil: govern how frequently we change frequency with rate_limit
Date: Wed, 15 Feb 2017 23:35:29 +0100
Message-ID: <6429586.HoWBhxDx3r@aspire.rjw.lan>
References: <4c9afe0a2cda5016b342f777f244c89c03cdc524.1487178939.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c9afe0a2cda5016b342f777f244c89c03cdc524.1487178939.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 15, 2017 10:45:47 PM Viresh Kumar wrote:

First of all, [RFC] pretty please on things like this.

> For an ideal system (where frequency change doesn't incur any penalty)
> we would like to change the frequency as soon as the load changes for a
> CPU. But the systems we have to work with are far from ideal and it
> takes time to change the frequency of a CPU. For many ARM platforms
> specially, it is at least 1 ms. In order to not spend too much time
> changing frequency, we have earlier introduced a sysfs controlled
> tunable for the schedutil governor: rate_limit_us.
> 
> Currently, rate_limit_us controls how frequently we reevaluate frequency
> for a set of CPUs controlled by a cpufreq policy. But that may not be
> the ideal behavior we want.
> 
> Consider for example the following scenario. The rate_limit_us tunable
> is set to 10 ms. The CPU has a constant load X and that requires the
> frequency to be set to Y. The schedutil governor changes the frequency
> to Y, updates last_freq_update_time and we wait for 10 ms to reevaluate
> the frequency again. After 10 ms, the schedutil governor reevaluates the
> load and finds it to be the same. And so it doesn't update the
> frequency, but updates last_freq_update_time before returning. Right
> after this point, the scheduler puts more load on the CPU and the CPU
> needs to go to a higher frequency Z. Because last_freq_update_time was
> updated just now, the schedutil governor waits for additional 10ms
> before reevaluating the load again.
> 
> Normally, the time it takes to reevaluate the frequency is negligible
> compared to the time it takes to change the frequency.

This should be "the time it takes to reevaluate the load is negligible
relative to the time it takes to change the frequency" I suppose?

Specifically, the "to reevaluate the frequency" phrase is ambiguous.

> And considering
> that in the above scenario, as we haven't updated the frequency for over
> 10ms, we should have changed the frequency as soon as the load changed.

Why should we?

> This patch changes the way rate_limit_us is used, i.e. It now governs
> "How frequently we change the frequency" instead of "How frequently we
> reevaluate the frequency".

That's questionable IMO.

> One may think that this change may have increased the number of times we
> reevaluate the frequency after a period of rate_limit_us has expired
> since the last change, if the load isn't changing. But that is protected
> by the scheduler as normally it doesn't call into the schedutil governor
> before 1 ms (Hint: "decayed" in update_cfs_rq_load_avg()) since the
> last call.
> 
> Tests were performed with this patch on a Dual cluster (same frequency
> domain), octa-core ARM64 platform (Hikey). Hackbench (Debian) and
> Vellamo/Galleryfling (Android) didn't had much difference in
> performance w/ or w/o this patch.
> 
> Its difficult to create a test case (tried rt-app as well) where this
> patch will show a lot of improvements as the target of this patch is a
> real corner case. I.e. Current load is X (resulting in freq change),
> load after rate_limit_us is also X, but right after that load becomes Y.
> Undoubtedly this patch would improve the responsiveness in such cases.

But can that be demonstrated somehow?

Otherwise it is rather not "undoubtedly", but "theoretically".

Thanks,
Rafael
