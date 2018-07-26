From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 2/3] thermal: tsens: switch from of_iomap() to
 devm_ioremap_resource()
Date: Thu, 26 Jul 2018 09:36:59 -0700
Message-ID: <20180726163659.GB5450@tuxbook-pro>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
 <a737a9decfee231ad065304077755267fa5466d7.1532600791.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a737a9decfee231ad065304077755267fa5466d7.1532600791.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 26 Jul 03:33 PDT 2018, Amit Kucheria wrote:

> devm_ioremap_resources() automatically requests resources (so that the I/O
> region shows up in /proc/iomem) and devm_ wrappers do better error handling
> and unmapping of the I/O region when needed.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens-common.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 25e7f247b027..6207d8d92351 100644
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
> -- 
> 2.17.GIT
> 
