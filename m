From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] power: axp288_charger: Fix broken extcon API calls
Date: Mon, 29 Jun 2015 10:49:31 +0900
Message-ID: <5590A42B.6050207@samsung.com>
References: <1435367564-12900-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39111 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbbF2Bte (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2015 21:49:34 -0400
In-reply-to: <1435367564-12900-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ramakrishna Pallala <ramakrishna.pallala@intel.com>

Hi Guenter,

The similar patch[1] was already merged.

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4b703b1d4c46ca4a00109ca1a391943ec21991b3

Thanks,
Chanwoo Choi

On 06/27/2015 10:12 AM, Guenter Roeck wrote:
> The extcon API calls have been changed to add an additional argument.
> This causes build errors such as
> 
> drivers/power/axp288_charger.c:851:2: error:
> 	too few arguments to function 'extcon_register_notifier'
> 
> Fixes: 73b6ecdb93e8 ("extcon: Redefine the unique id of supported
> 	external connectors without 'enum extcon' type")
> Fixes: 046050f6e623 ("extcon: Update the prototype of
> 	extcon_register_notifier() with enum extcon")
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/power/axp288_charger.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/axp288_charger.c b/drivers/power/axp288_charger.c
> index 5680317f4823..0aa6e7fd25d4 100644
> --- a/drivers/power/axp288_charger.c
> +++ b/drivers/power/axp288_charger.c
> @@ -848,7 +848,8 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	/* Register for extcon notification */
>  	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
>  	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
> -	ret = extcon_register_notifier(info->cable.edev, &info->cable.nb);
> +	ret = extcon_register_notifier(info->cable.edev, EXTCON_NONE,
> +				       &info->cable.nb);
>  	if (ret) {
>  		dev_err(&info->pdev->dev,
>  			"failed to register extcon notifier %d\n", ret);
> @@ -909,7 +910,8 @@ intr_reg_failed:
>  		extcon_unregister_interest(&info->otg.cable);
>  	power_supply_unregister(info->psy_usb);
>  psy_reg_failed:
> -	extcon_unregister_notifier(info->cable.edev, &info->cable.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE,
> +				   &info->cable.nb);
>  	return ret;
>  }
>  
> @@ -920,7 +922,8 @@ static int axp288_charger_remove(struct platform_device *pdev)
>  	if (info->otg.cable.edev)
>  		extcon_unregister_interest(&info->otg.cable);
>  
> -	extcon_unregister_notifier(info->cable.edev, &info->cable.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE,
> +				   &info->cable.nb);
>  	power_supply_unregister(info->psy_usb);
>  
>  	return 0;
> 

