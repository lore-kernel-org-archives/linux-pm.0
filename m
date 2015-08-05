From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] thermal: Fix thermal_zone_of_sensor_register to match
 documentation
Date: Wed, 05 Aug 2015 07:51:49 -0700
Message-ID: <55C22305.2030403@roeck-us.net>
References: <9hha8u7mi7a.fsf@e105922-lin.cambridge.arm.com> <1438768668-15225-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52537 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbHEOvz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 10:51:55 -0400
In-Reply-To: <1438768668-15225-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>

On 08/05/2015 02:57 AM, Punit Agrawal wrote:
> thermal_zone_of_sensor_register is documented as returning a pointer
> to either a valid thermal_zone_device on success, or a corresponding
> ERR_PTR() value.
>
> In contrast, the function returns NULL when THERMAL_OF is configured
> off. Fix this.
>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Hi Guenter,
>
> It was pointed out that ENOSYS is frowned upon for anything other than
> indicating lack of support for a syscall. The rest of the functions in
> the file use ENODEV. Updating thermal_zone_of_sensor_register to do
> the same.
>
> Could you please re-ack if you're ok with this change?
>
> Thanks,
> Punit
>
>   include/linux/thermal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 037e9df..f344e51 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -364,7 +364,7 @@ static inline struct thermal_zone_device *
>   thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>   				const struct thermal_zone_of_device_ops *ops)
>   {
> -	return NULL;
> +	return ERR_PTR(-ENODEV);
>   }
>
>   static inline
>

