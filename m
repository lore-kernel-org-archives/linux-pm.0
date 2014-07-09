From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 07/14] cpufreq: cpu0: OPPs can be populated at runtime
Date: Wed, 9 Jul 2014 10:44:52 -0400
Message-ID: <53BD5564.2060704@ti.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org> <1ba7771e910084cd0820c19ca5994fe1b3d6451d.1404231535.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1ba7771e910084cd0820c19ca5994fe1b3d6451d.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, t.figa@samsung.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, thomas.ab@samsung.com, arvind.chauhan@arm.com, spk.linux@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 July 2014 12:32 PM, Viresh Kumar wrote:
> OPPs can be populated statically, via DT, or added at run time with
> dev_pm_opp_add().
> 
> While this driver handles the first case correctly, it would fail to populate
> OPPs added at runtime. Because call to of_init_opp_table() would fail as there
> are no OPPs in DT and probe will return early.
> 
> To fix this, remove error checking and call dev_pm_opp_init_cpufreq_table()
> unconditionally.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Assuming you are updating bidnings as suggested by Stephen,
patch looks good to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
