From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v1 2/3] of: Add support for reading a s32 from a multi-value property.
Date: Tue, 16 Aug 2016 14:09:52 +0200
Message-ID: <23748508.K8gp1eOYRv@diego>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com> <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471315139-28285-3-git-send-email-finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Finlye Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tim.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, ulysses.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lin.huang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Finley,

Am Dienstag, 16. August 2016, 10:38:58 schrieb Finlye Xiao:
> From: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> This patch adds an of_property_read_s32_index() function to allow
> reading a single indexed s32 value from a property containing multiple
> s32 values.
>
> Signed-off-by: Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

for people reading along, this simply duplicates what of_property_read_s32 
already does, only for indexed properties.

But I do have one issue below.

> ---
>  drivers/of/base.c  | 23 +++++++++++++++++++++++
>  include/linux/of.h | 10 ++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 7792266..346457d 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1200,6 +1200,29 @@ int of_property_read_u32_index(const struct
> device_node *np, EXPORT_SYMBOL_GPL(of_property_read_u32_index);
> 
>  /**
> + * of_property_read_s32_index - Find and read a s32 from a multi-value
> property. + *
> + * @np:		device node from which the property value is to be read.
> + * @propname:	name of the property to be searched.
> + * @index:	index of the u32 in the list of values
> + * @out_value:	pointer to return value, modified only if no error.
> + *
> + * Search for a property in a device node and read nth 32-bit value from
> + * it. Returns 0 on success, -EINVAL if the property does not exist,
> + * -ENODATA if property does not have a value, and -EOVERFLOW if the
> + * property data isn't large enough.
> + *
> + * The out_value is modified only if a valid s32 value can be decoded.
> + */
> +int of_property_read_s32_index(const struct device_node *np,
> +			       const char *propname, u32 index, s32 *out_value)
> +{
> +	return of_property_read_u32_index(np, propname, index,
> +		(u32 *)out_value);
> +}
> +EXPORT_SYMBOL_GPL(of_property_read_s32_index);

I think this could very well live directly in the of.h header below 
of_property_read_s32 or so.

As this also only calls the more generic u32 variant, it can be just a static 
inline there and does not need to duplicate the whole stub voodoo, as the 
of_property_read_u32_index will also generate the -ENOSYS error in the !OF 
case.


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
