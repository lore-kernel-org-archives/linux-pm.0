From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 5/7] soc: renesas: Add r8a7793 SYSC PM Domain Binding Definitions
Date: Thu, 24 Mar 2016 17:09:18 +0100
Message-ID: <CAMuHMdX5dxJYNTGK31Umb_ZdAcJDf4nkVUcK=stQ-1-B-hZg7Q@mail.gmail.com>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
	<1457551122-21838-6-git-send-email-geert+renesas@glider.be>
	<2151958.o58rGSd9YV@avalon>
	<CAMuHMdUHZEGyGcb259-2mAW-g+Oy-eY2k_bFV=pnFrMgTRWJgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUHZEGyGcb259-2mAW-g+Oy-eY2k_bFV=pnFrMgTRWJgw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 10, 2016 at 9:09 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Mar 10, 2016 at 7:59 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> On Wednesday 09 March 2016 20:18:40 Geert Uytterhoeven wrote:
>>> R-Car M2-N is identical to R-Car M2-W w.r.t. power domains, so reuse the
>>> definitions from the latter.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>>> --- /dev/null
>>> +++ b/include/dt-bindings/power/r8a7793-sysc.h
>>> @@ -0,0 +1,27 @@
>>> +/*
>>> + * Copyright (C) 2016 Glider bvba
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; version 2 of the License.
>>> + */
>>> +#ifndef __DT_BINDINGS_POWER_R8A7793_SYSC_H__
>>> +#define __DT_BINDINGS_POWER_R8A7793_SYSC_H__
>>> +
>>> +/*
>>> + * These power domain indices match the numbers of the interrupt bits
>>> + * representing the power areas in the various Interrupt Registers
>>> + * (e.g. SYSCISR, Interrupt Status Register)
>>> + *
>>> + * R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
>>> + */
>>> +
>>> +#include "r8a7791-sysc.h"
>>> +
>>> +#define R8A7793_PD_CA15_CPU0         R8A7791_PD_CA15_CPU0
>>> +#define R8A7793_PD_CA15_CPU1         R8A7791_PD_CA15_CPU1
>>> +#define R8A7793_PD_CA15_SCU          R8A7791_PD_CA15_SCU
>>> +#define R8A7793_PD_SH                        R8A7791_PD_SH
>>> +#define R8A7793_PD_SGX                       R8A7791_PD_SGX
>>
>> I would use numbers directly without including r8a7791-sysc.h, it would save
>> going through yet another file when looking for the numerical value.
>
> My main motivation of doing it this way is that r8a7791-sysc.c is also used
> on r8a7793, and thus uses the R8A7791_PD_* values directly.
>
> But if you prefer it this way, I can make that change.

Upon second thought, I'll follow Laurent's advice, as it makes r8a7793-sysc.h
self-contained.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
