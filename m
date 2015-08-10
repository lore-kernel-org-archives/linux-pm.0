From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 4/6] PM / OPP: Move opp core to its own directory
Date: Mon, 10 Aug 2015 12:51:42 -0700
Message-ID: <20150810195142.GF9678@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <6dcf599b49886fd5a2157f2e61f7424cc754b6f0.1439187821.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34403 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbbHJTvn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 15:51:43 -0400
Content-Disposition: inline
In-Reply-To: <6dcf599b49886fd5a2157f2e61f7424cc754b6f0.1439187821.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Anand Moon <moon.linux@yahoo.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 08/10, Viresh Kumar wrote:
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index f94a6ccfe787..7ff2726dab6c 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -1,8 +1,8 @@
>  obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
>  obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
>  obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
> -obj-$(CONFIG_PM_OPP)	+= opp.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
>  obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
> +obj-$(CONFIG_PM_OPP)	+= opp/
>  
Any reason this moved from the previous location?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
