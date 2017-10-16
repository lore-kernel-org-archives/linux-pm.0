From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 09/10] [RFC] ravb: Remove obsolete explicit clock
 handling for WoL
Date: Mon, 16 Oct 2017 17:14:08 +0200
Message-ID: <20171016151408.GD19910@bigcity.dyn.berto.se>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
 <1508162116-5043-10-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:44313 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbdJPPON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 11:14:13 -0400
Received: by mail-lf0-f53.google.com with SMTP id 75so17416815lfx.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2017 08:14:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1508162116-5043-10-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org

Hi Geert,

On 2017-10-16 15:55:15 +0200, Geert Uytterhoeven wrote:
> Currently, if Wake-on-LAN is enabled, the EtherAVB device's module clock
> is manually kept running during system suspend, to make sure the device
> stays active.
> 
> Since "soc: renesas: rcar-sysc: Keep wakeup sources active during system
> suspend", this workaround is no longer needed.  Hence remove all
> explicit clock handling to keep the device active.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> This must not be applied before the dependency has landed upstream,
> hence the "RFC"!
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index fdf30bfa403bf416..11ffccca11d56df5 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2218,9 +2218,6 @@ static int ravb_wol_setup(struct net_device *ndev)
>  	/* Enable MagicPacket */
>  	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
>  
> -	/* Increased clock usage so device won't be suspended */
> -	clk_enable(priv->clk);
> -
>  	return enable_irq_wake(priv->emac_irq);
>  }
>  
> @@ -2239,9 +2236,6 @@ static int ravb_wol_restore(struct net_device *ndev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Restore clock usage count */
> -	clk_disable(priv->clk);
> -
>  	return disable_irq_wake(priv->emac_irq);
>  }
>  
> @@ -2289,8 +2283,6 @@ static int __maybe_unused ravb_resume(struct device *dev)
>  		 *       this clock dance should be removed.
>  		 */
>  		clk_disable(priv->clk);
> -		clk_disable(priv->clk);
> -		clk_enable(priv->clk);
>  		clk_enable(priv->clk);
>  
>  		/* Set reset mode to rearm the WoL logic */
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
