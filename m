From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 11/13] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Thu, 26 Jan 2017 10:10:35 +0100
Message-ID: <CACRpkdYc7u6Q4CW7a2ECsDkfUkiDJq_zk--RvKwz2i-XW0xHLQ@mail.gmail.com>
References: <CGME20170119134909eucas1p11a7638a4b9bf69b00458189ba9c1bb90@eucas1p1.samsung.com>
 <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com> <1484833733-16082-12-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33082 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbdAZJKq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2017 04:10:46 -0500
Received: by mail-io0-f179.google.com with SMTP id v96so33843728ioi.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2017 01:10:41 -0800 (PST)
In-Reply-To: <1484833733-16082-12-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, "arm@kernel.org" <arm@kernel.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> This patch moves pad retention control from PMU driver to Exynos pin
> controller driver. This helps to avoid possible ordering and logical
> dependencies between machine, PMU and pin control code. Till now it
> worked fine only because sys_ops for PMU and pin controller were called
> in registration order.
> This is also a preparation for adding new features to Exynos pin
> controller driver, like runtime power management and suspending
> individual pin controllers, which might be a part of some power domain.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/mach-exynos/suspend.c           |  64 --------------
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 145 +++++++++++++++++++++++++++++++

This makes all kind of sense, but I would ideally like an ACK
from the ARM SoC maintainer(s): Arnd, Olof, are you OK with
this?

Yours,
Linus Walleij
