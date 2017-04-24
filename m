From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 6/8] mfd: intel_soc_pmic_bxtwc: utilize devm_*
 functions in driver probe
Date: Mon, 24 Apr 2017 13:03:17 +0100
Message-ID: <20170424120317.xjl456aqzv5kyoqo@dell>
References: <0e4d82ca9cdc41c9d2a8b45258cd72659b4c2063.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <53d9242cd4b81d4dd6cfeb4f1995a405d0ca48ae.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53d9242cd4b81d4dd6cfeb4f1995a405d0ca48ae.1492210847.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, andy@infradead.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Apr 2017, sathyanarayanan.kuppuswamy@linux.intel.com wrote:

> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Cleanup the resource allocation/free code in probe function by using
> devm_* calls.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 54 +++++++++++++-------------------------
>  1 file changed, 18 insertions(+), 36 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> Changes since v1:
>  * None
> 
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index dc8af1d..442dc29 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -400,45 +400,44 @@ static int bxtwc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
> -				  IRQF_ONESHOT | IRQF_SHARED,
> -				  0, &bxtwc_regmap_irq_chip,
> -				  &pmic->irq_chip_data);
> +	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED,
> +				       0, &bxtwc_regmap_irq_chip,
> +				       &pmic->irq_chip_data);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to add IRQ chip\n");
>  		return ret;
>  	}
>  
> -	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
> -				  IRQF_ONESHOT | IRQF_SHARED,
> -				  0, &bxtwc_regmap_irq_chip_level2,
> -				  &pmic->irq_chip_data_level2);
> +	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED,
> +				       0, &bxtwc_regmap_irq_chip_level2,
> +				       &pmic->irq_chip_data_level2);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to add secondary IRQ chip\n");
> -		goto err_irq_chip_level2;
> +		return ret;
>  	}
>  
> -	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
> -				  IRQF_ONESHOT | IRQF_SHARED,
> -				  0, &bxtwc_regmap_irq_chip_tmu,
> -				  &pmic->irq_chip_data_tmu);
> +	ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
> +				       IRQF_ONESHOT | IRQF_SHARED,
> +				       0, &bxtwc_regmap_irq_chip_tmu,
> +				       &pmic->irq_chip_data_tmu);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to add TMU IRQ chip\n");
> -		goto err_irq_chip_tmu;
> +		return ret;
>  	}
>  
> -	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
> -			      ARRAY_SIZE(bxt_wc_dev), NULL, 0,
> -			      NULL);
> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
> +				   ARRAY_SIZE(bxt_wc_dev), NULL, 0, NULL);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to add devices\n");
> -		goto err_mfd;
> +		return ret;
>  	}
>  
>  	ret = sysfs_create_group(&pdev->dev.kobj, &bxtwc_group);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to create sysfs group %d\n", ret);
> -		goto err_sysfs;
> +		return ret;
>  	}
>  
>  	/*
> @@ -452,28 +451,11 @@ static int bxtwc_probe(struct platform_device *pdev)
>  				BXTWC_MIRQLVL1_MCHGR, 0);
>  
>  	return 0;
> -
> -err_sysfs:
> -	mfd_remove_devices(&pdev->dev);
> -err_mfd:
> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_tmu);
> -err_irq_chip_tmu:
> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_level2);
> -err_irq_chip_level2:
> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> -
> -	return ret;
>  }
>  
>  static int bxtwc_remove(struct platform_device *pdev)
>  {
> -	struct intel_soc_pmic *pmic = dev_get_drvdata(&pdev->dev);
> -
>  	sysfs_remove_group(&pdev->dev.kobj, &bxtwc_group);
> -	mfd_remove_devices(&pdev->dev);
> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_level2);
> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_tmu);
>  
>  	return 0;
>  }

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
