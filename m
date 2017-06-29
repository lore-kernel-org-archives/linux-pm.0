From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Find transition latency dynamically
Date: Thu, 29 Jun 2017 09:58:36 +0530
Message-ID: <20170629042836.GI29665@vireshk-i7>
References: <8041a965fcca71231576ae77a141b1e4333a81cc.1496402967.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36727 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdF2E2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 00:28:39 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so41635922pgb.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2017 21:28:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8041a965fcca71231576ae77a141b1e4333a81cc.1496402967.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 02-06-17, 16:59, Viresh Kumar wrote:
> The transition_latency_ns represents the maximum time it can take for
> the hardware to switch from/to any frequency for a CPU.
> 
> The transition_latency_ns is used currently for two purposes:
> 
> o To check if the hardware latency is over the maximum allowed for a
>   governor (only for ondemand and conservative (why not schedutil?)) and
>   to decide if the governor can be used or not.
> 
> o To calculate the sampling_rate or rate_limit for the governors by
>   multiplying transition_latency_ns with a constant.
> 
> The platform drivers can also set this value to CPUFREQ_ETERNAL if they
> don't know this number and in that case we disallow use of ondemand and
> conservative governors as the latency would be higher than the maximum
> allowed for the governors.
> 
> In many cases this number is forged by the driver authors to get the
> default sampling rate to a desired value. Anyway, the actual latency
> values can differ from what is received from the hardware designers.
> 
> Over that, what is provided by the drivers is most likely the time it
> takes to change frequency of the hardware, which doesn't account the
> software overhead involved.
> 
> In order to have guarantees about this number, this patch tries to
> calculate the latency dynamically at cpufreq driver registration time by
> first switching to min frequency, then to the max and finally back to
> the initial frequency. And the maximum of all three is used as the
> target_latency. Specifically the time it takes to go from min to max
> frequency (when the software runs the slowest) should be good enough,
> and even if there is a delta involved then it shouldn't be a lot.
> 
> For now this patch limits this feature only for platforms which have set
> the transition latency to CPUFREQ_ETERNAL. Maybe we can convert everyone
> to use it in future, but lets see.
> 
> This is tested over ARM64 Hikey platform which currently sets
> "clock-latency" as 500 us from DT, while with this patch the actualy
> value increased to 800 us.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)

Hi Rafael,

Any inputs on this one ?

-- 
viresh
