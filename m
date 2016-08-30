From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] soc: ti: Add ti_sci_pm_domains driver
Date: Tue, 30 Aug 2016 22:26:47 +0200
Message-ID: <CAPDyKFqszM48nXnnA9D8iCp34k-ZmNvOkHPCc=Fya4nJA7PvBQ@mail.gmail.com>
References: <20160819235653.26355-1-nm@ti.com> <20160819235653.26355-4-nm@ti.com>
 <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ@mail.gmail.com>
 <57C0D2C9.1030801@ti.com> <57C5E1DA.2040405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34329 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbcH3U0u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 16:26:50 -0400
Received: by mail-wm0-f46.google.com with SMTP id l4so973006wml.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2016 13:26:49 -0700 (PDT)
In-Reply-To: <57C5E1DA.2040405@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>

On 30 August 2016 at 21:43, Dave Gerlach <d-gerlach@ti.com> wrote:
> Jon, Ulf,
>
> On 08/26/2016 06:37 PM, Dave Gerlach wrote:
>>
>> Hi,
>> On 08/25/2016 02:27 AM, Ulf Hansson wrote:
>>>
>>> + Jon
>>>
>>> [...]
>>>
>>>> +
>>>> +static int ti_sci_pm_domains_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct device *dev = &pdev->dev;
>>>> +       struct device_node *np = dev->of_node;
>>>> +       struct ti_sci_genpd_data *ti_sci_genpd;
>>>> +
>>>> +       ti_sci_genpd = devm_kzalloc(dev, sizeof(*ti_sci_genpd),
>>>> GFP_KERNEL);
>>>> +       if (!ti_sci_genpd)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       ti_sci_genpd->ti_sci = devm_ti_sci_get_handle(dev);
>>>> +       if (IS_ERR(ti_sci_genpd->ti_sci))
>>>> +               return PTR_ERR(ti_sci_genpd->ti_sci);
>>>> +
>>>> +       ti_sci_genpd->dev = dev;
>>>> +
>>>> +       INIT_LIST_HEAD(&ti_sci_genpd->pd_list);
>>>> +       mutex_init(&ti_sci_genpd->pd_list_mutex);
>>>> +
>>>> +       return __of_genpd_add_provider(np,
>>>> of_ti_sci_genpd_xlate_onecell,
>>>> +                                      ti_sci_genpd);
>>>
>>>
>>> Jon Hunter are working on adding robust method to be able to remove
>>> initialized genpds [1].
>>>
>>> In that series we intend to remove the __of_genpd_add_provider() API,
>>> and instead only have of_genpd_add_provider_onecell() and
>>> of_genpd_add_provider_simple(). Could you please convert to use any of
>>> these APIs instead?
>>
>>
>> Thanks for pointing this out. I took at look at the series you've linked
>> and the
>> short answer is that I see no good way to directly convert what we've done
>> to
>> use those APIs.
>>
>> On this platform each device has it's power state controlled through the
>> SCI
>> protocol described in the cover letter. The system makes a request for
>> powering
>> on or off the device using a unique ID number for each device, as provided
>> in
>> patches 1 and 2. These operations map to those of a genpd, so we decided
>> to do a
>> 1:1 device to genpd mapping, where each device has it's own genpd.
>>
>> The split that we took from the provided simple and onecell xlate
>> functions
>> arises from this mapping. The IDs are not necessarily linear and also they
>> are
>> not necessarily defined in a fixed way for all SoCs, they are entirely
>> data
>> driven based on the provided device ID. To make use of these IDs, I
>> created a
>> new xlate function that takes a onecell value but instead dynamically
>> allocates
>> a new genpd, at probe time, to give us a genpd that contains the necessary
>> SoC
>> specific data for that device that probed and is mapped directly to the
>> device.
>> This lets us only create the genpds we need without having to redefine a
>> static
>> list of all possible genpds and duplicate the data.
>>
>> So my question back would be, how critical is it to be able to drop the
>> ability
>> to provide custom xlate functions?
>
>
> After thinking about this a bit more, I believe I see a way we can use the
> of_genpd_add_provider_onecell, although not optimally. The device IDs, and
> therefore the genpd IDs (in the last email I mentioned we are doing a 1:1
> device to genpd mapping) are fixed and defined by the hardware, and are not
> linear, there can be gaps and we won't necessarily always start at 0 even
> though we do on this SoC. However, we could build an array of genpds that
> map to our IDs similar to how several have done it, like in
> drivers/soc/bcm/raspberrypi-power.c, but because our IDs can have gaps,
> there will be unused struct generic_pm_domains that get allocated and are
> never touched because the index of the element doesn't correspond to a genpd
> ID.

There are a couple of ways to solve your problem without having to
create one genpd instance for each of the platform devices. As a
matter of fact, I think that approach should be avoided if possible.
Genpd isn't designed for these kind purposes, even if it can be done
like that.

Here are some ideas which could be used to solve the problem differently.

*)
Assuming each platform device has a driver for it!?
Then why don't you implement the ->runtime_suspend|resume() callbacks
on the driver level and call the SCI interface to power on/off the
device from there? This ought to be the most straight forward
solution.


**)
You may also use genpd's (struct generic_pm_domain)
->attach|detach_dev() callbacks to create the device specific data
(the SCI device ID). The ->attach_dev() callback are invoked when a
device gets attached to its PM domain (genpd) at probe time.

Currently these callbacks are already being used by SoCs that uses the
PM clk API from a genpd client. That is needed to create the device
specific PM clock list. We would have to do something similar here for
the SCI device IDs.

Then, you must also assign/implement the ->start() and ->stop()
callbacks of the struct gpd_dev_ops, which is a part of the genpd
struct. These callbacks can then easily invoke SoC specific code/APIs
and perhaps that is the issue with my first suggested approach!?

>
> Based on the ID set provided in patch 2 of this series I see 12 gaps, so
> we'd be wasting space the size of 12 genpds. The ID mapping will change on
> future SoCs, so this number could be larger. Do you think this is an
> acceptable solution? It allows us to play nice with the new genpd framework
> changes at the cost of wasting some space allocated to filler genpds.

There are other issues as well, which mostly has do to with a
unnecessary long execution path, involving taking mutexes etc in
genpd.

All you actually need, is to be able to power on/off a device from a
driver's ->runtime_suspend|resume() callback. Don't you think?

Kind regards
Uffe
