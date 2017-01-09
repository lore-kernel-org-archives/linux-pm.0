From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 11/12] PM / OPP: Simplify
 dev_pm_opp_get_max_volt_latency()
Date: Mon, 9 Jan 2017 14:40:31 -0800
Message-ID: <20170109224031.GS17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <a5187f39f00bb5904d8b6e86f6afe12545e6852a.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941729AbdAIWkd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 17:40:33 -0500
Content-Disposition: inline
In-Reply-To: <a5187f39f00bb5904d8b6e86f6afe12545e6852a.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> dev_pm_opp_get_max_volt_latency() calls _find_opp_table() two times
> effectively.
> 
> Merge _get_regulator_count() into dev_pm_opp_get_max_volt_latency() to
> avoid that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
