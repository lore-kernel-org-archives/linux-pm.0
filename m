From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Wed, 3 May 2017 10:12:20 +0200
Message-ID: <CAPDyKFokVKZfRAsEAB6ihx1FxW4JjarionyOwCATr3s+QW4aMg@mail.gmail.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <CAJZ5v0gMzN_zfC_2nnRtYFyFon3-_mnioQhNbDP0wsr91RnagA@mail.gmail.com>
 <ffe13074-9113-0a20-0fa6-76d0209dadfc@nvidia.com> <1832647.f77WMLkdQb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33736 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdECIMV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 04:12:21 -0400
Received: by mail-qk0-f176.google.com with SMTP id u68so8438612qkd.0
        for <linux-pm@vger.kernel.org>; Wed, 03 May 2017 01:12:21 -0700 (PDT)
In-Reply-To: <1832647.f77WMLkdQb@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

Rafael, Jon,

On 2 May 2017 at 23:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, May 02, 2017 11:10:29 AM Jon Hunter wrote:
>>
>> On 25/04/17 22:17, Rafael J. Wysocki wrote:
>> > On Tue, Apr 25, 2017 at 9:34 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >> On 25 April 2017 at 13:13, Jon Hunter <jonathanh@nvidia.com> wrote:
>> >>>
>> >>> On 28/03/17 15:13, Jon Hunter wrote:
>> >>>> The current generic PM domain framework (GenDP) only allows a single
>> >>>> PM domain to be associated with a given device. There are several
>> >>>> use-cases for various system-on-chip devices where it is necessary for
>> >>>> a PM domain consumer to control more than one PM domain where the PM
>> >>>> domains:
>> >>>> i).  Do not conform to a parent-child relationship so are not nested
>> >>>> ii). May not be powered on and off at the same time so need independent
>> >>>>      control.
>> >>>>
>> >>>> The solution proposed in this RFC is to allow consumers to explictly
>> >>>> control PM domains, by getting a handle to a PM domain and explicitly
>> >>>> making calls to power on and off the PM domain. Note that referencing
>> >>>> counting is used to ensure that a PM domain shared between consumers
>> >>>> is not powered off incorrectly.
>> >>>>
>> >>>> The Tegra124/210 XUSB subsystem (that consists of both host and device
>> >>>> controllers) is an example of a consumer that needs to control more than
>> >>>> one PM domain because the logic is partitioned across 3 PM domains which
>> >>>> are:
>> >>>> - XUSBA: Superspeed logic (for USB 3.0)
>> >>>> - XUSBB: Device controller
>> >>>> - XUSBC: Host controller
>> >>>>
>> >>>> These power domains are not nested and can be powered-up and down
>> >>>> independently of one another. In practice different scenarios require
>> >>>> different combinations of the power domains, for example:
>> >>>> - Superspeed host: XUSBA and XUSBC
>> >>>> - Superspeed device: XUSBA and XUSBB
>> >>>>
>> >>>> Although it could be possible to logically nest both the XUSBB and XUSBC
>> >>>> domains under the XUSBA, superspeed may not always be used/required and
>> >>>> so this would keep it on unnecessarily.
>> >>>>
>> >>>> Given that Tegra uses device-tree for describing the hardware, it would
>> >>>> be ideal that the device-tree 'power-domains' property for generic PM
>> >>>> domains could be extended to allow more than one PM domain to be
>> >>>> specified. For example, define the following the Tegra210 xHCI device ...
>> >>>>
>> >>>>       usb@70090000 {
>> >>>>               compatible = "nvidia,tegra210-xusb";
>> >>>>               ...
>> >>>>               power-domains = <&pd_xusbhost>, <&pd_xusbss>;
>> >>>>               power-domain-names = "host", "superspeed";
>> >>>>       };
>> >>>>
>> >>>> This RFC extends the generic PM domain framework to allow a device to
>> >>>> define more than one PM domain in the device-tree 'power-domains'
>> >>>> property. If there is more than one then the assumption is that these
>> >>>> PM domains will be controlled explicitly by the consumer and the device
>> >>>> will not be automatically bound to any PM domain.
>> >>>
>> >>> Any more comments/inputs on this? I can address Rajendra's feedback, but
>> >>> before I did I wanted to see if this is along the right lines or not?
>> >>
>> >> I discussed this with Rafael at the OSPM summit in Pisa a couple of
>> >> weeks ago. Apologize for the delay in providing additional feedback.
>> >>
>> >> First, whether the problem is really rare, perhaps adding a new
>> >> API/framework can't be justified - then it may be better to add some
>> >> kind of aggregation layer on top of the current PM domain
>> >> infrastructure (something along the first attempt you made for genpd).
>> >> That was kind of Rafael's thoughts (Rafael, please correct me if I am
>> >> wrong).
>> >
>> > We were talking about the original idea behind the pm_domain pointer
>> > concept, which was about adding a set of PM operations above the bus
>> > type/class layer, which could be used for intercepting bus-type PM
>> > operations and providing some common handling above them.  This is
>> > still relevant IMO.
>> >
>> > The basic observation here is that the PM core takes only one set of
>> > PM operation per device into account and therefore, in every stage of
>> > system suspend, for example, the callback invoked by it has to take
>> > care of all actions that need to be carried out for the given device,
>> > possibly by invoking callbacks from other code layers.  That
>> > limitation cannot be removed easily, because it is built into the PM
>> > core design quite fundamentally.
>> >
>> > However, this series seems to be about controlling power resources
>> > represented by power domain objects rather than about PM operations.
>> > In ACPI there is a power resource concept which seems to be quite
>> > similar to this, so it is not entirely new. :-)
>> >
>> > Of course, question is whether or not to extend genpd this way and I'm
>> > not really sure.  I actually probably wouldn't do that, because
>> > poweron/poweroff operations used by genpd can be implemeted in terms
>> > of lower-level power resource control and I don't see the reason for
>> > mixing the two in one framework.
>>
>> That seems fine to me. However, it seems that genpd itself should also
>> be a client of this 'low-level power resource control' so that
>> power-domains are registered once and can be used by either method.
>
> Right.
>
>> So unless I am misunderstanding you here, it seems that what we need to do
>> is split the current genpd framework into a couple layers:
>>
>> 1. Low-level power resource control which has:
>> - Power resource registration (ie. pm_genpd_init/remove())
>> - Power resource provider registration (ie. of_genpd_add_xxx())
>> - Power resource control (on/off etc)
>
> And reference counting.
>
>> - Power resource lookup (what this series is adding)
>>
>> 2. Generic power-domain infrastructure which is a client of the
>> low-level power resource control that can automatically bind a device to
>> a singular power resource entity (ie. power-domain).
>
> Something like that, but I would not require an additional complex framework
> to be present below genpd.  I would make it *possible* for genpd to use that
> framework if available, but if something simpler is sufficient, it should be
> fine to use that instead.
>
> That is, I would allow genpd to use either a list of power resources or the on/off
> callbacks provided by itself to cover different use cases.  That should be
> flexible enough.
>
>> Is this along the right lines?
>
> It is, at least for the very narrow definition of "right" as being done along
> the lines I would do that. :-)

Let me first give some more background to how it looks like today.

We have the following device callbacks being used by genpd:

struct gpd_dev_ops {
        int (*start)(struct device *dev);
        int (*stop)(struct device *dev);
        bool (*active_wakeup)(struct device *dev);
};

The ->stop|start() callback is invoked from genpd's
->runtime_suspend|resume() callbacks and may be assigned by a genpd
client before it registers a genpd though pm_genpd_init(). Typically
these callbacks can control any "power resources" that the genpd
client finds suitable.

To allow clients to instantiate "power resources" per device, we have
the following callbacks, part of the struct generic_pm_domain.

int (*attach_dev)(struct generic_pm_domain *domain, struct device *dev);
void (*detach_dev)(struct generic_pm_domain *domain, struct device *dev);

These callbacks are invoked when the device gets attached/detached
from its PM domain (genpd).

Moreover, the struct dev_pm_get_subsys_data is being used from within
genpd (via struct pm_domain_data *domain_data), as it allows genpd and
its client, to allocate and associate device specific data, which may
be needed to store information about the "power resources".

Currently Renesas SoCs are a good example of how to deploy this, as it
implements its clock PM domain on top of this. In this regards I
assume that we could consider the pm_clk_*() APIs as in control of the
"power resources".

So my conclusion is; unless I am totally misunderstanding the ideas
here; I think we already have the infrastructure in place and we also
have some good references of how to use it.

What is missing, is how a call to pm_runtime_get_sync() by a driver,
can inform the ->start() callback about what exact power resource(s)
it shall turn on, because it may not always be all of them. Similar
problem exists for pm_runtime_put().

Kind regards
Uffe
