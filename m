From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] PM / core: Invent a WAKEUP_POWERED driver flag
Date: Wed, 8 Nov 2017 16:41:36 +0100
Message-ID: <CAMuHMdUu6=zuCRBaON4K9ivG8bdV1xBuf4dCvPUr2JCL-=xC=w@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:51091 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbdKHPli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 10:41:38 -0500
In-Reply-To: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Ulf,

On Wed, Nov 8, 2017 at 4:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The generic problem this series is trying to solve, is that for some bus types
> and PM domains, it's not sufficient to only check the return value from
> device_may_wakeup(), to fully understand how to treat the device during system
> suspend.
>
> One particular case that suffers from this, is the generic PM domain (aka genpd)
> and that is taken care of in the final change in this series.
>
> The special case this series address, is to enable drivers to instruct bus types
> and PM domains, that the device need to stay powered in case wakeup signals
> is enabled for it.

Thanks for your patches!
They look good to me, hence my Reviewed-by.

> Geert Uytterhoeven, has been working on some related problems for some Renesas
> SoCs [1], to be able to properly configure WakeOnLAN, for some ethernet
> devices/drivers, which are used together with genpd. My intent is that this
> series enables a solution for those problems.
>
> [1]
> https://www.spinics.net/lists/linux-renesas-soc/msg19319.html

While your new WAKEUP_POWERED definitely serves a purpose, I don't think
it's the right solution for the Renesas SoCs.  I can just set the recently
added flag GENPD_FLAG_ACTIVE_WAKEUP in all Renesas clock/power domain
drivers to fix the issue for all Renesas drivers.  After all, all devices in
the clock/power domain must be kept enabled if they're a wakeup source, or
part of the wakeup path.

Not using GENPD_FLAG_ACTIVE_WAKEUP means I would have to add the
WAKEUP_POWERED flag to every single driver that can either be a wakeup
source itself, or be part of the wakeup path.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
