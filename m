From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] PowerCap: Fix an error code in powercap_register_zone()
Date: Wed, 10 May 2017 18:41:30 -0700
Message-ID: <1494466890.440.3.camel@linux.intel.com>
References: <20170510194006.vsr5r5eyvjry4cka@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:31294 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdEKBlf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 May 2017 21:41:35 -0400
In-Reply-To: <20170510194006.vsr5r5eyvjry4cka@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, 2017-05-10 at 22:40 +0300, Dan Carpenter wrote:
> In the current code we accidentally return the successful result from
> idr_alloc() instead of a negative error pointer.  The caller is
> looking
> for an error pointer and so it treats the returned value as a valid
> pointer.
> 
> This one might be a bit serious because if it lets people get around
> the
> kernel's protection for remapping NULL.  I'm not sure.
> 
> Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> 
> diff --git a/drivers/powercap/powercap_sys.c
> b/drivers/powercap/powercap_sys.c
> index 14bde0db8c24..5b10b50f8686 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -538,6 +538,7 @@ struct powercap_zone *powercap_register_zone(
>  
>  	power_zone->id = result;
>  	idr_init(&power_zone->idr);
> +	result = -ENOMEM;
>  	power_zone->name = kstrdup(name, GFP_KERNEL);
>  	if (!power_zone->name)
>  		goto err_name_alloc;
