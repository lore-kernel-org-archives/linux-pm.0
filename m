From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 2/7] PM / OPP: Mark cpumask as const in
 dev_pm_opp_set_sharing_cpus()
Date: Mon, 2 May 2016 17:43:57 -0700
Message-ID: <20160503004357.GK3492@codeaurora.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
 <9a4fef0ecf8329541140de9bb6ccb393b2ec21db.1461727086.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9a4fef0ecf8329541140de9bb6ccb393b2ec21db.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/27, Viresh Kumar wrote:
> dev_pm_opp_set_sharing_cpus() isn't supposed to update the cpumask
> passed as its parameter, and so it should always have been marked
> 'const'.
> 
> Do it now.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

I'm ignoring cpumask_var_t usage.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
