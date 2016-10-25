From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 8/8] PM / OPP: Don't WARN on multiple calls to
 dev_pm_opp_set_regulators()
Date: Tue, 25 Oct 2016 12:01:39 -0700
Message-ID: <20161025190139.GW26139@codeaurora.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <3017eefdae58adc192ccb9c829fa32ee9b58c799.1476952750.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759445AbcJYTBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 15:01:40 -0400
Content-Disposition: inline
In-Reply-To: <3017eefdae58adc192ccb9c829fa32ee9b58c799.1476952750.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 10/20, Viresh Kumar wrote:
> If a platform specific OPP driver has called this routine first and set
> the regulators, then the second call from cpufreq-dt driver will hit the
> WARN_ON(). Remove the WARN_ON(), but continue to return error in such
> cases.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
