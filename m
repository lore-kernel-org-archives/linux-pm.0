From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v2 13/14] clk: shmobile: mstp: Consider "zb_clk" suitable for
 power management
Date: Mon, 22 Jun 2015 13:05:49 -0700
Message-ID: <20150622200549.9112.2411@quantum>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
 <1432839219-475-14-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35932 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbFVUGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 16:06:04 -0400
Received: by pdcu2 with SMTP id u2so18938818pdc.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 13:06:03 -0700 (PDT)
In-Reply-To: <1432839219-475-14-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Quoting Geert Uytterhoeven (2015-05-28 11:53:38)
> Currently the CPG Clock Domain code looks for MSTP clocks to power
> manage a device.
> 
> Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
> the Bus State Controller (BSC) is not power-managed by an MSTP clock,
> but by a plain CPG clock (zb_clk).  Add a special case to handle this,
> so the clock is properly managed, and devices connected to the BSC work
> as expected.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> ---
>  drivers/clk/shmobile/clk-mstp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> index 619f3eccefd4884f..19e2b11953383587 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -258,6 +258,10 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
>                                             "renesas,cpg-mstp-clocks"))
>                         goto found;
>  
> +               /* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock*/
> +               if (!strcmp(clkspec.np->name, "zb_clk"))
> +                       goto found;

Hello Geert,

Is the driver the right place to handle this corner case? What do you
think about linking zb_clk up to the bsc devicetree node for
r8a73a4/sh73a0?

Regards,
Mike

> +
>                 of_node_put(clkspec.np);
>                 i++;
>         }
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
