From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/6] PM / OPP: Move cpu specific code to opp/cpu.c
Date: Mon, 10 Aug 2015 23:09:52 -0700
Message-ID: <20150811060952.GJ9678@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <ec65df12787e5e531bc50046c5981c30a2b5610e.1439187821.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59279 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbbHKGJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 02:09:54 -0400
Content-Disposition: inline
In-Reply-To: <ec65df12787e5e531bc50046c5981c30a2b5610e.1439187821.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Anand Moon <moon.linux@yahoo.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 08/10, Viresh Kumar wrote:
> Move cpu device specific code out of generic opp library, and add it to
> cpu.c.
> 
> Along with that, create a core-internal opp.h header, which will be used
> to share structures and function prototypes within opp core.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
