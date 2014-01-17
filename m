From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH -trivial 4/4] thermal: rcar: Spelling s/delaye/delay/g
Date: Fri, 17 Jan 2014 16:23:24 +0800
Message-ID: <1389947004.5918.47.camel@rzhang1-mobl4>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
	 <1389121036-3555-5-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1389121036-3555-5-git-send-email-geert@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Jiri Kosina <trivial@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-01-07 at 19:57 +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Cc: Jiri Kosina <trivial@kernel.org>

applied.

thanks,
rui
> ---
>  drivers/thermal/rcar_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index a5629500723a..32d591087307 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -427,7 +427,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		/* enable temperature comparation */
>  		rcar_thermal_common_write(common, ENR, 0x00030303);
>  
> -		idle = 0; /* polling delaye is not needed */
> +		idle = 0; /* polling delay is not needed */
>  	}
>  
>  	for (i = 0;; i++) {


