From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v3 03/16] Revert "platform/olpc: Make ec explicitly
 non-modular"
Date: Tue, 08 Jan 2019 09:29:07 +0100
Message-ID: <04e606dd8551bdf71d3b79b12aed46d1ad5157b6.camel@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
         <20190107183439.50626-4-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107183439.50626-4-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2019-01-07 at 19:34 +0100, Lubomir Rintel wrote:
> It doesn't make sense to always have this built-in, e.g. on ARM
> multiplatform kernels.
> 
> A better way to address the problem the original commit aimed to solve is
> to fix Kconfig. That is what the next commit in the series does.
> 
> This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.

The kBuild but figured out that this is not such a great idea.

I'm going to follow-up with a new patch set; sorry for the noise.

> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Sort it later in the patch set
> 
>  drivers/platform/olpc/olpc-ec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 981955dce926..35a21c66cd0d 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -1,8 +1,6 @@
>  /*
>   * Generic driver for the OLPC Embedded Controller.
>   *
> - * Author: Andres Salomon <dilinger@queued.net>
> - *
>   * Copyright (C) 2011-2012 One Laptop per Child Foundation.
>   *
>   * Licensed under the GPL v2 or later.
> @@ -14,7 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/olpc-ec.h>
>  
> @@ -327,4 +325,8 @@ static int __init olpc_ec_init_module(void)
>  {
>  	return platform_driver_register(&olpc_ec_plat_driver);
>  }
> +
>  arch_initcall(olpc_ec_init_module);
> +
> +MODULE_AUTHOR("Andres Salomon <dilinger@queued.net>");
> +MODULE_LICENSE("GPL");
