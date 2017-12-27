From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE# signal for OF
Date: Wed, 27 Dec 2017 01:57:07 +0100
Message-ID: <5491520.JsEYlZiECc@aspire.rjw.lan>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com> <9593014.U0c2JQdoEZ@aspire.rjw.lan> <5A41A0A7.5070605@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <5A41A0A7.5070605@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
To: JeffyChen <jeffy.chen@rock-chips.com>, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pm@vger.kernel.org, shawn.lin@rock-chips.com, briannorris@chromium.org, dianders@chromium.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 26, 2017 2:06:47 AM CET JeffyChen wrote:
> Hi Rafael,
> 
> Thanks for your reply :)
> 
> On 12/26/2017 08:11 AM, Rafael J. Wysocki wrote:
> >> >+
> >> >+	dn = pci_device_to_OF_node(ppdev);
> >> >+	if (!dn)
> >> >+		return 0;
> >> >+
> >> >+	irq = of_irq_get_byname(dn, "wakeup");
> > Why is this a property of the bridge and not of the device itself?
>
> That is suggested by Brian, because in that way, the wakeup pin would 
> not "tied to what exact device is installed (or no device, if it's a slot)."

But I don't think it works when there are two devices using different WAKE#
interrupt lines under the same bridge.  Or how does it work then?

> >> >+	if (irq == -EPROBE_DEFER)
> > Braces here, please.
> ok, will fix in the next version.
> 
> >
> >> >+		return irq;
> >> >+	/* Ignore other errors, since a missing wakeup is non-fatal. */
> >> >+	else if (irq < 0) {
> >> >+		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);
> >> >+		return 0;
> >> >+	}
> >> >+
> >> >+	device_init_wakeup(&pdev->dev, true);
> > Why do you call this before dev_pm_set_dedicated_wake_irq()?
>
> hmmm, i thought so too, but it turns out the dedicated wake irq 
> framework requires device_init_wakeup(dev, true) before attach the wake irq:
> 
> int device_wakeup_attach_irq(struct device *dev,
>                               struct wake_irq *wakeirq)
> {
>          struct wakeup_source *ws;
> 
>          ws = dev->power.wakeup;
>          if (!ws) {
>                  dev_err(dev, "forgot to call device_init_wakeup?\n");
>                  return -EINVAL;
> 

Well, that's a framework issue, fair enough.

That said, what if user space removes the wakeup source from under you
concurrently via sysfs?  Tony?

Thanks,
Rafael
