From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3 10/16] PM / OPP: Add support for opp-suspend
Date: Thu, 30 Jul 2015 23:24:07 -0700
Message-ID: <20150731062406.GS3159@codeaurora.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <3d1b8d7de9f2ad34d979540e367ed691bcb7bb77.1438166099.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38629 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbbGaGYJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:24:09 -0400
Content-Disposition: inline
In-Reply-To: <3d1b8d7de9f2ad34d979540e367ed691bcb7bb77.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 07/29, Viresh Kumar wrote:
> With "operating-points-v2" bindings, its possible to specify the OPP to

s/its/it's/ ?

> which the device must be switched, before suspending.
> 
> This patch adds support for getting that information.
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
