From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 2/4] dmaengine: Forward slave device
 pointer to of_xlate callback
Date: Thu, 9 Feb 2017 09:41:23 +0530
Message-ID: <20170209041123.GK19244@localhost>
References: <1485340088-25481-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125102824eucas1p1cf027184286131ff628eb7113c3f9e60@eucas1p1.samsung.com>
 <1485340088-25481-3-git-send-email-m.szyprowski@samsung.com>
 <26397455-1237-2a66-acf8-215aacc7c9ce@metafoo.de>
 <49c9c23d-ff0a-268a-5edd-931e04eb98b5@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <49c9c23d-ff0a-268a-5edd-931e04eb98b5@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 26, 2017 at 03:43:05PM +0100, Marek Szyprowski wrote:
> Hi Lars,
> 
> On 2017-01-25 14:12, Lars-Peter Clausen wrote:
> >On 01/25/2017 11:28 AM, Marek Szyprowski wrote:
> >>Add pointer to slave device to of_dma_xlate to let DMA engine driver
> >>to know which slave device is using given DMA channel. This will be
> >>later used to implement non-irq-safe runtime PM for DMA engine driver.
> >of_dma_xlate() is used to translate from a OF phandle and a specifier to a
> >DMA channel. On one hand this does not necessarily mean that the channel is
> >actually going to be used by the slave that called the xlate function.
> >Modifying the driver state when a lookup of the channel is done is a
> >layering violation. And this approach is also missing a way to disassociate
> >a slave from a DMA channel, e.g. when it is no longer used.
> >
> >On the other hand there are other mechanisms to translate between some kind
> >of firmware handle to a DMA channel which are completely ignored here.
> >
> >So this approach does not work. This is something that needs to be done at
> >the dmaengine level, not a the firmware resource translation level. And it
> >needs a matching method that is called when the channel is disassociated
> >from a device, when the device no longer uses the DMA channel.
> 
> Frankly I agree that of_dma_xlate() should only return the requested channel
> to the dmaengine core and do not do any modification in the the
> driver state.

True..

> However the current dma engine design and implementation breaks this rule.
> Please check the drivers - how do they implement of_xlate callback. They
> usually call dma_get_any_slave_channel, dma_get_slave_channel or
> __dma_request_channel there, which in turn calls dma_chan_get, which then
> calls back to device_alloc_chan_resources callback. Some of the drivers also
> do a hardware configuration or other resource allocation in of_xlate.
> This is a bit messy design and leave no place in the core to set
> slave device
> before device_alloc_chan_resources callback, where one would expect to have
> it already set.

We shouldn't be doing much at this stage. We operate on a channel, so the
channel is returned to the client. We need to do these HW configurations
when the channel has to be prepred for a txn.

> The best place to add new calls to the dmaengine drivers to set slave device
> would be just before device_alloc_chan_resources(), what in turn means that
> the current dmaengine core should do in dma_chan_get(). This would
> require to
> forward the slave device pointer via even more layers including the of_xlate
> callback too. IMHO this is not worth the effort.
> 
> DMA engine core and API definitely needs some cleanup. During such cleanup
> the slave device pointer might be moved out of xlate into separate callback
> when the core gets ready for such operation.

Yes agreed on that, plus the runtime handling needs to be built in, right
now the APIs dont work well with it, we disucssed these during the KS and
this goes without saying, patches are welcome :)

> I ignored other paths for other firmware handle to a DMA channel translation
> mechanism because for the current pl330 driver they are simply not used. I
> assume that if one needs to implement similar things for drivers relying on
> them, he will update the respective DMA engine core parts.
> 
> Slave device assignments can be cleared in device_chan_release_resources if
> this is needed and that what existing DMA engine drivers do with the
> resources
> allocated in the of_xlate callback...

-- 
~Vinod
