From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 12/13] pinctrl: samsung: Move retention control from
 mach-s5pv210 to the pinctrl driver
Date: Fri, 27 Jan 2017 17:20:41 +0100
Message-ID: <7931853.ZcRrqCbIhv@wuerfel>
References: <CGME20170119134910eucas1p2d401df77ccc1ef8e7b05f4cdb2ffc8d3@eucas1p2.samsung.com>
 <1484833733-16082-13-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdYSVvGPoJ-gLiyGuHrqz=GYHCmmFv_bD9HpAywPD5Yzzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdYSVvGPoJ-gLiyGuHrqz=GYHCmmFv_bD9HpAywPD5Yzzg@mail.gmail.com>
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

On Thursday, January 26, 2017 10:11:33 AM CET Linus Walleij wrote:
> On Thu, Jan 19, 2017 at 2:48 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> 
> > This patch moves pad retention control from S5PV210 machine code to
> > Exynos pin controller driver. This helps to avoid possible ordering
> > and logical dependencies between machine and pin control code. Till
> > now it worked fine only because sys_ops for machine code and pin
> > controller were called in registration order.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> > For mach-s5pv210:
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm/mach-s5pv210/pm.c               |  7 ----
> >  arch/arm/mach-s5pv210/regs-clock.h       |  4 ---
> >  drivers/pinctrl/samsung/pinctrl-exynos.c | 56 ++++++++++++++++++++++++++++++++
> 
> Same here, can I have an ARM SoC ACK?
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
