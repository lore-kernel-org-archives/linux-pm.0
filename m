From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] extcon: Split out extcon header file for consumer
 and provider device
Date: Thu, 12 Oct 2017 12:40:25 +0900
Message-ID: <59DEE429.2000608@samsung.com>
References: <CGME20171010101758epcas2p3b3f379076f5be5e81edee2bd00354c28@epcas2p3.samsung.com>
        <1507630671-23536-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1507630671-23536-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, lee.jones@linaro.org, heiko@sntech.de, yoshihiro.shimoda.uh@renesas.com, krzk@kernel.org, b.zolnierkie@samsung.com, maxime.ripard@free-electrons.com, wens@csie.org, chanwoo@kernel.org, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dear Kishon,

Could you please review this patch?
After that, I'll make the immutable brand and then send the pull request
for power_supply, mfd, phy, usb and extcon framework.

On 2017년 10월 10일 19:17, Chanwoo Choi wrote:
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
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v1:
> - Don't touch drivers/usb/renesas_usbhs/common.h.
> - Add acked-by from Sebastian Reichel (for drivers/power/supply/)
> - Add acked-by from Chen-Yu Tsai (for phy-sun4i-usb.c & extcon-axp288.c)
> - Add acked-by from Charles Keepax (for drivers/extcon/extcon-arizona.c)
> - Add acked-by from Lee Jones (fo include/linux/mfd/palmas.h)
> 
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
>  include/linux/extcon-provider.h               | 142 ++++++++++++++++++++++++++
>  include/linux/extcon.h                        | 109 +-------------------
>  include/linux/mfd/palmas.h                    |   2 +-
>  27 files changed, 172 insertions(+), 129 deletions(-)
>  create mode 100644 include/linux/extcon-provider.h
> 
> diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
> index 6f6537ab0a79..3877d86c746a 100644
> --- a/drivers/extcon/extcon-adc-jack.c
> +++ b/drivers/extcon/extcon-adc-jack.c
> @@ -26,7 +26,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/extcon/extcon-adc-jack.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  
>  /**
>   * struct adc_jack_data - internal data for adc_jack device driver
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index f84da4a17724..da0e9bc4262f 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -27,7 +27,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  
>  #include <sound/soc.h>
>  
> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
> index f4fd03e58e37..981fba56bc18 100644
> --- a/drivers/extcon/extcon-axp288.c
> +++ b/drivers/extcon/extcon-axp288.c
> @@ -22,7 +22,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/notifier.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
> diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
> index ebed22f22d75..ab770adcca7e 100644
> --- a/drivers/extcon/extcon-gpio.c
> +++ b/drivers/extcon/extcon-gpio.c
> @@ -17,7 +17,7 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/extcon/extcon-gpio.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 91a0023074af..7c4bc8c44c3f 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -15,7 +15,7 @@
>   * more details.
>   */
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/intel_soc_pmic.h>
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index 1a45e745717d..c8691b5a9cb0 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -19,7 +19,7 @@
>   */
>  
>  #include <linux/acpi.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
> index f6414b7fa5bc..6c2c9996eb71 100644
> --- a/drivers/extcon/extcon-max14577.c
> +++ b/drivers/extcon/extcon-max14577.c
> @@ -23,7 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mfd/max14577.h>
>  #include <linux/mfd/max14577-private.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  
>  #define	DELAY_MS_DEFAULT		17000		/* unit: millisecond */
>  
> diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
> index 533e16a952b8..0aa410836f4e 100644
> --- a/drivers/extcon/extcon-max3355.c
> +++ b/drivers/extcon/extcon-max3355.c
> @@ -9,7 +9,7 @@
>   * may be copied, distributed, and modified under those terms.
>   */
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
> index 7a5856809047..643411066ad9 100644
> --- a/drivers/extcon/extcon-max77693.c
> +++ b/drivers/extcon/extcon-max77693.c
> @@ -26,7 +26,7 @@
>  #include <linux/mfd/max77693.h>
>  #include <linux/mfd/max77693-common.h>
>  #include <linux/mfd/max77693-private.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/irqdomain.h>
>  
> diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
> index 6e722d552cf1..28f251ff0fa2 100644
> --- a/drivers/extcon/extcon-max77843.c
> +++ b/drivers/extcon/extcon-max77843.c
> @@ -11,7 +11,7 @@
>   * (at your option) any later version.
>   */
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
> index 4a0612fb9c07..8152790d72e1 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -25,7 +25,7 @@
>  #include <linux/kobject.h>
>  #include <linux/mfd/max8997.h>
>  #include <linux/mfd/max8997-private.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/irqdomain.h>
>  
>  #define	DEV_NAME			"max8997-muic"
> diff --git a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
> index b8cde096a808..660bbf163bf5 100644
> --- a/drivers/extcon/extcon-qcom-spmi-misc.c
> +++ b/drivers/extcon/extcon-qcom-spmi-misc.c
> @@ -15,7 +15,7 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
> index eaa355e7d9e4..e059bd5f2041 100644
> --- a/drivers/extcon/extcon-rt8973a.c
> +++ b/drivers/extcon/extcon-rt8973a.c
> @@ -20,7 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  
>  #include "extcon-rt8973a.h"
>  
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index 106ef0297b53..0cfb5a3efdf6 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -19,7 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  
>  #include "extcon-sm5502.h"
>  
> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
> index 9c925b05b7aa..53762864a9f7 100644
> --- a/drivers/extcon/extcon-usb-gpio.c
> +++ b/drivers/extcon/extcon-usb-gpio.c
> @@ -14,7 +14,7 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/init.h>
> diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
> index 598956f1dcae..6187f731b29d 100644
> --- a/drivers/extcon/extcon-usbc-cros-ec.c
> +++ b/drivers/extcon/extcon-usbc-cros-ec.c
> @@ -14,7 +14,7 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/module.h>
> diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
> index dddddcfa0587..cc1b436eb66a 100644
> --- a/drivers/extcon/extcon.h
> +++ b/drivers/extcon/extcon.h
> @@ -1,7 +1,7 @@
>  #ifndef __LINUX_EXTCON_INTERNAL_H__
>  #define __LINUX_EXTCON_INTERNAL_H__
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  
>  /**
>   * struct extcon_dev - An extcon device represents one external connector.
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 1161e11fb3cf..ef34f97f214b 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -24,7 +24,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
> index d099a0c8cee5..7ceea5ae2704 100644
> --- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
> +++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
> @@ -12,7 +12,7 @@
>   */
>  
>  #include <linux/delay.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/init.h>
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> index 54c34298a000..b33e2994ccce 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -12,7 +12,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index ee7ce5ee53f9..5049dac79bd0 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -17,7 +17,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/gpio/consumer.h>
> diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
> index f6a0d245731d..11de691b9a71 100644
> --- a/drivers/power/supply/qcom_smbb.c
> +++ b/drivers/power/supply/qcom_smbb.c
> @@ -34,7 +34,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/regulator/driver.h>
>  
>  #define SMBB_CHG_VMAX		0x040
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
> index df37c1e6e9d5..8b4d051fdbed 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -12,7 +12,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
> index 8babd318c0ed..354e8c98af05 100644
> --- a/drivers/usb/phy/phy-tahvo.c
> +++ b/drivers/usb/phy/phy-tahvo.c
> @@ -23,7 +23,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/usb.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/usb/otg.h>
> diff --git a/include/linux/extcon-provider.h b/include/linux/extcon-provider.h
> new file mode 100644
> index 000000000000..2feca5881fa7
> --- /dev/null
> +++ b/include/linux/extcon-provider.h
> @@ -0,0 +1,142 @@
> +/*
> + * External Connector (extcon) framework
> + * - linux/include/linux/extcon-provider.h for extcon provider device driver.
> + *
> + * Copyright (C) 2017 Samsung Electronics
> + * Author: Chanwoo Choi <cw00.choi@samsung.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __LINUX_EXTCON_PROVIDER_H__
> +#define __LINUX_EXTCON_PROVIDER_H__
> +
> +#include <linux/extcon.h>
> +
> +struct extcon_dev;
> +
> +#if IS_ENABLED(CONFIG_EXTCON)
> +
> +/* Following APIs register/unregister the extcon device. */
> +extern int extcon_dev_register(struct extcon_dev *edev);
> +extern void extcon_dev_unregister(struct extcon_dev *edev);
> +extern int devm_extcon_dev_register(struct device *dev,
> +				struct extcon_dev *edev);
> +extern void devm_extcon_dev_unregister(struct device *dev,
> +				struct extcon_dev *edev);
> +
> +/* Following APIs allocate/free the memory of the extcon device. */
> +extern struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
> +extern void extcon_dev_free(struct extcon_dev *edev);
> +extern struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
> +				const unsigned int *cable);
> +extern void devm_extcon_dev_free(struct device *dev, struct extcon_dev *edev);
> +
> +/* Synchronize the state and property value for each external connector. */
> +extern int extcon_sync(struct extcon_dev *edev, unsigned int id);
> +
> +/*
> + * Following APIs set the connected state of each external connector.
> + * The 'id' argument indicates the defined external connector.
> + */
> +extern int extcon_set_state(struct extcon_dev *edev, unsigned int id,
> +				bool state);
> +extern int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
> +				bool state);
> +
> +/*
> + * Following APIs set the property of each external connector.
> + * The 'id' argument indicates the defined external connector
> + * and the 'prop' indicates the extcon property.
> + *
> + * And extcon_set_property_capability() set the capability of the property
> + * for each external connector. They are used to set the capability of the
> + * property of each external connector based on the id and property.
> + */
> +extern int extcon_set_property(struct extcon_dev *edev, unsigned int id,
> +				unsigned int prop,
> +				union extcon_property_value prop_val);
> +extern int extcon_set_property_sync(struct extcon_dev *edev, unsigned int id,
> +				unsigned int prop,
> +				union extcon_property_value prop_val);
> +extern int extcon_set_property_capability(struct extcon_dev *edev,
> +				unsigned int id, unsigned int prop);
> +
> +#else /* CONFIG_EXTCON */
> +static inline int extcon_dev_register(struct extcon_dev *edev)
> +{
> +	return 0;
> +}
> +
> +static inline void extcon_dev_unregister(struct extcon_dev *edev) { }
> +
> +static inline int devm_extcon_dev_register(struct device *dev,
> +				struct extcon_dev *edev)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline void devm_extcon_dev_unregister(struct device *dev,
> +				struct extcon_dev *edev) { }
> +
> +static inline struct extcon_dev *extcon_dev_allocate(const unsigned int *cable)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline void extcon_dev_free(struct extcon_dev *edev) { }
> +
> +static inline struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
> +				const unsigned int *cable)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +
> +static inline void devm_extcon_dev_free(struct extcon_dev *edev) { }
> +
> +
> +static inline int extcon_set_state(struct extcon_dev *edev, unsigned int id,
> +				bool state)
> +{
> +	return 0;
> +}
> +
> +static inline int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
> +				bool state)
> +{
> +	return 0;
> +}
> +
> +static inline int extcon_sync(struct extcon_dev *edev, unsigned int id)
> +{
> +	return 0;
> +}
> +
> +static inline int extcon_set_property(struct extcon_dev *edev, unsigned int id,
> +				unsigned int prop,
> +				union extcon_property_value prop_val)
> +{
> +	return 0;
> +}
> +
> +static inline int extcon_set_property_sync(struct extcon_dev *edev,
> +				unsigned int id, unsigned int prop,
> +				union extcon_property_value prop_val)
> +{
> +	return 0;
> +}
> +
> +static inline int extcon_set_property_capability(struct extcon_dev *edev,
> +				unsigned int id, unsigned int prop)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_EXTCON */
> +#endif /* __LINUX_EXTCON_PROVIDER_H__ */
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 744d60ca80c3..6d94e82c8ad9 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -1,5 +1,6 @@
>  /*
>   * External Connector (extcon) framework
> + * - linux/include/linux/extcon.h for extcon consumer device driver.
>   *
>   * Copyright (C) 2015 Samsung Electronics
>   * Author: Chanwoo Choi <cw00.choi@samsung.com>
> @@ -170,61 +171,29 @@
>  	int intval;	/* type : integer (intval) */
>  };
>  
> -struct extcon_cable;
>  struct extcon_dev;
>  
>  #if IS_ENABLED(CONFIG_EXTCON)
> -
> -/* Following APIs register/unregister the extcon device. */
> -extern int extcon_dev_register(struct extcon_dev *edev);
> -extern void extcon_dev_unregister(struct extcon_dev *edev);
> -extern int devm_extcon_dev_register(struct device *dev,
> -				struct extcon_dev *edev);
> -extern void devm_extcon_dev_unregister(struct device *dev,
> -				struct extcon_dev *edev);
> -
> -/* Following APIs allocate/free the memory of the extcon device. */
> -extern struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
> -extern void extcon_dev_free(struct extcon_dev *edev);
> -extern struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
> -				const unsigned int *cable);
> -extern void devm_extcon_dev_free(struct device *dev, struct extcon_dev *edev);
> -
> -/* Synchronize the state and property value for each external connector. */
> -extern int extcon_sync(struct extcon_dev *edev, unsigned int id);
> -
>  /*
> - * Following APIs get/set the connected state of each external connector.
> + * Following APIs get the connected state of each external connector.
>   * The 'id' argument indicates the defined external connector.
>   */
>  extern int extcon_get_state(struct extcon_dev *edev, unsigned int id);
> -extern int extcon_set_state(struct extcon_dev *edev, unsigned int id,
> -				bool state);
> -extern int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
> -				bool state);
>  
>  /*
> - * Following APIs get/set the property of each external connector.
> + * Following APIs get the property of each external connector.
>   * The 'id' argument indicates the defined external connector
>   * and the 'prop' indicates the extcon property.
>   *
> - * And extcon_get/set_property_capability() set the capability of the property
> - * for each external connector. They are used to set the capability of the
> + * And extcon_get_property_capability() get the capability of the property
> + * for each external connector. They are used to get the capability of the
>   * property of each external connector based on the id and property.
>   */
>  extern int extcon_get_property(struct extcon_dev *edev, unsigned int id,
>  				unsigned int prop,
>  				union extcon_property_value *prop_val);
> -extern int extcon_set_property(struct extcon_dev *edev, unsigned int id,
> -				unsigned int prop,
> -				union extcon_property_value prop_val);
> -extern int extcon_set_property_sync(struct extcon_dev *edev, unsigned int id,
> -				unsigned int prop,
> -				union extcon_property_value prop_val);
>  extern int extcon_get_property_capability(struct extcon_dev *edev,
>  				unsigned int id, unsigned int prop);
> -extern int extcon_set_property_capability(struct extcon_dev *edev,
> -				unsigned int id, unsigned int prop);
>  
>  /*
>   * Following APIs register the notifier block in order to detect
> @@ -268,79 +237,17 @@ extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
>  extern const char *extcon_get_edev_name(struct extcon_dev *edev);
>  
>  #else /* CONFIG_EXTCON */
> -static inline int extcon_dev_register(struct extcon_dev *edev)
> -{
> -	return 0;
> -}
> -
> -static inline void extcon_dev_unregister(struct extcon_dev *edev) { }
> -
> -static inline int devm_extcon_dev_register(struct device *dev,
> -				struct extcon_dev *edev)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline void devm_extcon_dev_unregister(struct device *dev,
> -				struct extcon_dev *edev) { }
> -
> -static inline struct extcon_dev *extcon_dev_allocate(const unsigned int *cable)
> -{
> -	return ERR_PTR(-ENOSYS);
> -}
> -
> -static inline void extcon_dev_free(struct extcon_dev *edev) { }
> -
> -static inline struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
> -				const unsigned int *cable)
> -{
> -	return ERR_PTR(-ENOSYS);
> -}
> -
> -static inline void devm_extcon_dev_free(struct extcon_dev *edev) { }
> -
> -
>  static inline int extcon_get_state(struct extcon_dev *edev, unsigned int id)
>  {
>  	return 0;
>  }
>  
> -static inline int extcon_set_state(struct extcon_dev *edev, unsigned int id,
> -				bool state)
> -{
> -	return 0;
> -}
> -
> -static inline int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
> -				bool state)
> -{
> -	return 0;
> -}
> -
> -static inline int extcon_sync(struct extcon_dev *edev, unsigned int id)
> -{
> -	return 0;
> -}
> -
>  static inline int extcon_get_property(struct extcon_dev *edev, unsigned int id,
>  				unsigned int prop,
>  				union extcon_property_value *prop_val)
>  {
>  	return 0;
>  }
> -static inline int extcon_set_property(struct extcon_dev *edev, unsigned int id,
> -				unsigned int prop,
> -				union extcon_property_value prop_val)
> -{
> -	return 0;
> -}
> -
> -static inline int extcon_set_property_sync(struct extcon_dev *edev,
> -				unsigned int id, unsigned int prop,
> -				union extcon_property_value prop_val)
> -{
> -	return 0;
> -}
>  
>  static inline int extcon_get_property_capability(struct extcon_dev *edev,
>  				unsigned int id, unsigned int prop)
> @@ -348,12 +255,6 @@ static inline int extcon_get_property_capability(struct extcon_dev *edev,
>  	return 0;
>  }
>  
> -static inline int extcon_set_property_capability(struct extcon_dev *edev,
> -				unsigned int id, unsigned int prop)
> -{
> -	return 0;
> -}
> -
>  static inline int extcon_register_notifier(struct extcon_dev *edev,
>  				unsigned int id, struct notifier_block *nb)
>  {
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 6dec43826303..3c8568aa82a5 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -20,7 +20,7 @@
>  #include <linux/leds.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/driver.h>
> -#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/of_gpio.h>
>  #include <linux/usb/phy_companion.h>
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
