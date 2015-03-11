From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] power: reset: Add generic SYSCON register mapped
 poweroff.
Date: Wed, 11 Mar 2015 10:31:12 +0100
Message-ID: <1426066272.4244.37.camel@x220>
References: <1426029670-31775-1-git-send-email-moritz.fischer@ettus.com>
	 <1426029670-31775-2-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426029670-31775-2-git-send-email-moritz.fischer@ettus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-03-10 at 16:21 -0700, Moritz Fischer wrote:
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
 
> +config POWER_RESET_SYSCON_POWEROFF
> +	bool "Generic SYSCON regmap poweroff driver"

This adds a bool symbol.

> +	depends on OF
> +	select MFD_SYSCON
> +	help
> +	  Poweroff support for generic SYSCON mapped register poweroff.
> +

> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile

> +obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o

So this objectfile can never be part of a module.

> --- /dev/null
> +++ b/drivers/power/reset/syscon-poweroff.c
> @@ -0,0 +1,97 @@
> +/*
> + * Generic Syscon Poweroff Driver
> + *
> + * Copyright (c) 2015, National Instruments Corp.
> + * Author: Moritz Fischer <moritz.fischer@ettus.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

> +#include <linux/module.h>

Is that include needed?

> +MODULE_DEVICE_TABLE(of, syscon_poweroff_of_match);

This will be preprocessed away.

> +module_platform_driver(syscon_poweroff_driver);

I think the built-in equivalent of this would be adding a wrapper that
only does
    platform_driver_register(&syscon_poweroff_driver);

and have that wrapper be marked with device_initcall(). Apparently
there's no macro that does all that in one line.

> +MODULE_LICENSE("GPL v2");

You probably meant
    MODULE_LICENSE("GPL");

> +MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
> +MODULE_DESCRIPTION("Generic SYSCON poweroff driver");
> +MODULE_ALIAS("platform:syscon-poweroff");

But these four macros will all be effectively preprocessed away, anyhow.


Paul Bolle
