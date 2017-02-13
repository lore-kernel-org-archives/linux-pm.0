From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Mon, 13 Feb 2017 12:45:23 +0100
Message-ID: <cbccef67-54da-27ce-d0c0-ac57ef251b9b@samsung.com>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
 <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
 <20170210045004.GN19244@localhost>
 <d299ae6c-78dc-9049-6bed-dc84fff17db3@samsung.com>
 <CAPDyKFqW2av1mjDvRP=R1my2kepeX69TS6cchzoHmwaoydT5Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:9582 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbdBMLpa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2017 06:45:30 -0500
In-reply-to: <CAPDyKFqW2av1mjDvRP=R1my2kepeX69TS6cchzoHmwaoydT5Sg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Vinod Koul <vinod.koul@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>

Hi Ulf,

On 2017-02-10 14:57, Ulf Hansson wrote:
> On 10 February 2017 at 12:51, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 2017-02-10 05:50, Vinod Koul wrote:
>>> On Thu, Feb 09, 2017 at 03:22:51PM +0100, Marek Szyprowski wrote:
>>>> +static int pl330_set_slave(struct dma_chan *chan, struct device *slave)
>>>> +{
>>>> +       struct dma_pl330_chan *pch = to_pchan(chan);
>>>> +       struct pl330_dmac *pl330 = pch->dmac;
>>>> +       int i;
>>>> +
>>>> +       mutex_lock(&pl330->rpm_lock);
>>>> +
>>>> +       for (i = 0; i < pl330->num_peripherals; i++) {
>>>> +               if (pl330->peripherals[i].chan.slave == slave &&
>>>> +                   pl330->peripherals[i].slave_link) {
>>>> +                       pch->slave_link =
>>>> pl330->peripherals[i].slave_link;
>>>> +                       goto done;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       pch->slave_link = device_link_add(slave, pl330->ddma.dev,
>>>> +                                      DL_FLAG_PM_RUNTIME |
>>>> DL_FLAG_RPM_ACTIVE);
>>> So you are going to add the link on channel allocation and tear down on
>>> the
>>> freeup.
>>
>> Right. Channel allocation is typically done once per driver operation and it
>> won't hurt system performance.
>>
>>>    I am not sure I really like the idea here.
>>
>> Could you point what's wrong with it?
>>
>>> First, these thing shouldn't be handled in the drivers. These things
>>> should
>>> be set in core and each driver setting the links doesn't sound great to
>>> me.
>>
>> Which core? And what's wrong with the device links? They have been
>> introduced to
>> model relations between devices that are behind the usual parent/child/bus
>> topology.
> I think Vinod mean the dmaengine core. Which also would make perfect
> sense to me as it would benefit all dma drivers.
>
> The only related PM thing, that shall be the decision of the driver,
> is whether it wants to enable runtime PM or not, during ->probe().

So do you want to create the links during the DMAengine driver probe? 
How do you
plan to find all the client devices? Please note that you really want to 
create
links to devices which will really use the DMA engine calls. Some client
drivers might decide in runtime weather to use DMA engine or not, 
depending on
other data.

>>> Second, should the link be always there and we only mange the state? Here
>>> it
>>> seems that we have link being created and destroyed, so why not mark it
>>> ACTIVE and DORMANT instead...
>>
>> Link state is managed by device core and should not be touched by the
>> drivers.
>> It is related to both provider and consumer drivers states (probed/not
>> probed/etc).
>>
>> Second we would need to create those links first. The question is where to
>> create them then.
> Just to fill in, to me this is really also the key question.
>
> If we could set up the device link already at device initialization,
> it should also be possible to avoid getting -EPROBE_DEFER for dma
> client drivers when requesting their dma channels.

At the first glance this sounds like an ultimate solution for all problems,
but I don't think that device links can be used this way. If I get it right,
you would like to create links on client device initialization, preferably
somewhere in the kernel driver core. This will be handled somehow by a
completely generic code, which will create a link each pair of devices,
which are connected by a phandle. Is this what you meant? Please note that
that time no driver for both client and provider are probed. IMHO that
doesn't look like a right generic approach

How that code will know get following information:
1. is it really needed to create a link for given device pair?
2. what link flags should it use?
3. what about circular dependencies?
4. what about runtime optional dependencies?
5. what about non-dt platforms? acpi?

This looks like another newer ending story of "how can we avoid deferred 
probe
in a generic way". IMHO we should first solve the problem of irq-safe 
runtime
PM in DMA engine drivers first. I proposed how it can be done with 
device links.
With no changes in the client API. Later if one decide to extend the 
client API
in a way it will allow other runtime PM implementation - I see no problem to
convert pl330 driver to the new approach, but for the time being - this 
would
be the easiest way to get it really functional.

>>> Lastly, looking at th description of the issue here, am perceiving (maybe
>>> my
>>> understanding is not quite right here) that you have an IP block in SoC
>>> which has multiple things and share common stuff and doing right PM is a
>>> challenge for you, right?
>>
>> Nope. Doing right PM in my SoC is not that complex and I would say it is
>> rather
>> typical for any embedded stuff. It works fine (in terms of the power
>> consumption reduction) when all drivers simply properly manage their runtime
>> PM state, thus if device is not in use, the state is set to suspended and
>> finally, the power domain gets turned off.
>>
>> I've used device links for PM only because the current DMA engine API is
>> simply insufficient to implement it in the other way.
>>
>> I want to let a power domain, which contains a few devices, among those a
>> PL330
>> device, to get turned off when there is no activity. Handling power domain
>> power
>> on / off requires non-atomic context, what is typical for runtime pm calls.
>> For
>> that I need to have non-irq-safe runtime pm implemented for all devices that
>> belongs to that domains.
> Again, allow me to fill in. This issue exists for all ARM SoC which
> has a dma controller residing in a PM domain. I think that is quite
> many.
>
> Currently the only solution I have seen for this problem, but which I
> really dislike. That is, each dma client driver requests/releases
> their dma channel from their respective ->runtime_suspend|resume()
> callbacks - then the dma driver can use the dma request/release hooks,
> to do pm_runtime_get|put() which then becomes non-irq-safe.
>
>> The problem with PL330 driver is that it use irq-safe runtime pm, which like
>> it
>> was stated in the patch description doesn't bring much benefits. To switch
>> to
>> standard (non-irq-safe) runtime pm, the pm_runtime calls have to be done
>> from
>> a context which permits sleeping. The problem with DMA engine driver API is
>> that
>> most of its callbacks have to be IRQ-safe and frankly only
>> device_{alloc,release}_chan_resources() what more or less maps to
>> dma_request_chan()/dma_release_channel() and friends. There are DMA engine
>> drivers which do runtime PM calls there (tegra20-apb-dma, sirf-dma, cppi41,
>> rcar-dmac), but this is not really efficient. DMA engine clients usually
>> allocate
>> dma channel during their probe() and keep them for the whole driver life. In
>> turn
>> this very similar to calling pm_runtime_get() in the DMA engine driver
>> probe().
>> The result of both approaches is that DMA engine device keeps its power
>> domain
>> enabled almost all the time. This problem is also mentioned in the DMA
>> engine
>> TODO list, you have pointed me yesterday.
>>
>> To avoid such situation that DMA engine driver blocks turning off the power
>> domain and avoid changing DMA engine client API I came up with the device
>> links
>> pm based approach. I don't want to duplicate the description here, the
>> details
>> were in the patch description, however if you have any particular question
>> about
>> the details, let me know and I will try to clarify it more.
> So besides solving the irq-safe issue for dma driver, using the
> device-links has additionally two advantages. I already mentioned the
> -EPROBE_DEFER issue above.

Not really. IMHO device links can be properly established once both drivers
are probed...

>
> The second thing, is the runtime/system PM relations we get for free
> by using the links. In other words, the dma driver/core don't need to
> care about dealing with pm_runtime_get|put() as that would be managed
> by the dma client driver.

IMHO there might be drivers which don't want to use device links based 
runtime
PM in favor of irq-safe PM or something else. This should be really left to
drivers.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
