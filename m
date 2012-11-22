From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/2] thermal: rcar: add .get_trip_type/temp and .notify support
Date: Thu, 22 Nov 2012 16:05:48 +0900
Message-ID: <CANqRtoTuha4HNc3KAXyx6HzcbCcaG+Vo_VVsv1VUj9aaCGujug@mail.gmail.com>
References: <87sj82uo7o.wl%kuninori.morimoto.gx@renesas.com>
	<87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50737 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2KVUi4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Nov 2012 15:38:56 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so1062344qad.19
        for <linux-pm@vger.kernel.org>; Thu, 22 Nov 2012 12:38:55 -0800 (PST)
In-Reply-To: <87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Simon <horms@verge.net.au>, linux-pm@vger.kernel.org

Hello Morimoto-san,

On Thu, Nov 22, 2012 at 3:50 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> This patch adds .get_trip_type(), .get_trip_temp(), and .notify()
> on rcar_thermal_zone_ops.
> Driver will try platform power OFF if it reached to
> critical temperature.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c |   81 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 78 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 454035c..16723ba 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -212,8 +286,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>                 goto error_free_priv;
>         }
>
> -       zone = thermal_zone_device_register("rcar_thermal", 0, 0, priv,
> -                                           &rcar_thermal_zone_ops, 0, 0);
> +       zone = thermal_zone_device_register("rcar_thermal", 4, 0, priv,
> +                                           &rcar_thermal_zone_ops, 0,
> +                                           IDLE_INTERVAL);
>         if (IS_ERR(zone)) {
>                 dev_err(&pdev->dev, "thermal zone device is NULL\n");
>                 ret = PTR_ERR(zone);

Huh, so this IDLE_INTERVAL basically means that the driver currently is polled?

Good that this driver is for automotive systems and not mobile handsets. =)

Thanks,

/ magnus
