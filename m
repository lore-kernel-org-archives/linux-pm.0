From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 02/18] staging: typec: tcpm: Add extcon helper functions
 for USB2 current limit detect
Date: Sun, 6 Aug 2017 07:07:52 -0700
Message-ID: <b46b58c0-9bb5-8818-4f40-4fe3dc001409@roeck-us.net>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170806123555.5124-3-hdegoede@redhat.com>
Content-Language: en-US
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

On 08/06/2017 05:35 AM, Hans de Goede wrote:
> Some type-c port-controllers, such as the fusb302 port-controller, rely
> on an external device doing USB2 charger-type detection.
> 
> Existing PMIC (and charger) drivers already use extcon to communicate the
> detected charger-type from the PMIC (extcon) driver to the charger driver.
> 
> Rather then inventing a new API for USB2 charger-type detection
> specifically for use with the tcpm code, lets simply re-use the existing
> support. This will also allow re-using existing PMIC extcon drivers such
> as the axp288 and Intel Whiskey Cove drivers as is on devices where these
> are combined with a fusb302 (or in the future another port-controller
> which relies on external USB2 charger-type detection).
> 
> This commit adds a helper function which tcpc drivers can use to easily
> hook into existing PMIC extcon drivers for USB2 charger-type detection:
> 
> int tcpm_get_usb2_current_limit_extcon(struct tcpc_dev *tcpc);
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/staging/typec/tcpm.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   drivers/staging/typec/tcpm.h |  6 ++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/staging/typec/tcpm.c b/drivers/staging/typec/tcpm.c
> index 9f5adace4309..06bb0e640bcf 100644
> --- a/drivers/staging/typec/tcpm.c
> +++ b/drivers/staging/typec/tcpm.c
> @@ -16,6 +16,7 @@
>   
>   #include <linux/completion.h>
>   #include <linux/debugfs.h>
> +#include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> @@ -3532,6 +3533,45 @@ void tcpm_unregister_port(struct tcpm_port *port)
>   }
>   EXPORT_SYMBOL_GPL(tcpm_unregister_port);
>   
> +/* Generic (helper) implementations for some tcpc_dev callbacks */
> +int tcpm_get_usb2_current_limit_extcon(struct tcpc_dev *tcpc)
> +{
> +	struct extcon_dev *extcon = tcpc->usb2_extcon;
> +	int current_limit = 0;
> +	unsigned long timeout;
> +
> +	if (!extcon)
> +		return 0;
> +
> +	/*
> +	 * USB2 Charger detection may still be in progress when we get here,
> +	 * this can take upto 600ms, wait 800ms max.
> +	 */
> +	timeout = jiffies + msecs_to_jiffies(800);
> +	do {
> +		if (extcon_get_state(extcon, EXTCON_CHG_USB_SDP) == 1) {
> +			current_limit = 500;
> +			break;
> +		}
> +
> +		if (extcon_get_state(extcon, EXTCON_CHG_USB_CDP) == 1 ||
> +		    extcon_get_state(extcon, EXTCON_CHG_USB_ACA) == 1) {
> +			current_limit = 1500;
> +			break;
> +		}
> +
> +		if (extcon_get_state(extcon, EXTCON_CHG_USB_DCP) == 1) {
> +			current_limit = 2000;
> +			break;
> +		}
> +
> +		msleep(50);
> +	} while (time_before(jiffies, timeout));
> +
> +	return current_limit;
> +}
> +EXPORT_SYMBOL_GPL(tcpm_get_usb2_current_limit_extcon);
> +

Not really sure about this one. Should it be part of low level drivers ?

Guenter

>   MODULE_AUTHOR("Guenter Roeck <groeck@chromium.org>");
>   MODULE_DESCRIPTION("USB Type-C Port Manager");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/typec/tcpm.h b/drivers/staging/typec/tcpm.h
> index 01b7d89379a3..35e8c1e7dba0 100644
> --- a/drivers/staging/typec/tcpm.h
> +++ b/drivers/staging/typec/tcpm.h
> @@ -16,6 +16,7 @@
>   #define __LINUX_USB_TCPM_H
>   
>   #include <linux/bitops.h>
> +#include <linux/extcon.h>
>   #include <linux/usb/typec.h>
>   #include "pd.h"
>   
> @@ -126,6 +127,8 @@ struct tcpc_dev {
>   	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
>   			   const struct pd_message *msg);
>   	struct tcpc_mux_dev *mux;
> +	/* Used by tcpm_get_usb2_current_limit_extcon helpers */
> +	struct extcon_dev *usb2_extcon;
>   };
>   
>   struct tcpm_port;
> @@ -151,4 +154,7 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
>   void tcpm_pd_hard_reset(struct tcpm_port *port);
>   void tcpm_tcpc_reset(struct tcpm_port *port);
>   
> +/* Generic (helper) implementations for some tcpc_dev callbacks */
> +int tcpm_get_usb2_current_limit_extcon(struct tcpc_dev *tcpc);
> +
>   #endif /* __LINUX_USB_TCPM_H */
> 
