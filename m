From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 4/7] cpufreq: dt: Identify cpu-sharing for platforms
 without operating-points-v2
Date: Mon, 2 May 2016 17:45:19 -0700
Message-ID: <20160503004519.GM3492@codeaurora.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
 <63799f4fb97a958852ab5f5c055358f669da4772.1461727086.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63799f4fb97a958852ab5f5c055358f669da4772.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/27, Viresh Kumar wrote:
> Existing platforms, which do not support operating-points-v2, can
> explicitly tell the opp core that some of the CPUs share opp tables,
> with help of dev_pm_opp_set_sharing_cpus().
> 
> For such platforms, explicitly ask the opp core to provide list of CPUs
> sharing the opp table with current cpu device, before falling back to
> platform data.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
