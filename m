From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/5] Support CPR on MSM8916
Date: Sat, 26 Sep 2015 00:03:26 +0200
Message-ID: <7646588.WPLWGVmoNH@vostro.rjw.lan>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 18, 2015 05:52:04 PM Stephen Boyd wrote:
> This patch series adds support for CPR on MSM8916. The first
> patch exposes a corner voting API to the CPR driver so that we can
> change the corner for the MX regulator. If possible I would
> like to make this patch prettier, but I don't have any great
> ideas right now. The next patch adds support to adjust voltages in the OPP
> layer, and then hooks that up to cpufreq-dt so that we can adjust
> the voltage in response to what CPR tells us to do. I've also thrown
> in a patch to make RCU lockdep warnings go away, but I'm not sure if it's
> right. There's still work to do.
> 
> The final patch adds the CPR driver. This still has some rough edges. With
> the OPPv2 bindings I'm thinking of moving the frequency tables into DT
> and adding a custom vendor property to describe which fuse corner to use for
> each frequency.
> 
> Once you have these patches in place along with a CPU clock driver you
> can eanble enable cpufreq-dt and add the cpufreq-dt device (maybe the
> CPR driver should add the cpufreq-dt device?) and you'll see interrupts
> for CPR and OPP voltage adjustments triggering CPUfreq to modify voltages.
> 
> Andy Gross (1):
>   regulator: smd: Add floor and corner operations
> 
> Stephen Boyd (4):
>   PM / OPP: Support adjusting OPP voltages at runtime
>   OPP: Allow notifiers to call dev_pm_opp_get_{voltage,freq} RCU-free
>   cpufreq-dt: Handle OPP voltage adjust events
>   power: avs: Add support for CPR (Core Power Reduction)

>From the responses so far I gather there will be a v3?

Thanks,
Rafael
