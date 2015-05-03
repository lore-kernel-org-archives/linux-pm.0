From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 2/2] power: at91-reset: Constify platform_device_id
Date: Sun, 3 May 2015 12:03:56 +0200
Message-ID: <20150503100356.GV12076@piout.net>
References: <1430495204-31363-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495204-31363-2-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41240 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751957AbbECKD6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2015 06:03:58 -0400
Content-Disposition: inline
In-Reply-To: <1430495204-31363-2-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/05/2015 at 00:46:44 +0900, Krzysztof Kozlowski wrote :
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/power/reset/at91-reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 01c7055c4200..4bfd9056eef5 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -243,7 +243,7 @@ static int at91_reset_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_device_id at91_reset_plat_match[] = {
> +static const struct platform_device_id at91_reset_plat_match[] = {
>  	{ "at91-sam9260-reset", (unsigned long)at91sam9260_restart },
>  	{ "at91-sam9g45-reset", (unsigned long)at91sam9g45_restart },
>  	{ /* sentinel */ }
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
