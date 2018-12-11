From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / AVS: SmartReflex: NULL check before some freeing functions is not needed.
Date: Tue, 11 Dec 2018 10:53:05 -0800
Message-ID: <7hy38vuc8e.fsf@baylibre.com>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de> <1543760930051-514988180-4-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543760930051-514988180-4-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>, khilman@kernel.org, nm@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thomas Meyer <thomas@m3y3r.de> writes:

> NULL check before some freeing functions is not needed.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>
> diff -u -p a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -1010,8 +1010,7 @@ static int omap_sr_remove(struct platfor
>  
>  	if (sr_info->autocomp_active)
>  		sr_stop_vddautocomp(sr_info);
> -	if (sr_info->dbg_dir)
> -		debugfs_remove_recursive(sr_info->dbg_dir);
> +	debugfs_remove_recursive(sr_info->dbg_dir);
>  
>  	pm_runtime_disable(&pdev->dev);
>  	list_del(&sr_info->node);
