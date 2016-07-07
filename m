From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH 5/6] usb: chipidea: host: let the hcd know's parent device node
Date: Thu, 07 Jul 2016 15:56:51 -0700
Message-ID: <146793221122.31330.7571458363004882365@sboyd-linaro>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
 <1467882892-27589-6-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33298 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbcGGW4y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 18:56:54 -0400
Received: by mail-pa0-f45.google.com with SMTP id b13so9745090pat.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2016 15:56:53 -0700 (PDT)
In-Reply-To: <1467882892-27589-6-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, linux-pm@vger.kernel.org, Peter Chen <peter.chen@freescale.com>

Quoting Peter Chen (2016-07-07 02:14:51)
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index 053bac9..55120ef 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -109,15 +109,25 @@ static int host_start(struct ci_hdrc *ci)
>         struct ehci_hcd *ehci;
>         struct ehci_ci_priv *priv;
>         int ret;
> +       struct device *dev = ci->dev;
>  
> -       if (usb_disabled())
> +       if (usb_disabled() || !dev)

Does that ever happen?

>                 return -ENODEV;
>  
> -       hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
> +       /*
> +        * USB Core will try to get child node under roothub,
> +        * but chipidea core has no of_node, and the child node
> +        * for controller is located at glue layer's node which
> +        * is chipidea core's parent.
> +        */
> +       if (dev->parent && dev->parent->of_node)
> +               dev->of_node = dev->parent->of_node;

Why not do this during the ci device probe? How is host special for
having an of_node for the child device.

Doing that would also make my ULPI bus DT discovery patch simpler
because we wouldn't have to search the parent of the parent for a DT
node to find the ULPI node that's a child of the ci glue device.
