From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] power: ltc3651-charger: fix some error codes in probe
Date: Thu, 18 May 2017 10:41:08 +0200
Message-ID: <63d81057-f6b2-1fea-003d-3fa29638f89d@topic.nl>
References: <20170518074346.flhmb7xi6m7j2cni@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170518074346.flhmb7xi6m7j2cni@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

﻿Good catch, you can add my

Acked-by: Mike Looijmans <mike.looijmans@topic.nl>

On 18-05-17 09:43, Dan Carpenter wrote:
> There are several cut and past bugs here.  ltc3651_charger->charger is
> NULL at this point, so we return success instead of the intended error
> codes.
>
> Fixes: c94d4ed017ae ("power: supply: Add ltc3651-charger driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/supply/ltc3651-charger.c
> index 5f8d5c0b5721..eea63ff211c4 100644
> --- a/drivers/power/supply/ltc3651-charger.c
> +++ b/drivers/power/supply/ltc3651-charger.c
> @@ -110,21 +110,21 @@ static int ltc3651_charger_probe(struct platform_device *pdev)
>  	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
>  					"lltc,acpr", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
> -		ret = PTR_ERR(ltc3651_charger->charger);
> +		ret = PTR_ERR(ltc3651_charger->acpr_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
>  		return ret;
>  	}
>  	ltc3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
>  					"lltc,fault", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->fault_gpio)) {
> -		ret = PTR_ERR(ltc3651_charger->charger);
> +		ret = PTR_ERR(ltc3651_charger->fault_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
>  		return ret;
>  	}
>  	ltc3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
>  					"lltc,chrg", GPIOD_IN);
>  	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
> -		ret = PTR_ERR(ltc3651_charger->charger);
> +		ret = PTR_ERR(ltc3651_charger->chrg_gpio);
>  		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
>  		return ret;
>  	}
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail



Join our presentation at Electronics & Applications 2017:
FPGA for real-time data processing, subject “Hardware platform for industrial ultrasound steel plate Inspection” Topic Embedded Systems - Herman Kuster, 1st June 10 AM

Visit http://eabeurs.nl/author/612884/ for more information

