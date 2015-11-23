From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: fix error check
Date: Mon, 23 Nov 2015 15:25:43 -0800
Message-ID: <20151123232542.GA6815@localhost.localdomain>
References: <1448283281-21402-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34218 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbbKWXZw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 18:25:52 -0500
Content-Disposition: inline
In-Reply-To: <1448283281-21402-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, Nov 23, 2015 at 06:24:41PM +0530, Sudip Mukherjee wrote:
> We were only checking if data is not NULL but
> ti_bandgap_get_sensor_data() can return NULL or ERR_PTR.

Do you have a fail case? Can you please send the logs too?

> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index b213a12..d76bb7c 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -365,7 +365,7 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int id)
>  
>  	data = ti_bandgap_get_sensor_data(bgp, id);
>  
> -	if (data && data->ti_thermal) {
> +	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {

I don t really see the need for this as we always
ti_bandgap_set_sensor_data with a valid pointer, never with a ERR PTR.
So, it would be either valid or NULL.

>  		if (data->our_zone)
>  			thermal_zone_device_unregister(data->ti_thermal);
>  		else
> -- 
> 1.9.1
> 
