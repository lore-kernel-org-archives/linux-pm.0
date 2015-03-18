From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 3/5] ARM: EXYNOS: add exynos_set_boot_addr() helper
Date: Wed, 18 Mar 2015 14:48:14 +0100
Message-ID: <CAJKOXPfzLvjZtP60qRW9HRn7KBPGXPqy58Enb1eR9JrYPg15dg@mail.gmail.com>
References: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
	<1426684197-22281-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1426684197-22281-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2015-03-18 14:09 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> Add exynos_set_boot_addr() helper and covert existing code
> (exynos_boot_secondary() and exynos_smp_prepare_cpus()) to
> use it.
>
> There should be no functional changes caused by this patch.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c | 53 +++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)

Looks good.
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
