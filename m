From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 2/4] dmaengine: Forward slave device pointer to
 of_xlate callback
Date: Thu, 9 Feb 2017 21:58:47 +0530
Message-ID: <20170209162847.GL19244@localhost>
References: <1485340088-25481-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125102824eucas1p1cf027184286131ff628eb7113c3f9e60@eucas1p1.samsung.com>
 <1485340088-25481-3-git-send-email-m.szyprowski@samsung.com>
 <26397455-1237-2a66-acf8-215aacc7c9ce@metafoo.de>
 <49c9c23d-ff0a-268a-5edd-931e04eb98b5@samsung.com>
 <20170209041123.GK19244@localhost>
 <ded8b3e8-2ef8-218b-fb6d-783825588fd8@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ded8b3e8-2ef8-218b-fb6d-783825588fd8@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 09, 2017 at 10:22:38AM +0100, Marek Szyprowski wrote:
> Hi Vinod,
> 
> On 2017-02-09 05:11, Vinod Koul wrote:
> >On Thu, Jan 26, 2017 at 03:43:05PM +0100, Marek Szyprowski wrote:
> >>On 2017-01-25 14:12, Lars-Peter Clausen wrote:
> >>>On 01/25/2017 11:28 AM, Marek Szyprowski wrote:
> >>>>Add pointer to slave device to of_dma_xlate to let DMA engine driver
> >>>>to know which slave device is using given DMA channel. This will be
> >>>>later used to implement non-irq-safe runtime PM for DMA engine driver.
> >>>of_dma_xlate() is used to translate from a OF phandle and a specifier to a
> >>>DMA channel. On one hand this does not necessarily mean that the channel is
> >>>actually going to be used by the slave that called the xlate function.
> >>>Modifying the driver state when a lookup of the channel is done is a
> >>>layering violation. And this approach is also missing a way to disassociate
> >>>a slave from a DMA channel, e.g. when it is no longer used.
> >>>
> >>>On the other hand there are other mechanisms to translate between some kind
> >>>of firmware handle to a DMA channel which are completely ignored here.
> >>>
> >>>So this approach does not work. This is something that needs to be done at
> >>>the dmaengine level, not a the firmware resource translation level. And it
> >>>needs a matching method that is called when the channel is disassociated
> >>>from a device, when the device no longer uses the DMA channel.
> >>
> >>Frankly I agree that of_dma_xlate() should only return the requested channel
> >>to the dmaengine core and do not do any modification in the the
> >>driver state.
> >True..
> >
> >>However the current dma engine design and implementation breaks this rule.
> >>Please check the drivers - how do they implement of_xlate callback. They
> >>usually call dma_get_any_slave_channel, dma_get_slave_channel or
> >>__dma_request_channel there, which in turn calls dma_chan_get, which then
> >>calls back to device_alloc_chan_resources callback. Some of the drivers also
> >>do a hardware configuration or other resource allocation in of_xlate.
> >>This is a bit messy design and leave no place in the core to set
> >>slave device
> >>before device_alloc_chan_resources callback, where one would expect to have
> >>it already set.
> >We shouldn't be doing much at this stage. We operate on a channel, so the
> >channel is returned to the client. We need to do these HW configurations
> >when the channel has to be prepred for a txn.
> 
> IMHO, any HW configurations should be done in alloc_chan_resources
> callback and
> it would be best if a pointer of slave device will come as a
> parameter to it.

HW configuration is dependent upon the parameters passed, which are not part
of alloc_chan_resources(). Consider it as kind of open() to get a handle for
dmaengine

> 
> >>The best place to add new calls to the dmaengine drivers to set slave device
> >>would be just before device_alloc_chan_resources(), what in turn means that
> >>the current dmaengine core should do in dma_chan_get(). This would
> >>require to
> >>forward the slave device pointer via even more layers including the of_xlate
> >>callback too. IMHO this is not worth the effort.
> >>
> >>DMA engine core and API definitely needs some cleanup. During such cleanup
> >>the slave device pointer might be moved out of xlate into separate callback
> >>when the core gets ready for such operation.
> >Yes agreed on that, plus the runtime handling needs to be built in, right
> >now the APIs dont work well with it, we disucssed these during the KS and
> >this goes without saying, patches are welcome :)
> 
> Okay, so what is the conclusion? Do you want me to do the whole
> rework of dma
> engine core to get this runtime pm patchset for pl330 merged??? Is there any
> roadmap for this rework prepared, so I can at least take a look at
> the amount
> of work needed to be done?
> 
> I'm rather new to dma engine framework and I only wanted to fix pl330 driver
> not to block turning off the power domain on Exynos5422/5433 SoCs.
> 
> I can also check again if there is any other way to find the slave device in
> alloc_chan_resources, like for example scanning the device tree for
> phandles,
> to avoid changing dmaengine core as this turned out to be too problematic
> before one will do the proper dma engine core rework.

There are few things we need to do for making APIs cleaner.

We have a mini discussion during KS/Plumbers, Here are the notes
http://www.spinics.net/lists/dmaengine/msg11570.html

I don't want to block your series for this, I will take a look at v8, first
thing in morning..

Thanks
-- 
~Vinod
