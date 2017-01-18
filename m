From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 00/13] Move pad retention control to Exynos pin
 controller driver
Date: Wed, 18 Jan 2017 17:40:47 +0900
Message-ID: <CA+Ln22EpeAu59Yp0x7Ph_Z06xP4WY7KMJypwQ9x6Wkpf2yEhgg@mail.gmail.com>
References: <CGME20170117124453eucas1p1b812596939db4c4f3298b941555eb05a@eucas1p1.samsung.com>
 <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Marek,

2017-01-17 21:44 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> Changelog:
>
> v2:
> - reworked exynos_get_pmu_regmap() function and moved to Exynos PMU driver,
>   now it doesn't depend on driver probe order thus doesn't need to defer probing
>   of pinctrl driver if PMU has not yet been probed
> - collected Acks, minor fixes according to review comments

After fixing remaining nits in patch 1 and 10, for all pinctrl patches (4-13):

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

and for other patches (1-3):

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
