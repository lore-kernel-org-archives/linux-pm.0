From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/6] thermal: dove: remove unnecessary
 platform_set_drvdata()
Date: Mon, 6 May 2013 07:12:17 +0200
Message-ID: <20130506051217.GE2824@lunn.ch>
References: <003f01ce4a11$fc1b9a90$f452cfb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:51708 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab3EFFM0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 May 2013 01:12:26 -0400
Content-Disposition: inline
In-Reply-To: <003f01ce4a11$fc1b9a90$f452cfb0$@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Zhang Rui' <rui.zhang@intel.com>, 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On Mon, May 06, 2013 at 01:27:14PM +0900, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/thermal/dove_thermal.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
> index 4b15a5f..900479e 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -182,7 +182,6 @@ static int dove_thermal_exit(struct platform_device *pdev)
>  		platform_get_drvdata(pdev);
>  
>  	thermal_zone_device_unregister(dove_thermal);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
>  }
> -- 
> 1.7.2.5
> 
> 
Acked-by: Andrew Lunn <andrew@lunn.ch>
