From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/8 v4] thermal: rcar: retern error
 rcar_thermal_get_temp() if no ctemp update
Date: Mon, 14 Dec 2015 13:20:22 -0800
Message-ID: <20151214212021.GA10992@localhost.localdomain>
References: <87vb895x9d.wl%kuninori.morimoto.gx@renesas.com>
 <87poyh5x69.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87poyh5x69.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 08, 2015 at 05:28:13AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current rcar_thermal_get_temp() returns latest temperature, but it might
> not be updated if some HW issue happened. This means user might get
> wrong temperature. This patch solved this issue.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>  - "happend" -> "happened"
> 
>  drivers/thermal/rcar_thermal.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 67b5216..40c3ba5 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -199,9 +199,9 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
>  
>  	dev_dbg(dev, "thermal%d  %d -> %d\n", priv->id, priv->ctemp, ctemp);
>  
> -	priv->ctemp = ctemp;
>  	ret = 0;
>  err_out_unlock:
> +	priv->ctemp = ctemp;
>  	mutex_unlock(&priv->lock);
>  	return ret;

I believe the problem here is actually the lack of error
handling/propagation. Are you sure you want to write to parameter
in the fail path ?

rcar_thermal_update_temp already returns error code when it fails
to read temperature. Don't you think it would make more sense to fix the
places that call rcar_thermal_update_temp to properly handle its return
value and propagate that error code when necessary?

BR,
