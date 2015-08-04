From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 15/16] clk: shmobile: mstp: Consider "zb_clk" suitable
 for power management
Date: Tue, 4 Aug 2015 16:20:17 +0300
Message-ID: <55C0BC11.3030509@cogentembedded.com>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
 <1438691297-29235-16-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438691297-29235-16-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello.

On 08/04/2015 03:28 PM, Geert Uytterhoeven wrote:

> Currently the CPG/MSTP Clock Domain code looks for MSTP clocks to power
> manage a device.

> Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
> the Bus State Controller (BSC) is not power-managed by an MSTP clock,
> but by a plain CPG clock (zb_clk).  Add a special case to handle this,
> so the clock is properly managed, and devices connected to the BSC work
> as expected.

> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
[...]

> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> index b1df7b2f1e970adb..a117c3f0f257b5e1 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -259,6 +259,10 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
>   					    "renesas,cpg-mstp-clocks"))
>   			goto found;
>
> +		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock*/

    Please add a space before */.

> +		if (!strcmp(clkspec.np->name, "zb_clk"))
> +			goto found;
> +
>   		of_node_put(clkspec.np);
>   		i++;
>   	}

MBR, Sergei


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
