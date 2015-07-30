From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 8/8] mfd: Add support for Intel Sunrisepoint LPSS
 devices
Date: Thu, 30 Jul 2015 13:19:06 +0300
Message-ID: <1438251546.29746.123.camel@linux.intel.com>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1438009443-55317-9-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150729224434.642.39803@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150729224434.642.39803@quantum>
Sender: linux-acpi-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-07-29 at 15:44 -0700, Michael Turquette wrote:
> Hi Andy,
> 
> Is there a data sheet or reference manual publicly available for the
> LPSS?

Yes, I mentioned it in cover letter. For your convenience I just
copy'n'paste it here:

https://download.01.org/future-platform-configuration
-hub/skylake/register-definitions/332219-002.pdf


> 
> Quoting Andy Shevchenko (2015-07-27 08:04:03)
> > diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> > new file mode 100644
> > index 0000000..fdf4d5c
> > --- /dev/null
> > +++ b/drivers/mfd/intel-lpss.c
> > @@ -0,0 +1,524 @@
> > +/*
> > + * Intel Sunrisepoint LPSS core support.
> > + *
> > + * Copyright (C) 2015, Intel Corporation
> > + *
> > + * Authors: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > + *          Mika Westerberg <mika.westerberg@linux.intel.com>
> > + *          Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > + *          Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > + *
> > + * This program is free software; you can redistribute it and/or 
> > modify
> > + * it under the terms of the GNU General Public License version 2 
> > as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
> 
> I hope that we can get rid of the above two headers. See more below.
> 
> > +struct intel_lpss {
> > +       const struct intel_lpss_platform_info *info;
> > +       enum intel_lpss_dev_type type;
> > +       struct clk *clk;
> > +       struct clk_lookup *clock;
> 
> Same here. I don't see a use for the clk_lookup?

clkdev_create() returns it.

> 
> > +static void intel_lpss_unregister_clock_tree(struct clk *clk)
> > +{
> > +       struct clk *parent;
> > +
> > +       while (clk) {
> > +               parent = clk_get_parent(clk);
> > +               clk_unregister(clk);
> > +               clk = parent;
> > +       }
> 
> clk_unregister is for clock provider drivers that might be unloaded 
> at
> run-time, so it is nice of you to support it. However this
> implementation isn't fully safe.
> 
> For instance, what happens if one day you plug in another clock 
> provider
> on top of this one? Your root clock here no longer be a root clock; 
> it
> would have a parent, and possibly a whole tree of clocks up above. If
> the above happens then you'll unregister all of the parents up until 
> you
> hit a root clock!
> 
> A better alternative is for your clock provider driver (i.e. _this_
> driver) to keep track of which clocks its registers and then 
> unregister
> them later.
> 
> In fact we have a nice function to help with that: devm_clk_register!
> 

I will look at this.

> There are plenty of examples of how that is used. It doesn't work 
> with
> the "basic" clock types you are using here, but I'm not convinced 
> that
> you should be using those anyways...
> 
> > +}
> > +
> > +static int intel_lpss_register_clock_divider(struct intel_lpss 
> > *lpss,
> > +                                            const char *devname,
> > +                                            struct clk **clk)
> > +{
> > +       char name[32];
> > +       struct clk *tmp = *clk;
> > +
> > +       snprintf(name, sizeof(name), "%s-enable", devname);
> > +       tmp = clk_register_gate(NULL, name, __clk_get_name(tmp), 0,
> > +                               lpss->priv, 0, 0, NULL);
> > +       if (IS_ERR(tmp))
> > +               return PTR_ERR(tmp);
> > +
> > +       snprintf(name, sizeof(name), "%s-div", devname);
> > +       tmp = clk_register_fractional_divider(NULL, name, 
> > __clk_get_name(tmp),
> > +                                             0, lpss->priv, 1, 15, 
> > 16, 15, 0,
> > +                                             NULL);
> > +       if (IS_ERR(tmp))
> > +               return PTR_ERR(tmp);
> > +       *clk = tmp;
> > +
> > +       snprintf(name, sizeof(name), "%s-update", devname);
> > +       tmp = clk_register_gate(NULL, name, __clk_get_name(tmp),
> > +                               CLK_SET_RATE_PARENT, lpss->priv, 
> > 31, 0, NULL);
> 
> A gate, then a fixed divider, and then another gate? Seems weird. Do 
> you
> have other clock signals that are not enumerated here?
> 
> Where did those clock names come from? Are they like that in the data
> sheet or just made up for the sake of writing this driver?

For example, chapter 1.0, section 1.1 describes clock gating and
fractional divider for UART. Also the high bit updates the actual
divider after we supply m and n values.

Since we have the clock implementation which enables one bit per device
we have to do this in a way of clock tree.

If you have any better suggestion we would improve our driver.

> 
> Why are the names generated dynamically? Some static data might be
> better here. Do you anticipate having more than one LPSS in a running
> system? 

What do you mean under LPSS? We mean the entire IP block consists of
several devices (we only can say which and in what configuration
dynamically). devname here corresponds to the each device in the LPSS
IP block.

As an example
   clock                         enable_cnt  prepare_cnt        rate  
 accuracy   phase
-----------------------------------------------------------------------
-----------------
 0000:00:1e.3                             0            0   120000000   
       0 0  
    pxa2xx-spi.6-enable                   0            0   120000000   
       0 0  
       pxa2xx-spi.6-div                   0            0   120000000   
       0 0  
          pxa2xx-spi.6-update             0            0   120000000   
       0 0  
 0000:00:1e.0                             0            0   120000000   
       0 0  
    dw-apb-uart.5-enable                  0            0   120000000   
       0 0  
       dw-apb-uart.5-div                  0            0     1843200   
       0 0  
          dw-apb-uart.5-update            0            0     1843200   
       0 0  
 0000:00:19.0                             0            0   120000000   
       0 0  
    dw-apb-uart.4-enable                  0            0   120000000   
       0 0  
       dw-apb-uart.4-div                  0            0     1843200   
       0 0  
          dw-apb-uart.4-update            0            0     1843200   
       0 0  

> I really hate __clk_get_name and would like to remove it some
> day. If we can avoid using it here then I would be grateful.
> 
> Also, why do you register these clocks with clkdev? Do other drivers
> clk_get them?

Yes. The actual consumers do that: spi-pxa2xx, 8250_dw, i2c-designware.

>  When are the gates ever enabled/disabled?

In the mentioned drivers. For example, for UART is a clock called
'baudclk' which is changed whenever user changes a baud rate.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
