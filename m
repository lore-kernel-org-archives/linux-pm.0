From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 4/8] usb: core: add power sequence handling for USB
 devices
Date: Mon, 22 Aug 2016 12:09:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1608221156210.1543-100000@iolanthe.rowland.org>
References: <20160822065335.GC4362@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160822065335.GC4362@shlinux2>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: mark.rutland@arm.com, Peter Chen <peter.chen@nxp.com>, ulf.hansson@linaro.org, stephen.boyd@linaro.org, k.kozlowski@samsung.com, linux-kernel@vger.kernel.org, festevam@gmail.com, stillcompiling@gmail.com, pawel.moll@arm.com, dbaryshkov@gmail.com, mka@chromium.org, dwmw3@infradead.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, arnd@arndb.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Aug 2016, Peter Chen wrote:

> On Mon, Aug 15, 2016 at 05:13:14PM +0800, Peter Chen wrote:
> > Some hard-wired USB devices need to do power sequence to let the
> > device work normally, the typical power sequence like: enable USB
> > PHY clock, toggle reset pin, etc. But current Linux USB driver
> > lacks of such code to do it, it may cause some hard-wired USB devices
> > works abnormal or can't be recognized by controller at all.
> > 
> > In this patch, it calls power sequence library APIs to finish
> > the power sequence events. At first, it calls pwrseq_alloc_generic
> > to create a generic power sequence instance, then it will do power
> > on sequence at hub's probe for all devices under this hub
> > (includes root hub).
> > 
> > At hub_disconnect, it will do power off sequence which is at powered
> > on list.
> > 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> 
> Hi Alan,
> 
> The power sequence library code has been reviewed several rounds, would
> you please help to review the change for USB part?

Some small problems...  See below.

> > --- a/drivers/usb/core/Makefile
> > +++ b/drivers/usb/core/Makefile
> > @@ -9,5 +9,6 @@ usbcore-y += port.o of.o
> >  
> >  usbcore-$(CONFIG_PCI)		+= hcd-pci.o
> >  usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
> > +usbcore-$(CONFIG_PWRSEQ_GENERIC) += pwrseq.o

Please use a tab to align this with the lines above.

> > --- /dev/null
> > +++ b/drivers/usb/core/pwrseq.c
> > @@ -0,0 +1,100 @@
> > +/*
> > + * pwrseq.c	USB device power sequence management
> > + *
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Author: Peter Chen <peter.chen@nxp.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2  of
> > + * the License as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/list.h>
> > +#include <linux/of.h>
> > +#include <linux/power/pwrseq.h>
> > +#include <linux/slab.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/hcd.h>
> > +
> > +#include "hub.h"
> > +
> > +struct usb_pwrseq_node {
> > +	struct pwrseq *pwrseq;
> > +	struct list_head list;
> > +};
> > +
> > +static int hub_of_pwrseq_on(struct device_node *np, struct usb_hub *hub)
> > +{
> > +	struct pwrseq *pwrseq;
> > +	struct usb_pwrseq_node *pwrseq_node;
> > +	int ret;
> > +
> > +	pwrseq = pwrseq_alloc_generic();
> > +	if (IS_ERR(pwrseq))
> > +		return PTR_ERR(pwrseq);
> > +
> > +	ret = pwrseq_get(np, pwrseq);
> > +	if (ret)
> > +		goto pwr_free;
> > +
> > +	ret = pwrseq_on(np, pwrseq);
> > +	if (ret)
> > +		goto pwr_put;
> > +
> > +	pwrseq_node = kzalloc(sizeof(*pwrseq_node), GFP_KERNEL);

You need to check that the kzalloc succeeded.

> > +	pwrseq_node->pwrseq = pwrseq;
> > +	list_add(&pwrseq_node->list, &hub->pwrseq_on_list);
> > +
> > +	return 0;
> > +
> > +pwr_put:
> > +	pwrseq_put(pwrseq);
> > +pwr_free:
> > +	pwrseq_free(pwrseq);
> > +	return ret;
> > +}

This subroutine looks very generic.  The only place where it cares that
it was called for a USB hub is the list_add(), and that could easily
become generic also (make this function take &hub->pwrseq_on_list as
its second argument, instead of hub).

It looks like this routine really belongs in the power sequence 
library.

> > +
> > +int hub_pwrseq_on(struct usb_hub *hub)
> > +{

The names of this routine and the subroutine above are too similar.  
After all, both functions require OF support.

> > +	struct device *parent;
> > +	struct usb_device *hdev = hub->hdev;
> > +	struct device_node *np;
> > +	int ret;
> > +
> > +	if (hdev->parent)
> > +		parent = &hdev->dev;
> > +	else
> > +		parent = bus_to_hcd(hdev->bus)->self.controller;
> > +
> > +	for_each_child_of_node(parent->of_node, np) {
> > +		ret = hub_of_pwrseq_on(np, hub);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void hub_pwrseq_off(struct usb_hub *hub)
> > +{
> > +	struct pwrseq *pwrseq;
> > +	struct usb_pwrseq_node *pwrseq_node, *tmp_node;
> > +
> > +	list_for_each_entry_safe(pwrseq_node, tmp_node,
> > +			&hub->pwrseq_on_list, list) {
> > +		pwrseq = pwrseq_node->pwrseq;
> > +		pwrseq_off(pwrseq);
> > +		pwrseq_put(pwrseq);
> > +		pwrseq_free(pwrseq);
> > +		list_del(&pwrseq_node->list);
> > +		kfree(pwrseq_node);
> > +	}
> > +}

This routine also looks like it belongs in a library.

Alan Stern
