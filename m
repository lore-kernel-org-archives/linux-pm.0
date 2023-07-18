Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D1EB64DC
	for <linux-pm@archiver.kernel.org>; Tue, 18 Jul 2023 10:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGRKG0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 18 Jul 2023 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGRKGZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2023 06:06:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68567B9;
        Tue, 18 Jul 2023 03:06:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4vf14xf2z67nbv;
        Tue, 18 Jul 2023 18:03:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 11:06:21 +0100
Date:   Tue, 18 Jul 2023 11:06:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sean Wang <sean.wang@kernel.org>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 05/10] pinctrl: lynxpoint: Make use of pm_ptr()
Message-ID: <20230718110620.0000218e@Huawei.com>
In-Reply-To: <20230717172821.62827-6-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
        <20230717172821.62827-6-andriy.shevchenko@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 Jul 2023 20:28:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Cleaning up the driver to use pm_ptr() and *_PM_OPS() macros that
> make it simpler and allows the compiler to remove those functions
> if built without CONFIG_PM and CONFIG_PM_SLEEP support.
> 

Those macros add a load more callbacks... Whilst that may well be fine,
you should definitely mention that in this patch description.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-lynxpoint.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
> index cdace55aaeac..50d92bf80e20 100644
> --- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
> +++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
> @@ -948,9 +948,8 @@ static int lp_gpio_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops lp_gpio_pm_ops = {
> -	.runtime_suspend = lp_gpio_runtime_suspend,
> -	.runtime_resume = lp_gpio_runtime_resume,
> -	.resume = lp_gpio_resume,
> +	SYSTEM_SLEEP_PM_OPS(NULL, lp_gpio_resume)
> +	RUNTIME_PM_OPS(lp_gpio_runtime_suspend, lp_gpio_runtime_resume, NULL)
>  };
>  
>  static const struct acpi_device_id lynxpoint_gpio_acpi_match[] = {
> @@ -965,7 +964,7 @@ static struct platform_driver lp_gpio_driver = {
>  	.remove         = lp_gpio_remove,
>  	.driver         = {
>  		.name   = "lp_gpio",
> -		.pm	= &lp_gpio_pm_ops,
> +		.pm	= pm_ptr(&lp_gpio_pm_ops),
>  		.acpi_match_table = lynxpoint_gpio_acpi_match,
>  	},
>  };

