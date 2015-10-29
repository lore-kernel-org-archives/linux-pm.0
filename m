From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] drivers:power:twl4030-charger: don't check if battery
 is present
Date: Thu, 29 Oct 2015 14:50:26 -0500
Message-ID: <56327882.2030205@ti.com>
References: <cover.1446138086.git.hns@goldelico.com>
 <72eab67d8ae1e25803a78a4636c8da78b7a0d32f.1446138086.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58224 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbbJ2TvI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Oct 2015 15:51:08 -0400
In-Reply-To: <72eab67d8ae1e25803a78a4636c8da78b7a0d32f.1446138086.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com

On 10/29/2015 12:01 PM, H. Nikolaus Schaller wrote:
> We can't assume that the battery is present after probing (it can
> usually be removed while device is operated through external AC
> or USB power). So it makes no sense to check for it during probe.


Do you mean hot plug battery? you sure twl4030 is capable of dealing
with that :) ? we ran into all kinds of issues with LDP3430 trying to
make that logic work, finally came to the conclusion that the TWL4030
as it stands on LDP cannot just do that.

> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/power/twl4030_charger.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
> index 859991f..e232453 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -1008,13 +1008,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
>  	bci->irq_chg = platform_get_irq(pdev, 0);
>  	bci->irq_bci = platform_get_irq(pdev, 1);
>  
> -	/* Only proceed further *IF* battery is physically present */
> -	ret = twl4030_is_battery_present(bci);
> -	if  (ret) {
> -		dev_crit(&pdev->dev, "Battery was not detected:%d\n", ret);
> -		return ret;
> -	}
> -
>  	platform_set_drvdata(pdev, bci);
>  
>  	bci->ac = devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
> 


-- 
Regards,
Nishanth Menon
