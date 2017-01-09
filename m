From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/12] PM / OPP: Use dev_pm_opp_get_opp_table() instead
 of _add_opp_table()
Date: Mon, 9 Jan 2017 15:43:31 -0800
Message-ID: <20170109234331.GX17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <50b18f15c09e7a42830c5b7b71a1b6f48b2f198a.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbdAIXnd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 18:43:33 -0500
Content-Disposition: inline
In-Reply-To: <50b18f15c09e7a42830c5b7b71a1b6f48b2f198a.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> Migrate all users of _add_opp_table() to use dev_pm_opp_get_opp_table()
> to guarantee that the OPP table doesn't get freed while being used.
> 
> Also update _managed_opp() to get the reference to the OPP table.
> 
> Now that the OPP table wouldn't get freed while these routines are
> executing after dev_pm_opp_get_opp_table() is called, there is no need
> to take opp_table_lock. Drop them as well.
> 
> Now that _add_opp_table(), _remove_opp_table() and the unlocked release
> routines aren't used anymore, remove them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
