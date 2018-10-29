From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] thermal: qoriq: add multiple sensors support
Date: Mon, 29 Oct 2018 11:24:04 +0100
Message-ID: <27f5210f-d305-3d04-8fff-722623cb065c@linaro.org>
References: <20181029093119.33971-1-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029093119.33971-1-andy.tang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: andy.tang@nxp.com, rui.zhang@intel.com
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29/10/2018 10:31, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> The QorIQ Layerscape SoC has several thermal sensors but the current
> driver only supports one.
> 
> Massage the code to be sensor oriented and allow the support for
> multiple sensors.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---

With the fix below:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks!

[ ... ]

> +	ret = qoriq_tmu_register_tmu_zone(pdev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register sensors\n");
> +		ret = -ENODEV;
> +		goto err_iomap;
>  	

	if (ret) {
		dev_err(&pdev->dev, "Failed to register sensors\n");
		goto err_iomap;
	}


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
