From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] power_supply: fix return value of get_property
Date: Thu, 16 Jun 2016 10:43:21 +0200
Message-ID: <576266A9.9030906@samsung.com>
References: <1466028784-24459-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18103 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbcFPIoN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 04:44:13 -0400
In-reply-to: <1466028784-24459-1-git-send-email-rklein@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/16/2016 12:13 AM, Rhyland Klein wrote:
> power_supply_get_property() should ideally return -EAGAIN if it is
> called while the power_supply is being registered. There was no way
> previously to determine if use_cnt == 0 meant that the power_supply
> wasn't fully registered yet, or if it had already been unregistered.
> 
> Add a new boolean to the power_supply struct to simply show if
> registration is completed. Lastly, modify the check in
> power_supply_show_property() to also ignore -EAGAIN when so it
> doesn't complain about not returning the property.
> 
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> ---
> v2:
>  - Modify power_supply_show_property() to not complain if it
>    sees a return value of -EAGAIN after calling
>    power_supply_get_property().
> 
>  drivers/power/power_supply_core.c  | 6 +++++-
>  drivers/power/power_supply_sysfs.c | 2 +-
>  include/linux/power_supply.h       | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)

I don't like it for two reasons:
1. There is still a short window when the information will be
inaccurate. See comment below.

2. Although the code is not very complicated but it adds another field
and some checks just for differentiating EAGAIN/ENODEV. It is
unnecessary complexity.

> 
> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
> index b13cd074c52a..a39a47672979 100644
> --- a/drivers/power/power_supply_core.c
> +++ b/drivers/power/power_supply_core.c
> @@ -491,8 +491,11 @@ int power_supply_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val)
>  {
> -	if (atomic_read(&psy->use_cnt) <= 0)
> +	if (atomic_read(&psy->use_cnt) <= 0) {
> +		if (!psy->initialized)
> +			return -EAGAIN;
>  		return -ENODEV;
> +	}
>  
>  	return psy->desc->get_property(psy, psp, val);
>  }
> @@ -775,6 +778,7 @@ __power_supply_register(struct device *parent,
>  	if (rc)
>  		goto create_triggers_failed;
>  
> +	psy->initialized = true;

If someone calls power_supply_get_property() here, then ENODEV will be
returned which is wrong.

The problem is not solved entirely... I am not convinced that introduced
complexity is worth fixing it.

Best regards,
Krzysztof
