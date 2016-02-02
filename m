From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 03/16] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Mon, 1 Feb 2016 18:30:02 -0800
Message-ID: <20160202023002.GJ4848@codeaurora.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <81d90b48867dbdbb6e5e9a911de3873bc5ec4d14.1453965717.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44094 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbcBBCaF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 21:30:05 -0500
Content-Disposition: inline
In-Reply-To: <81d90b48867dbdbb6e5e9a911de3873bc5ec4d14.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 01/28, Viresh Kumar wrote:
> In few use cases (like: cpufreq), it is desired to get the maximum
> voltage latency for changing OPPs. Add support for that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
