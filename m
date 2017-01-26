From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 REBASED 12/13] pinctrl: samsung: Move retention control
 from mach-s5pv210 to the pinctrl driver
Date: Thu, 26 Jan 2017 16:39:51 +0100
Message-ID: <CACRpkdaVH-D+3LFZr67xNQ+63-18+rZMJcn0RvUmb4bsv2Tasw@mail.gmail.com>
References: <CACRpkdY_SpqfyTTqSP5+a1k1LDf_5w77UXo=EognmOzWBz2c-Q@mail.gmail.com>
 <CGME20170126093002eucas1p242ce2fc9c907f515d60e353076bf8214@eucas1p2.samsung.com>
 <1485422967-30643-1-git-send-email-m.szyprowski@samsung.com> <1485422967-30643-9-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1485422967-30643-9-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 26, 2017 at 10:29 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> This patch moves pad retention control from S5PV210 machine code to
> Exynos pin controller driver. This helps to avoid possible ordering
> and logical dependencies between machine and pin control code. Till
> now it worked fine only because sys_ops for machine code and pin
> controller were called in registration order.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> For mach-s5pv210:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch applied.

Yours,
Linus Walleij
