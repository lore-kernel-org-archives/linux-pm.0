From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: OF: Use pr_debug() instead of pr_err() while
 adding OPP table
Date: Wed, 12 Jul 2017 23:10:14 -0700
Message-ID: <20170713061014.GU22780@codeaurora.org>
References: <3b5b0e789b7296f7b38f4ab9503a53031280a672.1499831484.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdGMGKQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 02:10:16 -0400
Content-Disposition: inline
In-Reply-To: <3b5b0e789b7296f7b38f4ab9503a53031280a672.1499831484.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Mason <slash.tmp@free.fr>, linux-kernel@vger.kernel.org

On 07/12, Viresh Kumar wrote:
> Some platforms add the OPPs dynamically from platform specific drivers
> instead of getting them statically from DT. The cpufreq-dt driver
> already ignores the return value of dev_pm_opp_of_cpumask_add_table() to
> not error out for such cases, but we still end up printing error message
> from that routine. That's not nice.
> 
> Convert the print message to use pr_debug() instead.
> 
> Reported-by: Mason <slash.tmp@free.fr>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
