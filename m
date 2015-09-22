From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2] PM / OPP: of_property_count_u32_elems() can return
 errors
Date: Tue, 22 Sep 2015 09:51:27 -0700
Message-ID: <20150922165127.GH23081@codeaurora.org>
References: <3ad0ce115028e628e556a505689d396b6e98f04e.1442939340.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51035 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757764AbbIVQv3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 12:51:29 -0400
Content-Disposition: inline
In-Reply-To: <3ad0ce115028e628e556a505689d396b6e98f04e.1442939340.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 09/22, Viresh Kumar wrote:
> of_property_count_u32_elems() will never return 0, but a -ve error value
> of a positive count. And so the current !count check is wrong.
> 
> Also, a missing "opp-microvolt" property isn't a problem and so we need
> to do of_find_property() separately to confirm that.
> 
> Fixes: 274659029c9d ("PM / OPP: Add support to parse "operating-points-v2" bindings")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
