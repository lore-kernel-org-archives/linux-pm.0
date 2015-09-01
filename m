From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] modify the pl011 driver to let it work as wakeup source
Date: Tue, 01 Sep 2015 16:42:13 +0200
Message-ID: <55E5B945.5090907@linaro.org>
References: <1441100149-28071-1-git-send-email-zhaoyang.huang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36223 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbbIAOmQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 10:42:16 -0400
Received: by wibz8 with SMTP id z8so34947824wib.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2015 07:42:15 -0700 (PDT)
In-Reply-To: <1441100149-28071-1-git-send-email-zhaoyang.huang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>, linux-pm@vger.kernel.org
Cc: amit.kucheria@linaro.org, Sudeep Holla <Sudeep.Holla@arm.com>


Hi Zhaoyang,

added Sudeep in Cc.

You should run checkpatch.pl on this patch. There are 11 errors and 3=20
warnings.

On 09/01/2015 11:35 AM, Zhaoyang Huang wrote:
> the commit use the latest dev_pm_set_wake_irq API instead
> of the enable_irq_wake and IRQF_NO_SUSPEND to configure the
> ttyAMA device to work as the wakeup source
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org>
> ---
>   drivers/tty/serial/amba-pl011.c |   55 ++++++++++++++++++++++++++++=
++++++++---
>   1 file changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amb=
a-pl011.c
> index 50cf5b1..33a479a 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -59,6 +59,10 @@
>   #include <linux/sizes.h>
>   #include <linux/io.h>
>   #include <linux/acpi.h>
> +#include <linux/suspend.h>
> +#include <linux/pm_wakeirq.h>
> +#include "../../base/power/power.h"

I don't think it is usual to do this kind of inclusion. Why do you need=
=20
to do that ?

> +#include <linux/irq.h>
>
>   #define UART_NR			14
>
> @@ -127,6 +131,7 @@ static struct vendor_data vendor_st =3D {
>   	.get_fifosize		=3D get_fifosize_st,
>   };
>
> +static int is_suspended =3D 0;
>   /* Deals with DMA transactions */
>
>   struct pl011_sgbuf {
> @@ -1376,6 +1381,10 @@ static irqreturn_t pl011_int(int irq, void *de=
v_id)
>   					pl011_dma_rx_irq(uap);
>   				else
>   					pl011_rx_chars(uap);
> +
> +				if(is_suspended)
> +					pm_system_wakeup();

I don't think this is needed.

> +
>   			}
>   			if (status & (UART011_DSRMIS|UART011_DCDMIS|
>   				      UART011_CTSMIS|UART011_RIMIS))
> @@ -2353,11 +2362,29 @@ static int pl011_register_port(struct uart_am=
ba_port *uap)
>   	return ret;
>   }
>
> +struct uart_match {
> +	struct uart_port *port;
> +	struct uart_driver *driver;
> +};
> +
> +static int match_uart_port(struct device * dev, void * data)
> +{
> +	struct uart_match *match =3D data;
> +
> +	dev_t devt =3D MKDEV(match->driver->major, match->driver->minor) +
> +		match->port->line;
> +
> +	pr_info("the match data of ttyAMA0 is %d %d\n",(int)devt,(int)dev->=
devt);
> +
> +	return dev->devt =3D=3D devt; /* Actually, only one tty per port */
> +}
>   static int pl011_probe(struct amba_device *dev, const struct amba_i=
d *id)
>   {
>   	struct uart_amba_port *uap;
>   	struct vendor_data *vendor =3D id->data;
>   	int portnr, ret;
> +	struct device * uart_dev;
> +	struct uart_match match;
>
>   	portnr =3D pl011_find_free_port();
>   	if (portnr < 0)
> @@ -2387,7 +2414,17 @@ static int pl011_probe(struct amba_device *dev=
, const struct amba_id *id)
>
>   	amba_set_drvdata(dev, uap);
>
> -	return pl011_register_port(uap);
> +	ret =3D pl011_register_port(uap);
> +
> +	match.port =3D &uap->port;
> +	match.driver =3D &amba_reg;
> +
> +	uart_dev =3D device_find_child(&dev->dev, &match,match_uart_port);
> +
> +       device_init_wakeup(uart_dev, true);
> +       dev_pm_set_wake_irq(uart_dev, uap->port.irq);

I am sending a patch to move device_init_wakeup into dev_pm_set_wake_ir=
q.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

