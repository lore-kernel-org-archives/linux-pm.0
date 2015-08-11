From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCHv2 6/8] serial: imx: add runtime pm support
Date: Tue, 11 Aug 2015 00:02:58 -0300
Message-ID: <CAOMZO5CCAd3_nYw2M1qPEevzJaymMi0oAn6FqGih3HbhvrYc9A@mail.gmail.com>
References: <1439256949-626-1-git-send-email-edubezval@gmail.com>
	<1439256949-626-7-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34784 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326AbbHKDC7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 23:02:59 -0400
In-Reply-To: <1439256949-626-7-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <s.hauer@pengutronix.de>, Linux PM <linux-pm@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Aug 10, 2015 at 10:35 PM, Eduardo Valentin <edubezval@gmail.com> wrote:

>  static int imx_poll_get_char(struct uart_port *port)
>  {
> -       if (!(readl_relaxed(port->membase + USR2) & USR2_RDR))
> -               return NO_POLL_CHAR;
> +       int ret;
> +
> +       pm_runtime_get_sync(sport->dev);
> +       if (!(readl_relaxed(port->membase + USR2) & USR2_RDR)) {
> +               ret = NO_POLL_CHAR;
> +               goto mark_last;
> +       }
>
> -       return readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
> +       ret = readl_relaxed(port->membase + URXD0) & URXD_RX_DATA;
> +
> +mark_last:
> +       pm_runtime_mark_last_busy(sport->dev);
> +       pm_runtime_put_autosuspend(sport->dev);

You should return ret here.

> +static int serial_imx_runtime_resume(struct device *dev)
> +{
> +       struct imx_port *sport = dev_get_drvdata(dev);
> +
> +       clk_enable(sport->clk_per);

clk_enable() may fail.

> +       clk_enable(sport->clk_ipg);

Same here.

> @@ -2096,6 +2212,8 @@ static int imx_serial_port_resume(struct device *dev)
>         struct platform_device *pdev = to_platform_device(dev);
>         struct imx_port *sport = platform_get_drvdata(pdev);
>
> +       clk_prepare_enable(sport->clk_per);

clk_prepare_enable() may fail.

> +       clk_prepare_enable(sport->clk_ipg);

Ditto.
