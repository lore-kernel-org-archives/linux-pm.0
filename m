From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 6/6] PM / OPP: Add debugfs support
Date: Mon, 10 Aug 2015 12:50:09 -0700
Message-ID: <20150810195009.GE9678@codeaurora.org>
References: <cover.1439187821.git.viresh.kumar@linaro.org>
 <8a238dcc3bdef28aa9fc3f68787a84449c6ff17a.1439187821.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34237 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbbHJTuN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 15:50:13 -0400
Content-Disposition: inline
In-Reply-To: <8a238dcc3bdef28aa9fc3f68787a84449c6ff17a.1439187821.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, khilman@linaro.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 08/10, Viresh Kumar wrote:
> diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
> new file mode 100644
> index 000000000000..d4e18eac8278
> --- /dev/null
> +++ b/drivers/base/power/opp/debugfs.c
> @@ -0,0 +1,165 @@
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
> +
> +#include "opp.h"
> +
> +static struct dentry *rootdir;
> +
> +void opp_debug_remove_one(struct dev_pm_opp *opp)
> +{
> +	debugfs_remove_recursive(opp->dentry);
> +}
> +
> +int opp_debug_create_one(struct dev_pm_opp *opp, struct dentry *pdentry)

Maybe this could take dev_opp instead of dentry.

> +{
> +	struct dentry *d;
[..]
> +	return 0;
> +}
> +
> +static int device_opp_debug_create_dir(struct device_list_opp *list_dev,
> +				       struct device_opp *dev_opp)
> +{
> +	const struct device *dev = list_dev->dev;
> +	struct dentry *d = NULL;

Why assign this to NULL?

> +
> +	/* Create device specific directory */
> +	d = debugfs_create_dir(dev_name(dev), rootdir);
> +	if (!d) {
> +		dev_err(dev, "%s: Failed to create debugfs dir\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	list_dev->dentry = d;
> +	dev_opp->dentry = d;
> +	dev_opp->debugfs_dev = dev;
> +
> +	return 0;
> +}
> +
> +static int device_opp_debug_create_link(struct device_list_opp *list_dev,
> +					struct device_opp *dev_opp)
> +{
> +	const struct device *dev = list_dev->dev;
> +	struct dentry *d = NULL;

Why assign this to NULL?

> +
> +	/* Create device specific directory link */
> +	d = debugfs_create_symlink(dev_name(dev), rootdir,

The dev_name thing is going to fail. Eventually we'll get into a
situation where two devices with the same name on different
busses have OPPs. When we add them to debugfs their names are
going to conflict. The regulator core suffered this problem, see
commit a9eaa8130707 (regulator: Ensure unique regulator debugfs
directory names, 2014-10-17) for one solution.

> +				   dev_name(dev_opp->debugfs_dev));
> +	if (!d) {
> +		dev_err(dev, "%s: Failed to create link\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	list_dev->dentry = d;
> +
> +	return 0;
> +}
[..]
> +
> +/**
> + * opp_debug_unregister - remove a device opp node from debugfs opp directory
> + * @list_dev: list-dev pointer for device
> + * @dev_opp: the device-opp being removed
> + *
> + * Dynamically removes device specific directory from debugfs 'opp' directory.
> + */
> +void opp_debug_unregister(struct device_list_opp *list_dev,
> +			  struct device_opp *dev_opp)
> +{
> +	debugfs_remove_recursive(list_dev->dentry);

Can this break the symlink that other devices are linking to?

> +	if (list_dev->dentry == dev_opp->dentry)
> +		dev_opp->dentry = NULL;
> +	list_dev->dentry = NULL;

> +}
> +
> diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
> index dcb38f78dae4..8eb6a9a098a1 100644
> --- a/drivers/base/power/opp/opp.h
> +++ b/drivers/base/power/opp/opp.h
> @@ -60,6 +60,7 @@
>   * @dev_opp:	points back to the device_opp struct this opp belongs to
>   * @rcu_head:	RCU callback head used for deferred freeing
>   * @np:		OPP's device node.
> + * @dentry:	debugfs dentry pointer (per opp)
>   *
>   * This structure stores the OPP information for a given device.
>   */
> @@ -81,6 +82,9 @@ struct dev_pm_opp {
>  	struct rcu_head rcu_head;
>  
>  	struct device_node *np;
> +
> +	/* debugfs */
> +	struct dentry *dentry;

Should this be behind a CONFIG_DEBUG_FS ifdef?

>  };
>  
>  /**
> @@ -88,6 +92,7 @@ struct dev_pm_opp {
>   * @node:	list node
>   * @dev:	device to which the struct object belongs
>   * @rcu_head:	RCU callback head used for deferred freeing
> + * @dentry:	debugfs dentry pointer (per device)
>   *
>   * This is an internal data structure maintaining the list of devices that are
>   * managed by 'struct device_opp'.
> @@ -96,6 +101,9 @@ struct device_list_opp {
>  	struct list_head node;
>  	const struct device *dev;
>  	struct rcu_head rcu_head;
> +
> +	/* debugfs */
> +	struct dentry *dentry;

Should this be behind a CONFIG_DEBUG_FS ifdef?

>  };
>  
>  /**
> @@ -111,6 +119,8 @@ struct device_list_opp {
>   * @opp_list:	list of opps
>   * @np:		struct device_node pointer for opp's DT node.
>   * @shared_opp: OPP is shared between multiple devices.
> + * @dentry:	debugfs dentry pointer of the real device directory (not links).
> + * @debugfs_dev: Pointer to device for which the real directory was created.
>   *
>   * This is an internal data structure maintaining the link to opps attached to
>   * a device. This structure is not meant to be shared to users as it is
> @@ -132,6 +142,10 @@ struct device_opp {
>  	unsigned long clock_latency_ns_max;
>  	bool shared_opp;
>  	struct dev_pm_opp *suspend_opp;
> +
> +	/* debugfs */
> +	struct dentry *dentry;
> +	const struct device *debugfs_dev;

Should this be behind a CONFIG_DEBUG_FS guard?


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
