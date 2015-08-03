From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v2 04/10] thermal: Fix thermal_zone_of_sensor_register
 to match documentation
Date: Mon, 03 Aug 2015 08:56:21 -0700
Message-ID: <55BF8F25.9010305@roeck-us.net>
References: <1438615378-14241-1-git-send-email-punit.agrawal@arm.com> <1438615378-14241-5-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438615378-14241-5-git-send-email-punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 08/03/2015 08:22 AM, Punit Agrawal wrote:
> thermal_zone_of_sensor_register is documented as returning a pointer
> to either a valid thermal_zone_device on success, or a corresponding
> ERR_PTR() value.
>
> In contrast, the function returns NULL when THERMAL_OF is configured
> off. Fix this.
>
> Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

> ---
>   include/linux/thermal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 037e9df..a47b34a 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -364,7 +364,7 @@ static inline struct thermal_zone_device *
>   thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
>   				const struct thermal_zone_of_device_ops *ops)
>   {
> -	return NULL;
> +	return ERR_PTR(-ENOSYS);
>   }
>
>   static inline
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
