From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v12 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Date: Thu, 28 Dec 2017 01:32:25 +0100
Message-ID: <CAJZ5v0gVW12=10JfcQeOD+s6S1GqkF7KFz3k1rp3Up3dJDgaBg@mail.gmail.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
 <20171226023646.17722-5-jeffy.chen@rock-chips.com> <20171226235607.4rgp4ebrrktt6d56@rob-hp-laptop>
 <5A42F847.5060305@rock-chips.com> <CAL_JsqJssPABjoRM-XAnuN_Xd2-sHoFifJNrRDdk_ruQ0DRw6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqJssPABjoRM-XAnuN_Xd2-sHoFifJNrRDdk_ruQ0DRw6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 27, 2017 at 4:30 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Dec 26, 2017 at 7:32 PM, JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> Hi Rob,
>>
>> Thanks for your reply.
>>
>> On 12/27/2017 07:56 AM, Rob Herring wrote:
>>>>
>>>> >
>>>> >  drivers/of/of_pci_irq.c  | 49 +++++++++++++++++++++++++++++++
>>>
>>> Please move this to drivers/pci/of.c (or perhaps create pci/of_irq.c).
>>>
>>>> >  drivers/pci/Makefile     |  1 +
>>>> >  drivers/pci/pci-driver.c | 10 +++++++
>>>> >  drivers/pci/pci-of.c     | 75
>>>> > ++++++++++++++++++++++++++++++++++++++++++++++++
>>>
>>> We already have drivers/pci/of.c. It's not clear what the difference is
>>> from the filenames. Either merge with of.c or perhaps of-pm.c.
>>
>>
>> this new file does something similar to the pci-acpi.c and pci-mid.c..
>
> pci-acpi.c has similar things to pci/of.c. The naming is just not consistent.
>
> Also, I plan to move the rest of drivers/of/of_pci* to drivers/pci.
>
>> and i am agree the naming is not clear, maybe we can rename both of those
>> files to something like pci-pm-***.c?
>
> At least pci-acpi.c is more than just PM functions, so that doesn't
> make sense. Given that all the ACPI related functions are in 1 file,
> we should do the same for DT.

Agreed.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
