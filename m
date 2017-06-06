From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] cpufreq: Find transition latency dynamically
Date: Tue, 6 Jun 2017 18:48:30 +0300
Message-ID: <1496764110.28352.49.camel@nxp.com>
References: <8041a965fcca71231576ae77a141b1e4333a81cc.1496402967.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0058.outbound.protection.outlook.com ([104.47.34.58]:13984
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751281AbdFFPsi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Jun 2017 11:48:38 -0400
In-Reply-To: <8041a965fcca71231576ae77a141b1e4333a81cc.1496402967.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>

On Fri, 2017-06-02 at 16:59 +0530, Viresh Kumar wrote:
> The transition_latency_ns represents the maximum time it can take for
> the hardware to switch from/to any frequency for a CPU.
> 
> The transition_latency_ns is used currently for two purposes:
> 
> o To check if the hardware latency is over the maximum allowed for a
>   governor (only for ondemand and conservative (why not schedutil?)) and
>   to decide if the governor can be used or not.
> 
> o To calculate the sampling_rate or rate_limit for the governors by
>   multiplying transition_latency_ns with a constant.
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

I remember checking if transition latency is correct for imx6q-cpufreq
and it does not appear to be. Maybe because i2c latency of regulator
adjustments is not counted in?

It seems to me it would be much nicer to have a special flag for this
instead of overriding CPUFREQ_ETERNAL.

Also, wouldn't it be possible to update this dynamically? Just measure
the duration every time it happens and do an update like latency =
(latency * 7 + latest_latency) / 8.

--
Regards,
Leonard
