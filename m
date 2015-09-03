From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 Resend 2/5] PM / OPP: Prefix exported opp routines
 with dev_pm_opp_
Date: Wed, 2 Sep 2015 17:00:41 -0700
Message-ID: <20150903000041.GC15099@codeaurora.org>
References: <cover.1441083292.git.viresh.kumar@linaro.org>
 <7c5fd48b6e94fb84f44eb1e79d4518cbf3de6909.1441083292.git.viresh.kumar@linaro.org>
 <20150901190321.GA6123@amd>
 <20150902072238.GC22673@linux>
 <20150902072550.GD22673@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53785 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbICAAn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 20:00:43 -0400
Content-Disposition: inline
In-Reply-To: <20150902072550.GD22673@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, khilman@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>

On 09/02, Viresh Kumar wrote:
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Mon, 3 Aug 2015 14:34:23 +0530
> Subject: [PATCH 2/3] PM / OPP: Prefix exported opp routines with dev_pm_opp_
> 
> That's the naming convention followed in most of opp core, but few
> routines didn't follow this, fix them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
