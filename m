From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/10] PM / Domain: renesas: Fix active wakeup behavior
Date: Wed, 25 Oct 2017 23:39:55 +0200
Message-ID: <CAMuHMdXH0mayb0jW2sEejoC1=DdPx06kbwJ9VgNN1F-ueQcCvQ@mail.gmail.com>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be> <CAPDyKFoUn18uAmSpOmCcjopNxunnNma4Cv2F9C2k+tE=xcuYMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52353 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdJYVj5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2017 17:39:57 -0400
In-Reply-To: <CAPDyKFoUn18uAmSpOmCcjopNxunnNma4Cv2F9C2k+tE=xcuYMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Ulf,

On Wed, Oct 25, 2017 at 10:49 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 October 2017 at 15:55, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> If a device in a Renesas ARM SoC is part of a Clock Domain, and it is
>> used as a wakeup source, it must be kept active during system suspend.
>>
>> Currently this is handled in device-specific drivers by explicitly
>> increasing the use count of the module clock when the device is
>> configured as a wakeup source.  However, the proper way to prevent the
>> device from being stopped is to inform this requirement to the genpd
>> core.  Hence this series does that, so the workarounds can be removed.
>>
>> This patch series consist of 4 parts:
>>   1. Patches 1-3 fix the clk-renesas-mstp, clk-renesas-cpg-mssr, and
>>      rcar-sysc Clock and/or PM Domain drivers by providing
>>      gpd_dev_ops.active_wakeup() callbacks,
>
> As we spoked about at ELC yesterday, I think the genpd specific
> callback for dealing with this is not really the proper solution.
>
> Instead I think this should be treated as a generic problem. In
> principle I think we need a way for drivers to inform the
> middle-layer/genpd about wakeup requirements during system-wide PM.

Note that the platform (through genpd?) also matters.
The same device may need to be kept enabled on one platform to generate
wakeup events, and may generate such events while disabled on another
platform.

> Allow me to post a patch showing what I had in mind, then we can see
> what you think about it.

OK. Looking forward to it...

>>   2. Patch 4 adds a new GENPD_FLAG_ACTIVE_WAKEUP flag, to avoid various
>>      PM Domain drivers that need similar behavior having to provide
>>      their own identical .active_wakeup() callbacks,
>
> This makes sense, however I think it's sufficient to make genpd check
> the flag, rather than assigning and using the ->active_wakeup()
> callback.

OK. That can definitely be done.

> That would then make it possible to remove the callback altogether.
> Can you do that instead?

drivers/soc/mediatek/mtk-scpsys.c and drivers/soc/rockchip/pm_domains.c
seem to use a more complex callback, but it looks like it can be simplified to
a boolean flag, too.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
