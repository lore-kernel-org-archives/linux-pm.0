From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: rcar: Add support for R8A7796 SoC
Date: Tue, 10 May 2016 10:37:46 +0530
Message-ID: <20160510050746.GD2790@vireshk-i7>
References: <1462372543-31835-1-git-send-email-geert+renesas@glider.be>
 <5731664D.1030909@rvc.renesas.com>
 <573169CD.8050607@rvc.renesas.com>
 <57316A4E.7040100@rvc.renesas.com>
 <57316AB0.5040004@rvc.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57316AB0.5040004@rvc.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10-05-16, 11:59, Khiem Nguyen wrote:
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 32f6dda..7d038fd 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -54,6 +54,7 @@ static const struct of_device_id machines[] __initconst =
> {
>  	{ .compatible = "renesas,r8a7793", },
>  	{ .compatible = "renesas,r8a7794", },
>  	{ .compatible = "renesas,r8a7795", },
> +	{ .compatible = "renesas,r8a7796", },
>  	{ .compatible = "renesas,sh73a0", },
> 
>  	{ .compatible = "rockchip,rk2928", },

Well, you could have done that in the same patch. But I don't mind two patches
now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
