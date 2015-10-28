From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 1/4] PM / OPP: Improve print messages with pr_fmt
Date: Wed, 28 Oct 2015 11:49:50 -0700
Message-ID: <20151028184950.GZ19782@codeaurora.org>
References: <20151016192031.GB16437@codeaurora.org>
 <d3072ab1f6665e63d2e26db75a3d598b241d423e.1445055113.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41626 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbbJ1Stv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 14:49:51 -0400
Content-Disposition: inline
In-Reply-To: <d3072ab1f6665e63d2e26db75a3d598b241d423e.1445055113.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 10/17, Viresh Kumar wrote:
> To identify OPP core's print messages easily, prefix them with
> KBUILD_MODNAME.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
