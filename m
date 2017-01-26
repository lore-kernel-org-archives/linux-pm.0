From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 01/13] soc: samsung: pmu: Provide global function to
 get PMU regmap
Date: Thu, 26 Jan 2017 16:41:55 +0200
Message-ID: <CAJKOXPefwmNwqV1=PkWrbU6Tj4AgK78Z2qo2DqJ8v4jMJH=8=Q@mail.gmail.com>
References: <CGME20170119134904eucas1p153a1d5b2ff9826c88293b6a8fe5140bc@eucas1p1.samsung.com>
 <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <1484833733-16082-2-git-send-email-m.szyprowski@samsung.com> <CACRpkdYyOgpAhAY=7QrXiEB2oDgs0azt_Tb80iO4vjzk1obemQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYyOgpAhAY=7QrXiEB2oDgs0azt_Tb80iO4vjzk1obemQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 26, 2017 at 11:43 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> PMU is something like a SoC wide service, so add a helper function to get
>> PMU regmap. This will be used by other Exynos device drivers. This way it
>> can be avoided to model this dependency in device tree (as phandles to PMU
>> node) for almost every device in the SoC.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
>
> But why? I could understand it as a local header in
> drivers/soc/samsung/*.h for those files.

Marek gave quite detailed answer... so let me just add minor note.
Apparently we cannot satisfy everyone. When break the DT ABI, DT
people are not happy. When we try to avoid ABI break, we create such
dependency.

In fact, such compile and runtime dependency is not unusual. Our
drivers are coupled because our hardware modules are coupled. When
they were put in arch/arm/mach-exynos, no one cared because everything
was contained in mach-exynos. We try to move the code out of there
thus we need to model such dependencies in a new way... or break the
DT ABI.

Best regards,
Krzysztof
