From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/13] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Thu, 26 Jan 2017 11:20:37 +0100
Message-ID: <4644060.byZRaiX1kn@wuerfel>
References: <CGME20170119134909eucas1p11a7638a4b9bf69b00458189ba9c1bb90@eucas1p1.samsung.com>
 <2d9ad2d4-c2f8-ef6b-2504-1337db0da178@samsung.com>
 <CACRpkdapMKpsGVbbvJvXBtYGJCANYUOqMox=083+Lf6LkApmTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdapMKpsGVbbvJvXBtYGJCANYUOqMox=083+Lf6LkApmTw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, January 26, 2017 10:46:25 AM CET Linus Walleij wrote:
> On Thu, Jan 26, 2017 at 10:13 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > On 2017-01-26 10:10, Linus Walleij wrote:
> >> On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
> >> <m.szyprowski@samsung.com> wrote:
> >>>
> >>> This patch moves pad retention control from PMU driver to Exynos pin
> >>> controller driver. This helps to avoid possible ordering and logical
> >>> dependencies between machine, PMU and pin control code. Till now it
> >>> worked fine only because sys_ops for PMU and pin controller were called
> >>> in registration order.
> >>> This is also a preparation for adding new features to Exynos pin
> >>> controller driver, like runtime power management and suspending
> >>> individual pin controllers, which might be a part of some power domain.
> >>>
> >>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> >>> ---
> >>>   arch/arm/mach-exynos/suspend.c           |  64 --------------
> >>>   drivers/pinctrl/samsung/pinctrl-exynos.c | 145
> >>> +++++++++++++++++++++++++++++++
> >>
> >> This makes all kind of sense, but I would ideally like an ACK
> >> from the ARM SoC maintainer(s): Arnd, Olof, are you OK with
> >> this?

Acked-by: Arnd Bergmann <arnd@arndb.de>

> > Isn't enough to have Krzysztof's (Exynos SoC maintainer) 'reviewed-by' tag?
> > I assume that 'reviewed-by' also includes 'acked-by'.
> 
> If the SoC maintainers are too stressed to answer in reasonable time
> or I just get randomly bored of waiting yes, I usually apply it anyway.
> 
> Just want to give them a heads-up essentially.

Agreed, that is a reasonable strategy.

	Arnd
