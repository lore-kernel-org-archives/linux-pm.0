From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 12/13] pinctrl: samsung: Move retention control from
 mach-s5pv210 to the pinctrl driver
Date: Tue, 17 Jan 2017 19:54:27 +0200
Message-ID: <20170117175427.4jgjkhwd6etti7qj@kozik-lap>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124502eucas1p19ce0cd772fc4295b207b20cdad30485e@eucas1p1.samsung.com>
 <1484657084-26227-13-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484657084-26227-13-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 17, 2017 at 01:44:43PM +0100, Marek Szyprowski wrote:
> This patch moves pad retention control from S5PV210 machine code to
> Exynos pin controller driver. This helps to avoid possible ordering
> and logical dependencies between machine and pin control code. Till
> now it worked fine only because sys_ops for machine code and pin
> controller were called in registration order.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mach-s5pv210/pm.c               |  7 ----
>  arch/arm/mach-s5pv210/regs-clock.h       |  4 ---

For mach-s5pv210:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
