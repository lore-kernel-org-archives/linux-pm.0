From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 1/4] PM / OPP: Improve debug print messages with pr_fmt
Date: Thu, 15 Oct 2015 12:04:21 -0700
Message-ID: <20151015190421.GK4558@codeaurora.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
 <d3072ab1f6665e63d2e26db75a3d598b241d423e.1444925400.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47686 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbbJOTEX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 15:04:23 -0400
Content-Disposition: inline
In-Reply-To: <d3072ab1f6665e63d2e26db75a3d598b241d423e.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 10/15, Viresh Kumar wrote:
> With debug options on, it is difficult to locate OPP core's debug
> prints. Fix this by prefixing OPP debug prints with KBUILD_MODNAME.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Why not use dynamic debug's m flag to turn on KBUILD_MODNAME when
debugging?

>From Documentation/dynamic-debug-howto.txt

  m    Include module name in the printed message
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
