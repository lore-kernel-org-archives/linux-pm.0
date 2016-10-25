From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 7/8] PM / OPP: Allow platform specific custom
 opp_set_rate() callbacks
Date: Tue, 25 Oct 2016 12:01:14 -0700
Message-ID: <20161025190114.GV26139@codeaurora.org>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <4786e1f0958441b03e6d91ce21817898574c45ed.1476952750.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbcJYTBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 15:01:16 -0400
Content-Disposition: inline
In-Reply-To: <4786e1f0958441b03e6d91ce21817898574c45ed.1476952750.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org

On 10/20, Viresh Kumar wrote:
> The generic opp_set_rate() handler isn't sufficient for platforms with
> complex DVFS.  For example, some TI platforms have multiple regulators
> for a CPU device. The order in which various supplies need to be
> programmed is only known to the platform code and its best to leave it
> to it.
> 
> This patch implements APIs to register platform specific opp_set_rate()
> callback.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Overall it looks ok, but I'd prefer set_opp instead of set_rate.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
