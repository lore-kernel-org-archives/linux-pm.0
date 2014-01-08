From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH -trivial 4/4] thermal: rcar: Spelling s/delaye/delay/g
Date: Wed, 8 Jan 2014 09:12:28 +0900
Message-ID: <20140108001228.GD5136@verge.net.au>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-5-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54279 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515AbaAHAMa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2014 19:12:30 -0500
Content-Disposition: inline
In-Reply-To: <1389121036-3555-5-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Jiri Kosina <trivial@kernel.org>

On Tue, Jan 07, 2014 at 07:57:16PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Cc: Jiri Kosina <trivial@kernel.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

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
> -- 
> 1.7.9.5
> 
