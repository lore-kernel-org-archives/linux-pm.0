From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Tue, 25 Apr 2017 23:17:51 +0200
Message-ID: <CAJZ5v0gMzN_zfC_2nnRtYFyFon3-_mnioQhNbDP0wsr91RnagA@mail.gmail.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <d2e3ceaa-57e2-033d-ecd1-a3b2bd8ffa26@nvidia.com> <CAPDyKFoJ58pwGz2U90ob8a8cY=hEbE-wLBHZ0BBzqPoLW_wgGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoJ58pwGz2U90ob8a8cY=hEbE-wLBHZ0BBzqPoLW_wgGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 25, 2017 at 9:34 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 25 April 2017 at 13:13, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> On 28/03/17 15:13, Jon Hunter wrote:
>>> The current generic PM domain framework (GenDP) only allows a single
>>> PM domain to be associated with a given device. There are several
>>> use-cases for various system-on-chip devices where it is necessary for
>>> a PM domain consumer to control more than one PM domain where the PM
>>> domains:
>>> i).  Do not conform to a parent-child relationship so are not nested
>>> ii). May not be powered on and off at the same time so need independent
>>>      control.
>>>
>>> The solution proposed in this RFC is to allow consumers to explictly
>>> control PM domains, by getting a handle to a PM domain and explicitly
>>> making calls to power on and off the PM domain. Note that referencing
>>> counting is used to ensure that a PM domain shared between consumers
>>> is not powered off incorrectly.
>>>
>>> The Tegra124/210 XUSB subsystem (that consists of both host and device
>>> controllers) is an example of a consumer that needs to control more than
>>> one PM domain because the logic is partitioned across 3 PM domains which
>>> are:
>>> - XUSBA: Superspeed logic (for USB 3.0)
>>> - XUSBB: Device controller
>>> - XUSBC: Host controller
>>>
>>> These power domains are not nested and can be powered-up and down
>>> independently of one another. In practice different scenarios require
>>> different combinations of the power domains, for example:
>>> - Superspeed host: XUSBA and XUSBC
>>> - Superspeed device: XUSBA and XUSBB
>>>
>>> Although it could be possible to logically nest both the XUSBB and XUSBC
>>> domains under the XUSBA, superspeed may not always be used/required and
>>> so this would keep it on unnecessarily.
>>>
>>> Given that Tegra uses device-tree for describing the hardware, it would
>>> be ideal that the device-tree 'power-domains' property for generic PM
>>> domains could be extended to allow more than one PM domain to be
>>> specified. For example, define the following the Tegra210 xHCI device ...
>>>
>>>       usb@70090000 {
>>>               compatible = "nvidia,tegra210-xusb";
>>>               ...
>>>               power-domains = <&pd_xusbhost>, <&pd_xusbss>;
>>>               power-domain-names = "host", "superspeed";
>>>       };
>>>
>>> This RFC extends the generic PM domain framework to allow a device to
>>> define more than one PM domain in the device-tree 'power-domains'
>>> property. If there is more than one then the assumption is that these
>>> PM domains will be controlled explicitly by the consumer and the device
>>> will not be automatically bound to any PM domain.
>>
>> Any more comments/inputs on this? I can address Rajendra's feedback, but
>> before I did I wanted to see if this is along the right lines or not?
>
> I discussed this with Rafael at the OSPM summit in Pisa a couple of
> weeks ago. Apologize for the delay in providing additional feedback.
>
> First, whether the problem is really rare, perhaps adding a new
> API/framework can't be justified - then it may be better to add some
> kind of aggregation layer on top of the current PM domain
> infrastructure (something along the first attempt you made for genpd).
> That was kind of Rafael's thoughts (Rafael, please correct me if I am
> wrong).

We were talking about the original idea behind the pm_domain pointer
concept, which was about adding a set of PM operations above the bus
type/class layer, which could be used for intercepting bus-type PM
operations and providing some common handling above them.  This is
still relevant IMO.

The basic observation here is that the PM core takes only one set of
PM operation per device into account and therefore, in every stage of
system suspend, for example, the callback invoked by it has to take
care of all actions that need to be carried out for the given device,
possibly by invoking callbacks from other code layers.  That
limitation cannot be removed easily, because it is built into the PM
core design quite fundamentally.

However, this series seems to be about controlling power resources
represented by power domain objects rather than about PM operations.
In ACPI there is a power resource concept which seems to be quite
similar to this, so it is not entirely new. :-)

Of course, question is whether or not to extend genpd this way and I'm
not really sure.  I actually probably wouldn't do that, because
poweron/poweroff operations used by genpd can be implemeted in terms
of lower-level power resource control and I don't see the reason for
mixing the two in one framework.

> However, we currently know about at least two different SoCs that need
> this. Perhaps we can extend the below list to justify adding a new
> framework/APIs. Something along the lines what you propose in $subject
> patchset.
>
> 1) Nvidia; to solve the USB super-speed host/device problem.
> 2) QCOM, which has pointed to several cases where the PM topology is
> laid out like devices having two PM domains..
> 3?) I don't fully remember - but I think Geert also pointed to some
> examples where a device could reside in a clock domain but also in
> power domain for a Renesas SoC!?
> 4) ?
>
> Moreover, perhaps this could also be useful for SoCs using ACPI?

No, it couldn't.  At least not in general.

Thanks,
Rafael
