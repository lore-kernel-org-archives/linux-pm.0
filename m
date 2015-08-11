From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/6] PM / OPP: restructure _of_init_opp_table_v2()
Date: Mon, 10 Aug 2015 23:08:55 -0700
Message-ID: <20150811060855.GH9678@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <804c420eb23e70448c3c2c93f867a0eab3536bfd.1439187821.git.viresh.kumar@linaro.org>
 <20150810192336.GC9678@codeaurora.org>
 <20150811002342.GD5766@linux>
 <55C9425B.4060207@codeaurora.org>
 <20150811022546.GL5766@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59212 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbbHKGI6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 02:08:58 -0400
Content-Disposition: inline
In-Reply-To: <20150811022546.GL5766@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 08/11, Viresh Kumar wrote:
> On 10-08-15, 17:31, Stephen Boyd wrote:
> > So ret is 0. I thought it was an error path, but I guess this is a
> > warning path and we return 0 still?
> 
> Urg ..

Oh I see this is an existing problem... Same problem goes for the
count check. It may be better to fix those two cases first and
then do this cleanup. But I don't mind either way.

> 
> -------------------------8<-------------------------
> 
> Message-Id: <d0e8a9cd6b0fb38fa946cb6274f258d7aa66c00e.1439259818.git.viresh.kumar@linaro.org>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 4 Aug 2015 11:57:36 +0530
> Subject: [PATCH] PM / OPP: restructure _of_init_opp_table_v2()
> 
> 'dev_opp' will always be NULL in _of_init_opp_table_v2() after creating
> OPPs for a device. There is no point comparing it against NULL there.
> 
> Restructure code a bit to make it more efficient.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
