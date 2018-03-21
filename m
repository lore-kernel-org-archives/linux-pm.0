From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
Date: Wed, 21 Mar 2018 12:39:12 +0100
Message-ID: <2805898.zLaWSBKIiK@amdc3058>
References: <CGME20180321094523eucas1p1a87d146d65d4191ccdb37f1723977011@eucas1p1.samsung.com>
        <20180321094505.25494-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <20180321094505.25494-1-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 21, 2018 10:45:05 AM Marek Szyprowski wrote:
> Since commit 04c8b0f82c7d ("irqchip/gic: Make locking a BL_SWITCHER only
> feature") coupled CPU idle freezes from time to time on Exynos4210. Later
> commit 313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
> changed the context in which the CPU idle code is executed, what results
> in fully reproducible freeze all the time. However, almost the same coupled
> CPU idle code works fine on Exynos3250 regarless of the changes made in
> the mentioned commits.
> 
> It turned out that the IPI call used on Exynos4210 is conflicting with the
> change done in the first mentioned commit in GIC. Fix this by using the
> same code path as for Exynos3250, instead of the IPI call for
> synchronization with second CPU core, call dsb_sev() directly.
> 
> Tested on Exynos4210-based Trats and Origen boards.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: stable@vger.kernel.org # v4.13+

Thanks for spotting and fixing this.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
