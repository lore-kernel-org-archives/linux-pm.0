From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [RESEND PATCH v10 4/4] power: wm831x_power: Support USB charger
 current limit management
Date: Tue, 3 May 2016 09:30:48 +0530
Message-ID: <CAKDJKT46cJQbjdObUxBpWsciG1FjcL8CdV7iAeMefjNQPGicKA@mail.gmail.com>
References: <cover.1462245638.git.baolin.wang@linaro.org>
	<80aa73ffd5c8e9ae8cd280d37f5141067e79c11f.1462245638.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33597 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbcECEAu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2016 00:00:50 -0400
In-Reply-To: <80aa73ffd5c8e9ae8cd280d37f5141067e79c11f.1462245638.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, May 3, 2016 at 9:00 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Acked-by: Peter Chen <peter.chen@freescale.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/power/wm831x_power.c     |   69 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/wm831x/pdata.h |    3 ++
>  2 files changed, 72 insertions(+)
>
> diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_power.c
> index 7082301..cef1812 100644
> --- a/drivers/power/wm831x_power.c
> +++ b/drivers/power/wm831x_power.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> +#include <linux/usb/charger.h>
>
>  #include <linux/mfd/wm831x/core.h>
>  #include <linux/mfd/wm831x/auxadc.h>
> @@ -31,6 +32,8 @@ struct wm831x_power {
>         char usb_name[20];
>         char battery_name[20];
>         bool have_battery;
> +       struct usb_charger *usb_charger;
> +       struct notifier_block usb_notify;
>  };
>
>  static int wm831x_power_check_online(struct wm831x *wm831x, int supply,
> @@ -125,6 +128,43 @@ static enum power_supply_property wm831x_usb_props[] = {
>         POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
>
> +/* In milliamps */
> +static const unsigned int wm831x_usb_limits[] = {
> +       0,
> +       2,
> +       100,
> +       500,
> +       900,
> +       1500,
> +       1800,
> +       550,
> +};

Just for curiosity, How these current limits are getting decided?
Can we have some proper defines over here so that it can be grasped easily?

Thanks
Manish Badarkhe
