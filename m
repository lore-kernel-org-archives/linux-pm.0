From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH v12 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Date: Thu, 28 Dec 2017 10:47:24 +0200
Message-ID: <1514450844.7000.305.camel@linux.intel.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
         <20171226023646.17722-5-jeffy.chen@rock-chips.com>
         <20171226235607.4rgp4ebrrktt6d56@rob-hp-laptop>
         <5A42F847.5060305@rock-chips.com>
         <CAL_JsqJssPABjoRM-XAnuN_Xd2-sHoFifJNrRDdk_ruQ0DRw6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqJssPABjoRM-XAnuN_Xd2-sHoFifJNrRDdk_ruQ0DRw6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-12-27 at 09:30 -0600, Rob Herring wrote:
> On Tue, Dec 26, 2017 at 7:32 PM, JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> wrote:

> this new file does something similar to the pci-acpi.c and pci-mid.c..

> pci-acpi.c has similar things to pci/of.c. The naming is just not
> consistent.

> > and i am agree the naming is not clear, maybe we can rename both of
> > those
> > files to something like pci-pm-***.c?
> 
> At least pci-acpi.c is more than just PM functions, so that doesn't
> make sense. Given that all the ACPI related functions are in 1 file,
> we should do the same for DT.

> > but i have no idea about pci-mid.c or would it possible to have more
> > platform pm ops in the future...maybe we should add some dependency
> > in the
> > Kconfig?

You may consider pci-mid.c as pci-sfi.c to some extend.

So, in that sense it more looks like pci-of.c would be the name for DT
case.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
