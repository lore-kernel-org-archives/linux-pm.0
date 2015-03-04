From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 3/9] watchdog: at91rm9200: use the system timer syscon
Date: Wed, 04 Mar 2015 06:51:51 -0800
Message-ID: <54F71C07.6070204@roeck-us.net>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com> <1425478897-27322-4-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57369 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758806AbbCDOv4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 09:51:56 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YTAeR-003zUi-5x
	for linux-pm@vger.kernel.org; Wed, 04 Mar 2015 14:51:55 +0000
In-Reply-To: <1425478897-27322-4-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>, Wim Van Sebroeck <wim@iguana.be>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org

On 03/04/2015 06:21 AM, Alexandre Belloni wrote:
> Use a syscon regmap to access the systemr timer registers.
>
s/systemr/system/

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
...
>
>   static const struct of_device_id at91_wdt_dt_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-st" },
>   	{ .compatible = "atmel,at91rm9200-wdt" },
>   	{ /* sentinel */ }
>   };
> @@ -267,7 +276,7 @@ static struct platform_driver at91wdt_driver = {
>   	.suspend	= at91wdt_suspend,
>   	.resume		= at91wdt_resume,
>   	.driver		= {
> -		.name	= "at91_wdt",
> +		.name	= "atmel_st_watchdog",

If you change the driver name you also need to change the MODULE_ALIAS
a few lines down.

But why change it in the first place ? Maybe that was discussed somewhere,
but not here where it belongs, and not in patch 0/9 either.

Guenter

