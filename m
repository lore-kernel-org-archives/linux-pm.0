From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 08/12] PM / OPP: Take kref from _find_opp_table()
Date: Mon, 9 Jan 2017 15:49:58 -0800
Message-ID: <20170109234958.GZ17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <88eef775e522f5addaca2059ae4d0815507d2ffe.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031751AbdAIXuA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 18:50:00 -0500
Content-Disposition: inline
In-Reply-To: <88eef775e522f5addaca2059ae4d0815507d2ffe.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> Take reference of the OPP table from within _find_opp_table(). Also
> update the callers of _find_opp_table() to call
> dev_pm_opp_put_opp_table() after they have used the OPP table.
> 
> Note that _find_opp_table() increments the reference under the
> opp_table_lock.
> 
> Now that the OPP table wouldn't get freed until the callers of
> _find_opp_table() call dev_pm_opp_put_opp_table(), there is no need to
> take the opp_table_lock or rcu_read_lock() around it. Drop them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
