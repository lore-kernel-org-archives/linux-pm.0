From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 08/10] PM / OPP: Rename dev_pm_opp_get_suspend_opp()
 and return OPP rate
Date: Wed, 21 Dec 2016 16:37:14 -0800
Message-ID: <20161222003714.GZ8288@codeaurora.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
 <e622d7a515012e965d78aa2b0bdb59560d375df1.1481085478.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758236AbcLVAhQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2016 19:37:16 -0500
Content-Disposition: inline
In-Reply-To: <e622d7a515012e965d78aa2b0bdb59560d375df1.1481085478.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> There is only one user of dev_pm_opp_get_suspend_opp() and that uses it
> to get the OPP rate for the suspend_opp.
> 
> Rename dev_pm_opp_get_suspend_opp() as dev_pm_opp_get_suspend_opp_freq()
> and return the rate directly from it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
