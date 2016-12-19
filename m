From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 08/14] power: supply: axp288_charger: Actually get and use
 the USB_HOST extcon device
Date: Mon, 19 Dec 2016 19:16:16 +0900
Message-ID: <5857B370.4040303@samsung.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
 <CGME20161219001051epcas2p347121ca783f186cb927b7e02646eb234@epcas2p3.samsung.com>
 <20161219000731.10188-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20161219000731.10188-9-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Hans,

On 2016년 12월 19일 09:07, Hans de Goede wrote:
> Nothing was setting info->otg.cable, so the extcon_get_cable_state_
> calls on it would always return -EINVAL.
> 
> This commit fixes this by actually setting info->otg.cable using the new
> extcon_get_extcon_dev_by_cable_id function.
> 
> This commit also makes failing to register the extcon notifier for the
> USB_HOST cable an error rather then a warning, because we MUST have this
> notfier to properly disable the VBUS path when in host mode so that we're
> not drawing current from the 5V boost converter which is supplying power
> to the otg port when in host mode.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/axp288_charger.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index 08a5dba..2b95db2 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -833,6 +833,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  		return -EPROBE_DEFER;
>  	}
>  
> +	info->otg.cable = extcon_get_extcon_dev_by_cable_id(EXTCON_USB_HOST);
> +	if (info->otg.cable == NULL) {
> +		dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> +		return -EPROBE_DEFER;
> +	}
> +

I replied my opinion of extcon_get_extcon_dev_by_cable_id from patch1.

If you possible, I think that you better to use the id_table which
includes the correct name of extcon device which support the EXTCON_USB_HOST.

When changing the hardware design, I think you can add the new device_id
with new extcon device name.

>  	platform_set_drvdata(pdev, info);
>  	mutex_init(&info->lock);
>  
> @@ -867,12 +873,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
>  	ret = devm_extcon_register_notifier(dev, info->otg.cable,
>  					    EXTCON_USB_HOST, &info->otg.id_nb);
> -	if (ret)
> -		dev_warn(&pdev->dev, "failed to register otg notifier\n");
> -
> -	if (info->otg.cable)
> -		info->otg.id_short = extcon_get_cable_state_(
> -					info->otg.cable, EXTCON_USB_HOST);
> +	if (ret) {
> +		dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
> +		return ret;
> +	}
> +	info->otg.id_short = extcon_get_cable_state_(info->otg.cable,
> +						     EXTCON_USB_HOST);
>  
>  	/* Register charger interrupts */
>  	for (i = 0; i < CHRG_INTR_END; i++) {
> 

-- 
Regards,
Chanwoo Choi
