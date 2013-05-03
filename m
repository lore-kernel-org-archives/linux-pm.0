From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/6] Thermal: dove_thermal: Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 12:12:59 +0200
Message-ID: <20130503101259.GC2824@lunn.ch>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
 <1367575034-18432-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:34474 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763078Ab3ECKNH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 May 2013 06:13:07 -0400
Content-Disposition: inline
In-Reply-To: <1367575034-18432-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Andrew Lunn <andrew@lunn.ch>

On Fri, May 03, 2013 at 03:27:09PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/thermal/dove_thermal.c |    1 -
>  1 file changed, 1 deletion(-)
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
> 1.7.9.5
> 

Acked-by: Andrew Lunn <andrew@lunn.ch>
