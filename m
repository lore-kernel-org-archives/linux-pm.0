From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv5 4/4] thermal: exynos: Remove duplicate code when reading
 triminfo register of Exynos5440
Date: Thu, 28 Aug 2014 13:25:14 +0900
Message-ID: <53FEAF2A.1080400@samsung.com>
References: <1409016665-3824-1-git-send-email-cw00.choi@samsung.com>
 <1409016665-3824-5-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1409016665-3824-5-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: eduardo.valentin@ti.com, amit.daniel@samsung.com, rui.zhang@intel.com, kgene.kim@samsung.com, ch.naveen@samsung.com, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Dear Eduardo,

This patch is wrong. It is my mistake.

Please ignore only this patch because
the offset calculation of 'case 0' is different from 'case 2'.

Best Regards,
Chanwoo Choi

On 08/26/2014 10:31 AM, Chanwoo Choi wrote:
> This patch remove simply duplicate code when reading triminfo register of Exynos5440.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 64c702a..5888467 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -187,15 +187,13 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  		 */
>  		switch (data->id) {
>  		case 0:
> +		case 2:
>  			trim_info = readl(data->base +
>  			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
>  			break;
>  		case 1:
>  			trim_info = readl(data->base + reg->triminfo_data);
>  			break;
> -		case 2:
> -			trim_info = readl(data->base -
> -			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
>  		}
>  	} else {
>  		/* On exynos5420 the triminfo register is in the shared space */
> 
