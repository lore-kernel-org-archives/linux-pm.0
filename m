From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 12/12] PM / OPP: Update Documentation to remove RCU
 specific bits
Date: Mon, 9 Jan 2017 14:39:37 -0800
Message-ID: <20170109223937.GR17126@codeaurora.org>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <164ad6c0c6a5200eae99a7ac23554f33542f465b.1481106919.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754245AbdAIWjj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 17:39:39 -0500
Content-Disposition: inline
In-Reply-To: <164ad6c0c6a5200eae99a7ac23554f33542f465b.1481106919.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 12/07, Viresh Kumar wrote:
> @@ -137,15 +121,18 @@ functions return the matching pointer representing the opp if a match is
>  found, else returns error. These errors are expected to be handled by standard
>  error checks such as IS_ERR() and appropriate actions taken by the caller.
>  
> +Callers of these functions shall call dev_pm_opp_put() after they have used the
> +OPP. Otherwise the memory for the OPP will never get freed and result in
> +memleak.
> +
>  dev_pm_opp_find_freq_exact - Search for an OPP based on an *exact* frequency and
>  	availability. This function is especially useful to enable an OPP which
>  	is not available by default.
>  	Example: In a case when SoC framework detects a situation where a
>  	higher frequency could be made available, it can use this function to
>  	find the OPP prior to call the dev_pm_opp_enable to actually make it available.
> -	 rcu_read_lock();
>  	 opp = dev_pm_opp_find_freq_exact(dev, 1000000000, false);
> -	 rcu_read_unlock();
> +	 dev_pm_opp_put(opp);
>  	 /* dont operate on the pointer.. just do a sanity check.. */
>  	 if (IS_ERR(opp)) {
>  		pr_err("frequency not disabled!\n");
> @@ -163,9 +150,8 @@ dev_pm_opp_find_freq_floor - Search for an available OPP which is *at most* the
>  	frequency.
>  	Example: To find the highest opp for a device:
>  	 freq = ULONG_MAX;
> -	 rcu_read_lock();
>  	 dev_pm_opp_find_freq_floor(dev, &freq);
> -	 rcu_read_unlock();
> +	 dev_pm_opp_put(opp);

opp doesn't exist in the scope here. Missing an assignment during
the dev_pm_opp_find_freq_floor() call?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
