From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 0/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Wed, 26 Apr 2017 10:06:20 +0200
Message-ID: <CAMuHMdWvS6_Zf1nn1=zVLb1qNChyk+B6BDZsK9P9oKRBEpPKMg@mail.gmail.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <d2e3ceaa-57e2-033d-ecd1-a3b2bd8ffa26@nvidia.com> <CAPDyKFoJ58pwGz2U90ob8a8cY=hEbE-wLBHZ0BBzqPoLW_wgGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:38796 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1956777AbdDZIGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 04:06:22 -0400
In-Reply-To: <CAPDyKFoJ58pwGz2U90ob8a8cY=hEbE-wLBHZ0BBzqPoLW_wgGA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

Hi Ulf,

On Tue, Apr 25, 2017 at 9:34 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> However, we currently know about at least two different SoCs that need
> this. Perhaps we can extend the below list to justify adding a new
> framework/APIs. Something along the lines what you propose in $subject
> patchset.
>
> 1) Nvidia; to solve the USB super-speed host/device problem.
> 2) QCOM, which has pointed to several cases where the PM topology is
> laid out like devices having two PM domains..
> 3?) I don't fully remember - but I think Geert also pointed to some
> examples where a device could reside in a clock domain but also in
> power domain for a Renesas SoC!?
> 4) ?

Most Renesas SoCs have module clocks, which we model as a clock domain.
Some Renesas SoCs have power domains for CPUs, others have them for
devices as well.
As we always provide a virtual "always-on" power domain in the power domain
controller, all devices can refer to it using "power-domains" properties,
and the driver for the power domain controller can just forward the clock
domain operations to the clock driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
