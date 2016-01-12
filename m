From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 14/17] cpufreq: dt: Reuse
 dev_pm_opp_get_max_transition_latency()
Date: Mon, 11 Jan 2016 17:54:46 -0800
Message-ID: <20160112015446.GS22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <25c4f290a6d03cee3239ea68273bc229c8f939d3.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43335 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762119AbcALBys (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:54:48 -0500
Content-Disposition: inline
In-Reply-To: <25c4f290a6d03cee3239ea68273bc229c8f939d3.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> OPP layer has all the information now to calculate transition latency
> (clock_latency + voltage_latency). Lets reuse the OPP layer helper
> dev_pm_opp_get_max_transition_latency() instead of open coding the same
> in cpufreq-dt driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Maybe this can be combined with patch 13. I don't seem much need
to distinguish between the two.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
