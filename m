From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/17] PM / OPP: Introduce
 dev_pm_opp_get_max_transition_latency()
Date: Mon, 11 Jan 2016 18:20:34 -0800
Message-ID: <20160112022034.GW22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <0dd4be8d1e6dec70cd859c99bb597726317ced1e.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44559 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762193AbcALCUf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 21:20:35 -0500
Content-Disposition: inline
In-Reply-To: <0dd4be8d1e6dec70cd859c99bb597726317ced1e.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> In few use cases (like: cpufreq), it is desired to get the maximum
> latency for changing OPPs. Add support for that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
