From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 15/16] cpufreq: dt: drop references to DT node
Date: Mon, 8 Feb 2016 14:56:05 -0800
Message-ID: <20160208225605.GG10791@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <b0f0134c9d2488db1971d7be4b8bcdc27356eee4.1453965717.git.viresh.kumar@linaro.org>
 <20160202061132.GD31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160202061132.GD31828@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/02, Viresh Kumar wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 8 Sep 2015 17:34:26 +0530
> Subject: [PATCH 08/20] cpufreq: dt: No need to fetch voltage-tolerance
> 
> Its already done by core and we don't need to get it anymore.  And so,
> we don't need to get of node in cpufreq_init() anymore, move that to
> find_supply_name() instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
