From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 1/2] ARM: EXYNOS: apply S5P_CENTRAL_SEQ_OPTION fix only
 when necessary
Date: Mon, 26 Jan 2015 08:49:35 +0100
Message-ID: <1422258575.4131.0.camel@AMDC1943>
References: <1422030294-20925-1-git-send-email-b.zolnierkie@samsung.com>
 <1422030294-20925-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36733 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbAZHtk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jan 2015 02:49:40 -0500
In-reply-to: <1422030294-20925-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

On pi=C4=85, 2015-01-23 at 17:24 +0100, Bartlomiej Zolnierkiewicz wrote=
:
> Commit c2dd114d2486 ("ARM: EXYNOS: fix register setup for AFTR mode
> code") added S5P_CENTRAL_SEQ_OPTION register setup fix for all
> Exynos SoCs to AFTR mode code-path.  It turned out that for coupled
> cpuidle AFTR mode on Exynos4210 (added by the next patch) applying
> this fix causes lockup so enable it in the AFTR mode code-path only
> on SoCs that require it (in the suspend code-path it can be always
> applied like it was before commit c2dd114d2486).
>=20
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Colin Cross <ccross@google.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c      | 11 +++++++----
>  arch/arm/mach-exynos/suspend.c |  4 ++++
>  2 files changed, 11 insertions(+), 4 deletions(-)

Looks good.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

>=20
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index dfc8594..1a7454d 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -98,10 +98,6 @@ void exynos_pm_central_suspend(void)
>  	tmp =3D pmu_raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
>  	tmp &=3D ~S5P_CENTRAL_LOWPWR_CFG;
>  	pmu_raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> -
> -	/* Setting SEQ_OPTION register */
> -	pmu_raw_writel(S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0,
> -		       S5P_CENTRAL_SEQ_OPTION);
>  }
> =20
>  int exynos_pm_central_resume(void)
> @@ -165,6 +161,13 @@ void exynos_enter_aftr(void)
> =20
>  	exynos_pm_central_suspend();
> =20
> +	if (of_machine_is_compatible("samsung,exynos4212") ||
> +	    of_machine_is_compatible("samsung,exynos4412")) {
> +		/* Setting SEQ_OPTION register */
> +		pmu_raw_writel(S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0,
> +			       S5P_CENTRAL_SEQ_OPTION);
> +	}
> +
>  	cpu_suspend(0, exynos_aftr_finisher);
> =20
>  	if (read_cpuid_part() =3D=3D ARM_CPU_PART_CORTEX_A9) {
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/su=
spend.c
> index 82e6b6f..666ec3e 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -319,6 +319,10 @@ static int exynos_pm_suspend(void)
>  {
>  	exynos_pm_central_suspend();
> =20
> +	/* Setting SEQ_OPTION register */
> +	pmu_raw_writel(S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0,
> +		       S5P_CENTRAL_SEQ_OPTION);
> +
>  	if (read_cpuid_part() =3D=3D ARM_CPU_PART_CORTEX_A9)
>  		exynos_cpu_save_register();
> =20

