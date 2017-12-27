From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC PATCH v12 1/5] dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
Date: Wed, 27 Dec 2017 01:43:09 +0100
Message-ID: <3268448.IvXk7OJtIY@aspire.rjw.lan>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com> <20171226023646.17722-2-jeffy.chen@rock-chips.com> <20171226233552.nacwqbpkozmy7n6c@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171226233552.nacwqbpkozmy7n6c@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 27, 2017 12:35:52 AM CET Rob Herring wrote:
> On Tue, Dec 26, 2017 at 10:36:42AM +0800, Jeffy Chen wrote:
> > We are going to handle PCIe WAKE# pin for PCI devices in the pci core,
> > so add definitions of the optional PCIe WAKE# pin for PCI devices.
> > 
> > Also add an definition of the optional PCI interrupt pin for PCI
> > devices to distinguish it from the PCIe WAKE# pin.
> 
> By v13 you should drop "RFC". RFC implies not ready for merging.

Which very much still is the case AFAICS.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
