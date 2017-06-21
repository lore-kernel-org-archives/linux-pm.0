From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2] PM / OPP: Add dev_pm_opp_{set|put}_clkname()
Date: Wed, 21 Jun 2017 10:38:27 -0700
Message-ID: <20170621173827.GA4493@codeaurora.org>
References: <e1ae46672cc137bf375349a6b9f7a5a3c9823e74.1497953043.git.viresh.kumar@linaro.org>
 <60e18f9d62e5cd65ae468beb065a3e3ebc205aa4.1498021098.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFURia (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 13:38:30 -0400
Content-Disposition: inline
In-Reply-To: <60e18f9d62e5cd65ae468beb065a3e3ebc205aa4.1498021098.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org

On 06/21, Viresh Kumar wrote:
> In order to support OPP switching, OPP layer needs to get pointer to the
> clock for the device. Simple cases work fine without using the routines
> added by this patch (i.e.  by passing connection-id as NULL), but for a
> device with multiple clocks available, the OPP core needs to know the
> exact name of the clk to use.
> 
> Add a new set of APIs to get that done.
> 
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
