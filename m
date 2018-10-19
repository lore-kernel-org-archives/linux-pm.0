From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 02/15] Revert "platform/olpc: Make ec explicitly non-modular"
Date: Fri, 19 Oct 2018 16:04:17 +0300
Message-ID: <CAHp75Vfrna+htxyDQmmUnyoP3Q=61WWF0LYWNWpNjfScwX2irg@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010172300.317643-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, devel@driverdev.osuosl.or
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> It doesn't make sense to always have this built-in, e.g. on ARM
> multiplatform kernels. A better way to address the problem the original
> commit aimed to solve is to fix Kconfig.
>
> This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.
>

This change doesn't make any sense when put in _this_ order in the series.

First, you need to show the CONFIG_OLPC as tristate, which doesn't (Am
I missing something?).

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/platform/olpc/olpc-ec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 374a8028fec7..f99b183d5296 100644
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
>  #include <asm/olpc.h>
> @@ -328,4 +326,8 @@ static int __init olpc_ec_init_module(void)
>  {
>         return platform_driver_register(&olpc_ec_plat_driver);
>  }
> +
>  arch_initcall(olpc_ec_init_module);
> +
> +MODULE_AUTHOR("Andres Salomon <dilinger@queued.net>");
> +MODULE_LICENSE("GPL");
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
