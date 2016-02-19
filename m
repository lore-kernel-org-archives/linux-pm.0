From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 3/3] thermal: exynos: Defer probe if vtmu is present but
 not registered
Date: Fri, 19 Feb 2016 13:20:14 +0900
Message-ID: <20160219042014.GB27936@samsunx.samsung>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-4-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36886 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226AbcBSEUQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 23:20:16 -0500
Content-disposition: inline
In-reply-to: <1455819551-4666-4-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Javier,

Just a question...

> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index f4f36bba7be9..f3ce94ec73b5 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1318,6 +1318,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  			return ret;
>  		}
>  	} else {
> +		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;

shouldn't we return also in case of -ENOMEM? -ENOMEM is a Kernel
failure, not depending on the regulator itself.

Andi

>  		dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
>  	}
