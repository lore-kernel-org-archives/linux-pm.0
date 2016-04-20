From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 7/9] thermal: of: Add support for hardware-tracked trip
 points
Date: Wed, 20 Apr 2016 16:48:18 -0700
Message-ID: <20160420234818.GB2558@localhost.localdomain>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
 <1460950562-20652-8-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34465 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbcDTXsV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 19:48:21 -0400
Content-Disposition: inline
In-Reply-To: <1460950562-20652-8-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, Mikko Perttunen <mperttunen@nvidia.com>, Paul Walmsley <pwalmsley@nvidia.com>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 18, 2016 at 11:35:59AM +0800, Caesar Wang wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> This adds support for hardware-tracked trip points to the device tree
<cut>

> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 97b86c5..6ef932a 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -335,12 +335,14 @@ struct thermal_genl_event {
>   * @get_trend: a pointer to a function that reads the sensor temperature trend.
>   * @set_emul_temp: a pointer to a function that sets sensor emulated
>   *		   temperature.
> + * @set_trips: a pointer to a function that set low/high trip temperature.
>   */
>  struct thermal_zone_of_device_ops {
>  	int (*get_temp)(void *, int *);
>  	int (*get_trend)(void *, long *);
>  	int (*set_emul_temp)(void *, int);
>  	int (*set_trip_temp)(void *, int, int);
> +	int (*set_trips)(void *, int, int);

This is unfortunately a diverges from API available on thermal core. Can
you please add first on thermal core then, use it in of thermal?

I don't want to have callbacks available only via of thermal. If we
allow it, OF thermal becomes a separate API.

>  };
>  
>  /**
> -- 
> 1.9.1
> 
