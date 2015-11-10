From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4] PM / OPP: Add debugfs support
Date: Tue, 10 Nov 2015 11:36:03 -0800
Message-ID: <20151110193603.GA24116@codeaurora.org>
References: <6775c5c7c2e87b68f999870bdd70de3f77e8a660.1446715747.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46631 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbKJTgF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2015 14:36:05 -0500
Content-Disposition: inline
In-Reply-To: <6775c5c7c2e87b68f999870bdd70de3f77e8a660.1446715747.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>

Minor nitpicks. Looks mostly fine.

On 11/05, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
> new file mode 100644
> index 000000000000..b512a76ef0df
> --- /dev/null
> +++ b/drivers/base/power/opp/debugfs.c
> @@ -0,0 +1,216 @@
> +/*
> + * Generic OPP debugfs interface
> + *
> + * Copyright (C) 2015-2016 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/debugfs.h>
> +#include <linux/err.h>

#include <linux/init.h>
#include <linux/limits.h>
#include <linux/device.h>

> +
> +#include "opp.h"
> +
[..]
> @@ -69,6 +71,7 @@ struct dev_pm_opp {
>  	bool available;
>  	bool dynamic;
>  	bool turbo;
> +	bool suspend;

This should be documented as well.

>  	unsigned long rate;
>  
>  	unsigned long u_volt;
> @@ -81,6 +84,11 @@ struct dev_pm_opp {
>  	struct rcu_head rcu_head;
>  
>  	struct device_node *np;
> +
> +#ifdef CONFIG_DEBUG_FS
> +	/* debugfs */

This comment is pretty useless (for all three instances).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
