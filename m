From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 09/10] [RFC] ravb: Remove obsolete explicit clock handling
 for WoL
Date: Mon, 16 Oct 2017 23:17:17 +0300
Message-ID: <b3825de9-16e8-94a4-0b23-bf0caf87a343@cogentembedded.com>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
 <1508162116-5043-10-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1508162116-5043-10-git-send-email-geert+renesas@glider.be>
Content-Language: en-MW
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/16/2017 04:55 PM, Geert Uytterhoeven wrote:

> Currently, if Wake-on-LAN is enabled, the EtherAVB device's module clock
> is manually kept running during system suspend, to make sure the device
> stays active.
> 
> Since "soc: renesas: rcar-sysc: Keep wakeup sources active during system
> suspend", this workaround is no longer needed.  Hence remove all
> explicit clock handling to keep the device active.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index fdf30bfa403bf416..11ffccca11d56df5 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
> @@ -2289,8 +2283,6 @@ static int __maybe_unused ravb_resume(struct device *dev)
>   		 *       this clock dance should be removed.
>   		 */
>   		clk_disable(priv->clk);
> -		clk_disable(priv->clk);
> -		clk_enable(priv->clk);
>   		clk_enable(priv->clk);

    I thought the entire clock dance could be removed now? Not yet?

[...]

MBR, Sergei
