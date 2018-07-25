From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v1 2/3] thermal: tsens: switch from of_iomap() to
 devm_ioremap_resource()
Date: Wed, 25 Jul 2018 15:56:05 -0700
Message-ID: <20180725225605.GS129942@google.com>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
 <4dd9f01c2b5d6988c5329062c25ae61747b42a32.1531898088.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4dd9f01c2b5d6988c5329062c25ae61747b42a32.1531898088.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 18, 2018 at 12:55:02PM +0530, Amit Kucheria wrote:
> devm_ioremap_resources() automatically requests resources (so that the I/O
> region shows up in /proc/iomem) and devm_ wrappers do better error handling
> and unmapping of the I/O region when needed.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 25e7f24..6207d8d 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -127,13 +127,11 @@ static const struct regmap_config tsens_config = {
>  int __init init_common(struct tsens_device *tmdev)
>  {
>  	void __iomem *base;
> +	struct resource *res;
>  	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>  
>  	if (!op)
>  		return -EINVAL;
> -	base = of_iomap(tmdev->dev->of_node, 0);
> -	if (!base)
> -		return -EINVAL;
>  
>  	/* The driver only uses the TM register address space for now */
>  	if (op->num_resources > 1) {
> @@ -143,11 +141,14 @@ int __init init_common(struct tsens_device *tmdev)
>  		tmdev->tm_offset = 0x1000;
>  	}
>  
> +	res = platform_get_resource(op, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&op->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
>  	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
> -	if (IS_ERR(tmdev->map)) {
> -		iounmap(base);
> +	if (IS_ERR(tmdev->map))
>  		return PTR_ERR(tmdev->map);
> -	}
>  
>  	return 0;
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
