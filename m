From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 3/4] PM / OPP: Parse all power-supply related bindings
 together
Date: Wed, 28 Oct 2015 11:48:03 -0700
Message-ID: <20151028184803.GW19782@codeaurora.org>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
 <10b3f112bb2863098a0ab21bcb9e951f0a8da51c.1444925400.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41392 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbJ1SsF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 14:48:05 -0400
Content-Disposition: inline
In-Reply-To: <10b3f112bb2863098a0ab21bcb9e951f0a8da51c.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 10/15, Viresh Kumar wrote:
> Move all DT parsing for the power supplies to a single function, rather
> than keeping them at separate places. This will help manage things
> properly.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
