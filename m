From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/4] thermal: trivial: fix typo in comment
Date: Fri, 31 Jul 2015 10:46:35 +0200
Message-ID: <20150731084635.GM5161@pengutronix.de>
References: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
 <1436168777-10463-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37907 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbbGaIqk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 04:46:40 -0400
Content-Disposition: inline
In-Reply-To: <1436168777-10463-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

Hi Rui,

Any input to this series? Could you apply it?

Sascha

On Mon, Jul 06, 2015 at 09:46:14AM +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 04659bf..34ce9e4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -465,7 +465,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>  }
>  
>  /**
> - * thermal_zone_get_temp() - returns its the temperature of thermal zone
> + * thermal_zone_get_temp() - returns the temperature of a thermal zone
>   * @tz: a valid pointer to a struct thermal_zone_device
>   * @temp: a valid pointer to where to store the resulting temperature.
>   *
> -- 
> 2.1.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
