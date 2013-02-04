From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch] PM: intel_powerclamp: off by one in start_power_clamp()
Date: Mon, 04 Feb 2013 09:44:36 +0800
Message-ID: <1359942276.2250.32.camel@rzhang1-mobl4>
References: <20130124085122.GA3547@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6128 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab3BDBox (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 3 Feb 2013 20:44:53 -0500
In-Reply-To: <20130124085122.GA3547@elgon.mountain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>, kernel-janitors@vger.kernel.org

On Thu, 2013-01-24 at 11:51 +0300, Dan Carpenter wrote:
> This value has already been clamped correctly to 0 through 49 in
> powerclamp_set_cur_state() so this patch doesn't actually change
> anything.  But we should fix it anyway for consistency.
> 
> set_target_ratio is used as an offset into an array with
> MAX_TARGET_RATIO (50) elements.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

applied to thermal-next.

BTW, Jacob, it would be good to get your comments on this as you're the
author of this driver.

thanks,
rui
> 
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> index a85ff38..ab3ed90 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -504,7 +504,7 @@ static int start_power_clamp(void)
>  		return -EINVAL;
>  	}
>  
> -	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO);
> +	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
>  	/* prevent cpu hotplug */
>  	get_online_cpus();
>  


