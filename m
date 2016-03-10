From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v3 5/7] soc: renesas: Add r8a7793 SYSC PM Domain Binding Definitions
Date: Thu, 10 Mar 2016 09:09:04 +0100
Message-ID: <CAMuHMdUHZEGyGcb259-2mAW-g+Oy-eY2k_bFV=pnFrMgTRWJgw@mail.gmail.com>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
	<1457551122-21838-6-git-send-email-geert+renesas@glider.be>
	<2151958.o58rGSd9YV@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2151958.o58rGSd9YV@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Thu, Mar 10, 2016 at 7:59 AM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Wednesday 09 March 2016 20:18:40 Geert Uytterhoeven wrote:
>> R-Car M2-N is identical to R-Car M2-W w.r.t. power domains, so reuse the
>> definitions from the latter.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

>> --- /dev/null
>> +++ b/include/dt-bindings/power/r8a7793-sysc.h
>> @@ -0,0 +1,27 @@
>> +/*
>> + * Copyright (C) 2016 Glider bvba
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + */
>> +#ifndef __DT_BINDINGS_POWER_R8A7793_SYSC_H__
>> +#define __DT_BINDINGS_POWER_R8A7793_SYSC_H__
>> +
>> +/*
>> + * These power domain indices match the numbers of the interrupt bits
>> + * representing the power areas in the various Interrupt Registers
>> + * (e.g. SYSCISR, Interrupt Status Register)
>> + *
>> + * R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
>> + */
>> +
>> +#include "r8a7791-sysc.h"
>> +
>> +#define R8A7793_PD_CA15_CPU0         R8A7791_PD_CA15_CPU0
>> +#define R8A7793_PD_CA15_CPU1         R8A7791_PD_CA15_CPU1
>> +#define R8A7793_PD_CA15_SCU          R8A7791_PD_CA15_SCU
>> +#define R8A7793_PD_SH                        R8A7791_PD_SH
>> +#define R8A7793_PD_SGX                       R8A7791_PD_SGX
>
> I would use numbers directly without including r8a7791-sysc.h, it would save
> going through yet another file when looking for the numerical value.

My main motivation of doing it this way is that r8a7791-sysc.c is also used
on r8a7793, and thus uses the R8A7791_PD_* values directly.

But if you prefer it this way, I can make that change.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
