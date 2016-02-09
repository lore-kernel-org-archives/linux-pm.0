From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 03/16] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Tue, 9 Feb 2016 11:04:48 -0800
Message-ID: <20160209190448.GA30978@codeaurora.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
 <243345f4534fab598d62e8247b8312c8677fa864.1454992186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55102 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbcBITEu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 14:04:50 -0500
Content-Disposition: inline
In-Reply-To: <243345f4534fab598d62e8247b8312c8677fa864.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 02/09, Viresh Kumar wrote:
> In few use cases (like: cpufreq), it is desired to get the maximum
> voltage latency for changing OPPs. Add support for that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
