From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v9 0/5] Add runtime PM support for clocks (on Exynos SoC example)
Date: Tue, 22 Aug 2017 11:21:02 +0200
Message-ID: <CAMuHMdUy5hi3fLVW6J1o=D194ASjr7Vz-pjWtddHyybK4RZxxA@mail.gmail.com>
References: <CGME20170821080538eucas1p1e273ef22920493ee406ef546bcc230e5@eucas1p1.samsung.com>
 <1503302703-13801-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36195 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbdHVJVD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 05:21:03 -0400
In-Reply-To: <1503302703-13801-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Marek,

On Mon, Aug 21, 2017 at 10:04 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Patches for clocks drivers change the way the clock provider is initialized.
> Instead of CLK_OF_DECLARE based initialization, a complete platform device driver
> infrastructure is being used. This is needed to let driver to use runtime PM
> feature and integrate with generic power domains. The side-effect of this change
> is a delay in clock provider registeration during system boot, so early
> initialized drivers might get EPROBEDEFER error when requesting their clocks.
> This was an issue for IOMMU drivers, but IOMMU deferred probe support has been
> finally merged to v4.13-rc1 and now it is handled correctly.

Any chances you have PHY devices falling back to polling due to this,
cfr. https://patchwork.kernel.org/patch/9734175/?

Thanks!

Gr{oetje,eeting}s,

                        Geert (collecting momentum for the patch
referenced above)

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
