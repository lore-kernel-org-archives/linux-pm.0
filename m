From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 05/14] power: supply: axp288_charger: use devm extcon /
 supply register
Date: Mon, 19 Dec 2016 17:03:04 +0900
Message-ID: <58579438.3050205@samsung.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
 <CGME20161219000751epcas2p31f6f4ffcc4f7efc3d030874ce317705a@epcas2p3.samsung.com>
 <20161219000731.10188-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59805 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbcLSIDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 03:03:06 -0500
In-reply-to: <20161219000731.10188-6-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Hans,

For the extcon part, I sent the patch[1]. 

[1]https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next-next&id=3164eef74088d9603a16b97e574a4e0067da083a

Regards,
Chanwoo Choi

On 2016년 12월 19일 09:07, Hans de Goede wrote:
> Use devm_extcon_register_notifier and devm_power_supply_register
> instead of their non devm counterparts, this avoids the need to do
> manual cleanup and results in quite a nice code cleanup.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/axp288_charger.c | 71 ++++++++---------------------------
>  1 file changed, 15 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index 76f7d29..e435b1e 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -812,6 +812,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  {
>  	int ret, i, pirq;
>  	struct axp288_chrg_info *info;
> +	struct device *dev = &pdev->dev;
>  	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>  	struct power_supply_config charger_cfg = {};
>  
> @@ -833,33 +834,27 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	/* Register for extcon notification */
>  	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
>  	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
> -	ret = extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> -					&info->cable.nb);
> +	ret = devm_extcon_register_notifier(dev, info->cable.edev,
> +					EXTCON_CHG_USB_SDP, &info->cable.nb);
>  	if (ret) {
>  		dev_err(&info->pdev->dev,
>  			"failed to register extcon notifier for SDP %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_CDP,
> -					&info->cable.nb);
> +	ret = devm_extcon_register_notifier(dev, info->cable.edev,
> +					EXTCON_CHG_USB_CDP, &info->cable.nb);
>  	if (ret) {
>  		dev_err(&info->pdev->dev,
>  			"failed to register extcon notifier for CDP %d\n", ret);
> -		extcon_unregister_notifier(info->cable.edev,
> -				EXTCON_CHG_USB_SDP, &info->cable.nb);
>  		return ret;
>  	}
>  
> -	ret = extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
> -					&info->cable.nb);
> +	ret = devm_extcon_register_notifier(dev, info->cable.edev,
> +					EXTCON_CHG_USB_DCP, &info->cable.nb);
>  	if (ret) {
>  		dev_err(&info->pdev->dev,
>  			"failed to register extcon notifier for DCP %d\n", ret);
> -		extcon_unregister_notifier(info->cable.edev,
> -				EXTCON_CHG_USB_SDP, &info->cable.nb);
> -		extcon_unregister_notifier(info->cable.edev,
> -				EXTCON_CHG_USB_CDP, &info->cable.nb);
>  		return ret;
>  	}
>  
> @@ -868,19 +863,18 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  
>  	/* Register with power supply class */
>  	charger_cfg.drv_data = info;
> -	info->psy_usb = power_supply_register(&pdev->dev, &axp288_charger_desc,
> -						&charger_cfg);
> +	info->psy_usb = devm_power_supply_register(dev, &axp288_charger_desc,
> +						   &charger_cfg);
>  	if (IS_ERR(info->psy_usb)) {
>  		dev_err(&pdev->dev, "failed to register power supply charger\n");
> -		ret = PTR_ERR(info->psy_usb);
> -		goto psy_reg_failed;
> +		return PTR_ERR(info->psy_usb);
>  	}
>  
>  	/* Register for OTG notification */
>  	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
>  	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
> -	ret = extcon_register_notifier(info->otg.cable, EXTCON_USB_HOST,
> -				       &info->otg.id_nb);
> +	ret = devm_extcon_register_notifier(dev, info->otg.cable,
> +					    EXTCON_USB_HOST, &info->otg.id_nb);
>  	if (ret)
>  		dev_warn(&pdev->dev, "failed to register otg notifier\n");
>  
> @@ -895,8 +889,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  		if (info->irq[i] < 0) {
>  			dev_warn(&info->pdev->dev,
>  				"failed to get virtual interrupt=%d\n", pirq);
> -			ret = info->irq[i];
> -			goto intr_reg_failed;
> +			return info->irq[i];
>  		}
>  		ret = devm_request_threaded_irq(&info->pdev->dev, info->irq[i],
>  					NULL, axp288_charger_irq_thread_handler,
> @@ -904,53 +897,19 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to request interrupt=%d\n",
>  								info->irq[i]);
> -			goto intr_reg_failed;
> +			return ret;
>  		}
>  	}
>  
>  	ret = charger_init_hw_regs(info);
>  	if (ret)
> -		goto intr_reg_failed;
> -
> -	return 0;
> -
> -intr_reg_failed:
> -	if (info->otg.cable)
> -		extcon_unregister_notifier(info->otg.cable, EXTCON_USB_HOST,
> -					&info->otg.id_nb);
> -	power_supply_unregister(info->psy_usb);
> -psy_reg_failed:
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> -					&info->cable.nb);
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_CDP,
> -					&info->cable.nb);
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
> -					&info->cable.nb);
> -	return ret;
> -}
> -
> -static int axp288_charger_remove(struct platform_device *pdev)
> -{
> -	struct axp288_chrg_info *info =  dev_get_drvdata(&pdev->dev);
> -
> -	if (info->otg.cable)
> -		extcon_unregister_notifier(info->otg.cable, EXTCON_USB_HOST,
> -					&info->otg.id_nb);
> -
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> -					&info->cable.nb);
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_CDP,
> -					&info->cable.nb);
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
> -					&info->cable.nb);
> -	power_supply_unregister(info->psy_usb);
> +		return ret;
>  
>  	return 0;
>  }
>  
>  static struct platform_driver axp288_charger_driver = {
>  	.probe = axp288_charger_probe,
> -	.remove = axp288_charger_remove,
>  	.driver = {
>  		.name = "axp288_charger",
>  	},
> 

