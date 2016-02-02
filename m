From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 07/16] PM / OPP: Add dev_pm_opp_set_rate()
Date: Tue, 2 Feb 2016 12:46:11 -0800
Message-ID: <20160202204611.GP4848@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <9151a47d7235855032be559372398edf809fe52b.1453965717.git.viresh.kumar@linaro.org>
 <20160202021046.GH4848@codeaurora.org>
 <20160202033856.GB31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160202033856.GB31828@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/02, Viresh Kumar wrote:
> On 01-02-16, 18:10, Stephen Boyd wrote:
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Fri, 4 Sep 2015 12:28:39 +0530
> Subject: [PATCH] PM / OPP: Add dev_pm_opp_set_rate()
> 
> This adds a routine, dev_pm_opp_set_rate(), responsible for configuring
> power-supply and clock source for an OPP.
> 
> The OPP is found by matching against the target_freq passed to the
> routine. This shall replace similar code present in most of the OPP
> users and help simplify them a lot.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
