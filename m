From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/10] PM / OPP: Rename and split
 _dev_pm_opp_remove_table()
Date: Tue, 6 Dec 2016 17:19:06 -0800
Message-ID: <20161207011906.GK4388@codeaurora.org>
References: <cover.1481015522.git.viresh.kumar@linaro.org>
 <36344ecefaa4870ad1789339014d41a5f207a9dd.1481015522.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbcLGBTI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2016 20:19:08 -0500
Content-Disposition: inline
In-Reply-To: <36344ecefaa4870ad1789339014d41a5f207a9dd.1481015522.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/06, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index ee5fbbd6da93..ef114cf9edcd 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -1897,11 +1897,27 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
>   * Free OPPs either created using static entries present in DT or even the
>   * dynamically added entries based on remove_all param.
>   */
> -void _dev_pm_opp_remove_table(struct device *dev, bool remove_all)
> +static void _dev_pm_opp_remove_table(struct opp_table *opp_table,
> +				     struct device *dev, bool remove_all)
>  {
> -	struct opp_table *opp_table;
>  	struct dev_pm_opp *opp, *tmp;

Please add a comment or lockdep check to make sure we're holding
the table lock.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
