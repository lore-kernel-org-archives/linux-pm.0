From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 12/12] PM / OPP: Update Documentation to remove RCU
 specific bits
Date: Fri, 13 Jan 2017 00:44:51 -0800
Message-ID: <20170113084451.GR17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <164ad6c0c6a5200eae99a7ac23554f33542f465b.1481106919.git.viresh.kumar@linaro.org>
 <20170109223937.GR17126@codeaurora.org>
 <20170110043941.GE6332@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdAMIoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 03:44:54 -0500
Content-Disposition: inline
In-Reply-To: <20170110043941.GE6332@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 01/10, Viresh Kumar wrote:
> @@ -252,6 +252,7 @@ dev_pm_opp_get_freq - Retrieve the freq represented by the opp pointer.
>                  if (!IS_ERR(max_opp) && !IS_ERR(requested_opp))
>                         r = soc_test_validity(max_opp, requested_opp);
>                  dev_pm_opp_put(max_opp);
> +                dev_pm_opp_put(requested_opp);
>                 /* do other things */
>          }
>          soc_test_validity(..)
> 
> 
> Please add your RBY if it looks fine to you now.
> 

Sure.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
