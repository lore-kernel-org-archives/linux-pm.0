From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 02/14] staging: typec: tcpm: Add get_current_limit
 tcpc_dev callback
Date: Wed, 16 Aug 2017 08:11:18 -0700
Message-ID: <655b5cd9-76df-c99d-39d9-efe31ad5849d@roeck-us.net>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55534 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdHPPLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2017 11:11:22 -0400
In-Reply-To: <20170815200502.17339-3-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org

On 08/15/2017 01:04 PM, Hans de Goede wrote:
> A Rp signalling the default current limit indicates that we're possibly
> connected to an USB2 power-source. In some cases the type-c port-controller
> may provide the capability to detect the current-limit in this case,
> through e.g. BC1.2 detection.
> 
> This commit adds an optional get_current_limit tcpc_dev callback which
> allows the port-controller to provide current-limit detection for when
> the CC pin is pulled up with Rp.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> -s/get_usb2_current_limit/get_current_limit/
> ---
>   drivers/staging/typec/tcpm.c | 5 ++++-
>   drivers/staging/typec/tcpm.h | 7 +++++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/typec/tcpm.c b/drivers/staging/typec/tcpm.c
> index 20eb4eb..8e823af 100644
> --- a/drivers/staging/typec/tcpm.c
> +++ b/drivers/staging/typec/tcpm.c
> @@ -660,7 +660,10 @@ static u32 tcpm_get_current_limit(struct tcpm_port *port)
>   		break;
>   	case TYPEC_CC_RP_DEF:
>   	default:
> -		limit = 0;
> +		if (port->tcpc->get_current_limit)
> +			limit = port->tcpc->get_current_limit(port->tcpc);
> +		else
> +			limit = 0;
>   		break;
>   	}
>   
> diff --git a/drivers/staging/typec/tcpm.h b/drivers/staging/typec/tcpm.h
> index 19c307d..1465668 100644
> --- a/drivers/staging/typec/tcpm.h
> +++ b/drivers/staging/typec/tcpm.h
> @@ -108,6 +108,13 @@ struct tcpc_dev {
>   
>   	int (*init)(struct tcpc_dev *dev);
>   	int (*get_vbus)(struct tcpc_dev *dev);
> +	/*
> +	 * This optional callback gets called by the tcpm core when configured
> +	 * as a snk and cc=Rp-def. This allows the tcpm to provide a fallback
> +	 * current-limit detection method for the cc=Rp-def case. E.g. some
> +	 * tcpcs may include BC1.2 charger detection and use that in this case.
> +	 */
> +	int (*get_current_limit)(struct tcpc_dev *dev);
>   	int (*set_cc)(struct tcpc_dev *dev, enum typec_cc_status cc);
>   	int (*get_cc)(struct tcpc_dev *dev, enum typec_cc_status *cc1,
>   		      enum typec_cc_status *cc2);
> 
