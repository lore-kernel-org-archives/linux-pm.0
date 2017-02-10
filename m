From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Fri, 10 Feb 2017 12:51:26 +0100
Message-ID: <d299ae6c-78dc-9049-6bed-dc84fff17db3@samsung.com>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
 <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
 <20170210045004.GN19244@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:26819 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbdBJLvd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 06:51:33 -0500
In-reply-to: <20170210045004.GN19244@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>

Hi Vinod,

On 2017-02-10 05:50, Vinod Koul wrote:
> On Thu, Feb 09, 2017 at 03:22:51PM +0100, Marek Szyprowski wrote:
>
>> +static int pl330_set_slave(struct dma_chan *chan, struct device *slave)
>> +{
>> +	struct dma_pl330_chan *pch = to_pchan(chan);
>> +	struct pl330_dmac *pl330 = pch->dmac;
>> +	int i;
>> +
>> +	mutex_lock(&pl330->rpm_lock);
>> +
>> +	for (i = 0; i < pl330->num_peripherals; i++) {
>> +		if (pl330->peripherals[i].chan.slave == slave &&
>> +		    pl330->peripherals[i].slave_link) {
>> +			pch->slave_link = pl330->peripherals[i].slave_link;
>> +			goto done;
>> +		}
>> +	}
>> +
>> +	pch->slave_link = device_link_add(slave, pl330->ddma.dev,
>> +				       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> So you are going to add the link on channel allocation and tear down on the
> freeup.

Right. Channel allocation is typically done once per driver operation and it
won't hurt system performance.

>   I am not sure I really like the idea here.

Could you point what's wrong with it?

> First, these thing shouldn't be handled in the drivers. These things should
> be set in core and each driver setting the links doesn't sound great to me.

Which core? And what's wrong with the device links? They have been 
introduced to
model relations between devices that are behind the usual parent/child/bus
topology.

> Second, should the link be always there and we only mange the state? Here it
> seems that we have link being created and destroyed, so why not mark it
> ACTIVE and DORMANT instead...

Link state is managed by device core and should not be touched by the 
drivers.
It is related to both provider and consumer drivers states (probed/not 
probed/etc).

Second we would need to create those links first. The question is where to
create them then.

> Lastly, looking at th description of the issue here, am perceiving (maybe my
> understanding is not quite right here) that you have an IP block in SoC
> which has multiple things and share common stuff and doing right PM is a
> challenge for you, right?

Nope. Doing right PM in my SoC is not that complex and I would say it is 
rather
typical for any embedded stuff. It works fine (in terms of the power
consumption reduction) when all drivers simply properly manage their runtime
PM state, thus if device is not in use, the state is set to suspended and
finally, the power domain gets turned off.

I've used device links for PM only because the current DMA engine API is
simply insufficient to implement it in the other way.

I want to let a power domain, which contains a few devices, among those 
a PL330
device, to get turned off when there is no activity. Handling power 
domain power
on / off requires non-atomic context, what is typical for runtime pm 
calls. For
that I need to have non-irq-safe runtime pm implemented for all devices that
belongs to that domains.

The problem with PL330 driver is that it use irq-safe runtime pm, which 
like it
was stated in the patch description doesn't bring much benefits. To 
switch to
standard (non-irq-safe) runtime pm, the pm_runtime calls have to be done 
from
a context which permits sleeping. The problem with DMA engine driver API 
is that
most of its callbacks have to be IRQ-safe and frankly only
device_{alloc,release}_chan_resources() what more or less maps to
dma_request_chan()/dma_release_channel() and friends. There are DMA engine
drivers which do runtime PM calls there (tegra20-apb-dma, sirf-dma, cppi41,
rcar-dmac), but this is not really efficient. DMA engine clients usually 
allocate
dma channel during their probe() and keep them for the whole driver 
life. In turn
this very similar to calling pm_runtime_get() in the DMA engine driver 
probe().
The result of both approaches is that DMA engine device keeps its power 
domain
enabled almost all the time. This problem is also mentioned in the DMA 
engine
TODO list, you have pointed me yesterday.

To avoid such situation that DMA engine driver blocks turning off the power
domain and avoid changing DMA engine client API I came up with the 
device links
pm based approach. I don't want to duplicate the description here, the 
details
were in the patch description, however if you have any particular 
question about
the details, let me know and I will try to clarify it more.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

