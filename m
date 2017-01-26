From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 07/13] pinctrl: samsung: Add missing initconst annotation
Date: Thu, 26 Jan 2017 10:08:49 +0100
Message-ID: <CACRpkdY_SpqfyTTqSP5+a1k1LDf_5w77UXo=EognmOzWBz2c-Q@mail.gmail.com>
References: <CGME20170119134907eucas1p14be6b994bddf37f8baca669a66acc1d4@eucas1p1.samsung.com>
 <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com> <1484833733-16082-8-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38443 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdAZJIv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2017 04:08:51 -0500
Received: by mail-it0-f49.google.com with SMTP id c7so30395023itd.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2017 01:08:50 -0800 (PST)
In-Reply-To: <1484833733-16082-8-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> Exynos5433 support has been added in parallel to adding initconst
> annotation to most of the init data structures, so add those
> annotations also to Exynos5433 structures.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

This fails to apply to the pinctrl tree "devel" branch.

I guess I have other Samsung patches on the branch colliding
with this.

Can you please rebase this and the following patches on this
branch and resend?
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Yours,
Linus Walleij
