From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/9] device property: convert to use match_string() helper
Date: Sat, 09 Jan 2016 00:33:17 +0100
Message-ID: <9839952.QQZMlEqdiM@vostro.rjw.lan>
References: <1452258558-119552-1-git-send-email-andriy.shevchenko@linux.intel.com> <1452258558-119552-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59844 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753314AbcAHXCc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2016 18:02:32 -0500
In-Reply-To: <1452258558-119552-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Friday, January 08, 2016 03:09:11 PM Andy Shevchenko wrote:
> The new helper returns index of the mathing string in an array. We would use it
> here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

in case you need that.

I think though that it might be more efficient to simply push [1/9] first
maybe with one user and then send the other patches to the relevant maintainers
when that has been applied.

> ---
>  drivers/base/property.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c359351..f902b55 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -647,7 +647,7 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
>  	const char *propname, const char *string)
>  {
>  	const char **values;
> -	int nval, ret, i;
> +	int nval, ret;
>  
>  	nval = fwnode_property_read_string_array(fwnode, propname, NULL, 0);
>  	if (nval < 0)
> @@ -664,13 +664,7 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
>  	if (ret < 0)
>  		goto out;
>  
> -	ret = -ENODATA;
> -	for (i = 0; i < nval; i++) {
> -		if (!strcmp(values[i], string)) {
> -			ret = i;
> -			break;
> -		}
> -	}
> +	ret = match_string(values, nval, string);
>  out:
>  	kfree(values);
>  	return ret;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
