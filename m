From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH V11 1/6] of: base: Implement read function for s32 array
Date: Thu, 23 Mar 2017 16:26:04 -0700
Message-ID: <58D4598C.8030407@gmail.com>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
 <1489356665-3175-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35557 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdCWX0V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 19:26:21 -0400
In-Reply-To: <1489356665-3175-2-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org
Cc: Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On 03/12/17 15:11, Stefan Wahren wrote:
> In order to read signed thermal coefficients from DT we need a proper
> function.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  include/linux/of.h |   35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 21e6323..98a046a 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -474,6 +474,34 @@ static inline int of_property_read_u32_array(const struct device_node *np,
>  }
>  
>  /**
> + * of_property_read_s32_array - Find and read an array of 32 bit signed integers
> + * from a property.
> + *
> + * @np:		device node from which the property value is to be read.
> + * @propname:	name of the property to be searched.
> + * @out_values:	pointer to return value, modified only if return value is 0.
> + * @sz:		number of array elements to read
> + *
> + * Search for a property in a device node and read 32-bit value(s) from
> + * it. Returns 0 on success, -EINVAL if the property does not exist,
> + * -ENODATA if property does not have a value, and -EOVERFLOW if the
> + * property data isn't large enough.
> + *
> + * The out_values is modified only if a valid s32 value can be decoded.
> + */
> +static inline int of_property_read_s32_array(const struct device_node *np,
> +					     const char *propname,
> +					     s32 *out_values, size_t sz)
> +{
> +	int ret = of_property_read_variable_u32_array(np, propname, out_values,
> +						      sz, 0);

Add the type coercion of out_values to make it obvious:

+       int ret = of_property_read_variable_u32_array(np, propname,
+                                                     (u32*) out_values, sz, 0);

> +	if (ret >= 0)
> +		return 0;
> +	else
> +		return ret;
> +}
> +
> +/**
>   * of_property_read_u64_array - Find and read an array of 64 bit integers
>   * from a property.
>   *
> @@ -676,6 +704,13 @@ static inline int of_property_read_u32_array(const struct device_node *np,
>  	return -ENOSYS;
>  }
>  
> +static inline int of_property_read_s32_array(const struct device_node *np,
> +					     const char *propname,
> +					     s32 *out_values, size_t sz)
> +{
> +	return -ENOSYS;
> +}
> +
>  static inline int of_property_read_u64_array(const struct device_node *np,
>  					     const char *propname,
>  					     u64 *out_values, size_t sz)
> 

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
