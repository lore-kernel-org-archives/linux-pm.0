Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15766C433DB
	for <linux-pm@archiver.kernel.org>; Sun, 17 Jan 2021 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC58E207FB
	for <linux-pm@archiver.kernel.org>; Sun, 17 Jan 2021 09:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbhAQJtc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 17 Jan 2021 04:49:32 -0500
Received: from fold.natur.cuni.cz ([195.113.57.32]:58720 "EHLO
        fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbhAQJt1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 04:49:27 -0500
Received: from [192.168.251.4] (unknown [192.168.251.4])
        by fold.natur.cuni.cz (Postfix) with ESMTP id ABB3610FC077;
        Sun, 17 Jan 2021 10:48:44 +0100 (MET)
Subject: Re: [PATCH] power: supply: fix sbs-charger build, needs REGMAP_I2C
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolassaenzj@gmail.com,
        Nicolas Saenz Julienne <nicolas.saenz@prodys.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210116211310.19232-1-rdunlap@infradead.org>
From:   Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Message-ID: <537de36b-6709-3e58-5610-9f54e2bee8a9@fold.natur.cuni.cz>
Date:   Sun, 17 Jan 2021 10:48:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210116211310.19232-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Randy,
  thank you very much. I would not mind dropping my name but I tested the patch
now with 5.4.89 so you may actually also add

Tested-by: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>

It also happened with 5.10.7, it is probably obvious.

Thank you for quick action.
Martin

On 16/01/2021 22:13, Randy Dunlap wrote:
> CHARGER_SBS should select REGMAP_I2C since it uses API(s) that are
> provided by that Kconfig symbol.
> 
> Fixes these errors:
> 
> ../drivers/power/supply/sbs-charger.c:149:21: error: variable ‘sbs_regmap’ has initializer but incomplete type
>  static const struct regmap_config sbs_regmap = {
> ../drivers/power/supply/sbs-charger.c:150:3: error: ‘const struct regmap_config’ has no member named ‘reg_bits’
>   .reg_bits = 8,
> ../drivers/power/supply/sbs-charger.c:155:23: error: ‘REGMAP_ENDIAN_LITTLE’ undeclared here (not in a function)
>   .val_format_endian = REGMAP_ENDIAN_LITTLE, /* since based on SMBus */
> ../drivers/power/supply/sbs-charger.c: In function ‘sbs_probe’:
> ../drivers/power/supply/sbs-charger.c:183:17: error: implicit declaration of function ‘devm_regmap_init_i2c’; did you mean ‘devm_request_irq’? [-Werror=implicit-function-declaration]
>   chip->regmap = devm_regmap_init_i2c(client, &sbs_regmap);
> ../drivers/power/supply/sbs-charger.c: At top level:
> ../drivers/power/supply/sbs-charger.c:149:35: error: storage size of ‘sbs_regmap’ isn’t known
>  static const struct regmap_config sbs_regmap = {
> 
> Fixes: feb583e37f8a ("power: supply: add sbs-charger driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: nicolassaenzj@gmail.com
> Cc: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
> Martin, do you want Reported-by: on this?
> 
>  drivers/power/supply/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20210115.orig/drivers/power/supply/Kconfig
> +++ linux-next-20210115/drivers/power/supply/Kconfig
> @@ -229,6 +229,7 @@ config BATTERY_SBS
>  config CHARGER_SBS
>  	tristate "SBS Compliant charger"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  Say Y to include support for SBS compliant battery chargers.
>  
> 

