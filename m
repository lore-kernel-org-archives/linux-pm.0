From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 4/5] thermal: exynos: Remove unneeded semicolon
Date: Wed, 04 Nov 2015 11:52:11 +0100
Message-ID: <20151104115211.3ae5c0c0@amdc2363>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
 <1444282446-6419-4-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1444282446-6419-4-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

> Remove semicolons after switch statement.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> b/drivers/thermal/samsung/exynos_tmu.c index
> eac6aebf82f3..1af7ea8dda71 100644 ---
> a/drivers/thermal/samsung/exynos_tmu.c +++
> b/drivers/thermal/samsung/exynos_tmu.c @@ -548,7 +548,7 @@ static int
> exynos5433_tmu_initialize(struct platform_device *pdev) default:
>  		pdata->cal_type = TYPE_ONE_POINT_TRIMMING;
>  		break;
> -	};
> +	}
>  
>  	dev_info(&pdev->dev, "Calibration type is %d-point
> calibration\n", cal_type ?  2 : 1);
> @@ -1356,7 +1356,7 @@ static int exynos_tmu_probe(struct
> platform_device *pdev) break;
>  	default:
>  		break;
> -	};
> +	}
>  
>  	/*
>  	 * data->tzd must be registered before calling
> exynos_tmu_initialize(),

Acked-by: Lukasz Majewski <l.majewski@samsung.com>
Tested-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
