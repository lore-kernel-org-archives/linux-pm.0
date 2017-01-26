From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 REBASED 11/13] pinctrl: samsung: Move retention control
 from mach-exynos to the pinctrl driver
Date: Thu, 26 Jan 2017 16:38:44 +0100
Message-ID: <CACRpkdaCwfm6aU4kNBgmhmRzEiASkBWY-pX=3FqERtyG+55sqQ@mail.gmail.com>
References: <CACRpkdY_SpqfyTTqSP5+a1k1LDf_5w77UXo=EognmOzWBz2c-Q@mail.gmail.com>
 <CGME20170126093002eucas1p1d2c86542c56bd54d78852693f9ddb0b2@eucas1p1.samsung.com>
 <1485422967-30643-1-git-send-email-m.szyprowski@samsung.com> <1485422967-30643-8-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1485422967-30643-8-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 26, 2017 at 10:29 AM, Marek Szyprowski
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

Patch applied with Arnd's ACK and THANKS for cleaning up the
ARM tree.

Yours,
Linus Walleij
