From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 10/10] [RFC] sh_eth: Remove obsolete explicit clock
 handling for WoL
Date: Mon, 16 Oct 2017 17:15:18 +0200
Message-ID: <20171016151518.GE19910@bigcity.dyn.berto.se>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
 <1508162116-5043-11-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508162116-5043-11-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On 2017-10-16 15:55:16 +0200, Geert Uytterhoeven wrote:
> Currently, if Wake-on-LAN is enabled, the SH-ETH device's module clock
> is manually kept running during system suspend, to make sure the device
> stays active.
> 
> Since "soc: renesas: rcar-sysc: Keep wakeup sources active during system
> suspend" and "clk: renesas: mstp: Keep wakeup sources active during
> system suspend", this workaround is no longer needed.  Hence remove all
> explicit clock handling to keep the device active.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> This must not be applied before the dependency has landed upstream,
> hence the "RFC"!
> ---
>  drivers/net/ethernet/renesas/sh_eth.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index d2e88a30f57bb4c5..8ea4d0cc325baeca 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -40,7 +40,6 @@
>  #include <linux/slab.h>
>  #include <linux/ethtool.h>
>  #include <linux/if_vlan.h>
> -#include <linux/clk.h>
>  #include <linux/sh_eth.h>
>  #include <linux/of_mdio.h>
>  
> @@ -2293,7 +2292,7 @@ static void sh_eth_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
>  	wol->supported = 0;
>  	wol->wolopts = 0;
>  
> -	if (mdp->cd->magic && mdp->clk) {
> +	if (mdp->cd->magic) {
>  		wol->supported = WAKE_MAGIC;
>  		wol->wolopts = mdp->wol_enabled ? WAKE_MAGIC : 0;
>  	}
> @@ -2303,7 +2302,7 @@ static int sh_eth_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
>  {
>  	struct sh_eth_private *mdp = netdev_priv(ndev);
>  
> -	if (!mdp->cd->magic || !mdp->clk || wol->wolopts & ~WAKE_MAGIC)
> +	if (!mdp->cd->magic || wol->wolopts & ~WAKE_MAGIC)
>  		return -EOPNOTSUPP;
>  
>  	mdp->wol_enabled = !!(wol->wolopts & WAKE_MAGIC);
> @@ -3144,11 +3143,6 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
>  		goto out_release;
>  	}
>  
> -	/* Get clock, if not found that's OK but Wake-On-Lan is unavailable */
> -	mdp->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(mdp->clk))
> -		mdp->clk = NULL;
> -
>  	ndev->base_addr = res->start;
>  
>  	spin_lock_init(&mdp->lock);
> @@ -3251,7 +3245,7 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_napi_del;
>  
> -	if (mdp->cd->magic && mdp->clk)
> +	if (mdp->cd->magic)
>  		device_set_wakeup_capable(&pdev->dev, 1);
>  
>  	/* print device information */
> @@ -3305,9 +3299,6 @@ static int sh_eth_wol_setup(struct net_device *ndev)
>  	/* Enable MagicPacket */
>  	sh_eth_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
>  
> -	/* Increased clock usage so device won't be suspended */
> -	clk_enable(mdp->clk);
> -
>  	return enable_irq_wake(ndev->irq);
>  }
>  
> @@ -3333,9 +3324,6 @@ static int sh_eth_wol_restore(struct net_device *ndev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Restore clock usage count */
> -	clk_disable(mdp->clk);
> -
>  	return disable_irq_wake(ndev->irq);
>  }
>  
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
