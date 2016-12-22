From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 06/10] PM / OPP: Rename and split
 _dev_pm_opp_remove_table()
Date: Wed, 21 Dec 2016 16:40:06 -0800
Message-ID: <20161222004006.GB8288@codeaurora.org>
References: <cover.1481085478.git.viresh.kumar@linaro.org>
 <e10b4a5f14d3c95d6b0493ef51341f85c63091f7.1481085478.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47762 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754167AbcLVAkH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2016 19:40:07 -0500
Content-Disposition: inline
In-Reply-To: <e10b4a5f14d3c95d6b0493ef51341f85c63091f7.1481085478.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> Later patches would want to remove OPP table (and its OPPs) using the
> opp_table pointer instead of 'dev'.
> 
> In order to prepare for that, rename _dev_pm_opp_remove_table() as
> _dev_pm_opp_find_and_remove_table() split out part of it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
