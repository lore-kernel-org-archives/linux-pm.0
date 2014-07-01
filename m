From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 07/14] cpufreq: cpu0: OPPs can be populated at runtime
Date: Tue, 01 Jul 2014 11:02:43 -0700
Message-ID: <53B2F7C3.5060107@codeaurora.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org> <1ba7771e910084cd0820c19ca5994fe1b3d6451d.1404231535.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1ba7771e910084cd0820c19ca5994fe1b3d6451d.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, shawn.guo@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, nm@ti.com, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

On 07/01/14 09:32, Viresh Kumar wrote:
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
>  drivers/cpufreq/cpufreq-cpu0.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Please update the binding as well to indicate that this property is now
optional.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
