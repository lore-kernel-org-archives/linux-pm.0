From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] thermal: rockchip: disable thermal->clk in err case
Date: Tue, 01 Mar 2016 12:48:30 +0100
Message-ID: <1746917.OUUFyOy2vj@diego>
References: <1455503242-19907-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:49931 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbcCALsj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 06:48:39 -0500
In-Reply-To: <1455503242-19907-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

Am Montag, 15. Februar 2016, 10:27:22 schrieb Shawn Lin:
> Disable thermal->clk when enabling pclk fails in
> resume routine.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
>  drivers/thermal/rockchip_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c
> b/drivers/thermal/rockchip_thermal.c index 9787e8a..b54f6db 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -656,8 +656,10 @@ static int __maybe_unused
> rockchip_thermal_resume(struct device *dev) return error;
> 
>  	error = clk_enable(thermal->pclk);
> -	if (error)
> +	if (error) {
> +		clk_disable(thermal->clk);
>  		return error;
> +	}
> 
>  	rockchip_thermal_reset_controller(thermal->reset);

