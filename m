From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/4] thermal: rcar: Add missing clock handling
Date: Wed, 08 Jan 2014 00:04:04 +0400
Message-ID: <52CC5DB4.6070205@cogentembedded.com>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org> <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34405 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbaAGUEF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2014 15:04:05 -0500
Received: by mail-la0-f41.google.com with SMTP id c6so483359lan.14
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2014 12:04:03 -0800 (PST)
In-Reply-To: <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Hello.

On 07-01-2014 22:57, Geert Uytterhoeven wrote:

> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

> When using DT to instantiate the rcar-thermal device, it prints the
> following error:

>      rcar_thermal e61f0000.thermal: thermal sensor was broken

> Explicitly request and enable the thermal clock to fix this.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>   drivers/thermal/rcar_thermal.c |   40 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 33 insertions(+), 7 deletions(-)

> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 88f92e1a9944..a5629500723a 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
[...]
> @@ -378,23 +380,38 @@ static int rcar_thermal_probe(struct platform_device *pdev)
[...]
> +	ret = clk_prepare(common->clk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to prepare clock\n");
> +		return ret;
> +	}
> +
> +	clk_enable(common->clk);
> +

    Why not just clk_prepare_enable()?

[...]
> @@ -465,9 +484,13 @@ error_unregister:
>   			rcar_thermal_irq_disable(priv);
>   	}
>
> +error_unpm:
>   	pm_runtime_put_sync(dev);
>   	pm_runtime_disable(dev);
>
> +	clk_disable(common->clk);
> +	clk_unprepare(common->clk);
> +

    Why not just clk_disable_unprepare()?

>   	return ret;
>   }
>
> @@ -486,6 +509,9 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>   	pm_runtime_put_sync(dev);
>   	pm_runtime_disable(dev);
>
> +	clk_disable(common->clk);
> +	clk_unprepare(common->clk);
> +

    Likewise.

WBR, Sergei

