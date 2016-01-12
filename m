From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 15/17] cpufreq: dt: Use dev_pm_opp_set_rate() to switch
 frequency
Date: Mon, 11 Jan 2016 17:55:27 -0800
Message-ID: <20160112015527.GT22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <b050fef8d3c3f72d20ac9ca0f7891dc66fb7bc39.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43397 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290AbcALBz2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:55:28 -0500
Content-Disposition: inline
In-Reply-To: <b050fef8d3c3f72d20ac9ca0f7891dc66fb7bc39.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> OPP core supports frequency/voltage changes based on the target
> frequency now, use that instead of open coding the same in cpufreq-dt
> driver.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Nice, assuming that dev_pm_opp_set_rate() is fixed:

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
