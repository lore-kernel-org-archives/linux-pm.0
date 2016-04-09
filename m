From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 11/11] soc: renesas: rcar-sysc: Add support for R-Car H3 power areas
Date: Sat, 09 Apr 2016 22:22:25 +0300
Message-ID: <1469037.GP7ci3FqN3@avalon>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be> <1460031628-13336-12-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:52614 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814AbcDITWc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 15:22:32 -0400
In-Reply-To: <1460031628-13336-12-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 07 Apr 2016 14:20:28 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - Remove always-on power area, as it's now implicitly handled by the
>     rcar-sysc driver,
>   - Reformat table,
> 
> v3:
>   - New (converted from DT to C).
> ---
>  drivers/soc/renesas/Makefile       |  1 +
>  drivers/soc/renesas/r8a7795-sysc.c | 53 +++++++++++++++++++++++++++++++++++
>  drivers/soc/renesas/rcar-sysc.c    |  3 +++
>  drivers/soc/renesas/rcar-sysc.h    |  1 +
>  4 files changed, 58 insertions(+)
>  create mode 100644 drivers/soc/renesas/r8a7795-sysc.c
> 
> diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
> index b328205fef36441a..151fcd3f025b01f3 100644
> --- a/drivers/soc/renesas/Makefile
> +++ b/drivers/soc/renesas/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_ARCH_R8A7791)	+= rcar-sysc.o r8a7791-sysc.o
>  # R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
>  obj-$(CONFIG_ARCH_R8A7793)	+= rcar-sysc.o r8a7791-sysc.o
>  obj-$(CONFIG_ARCH_R8A7794)	+= rcar-sysc.o r8a7794-sysc.o
> +obj-$(CONFIG_ARCH_R8A7795)	+= rcar-sysc.o r8a7795-sysc.o
> diff --git a/drivers/soc/renesas/r8a7795-sysc.c
> b/drivers/soc/renesas/r8a7795-sysc.c new file mode 100644
> index 0000000000000000..f453dc93d2f2912d
> --- /dev/null
> +++ b/drivers/soc/renesas/r8a7795-sysc.c
> @@ -0,0 +1,53 @@
> +/*
> + * Renesas R-Car H3 System Controller
> + *
> + * Copyright (C) 2016 Glider bvba
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/bug.h>

Why do you need this header ? ARRAY_SIZE is defined in linux/kernel.h and 
__initconst in linux/init.h. Am I missing something ?

Apart from this, for patches 06/11, 07/11, 08/11, 10/11 and 11/11,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +#include <linux/kernel.h>
> +
> +#include <dt-bindings/power/r8a7795-sysc.h>
> +
> +#include "rcar-sysc.h"
> +
> +static const struct rcar_sysc_area r8a7795_areas[] __initconst = {
> +	{ "ca57-scu",	0x1c0, 0, R8A7795_PD_CA57_SCU,	-1, PD_SCU },
> +	{ "ca57-cpu0",	 0x80, 0, R8A7795_PD_CA57_CPU0,	R8A7795_PD_CA57_SCU,
> +	  PD_CPU_NOCR },
> +	{ "ca57-cpu1",	 0x80, 1, R8A7795_PD_CA57_CPU1,	R8A7795_PD_CA57_SCU,
> +	  PD_CPU_NOCR },
> +	{ "ca57-cpu2",	 0x80, 2, R8A7795_PD_CA57_CPU2,	R8A7795_PD_CA57_SCU,
> +	  PD_CPU_NOCR },
> +	{ "ca57-cpu3",	 0x80, 3, R8A7795_PD_CA57_CPU3,	R8A7795_PD_CA57_SCU,
> +	  PD_CPU_NOCR },
> +	{ "ca53-scu",	0x140, 0, R8A7795_PD_CA53_SCU,	-1, PD_SCU },
> +	{ "ca53-cpu0",	0x200, 0, R8A7795_PD_CA53_CPU0,	R8A7795_PD_CA53_SCU,
> +	  PD_CPU_NOCR },
> +	{ "ca53-cpu1",	0x200, 1, R8A7795_PD_CA53_CPU1,	R8A7795_PD_CA53_SCU,
> +	  PD_CPU_NOCR },
> +	{ "ca53-cpu2",	0x200, 2, R8A7795_PD_CA53_CPU2,	R8A7795_PD_CA53_SCU,
> +	  PD_CPU_NOCR },
> +	{ "ca53-cpu3",	0x200, 3, R8A7795_PD_CA53_CPU3,	R8A7795_PD_CA53_SCU,
> +	  PD_CPU_NOCR },
> +	{ "a3vp",	0x340, 0, R8A7795_PD_A3VP,	-1 },
> +	{ "cr7",	0x240, 0, R8A7795_PD_CR7,	-1 },
> +	{ "a3vc",	0x380, 0, R8A7795_PD_A3VC,	-1 },
> +	{ "a2vc0",	0x3c0, 0, R8A7795_PD_A2VC0,	R8A7795_PD_A3VC },
> +	{ "a2vc1",	0x3c0, 1, R8A7795_PD_A2VC1,	R8A7795_PD_A3VC },
> +	{ "3dg-a",	0x100, 0, R8A7795_PD_3DG_A,	-1 },
> +	{ "3dg-b",	0x100, 1, R8A7795_PD_3DG_B,	R8A7795_PD_3DG_A },
> +	{ "3dg-c",	0x100, 2, R8A7795_PD_3DG_C,	R8A7795_PD_3DG_B },
> +	{ "3dg-d",	0x100, 3, R8A7795_PD_3DG_D,	R8A7795_PD_3DG_C },
> +	{ "3dg-e",	0x100, 4, R8A7795_PD_3DG_E,	R8A7795_PD_3DG_D },
> +	{ "a3ir",	0x180, 0, R8A7795_PD_A3IR,	-1 },
> +};
> +
> +const struct rcar_sysc_info r8a7795_sysc_info __initconst = {
> +	.areas = r8a7795_areas,
> +	.num_areas = ARRAY_SIZE(r8a7795_areas),
> +};
> diff --git a/drivers/soc/renesas/rcar-sysc.c
> b/drivers/soc/renesas/rcar-sysc.c index 9bb227b104f1abd2..e4c6f39d43e637c8
> 100644
> --- a/drivers/soc/renesas/rcar-sysc.c
> +++ b/drivers/soc/renesas/rcar-sysc.c
> @@ -323,6 +323,9 @@ static const struct of_device_id rcar_sysc_matches[] = {
> #ifdef CONFIG_ARCH_R8A7794
>  	{ .compatible = "renesas,r8a7794-sysc", .data = &r8a7794_sysc_info },
>  #endif
> +#ifdef CONFIG_ARCH_R8A7795
> +	{ .compatible = "renesas,r8a7795-sysc", .data = &r8a7795_sysc_info },
> +#endif
>  	{ /* sentinel */ }
>  };
> 
> diff --git a/drivers/soc/renesas/rcar-sysc.h
> b/drivers/soc/renesas/rcar-sysc.h index e6d8a42789837cf8..e3b4947914fc7f4f
> 100644
> --- a/drivers/soc/renesas/rcar-sysc.h
> +++ b/drivers/soc/renesas/rcar-sysc.h
> @@ -55,4 +55,5 @@ extern const struct rcar_sysc_info r8a7791_sysc_info;
>  /* R-Car M2-N is identical to R-Car M2-W w.r.t. power domains. */
>  #define r8a7793_sysc_info r8a7791_sysc_info
>  extern const struct rcar_sysc_info r8a7794_sysc_info;
> +extern const struct rcar_sysc_info r8a7795_sysc_info;
>  #endif /* __SOC_RENESAS_RCAR_SYSC_H__ */

-- 
Regards,

Laurent Pinchart

