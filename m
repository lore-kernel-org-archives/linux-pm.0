From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 4/8] PM / OPP: Pass struct dev_pm_opp_supply to
 _set_opp_voltage()
Date: Mon, 24 Oct 2016 16:14:53 -0700
Message-ID: <20161024231453.GS26139@codeaurora.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <5f5f81da4b9773854fba72359cb911d2660e2957.1476952750.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f5f81da4b9773854fba72359cb911d2660e2957.1476952750.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/20, Viresh Kumar wrote:
> Pass the entire supply structure instead of all of its fields.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

This patch should be combined with the previous one. I'm still
not sure if it even makes sense to do this though. Do we really
have to make duplicate "OPP snapshot" structures just because of
how OPPs use RCU?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
