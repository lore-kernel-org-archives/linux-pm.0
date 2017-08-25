From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: max77620: constify platform_device_id
Date: Fri, 25 Aug 2017 10:34:11 +0800
Message-ID: <1503628451.2774.9.camel@intel.com>
References: <30f8e66e4397f59747e9843e7c09b0c42b2d5804.1502623863.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:43145 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754191AbdHYCdx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Aug 2017 22:33:53 -0400
In-Reply-To: <30f8e66e4397f59747e9843e7c09b0c42b2d5804.1502623863.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, edubezval@gmail.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sun, 2017-08-13 at 17:03 +0530, Arvind Yadav wrote:
> platform_device_id are not supposed to change at runtime. All
> functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/max77620_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/max77620_thermal.c
> b/drivers/thermal/max77620_thermal.c
> index 159bbce..3c74b91 100644
> --- a/drivers/thermal/max77620_thermal.c
> +++ b/drivers/thermal/max77620_thermal.c
> @@ -149,7 +149,7 @@ static int max77620_thermal_probe(struct
> platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_device_id max77620_thermal_devtype[] = {
> +static const struct platform_device_id max77620_thermal_devtype[] =
> {
>  	{ .name = "max77620-thermal", },
>  	{},
>  };
