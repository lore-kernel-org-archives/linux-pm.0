From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [PATCH 2/4] thermal: rcar: enable to use thermal-zone on DT
Date: Fri, 4 Dec 2015 11:51:13 +0530
Message-ID: <CAKDJKT47kHx9vNO_L_h085cJs3ACndiA9sQL7e2K5PtYySWJxA@mail.gmail.com>
References: <871tb2hpn2.wl%kuninori.morimoto.gx@renesas.com>
	<87y4dagb0i.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33274 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbLDGVP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 01:21:15 -0500
In-Reply-To: <87y4dagb0i.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi


> +static int rcar_thermal_of_get_temp(void *data, int *temp)
> +{
> +       struct rcar_thermal_priv *priv = data;
> +
> +       *temp = rcar_thermal_get_current_temp(priv);
> +
> +       return 0;
> +}
> +
> +static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
> +{
> +       struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> +
> +       *temp = rcar_thermal_get_current_temp(priv);
> +
>         return 0;
>  }
>

Above two function, always returns 0. Can it possible to handle error
and log some messages.

Regards
Manish Badarkhe
