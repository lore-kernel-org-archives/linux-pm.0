From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 11/17] cpufreq: dt: OPP layers handles clock-latency for
 V1 bindings as well
Date: Mon, 11 Jan 2016 17:41:56 -0800
Message-ID: <20160112014156.GP22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <617c40e84b653fa4253c8f3b2520f27127f87264.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42211 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758859AbcALBl7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:41:59 -0500
Content-Disposition: inline
In-Reply-To: <617c40e84b653fa4253c8f3b2520f27127f87264.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> "clock-latency" is handled by OPP layer for all bindings and so there is
> no need to make special calls for V1 bindings. Use
> dev_pm_opp_get_max_clock_latency() for both the cases.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
