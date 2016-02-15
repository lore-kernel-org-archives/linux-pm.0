From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC v2 03/11] soc: renesas: Improve rcar_sysc_power() debug info
Date: Tue, 16 Feb 2016 00:11:24 +0200
Message-ID: <1640540.sfVMLcT3LH@avalon>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be> <1455571020-18968-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455571020-18968-4-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 15 February 2016 22:16:52 Geert Uytterhoeven wrote:
> Print requested power domain state.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>   - New.
> ---
>  drivers/soc/renesas/pm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/renesas/pm-rcar.c b/drivers/soc/renesas/pm-rcar.c
> index bc605d9fbc6ce79c..cc684e9cc8db5d1c 100644
> --- a/drivers/soc/renesas/pm-rcar.c
> +++ b/drivers/soc/renesas/pm-rcar.c
> @@ -128,7 +128,7 @@ static int rcar_sysc_power(const struct rcar_sysc_ch
> *sysc_ch, bool on) out:
>  	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
> 
> -	pr_debug("sysc power domain %d: %08x -> %d\n",
> +	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
>  		 sysc_ch->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
>  	return ret;
>  }

-- 
Regards,

Laurent Pinchart
