From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH] thermal: exynos: Fix register read in TMU
Date: Sat, 17 Oct 2015 08:20:27 +0900
Message-ID: <5621863B.6000603@kernel.org>
References: <1444693909-17754-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1444693909-17754-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Sudip Mukherjee <sudip@vectorindia.org>
List-Id: linux-pm@vger.kernel.org

On 10/13/15 08:51, Krzysztof Kozlowski wrote:
> From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> The value of emul_con was getting overwritten if the selected soc is
> SOC_ARCH_EXYNOS5260. And so as a result we were reading from the wrong
> register in the case of SOC_ARCH_EXYNOS5260.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Lukasz Majewski <l.majewski@samsung.com>
> Fixes: 488c7455d74c ("thermal: exynos: Add the support for Exynos5433 TMU")
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 0bae8cc6c23a..ca920b0ecf8f 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -932,7 +932,7 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
>  
>  	if (data->soc == SOC_ARCH_EXYNOS5260)
>  		emul_con = EXYNOS5260_EMUL_CON;
> -	if (data->soc == SOC_ARCH_EXYNOS5433)
> +	else if (data->soc == SOC_ARCH_EXYNOS5433)
>  		emul_con = EXYNOS5433_TMU_EMUL_CON;
>  	else if (data->soc == SOC_ARCH_EXYNOS7)
>  		emul_con = EXYNOS7_TMU_REG_EMUL_CON;

Applied, thanks.

- Kukjin
