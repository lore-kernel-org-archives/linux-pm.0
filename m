From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 03/12] PM / OPP: Return opp_table from dev_pm_opp_set_*()
 routines
Date: Mon, 9 Jan 2017 15:37:53 -0800
Message-ID: <20170109233753.GV17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <32ef11baf0323b81dfb0a3f2371a28ebfb10082b.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32ef11baf0323b81dfb0a3f2371a28ebfb10082b.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@st.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 12/07, Viresh Kumar wrote:
> Now that we have proper kernel reference infrastructure in place for OPP
> tables, use it to guarantee that the OPP table isn't freed while being
> used by the callers of dev_pm_opp_set_*() APIs.
> 
> Make them all return the pointer to the OPP table after taking its
> reference and put the reference back with dev_pm_opp_put_*() APIs.
> 
> Now that the OPP table wouldn't get freed while these routines are
> executing after dev_pm_opp_get_opp_table() is called, there is no need
> to take opp_table_lock. Drop them as well.
> 
> Remove the rcu specific comments from these routines as they aren't
> relevant anymore.
> 
> Note that prototypes of dev_pm_opp_{set|put}_regulators() were already
> updated by another patch.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
