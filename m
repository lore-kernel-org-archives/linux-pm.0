Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE10C4361B
	for <linux-pm@archiver.kernel.org>; Wed, 16 Dec 2020 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BEE23105
	for <linux-pm@archiver.kernel.org>; Wed, 16 Dec 2020 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLPNlB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:41:01 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:46589 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgLPNlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 08:41:01 -0500
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 02B31200005;
        Wed, 16 Dec 2020 13:40:15 +0000 (UTC)
Date:   Wed, 16 Dec 2020 14:40:15 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] power: reset: at91-sama5d2_shdwc: fix wkupdbc mask
Message-ID: <20201216134015.GF2814589@piout.net>
References: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
 <1608123453-1423-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608123453-1423-2-git-send-email-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/12/2020 14:57:31+0200, Claudiu Beznea wrote:
> According to datasheet WKUPDBC mask is b/w bits 26..24.
> 
> Fixes: f80cb48843987 ("power: reset: at91-shdwc: add new shutdown controller driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index e90368ed6f71..3996167f676f 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -37,7 +37,7 @@
>  
>  #define AT91_SHDW_MR	0x04		/* Shut Down Mode Register */
>  #define AT91_SHDW_WKUPDBC_SHIFT	24
> -#define AT91_SHDW_WKUPDBC_MASK	GENMASK(31, 16)
> +#define AT91_SHDW_WKUPDBC_MASK	GENMASK(26, 24)
>  #define AT91_SHDW_WKUPDBC(x)	(((x) << AT91_SHDW_WKUPDBC_SHIFT) \
>  						& AT91_SHDW_WKUPDBC_MASK)
>  

Maybe you would switch to FIELD_PREP to remove the need for 2 of those 3
macros and would have made the issue apparent right away.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
