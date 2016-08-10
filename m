From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH v5 5/6] usb: chipidea: let chipidea core device of_node equal's
 glue layer device of_node
Date: Tue, 09 Aug 2016 17:15:36 -0700
Message-ID: <147078813636.20133.1120685098868481913@sboyd-linaro>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
 <1470646331-23227-6-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36207 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932554AbcHJAPn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2016 20:15:43 -0400
Received: by mail-pf0-f181.google.com with SMTP id h186so9652477pfg.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Aug 2016 17:15:42 -0700 (PDT)
In-Reply-To: <1470646331-23227-6-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, Peter Chen <peter.chen@freescale.com>

Quoting Peter Chen (2016-08-08 01:52:10)
> From: Peter Chen <peter.chen@freescale.com>
> 
> At device tree, we have no device node for chipidea core,
> the glue layer's node is the parent node for host and udc
> device. But in related driver, the parent device is chipidea
> core. So, in order to let the common driver get parent's node,
> we let the core's device node equals glue layer device node.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> ---
>  drivers/usb/chipidea/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 69426e6..b189dc7 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -954,6 +954,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>                 dev_err(dev, "unable to init phy: %d\n", ret);
>                 return ret;
>         }
> +       /*
> +        * At device tree, we have no device node for chipidea core,
> +        * the glue layer's node is the parent node for host and udc
> +        * device. But in related driver, the parent device is chipidea
> +        * core. So, in order to let the common driver get parent's node,
> +        * we let the core's device node equals glue layer's node.
> +        */
> +       if (dev->parent && dev->parent->of_node)
> +               dev->of_node = dev->parent->of_node;

Can this be done earlier? Perhaps after hw_device_init() in this probe
routine? That would allow me to remove the awkward parent searching in
my ULPI DT awareness patch.
