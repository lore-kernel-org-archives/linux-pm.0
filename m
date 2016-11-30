From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V5] PM / OPP: Pass opp_table to dev_pm_opp_put_regulator()
Date: Wed, 30 Nov 2016 14:00:19 -0800
Message-ID: <20161130220019.GK6095@codeaurora.org>
References: <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org>
 <79cd13ecd7fae57d8afb0c73106ae071c665bf66.1480502882.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79cd13ecd7fae57d8afb0c73106ae071c665bf66.1480502882.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11/30, Viresh Kumar wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Joonyoung Shim reported an interesting problem on his ARM octa-core
> Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
> was failing for a struct device for which dev_pm_opp_set_regulator() is
> called earlier.
> 
> This happened because an earlier call to
> dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
> removed all the entries from opp_table->dev_list apart from the last CPU
> device in the cpumask of CPUs sharing the OPP.
> 
> But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
> routines get CPU device for the first CPU in the cpumask. And so the OPP
> core failed to find the OPP table for the struct device.
> 
> This patch attempts to fix this problem by returning a pointer to the
> opp_table from dev_pm_opp_set_regulator() and using that as the
> parameter to dev_pm_opp_put_regulator(). This ensures that the
> dev_pm_opp_put_regulator() doesn't fail to find the opp table.
> 
> Note that similar design problem also exists with other
> dev_pm_opp_put_*() APIs, but those aren't used currently by anyone and
> so we don't need to update them for now.
> 
> [Viresh]: Written commit log and tested on exynos 5250.
> 
> Cc: # v4.4+ <stable@vger.kernel.org>
> Reported-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

You should have asked for my Signed-off-by instead of just adding
it. Here it is to make things explicit and recorded:

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks for putting everything together and simplifying the error
case.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
