From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: add const to
 thermal_cooling_device_ops structure
Date: Thu, 29 Jun 2017 11:00:19 +0800
Message-ID: <1498705219.2510.4.camel@intel.com>
References: <1498028988-12916-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:39455 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbdF2DAZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Jun 2017 23:00:25 -0400
In-Reply-To: <1498028988-12916-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>

On Wed, 2017-06-21 at 12:39 +0530, Bhumika Goyal wrote:
> Declare thermal_cooling_device_ops structure as const as it is only
> passed
> as an argument to the function thermal_cooling_device_register and
> this
> argument is of type const. So, declare the structure as const.
> 
I checked the source and the code is written in this way as well in
some other drivers, why not fix them altogether?

thanks,
rui
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/thermal/intel_powerclamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c
> index d718cd1..e4c68b7 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -659,7 +659,7 @@ static int powerclamp_set_cur_state(struct
> thermal_cooling_device *cdev,
>  }
>  
>  /* bind to generic thermal layer as cooling device*/
> -static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
> +static const struct thermal_cooling_device_ops
> powerclamp_cooling_ops = {
>  	.get_max_state = powerclamp_get_max_state,
>  	.get_cur_state = powerclamp_get_cur_state,
>  	.set_cur_state = powerclamp_set_cur_state,
