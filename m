From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v6 8/8] mfd: Add support for Intel Sunrisepoint LPSS devices
Date: Wed, 29 Jul 2015 15:44:34 -0700
Message-ID: <20150729224434.642.39803@quantum>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-9-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34358 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbbG2Wom convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 18:44:42 -0400
Received: by pdbbh15 with SMTP id bh15so12964199pdb.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2015 15:44:41 -0700 (PDT)
In-Reply-To: <1438009443-55317-9-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, sboyd@codeaurora.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

Is there a data sheet or reference manual publicly available for the
LPSS?

Quoting Andy Shevchenko (2015-07-27 08:04:03)
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> new file mode 100644
> index 0000000..fdf4d5c
> --- /dev/null
> +++ b/drivers/mfd/intel-lpss.c
> @@ -0,0 +1,524 @@
> +/*
> + * Intel Sunrisepoint LPSS core support.
> + *
> + * Copyright (C) 2015, Intel Corporation
> + *
> + * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> + *          Mika Westerberg <mika.westerberg@linux.intel.com>
> + *          Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + *          Jarkko Nikula <jarkko.nikula@linux.intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>

I hope that we can get rid of the above two headers. See more below.

> +struct intel_lpss {
> +       const struct intel_lpss_platform_info *info;
> +       enum intel_lpss_dev_type type;
> +       struct clk *clk;
> +       struct clk_lookup *clock;

Same here. I don't see a use for the clk_lookup?

> +static void intel_lpss_unregister_clock_tree(struct clk *clk)
> +{
> +       struct clk *parent;
> +
> +       while (clk) {
> +               parent = clk_get_parent(clk);
> +               clk_unregister(clk);
> +               clk = parent;
> +       }

clk_unregister is for clock provider drivers that might be unloaded at
run-time, so it is nice of you to support it. However this
implementation isn't fully safe.

For instance, what happens if one day you plug in another clock provider
on top of this one? Your root clock here no longer be a root clock; it
would have a parent, and possibly a whole tree of clocks up above. If
the above happens then you'll unregister all of the parents up until you
hit a root clock!

A better alternative is for your clock provider driver (i.e. _this_
driver) to keep track of which clocks its registers and then unregister
them later.

In fact we have a nice function to help with that: devm_clk_register!
There are plenty of examples of how that is used. It doesn't work with
the "basic" clock types you are using here, but I'm not convinced that
you should be using those anyways...

> +}
> +
> +static int intel_lpss_register_clock_divider(struct intel_lpss *lpss,
> +                                            const char *devname,
> +                                            struct clk **clk)
> +{
> +       char name[32];
> +       struct clk *tmp = *clk;
> +
> +       snprintf(name, sizeof(name), "%s-enable", devname);
> +       tmp = clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
> +                               lpss->priv, 0, 0, NULL);
> +       if (IS_ERR(tmp))
> +               return PTR_ERR(tmp);
> +
> +       snprintf(name, sizeof(name), "%s-div", devname);
> +       tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
> +                                             0, lpss->priv, 1, 15, 16, 15, 0,
> +                                             NULL);
> +       if (IS_ERR(tmp))
> +               return PTR_ERR(tmp);
> +       *clk = tmp;
> +
> +       snprintf(name, sizeof(name), "%s-update", devname);
> +       tmp = clk_register_gate(NULL, name, __clk_get_name(tmp),
> +                               CLK_SET_RATE_PARENT, lpss->priv, 31, 0, NULL);

A gate, then a fixed divider, and then another gate? Seems weird. Do you
have other clock signals that are not enumerated here?

Where did those clock names come from? Are they like that in the data
sheet or just made up for the sake of writing this driver?

Why are the names generated dynamically? Some static data might be
better here. Do you anticipate having more than one LPSS in a running
system? I really hate __clk_get_name and would like to remove it some
day. If we can avoid using it here then I would be grateful.

Also, why do you register these clocks with clkdev? Do other drivers
clk_get them? When are the gates ever enabled/disabled?

> +       if (IS_ERR(tmp))
> +               return PTR_ERR(tmp);
> +       *clk = tmp;
> +
> +       return 0;
> +}
> +
> +static int intel_lpss_register_clock(struct intel_lpss *lpss)
> +{
> +       const struct mfd_cell *cell = lpss->cell;
> +       struct clk *clk;
> +       char devname[24];
> +       int ret;
> +
> +       if (!lpss->info->clk_rate)
> +               return 0;
> +
> +       /* Root clock */
> +       clk = clk_register_fixed_rate(NULL, dev_name(lpss->dev), NULL,
> +                                     CLK_IS_ROOT, lpss->info->clk_rate);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       snprintf(devname, sizeof(devname), "%s.%d", cell->name, lpss->devid);
> +
> +       /*
> +        * Support for clock divider only if it has some preset value.
> +        * Otherwise we assume that the divider is not used.
> +        */
> +       if (lpss->type != LPSS_DEV_I2C) {
> +               ret = intel_lpss_register_clock_divider(lpss, devname, &clk);
> +               if (ret)
> +                       goto err_clk_register;
> +       }

Do ACPI tables encode any meaningful data about clock signals? I gave
some advice on this topic a couple of years ago to folks hacking on ACPI
stuff in Linux, but I haven't kept up with the topic.

By comparison, most ARM-based platforms use Devicetree to link up a
clock provider to a clock consumer. I do not think similar
infrastructure exists yet for ACPI-based designs, but I wonder if the
clock data exists in newer ACPI tables to at least make it possible?

Regards,
Mike
