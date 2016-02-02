From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 3/9] pinctrl: convert to use match_string() helper
Date: Mon, 1 Feb 2016 22:02:30 -0800
Message-ID: <20160201220230.92810bde.akpm@linux-foundation.org>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1453986865-133572-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55959 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcBBF7l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 00:59:41 -0500
In-Reply-To: <1453986865-133572-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Thu, 28 Jan 2016 15:14:19 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The new helper returns index of the mathing string in an array. We would use it
> here.
> 
> --- a/drivers/pinctrl/pinmux.c
> +++ b/drivers/pinctrl/pinmux.c
> @@ -334,7 +334,6 @@ int pinmux_map_to_setting(struct pinctrl_map const *map,
>  	unsigned num_groups;
>  	int ret;
>  	const char *group;
> -	int i;
>  
>  	if (!pmxops) {
>  		dev_err(pctldev->dev, "does not support mux function\n");
> @@ -363,19 +362,13 @@ int pinmux_map_to_setting(struct pinctrl_map const *map,
>  		return -EINVAL;
>  	}
>  	if (map->data.mux.group) {
> -		bool found = false;
>  		group = map->data.mux.group;
> -		for (i = 0; i < num_groups; i++) {
> -			if (!strcmp(group, groups[i])) {
> -				found = true;
> -				break;
> -			}
> -		}
> -		if (!found) {
> +		ret = match_string(groups, num_groups, group);
> +		if (ret < 0) {
>  			dev_err(pctldev->dev,
>  				"invalid group \"%s\" for function \"%s\"\n",
>  				group, map->data.mux.function);
> -			return -EINVAL;
> +			return ret;

Changes the return value from -EINVAL to -ENODATA.  I'm not reeeeeealy
sure what ENODATA means - it seems mostly a networking thing?  People
use it in various places because it kinda sounds like whatever it is
that just went wrong.

But the question is: what will the end user think when this error comes
out of the kernel?  Given that he/she has just tried to misconfigure
the pinctrl system, ENODATA will cause much head-scratching.  EINVAL is
more appropriate?  "You tried to do something invalid".

>  		}
>  	} else {
>  		group = groups[0];
> -- 
> 2.7.0.rc3
