From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/11] misc: throttler: Add core support for non-thermal
 throttling
Date: Mon, 28 May 2018 10:08:26 +0200
Message-ID: <20180528080826.GA17162@kroah.com>
References: <20180525203043.249193-1-mka@chromium.org>
 <20180525203043.249193-10-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180525203043.249193-10-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Fri, May 25, 2018 at 01:30:41PM -0700, Matthias Kaehlcke wrote:
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 20be70c3f118..01a1714dd2ad 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_MISC_RTSX)		+= cardreader/
> +obj-y				+= throttler/

Shouldn't you depend on a Kconfig option to traverse into this
directory?

> diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> new file mode 100644
> index 000000000000..ef8388f6bc0a
> --- /dev/null
> +++ b/drivers/misc/throttler/Kconfig
> @@ -0,0 +1,13 @@
> +menuconfig THROTTLER
> +	bool "Throttler support"
> +	default n

the default is always 'n' no need to say it again here :)

> +	depends on OF
> +	select CPU_FREQ
> +	select PM_DEVFREQ
> +	help
> +	  This option enables core support for non-thermal throttling of CPUs
> +	  and devfreq devices.
> +
> +	  Note that you also need a event monitor module usually called
> +	  *_throttler.
> +
> diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
> new file mode 100644
> index 000000000000..c8d920cee315
> --- /dev/null
> +++ b/drivers/misc/throttler/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_THROTTLER)		+= core.o
> diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
> new file mode 100644
> index 000000000000..c058d03212b8
> --- /dev/null
> +++ b/drivers/misc/throttler/core.c
> @@ -0,0 +1,373 @@
> +/*
> + * Core code for non-thermal throttling
> + *
> + * Copyright (C) 2018 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */

Please just use a single SPDX line, like checkpatch.pl would have warned
you about.  No need for the full verbous license boiler-plate text here
at all.

thanks,

greg k-h
