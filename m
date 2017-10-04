From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] extcon: Split out extcon header file for consumer and
 provider device
Date: Wed, 4 Oct 2017 11:48:50 +0100
Message-ID: <20171004104850.aeedla2bkns36iw7@dell>
References: <CGME20170929000148epcas2p200e56186b067ec626a033c7ae2d4bbdb@epcas2p2.samsung.com>
 <1506643305-4581-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1506643305-4581-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, chanwoo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, 29 Sep 2017, Chanwoo Choi wrote:

> The extcon has two type of extcon devices as following.
> - 'extcon provider deivce' adds new extcon device and detect the
>    state/properties of external connector. Also, it notifies the
>    state/properties to the extcon consumer device.
> - 'extcon consumer device' gets the change state/properties
>    from extcon provider device.
> Prior to that, include/linux/extcon.h contains all exported API for
> both provider and consumer device driver. To clarify the meaning of
> header file and to remove the wrong use-case on consumer device,
> this patch separates into extcon.h and extcon-provider.h.
> 
> [Description for include/linux/{extcon.h|extcon-provider.h}]
> - extcon.h includes the extcon API and data structure for extcon consumer
>   device driver. This header file contains the following APIs:
>   : Register/unregister the notifier to catch the change of extcon device
>   : Get the extcon device instance
>   : Get the extcon device name
>   : Get the state of each external connector
>   : Get the property value of each external connector
>   : Get the property capability of each external connector
> 
> - extcon-provider.h includes the extcon API and data structure for extcon
>   provider device driver. This header file contains the following APIs:
>   : Include 'include/linux/extcon.h'
>   : Allocate the memory for extcon device instance
>   : Register/unregister extcon device
>   : Set the state of each external connector
>   : Set the property value of each external connector
>   : Set the property capability of each external connector
> 
> Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/extcon/extcon-adc-jack.c              |   2 +-
>  drivers/extcon/extcon-arizona.c               |   2 +-
>  drivers/extcon/extcon-axp288.c                |   2 +-
>  drivers/extcon/extcon-gpio.c                  |   2 +-
>  drivers/extcon/extcon-intel-cht-wc.c          |   2 +-
>  drivers/extcon/extcon-intel-int3496.c         |   2 +-
>  drivers/extcon/extcon-max14577.c              |   2 +-
>  drivers/extcon/extcon-max3355.c               |   2 +-
>  drivers/extcon/extcon-max77693.c              |   2 +-
>  drivers/extcon/extcon-max77843.c              |   2 +-
>  drivers/extcon/extcon-max8997.c               |   2 +-
>  drivers/extcon/extcon-qcom-spmi-misc.c        |   2 +-
>  drivers/extcon/extcon-rt8973a.c               |   2 +-
>  drivers/extcon/extcon-sm5502.c                |   2 +-
>  drivers/extcon/extcon-usb-gpio.c              |   2 +-
>  drivers/extcon/extcon-usbc-cros-ec.c          |   2 +-
>  drivers/extcon/extcon.h                       |   2 +-
>  drivers/phy/allwinner/phy-sun4i-usb.c         |   2 +-
>  drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c     |   2 +-
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c      |   2 +-
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   2 +-
>  drivers/power/supply/qcom_smbb.c              |   2 +-
>  drivers/usb/gadget/udc/renesas_usb3.c         |   2 +-
>  drivers/usb/phy/phy-tahvo.c                   |   2 +-
>  drivers/usb/renesas_usbhs/common.h            |   2 +-
>  include/linux/extcon-provider.h               | 142 ++++++++++++++++++++++++++
>  include/linux/extcon.h                        | 109 +-------------------

>  include/linux/mfd/palmas.h                    |   2 +-

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
