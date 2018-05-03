From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4][for 4.17-rc3] cpufreq / CPPC: Set platform specific
 transition_delay_us
Date: Thu, 3 May 2018 10:01:20 +0530
Message-ID: <20180503043120.gyy6fvy7qic4mjd4@vireshk-i7>
References: <1524850527-31720-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524850527-31720-1-git-send-email-pprakash@codeaurora.org>
Sender: stable-owner@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, "4.14+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27-04-18, 11:35, Prashanth Prakash wrote:
> Add support to specify platform specific transition_delay_us instead
> of using the transition delay derived from PCC.
> 
> With commit "3d41386d556d: cpufreq: CPPC: Use transition_delay_us
> depending transition_latency" we are setting transition_delay_us
> directly and not applying the LATENCY_MULTIPLIER. With this on Qualcomm
> Centriq we can end up with a very high rate of frequency change requests
> when using schedutil governor (default rate_limit_us=10 compared to an
> earlier value of 10000).
> 
> The PCC subspace describes the rate at which the platform can accept
> commands on the CPPC's PCC channel. This includes read and write
> command on the PCC channel that can be used for reasons other than
> frequency transitions. Moreover the same PCC subspace can be used by
> multiple freq domains and deriving transition_delay_us from it as we do
> now can be sub-optimal.
> 
> Moreover if a platform does not use PCC for desired_perf register then
> there is no way to compute the transition latency or the delay_us.
> 
> CPPC does not have a standard defined mechanism to get the transition
> rate or the latency at the moment.
> 
> Given the above limitations, it is simpler to have a platform specific
> transition_delay_us and rely on PCC derived value only if a platform
> specific value is not available.
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: 4.14+ <stable@vger.kernel.org>
> Fixes: 3d41386d556d ("cpufreq: CPPC: Use transition_delay_us depending
> transition_latency)
> ---
> v2:
> * Return final delay_us from cppc_cpufreq_get_transition_delay_us (Viresh)
> v3 and v4:
> * code style changes (Viresh)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
