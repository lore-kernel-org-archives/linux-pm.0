From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 4/4] ARM: EXYNOS: cpuidle: allow driver usage on
 Exynos3250 SoC
Date: Wed, 18 Mar 2015 14:39:32 +0100
Message-ID: <CAJKOXPfg1UZ9N_FVoHgrE-aZq3y5JUcuE0H1deaZexMXTYZVmw@mail.gmail.com>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
	<1426683113-31209-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426683113-31209-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2015-03-18 13:51 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> Register cpuidle platform device on Exynos3250 SoC allowing EXYNOS
> cpuidle driver usage on this SoC.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
