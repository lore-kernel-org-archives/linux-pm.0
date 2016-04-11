From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 11/11] soc: renesas: rcar-sysc: Add support for R-Car
 H3 power areas
Date: Mon, 11 Apr 2016 09:24:54 +0200
Message-ID: <CAMuHMdU7pEkbMBmFmJ_X7iqrk-mjXFsXSYSRZJQgBYR_KS5Hhg@mail.gmail.com>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
	<1460031628-13336-12-git-send-email-geert+renesas@glider.be>
	<1469037.GP7ci3FqN3@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1469037.GP7ci3FqN3@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 9, 2016 at 9:22 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- /dev/null
>> +++ b/drivers/soc/renesas/r8a7795-sysc.c
>> @@ -0,0 +1,53 @@
>> +/*
>> + * Renesas R-Car H3 System Controller
>> + *
>> + * Copyright (C) 2016 Glider bvba
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + */
>> +
>> +#include <linux/bug.h>
>
> Why do you need this header ? ARRAY_SIZE is defined in linux/kernel.h and
> __initconst in linux/init.h. Am I missing something ?

ARRAY_SIZE() uses __must_be_array() uses BUILD_BUG_ON_ZERO().

IIRC, I sent a patch to include bug.h a while ago, but it was rejected.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
