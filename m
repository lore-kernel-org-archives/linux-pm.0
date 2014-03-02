From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] x86_pkg_temp_thermal: Do not expose as a hwmon device
Date: Sun, 02 Mar 2014 08:03:28 -0800
Message-ID: <53135650.3070909@roeck-us.net>
References: <20140302153335.0f1326b6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61029 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaCBQDa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Mar 2014 11:03:30 -0500
In-Reply-To: <20140302153335.0f1326b6@endymion.delvare>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>

On 03/02/2014 06:33 AM, Jean Delvare wrote:
> The temperature value reported by x86_pkg_temp_thermal is already
> reported by the coretemp driver. So, do not expose this thermal zone
> as a hwmon device, because it would be redundant.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

Does that make the "Fix thermal zone type" patch unnecessary ?
If so, this patch would be a candidate for stable.

Guenter

> ---
>   drivers/thermal/x86_pkg_temp_thermal.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> --- linux-3.14-rc4.orig/drivers/thermal/x86_pkg_temp_thermal.c	2014-03-02 15:29:21.646475545 +0100
> +++ linux-3.14-rc4/drivers/thermal/x86_pkg_temp_thermal.c	2014-03-02 15:29:37.568831104 +0100
> @@ -68,6 +68,10 @@ struct phy_dev_entry {
>   	struct thermal_zone_device *tzone;
>   };
>
> +static const struct thermal_zone_params pkg_temp_tz_params = {
> +	.no_hwmon	= true,
> +};
> +
>   /* List maintaining number of package instances */
>   static LIST_HEAD(phy_dev_list);
>   static DEFINE_MUTEX(phy_dev_list_mutex);
> @@ -443,7 +447,7 @@ static int pkg_temp_thermal_device_add(u
>   			thres_count,
>   			(thres_count == MAX_NUMBER_OF_TRIPS) ?
>   				0x03 : 0x01,
> -			phy_dev_entry, &tzone_ops, NULL, 0, 0);
> +			phy_dev_entry, &tzone_ops, &pkg_temp_tz_params, 0, 0);
>   	if (IS_ERR(phy_dev_entry->tzone)) {
>   		err = PTR_ERR(phy_dev_entry->tzone);
>   		goto err_ret_free;
>

