From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v3 4/7] soc: renesas: Add r8a7791 SYSC PM Domain Binding Definitions
Date: Thu, 10 Mar 2016 08:58:12 +0200
Message-ID: <27503872.R73ke9ZNPh@avalon>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be> <1457551122-21838-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457551122-21838-5-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 09 March 2016 20:18:39 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> v3:
>   - New.
> ---
>  include/dt-bindings/power/r8a7791-sysc.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 include/dt-bindings/power/r8a7791-sysc.h
> 
> diff --git a/include/dt-bindings/power/r8a7791-sysc.h
> b/include/dt-bindings/power/r8a7791-sysc.h new file mode 100644
> index 0000000000000000..791bcdc0df1c6c04
> --- /dev/null
> +++ b/include/dt-bindings/power/r8a7791-sysc.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2016 Glider bvba
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +#ifndef __DT_BINDINGS_POWER_R8A7791_SYSC_H__
> +#define __DT_BINDINGS_POWER_R8A7791_SYSC_H__
> +
> +/*
> + * These power domain indices match the numbers of the interrupt bits
> + * representing the power areas in the various Interrupt Registers
> + * (e.g. SYSCISR, Interrupt Status Register)
> + */
> +
> +#define R8A7791_PD_CA15_CPU0		 0
> +#define R8A7791_PD_CA15_CPU1		 1
> +#define R8A7791_PD_CA15_SCU		12
> +#define R8A7791_PD_SH			16

The power domain is called SH-4A in the datasheet, how about naming it 
R8A7791_PD_SH_4A ?

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> +#define R8A7791_PD_SGX			20
> +
> +#endif /* __DT_BINDINGS_POWER_R8A7791_SYSC_H__ */

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
