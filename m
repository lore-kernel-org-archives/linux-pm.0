From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] drivers:power:twl4030-charger: fix problem with
 EPROBE_DEFER
Date: Thu, 29 Oct 2015 14:52:58 -0500
Message-ID: <5632791A.4020204@ti.com>
References: <cover.1446138086.git.hns@goldelico.com>
 <cfc5db66692e0415c86a08e2a3d37c2b299bf170.1446138086.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34362 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbbJ2Txh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Oct 2015 15:53:37 -0400
In-Reply-To: <cfc5db66692e0415c86a08e2a3d37c2b299bf170.1446138086.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com

On 10/29/2015 12:01 PM, H. Nikolaus Schaller wrote:
> devm_usb_get_phy_by_node() may return -EPROBE_DEFER in which
> case we should also defer probing of the twl4030 charger
> instead of turing USB charging off (forever).

s/turing/turning

> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/power/twl4030_charger.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
> index 423e886..859991f 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -1059,9 +1059,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
>  
>  		phynode = of_find_compatible_node(bci->dev->of_node->parent,
>  						  NULL, "ti,twl4030-usb");
> -		if (phynode)
> +		if (phynode) {
>  			bci->transceiver = devm_usb_get_phy_by_node(
>  				bci->dev, phynode, &bci->usb_nb);
> +			if (IS_ERR(bci->transceiver) &&
> +				PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
I might align this with the IS_ERR

> +				return -EPROBE_DEFER;	/* PHY not ready */
> +		}
>  	}
>  
>  	/* Enable interrupts now. */
> 

Otherwise it looks good to me.

-- 
Regards,
Nishanth Menon
