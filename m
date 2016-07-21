From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH v3 5/6] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
Date: Thu, 21 Jul 2016 10:14:38 +0100
Message-ID: <20160721091438.GL1041@n2100.armlinux.org.uk>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
 <1469007629-31757-6-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469007629-31757-6-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 20, 2016 at 05:40:28PM +0800, Peter Chen wrote:
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 69426e6..0d05812 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -914,6 +914,16 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  	if (!ci)
>  		return -ENOMEM;
>  
> +	/*
> +	 * At device tree, we have no device node for chipidea core,
> +	 * the glue layer's node is the parent node for host and udc
> +	 * device. But in related driver, the parent device is chipidea
> +	 * core. So, in order to let the common driver get parent's node,
> +	 * we let the core's device node equals glue layer's node.
> +	 */
> +	if (dev->parent && dev->parent->of_node)
> +		dev->of_node = dev->parent->of_node;

This is a dangerous thing to do.  You're changing the dev->of_node of
_this_ device, which means that _this_ driver will no longer match
the device if you remove and reinsert the driver module, or unbind
and try to re-bind the device to this driver.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
