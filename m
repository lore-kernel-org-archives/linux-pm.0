From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: int340x: fix sparse warning
Date: Fri, 06 Feb 2015 16:28:33 +0800
Message-ID: <1423211313.1729.15.camel@rzhang1-mobl4>
References: <1423143817-16128-1-git-send-email-prabhakar.csengg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46105 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbbBFI2w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Feb 2015 03:28:52 -0500
In-Reply-To: <1423143817-16128-1-git-send-email-prabhakar.csengg@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2015-02-05 at 13:43 +0000, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> this patch fixes following sparse warning:
> 
> processor_thermal_device.c:188:6: warning: symbol 'proc_thermal_remove' was not declared. Should it be static?
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

applied. thanks!

-rui
> ---
>  Found this issue on linux-next (gcc  version 4.9.2,
>  sparse version  0.4.5-rc1)and applies on top linux-next.
> 
>  drivers/thermal/int340x_thermal/processor_thermal_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
> index 0fe5dbb..095acac 100644
> --- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
> @@ -185,7 +185,7 @@ free_buffer:
>  	return ret;
>  }
>  
> -void proc_thermal_remove(struct proc_thermal_device *proc_priv)
> +static void proc_thermal_remove(struct proc_thermal_device *proc_priv)
>  {
>  	sysfs_remove_group(&proc_priv->dev->kobj,
>  			   &power_limit_attribute_group);


