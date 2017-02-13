From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime
 PM
Date: Mon, 13 Feb 2017 18:02:35 +0530
Message-ID: <20170213123235.GM2843@localhost>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
 <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
 <20170210045004.GN19244@localhost>
 <d299ae6c-78dc-9049-6bed-dc84fff17db3@samsung.com>
 <CAPDyKFqW2av1mjDvRP=R1my2kepeX69TS6cchzoHmwaoydT5Sg@mail.gmail.com>
 <20170213020340.GH2843@localhost>
 <CAPDyKFpt9O8GM-7xeNJ8bF0JqUJ7nPaRmmC+aMVsdMH-yWBCNg@mail.gmail.com>
 <d6f67b70-92f2-7e9a-7082-ecca3d6b392b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:23579 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbdBMMcC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Feb 2017 07:32:02 -0500
Content-Disposition: inline
In-Reply-To: <d6f67b70-92f2-7e9a-7082-ecca3d6b392b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>

On Mon, Feb 13, 2017 at 01:15:27PM +0100, Marek Szyprowski wrote:

> >Although, I don't know of other examples, besides the runtime PM use
> >case, where non-atomic channel prepare/unprepare would make sense. Do
> >you?
> 
> Changing GFP_ATOMIC to GFP_KERNEL in some calls in the DMA engine drivers
> would be also a nice present for the memory management subsystem if there
> is no real reason to drain atomic pools.

The reason for the calls being atomic is that they will be invoked from
atomic context. All prepare callbacks, submit, issue_pending are in that context.
You have to be mindful that we can prepare and issue next txn from dmaengine
callback which is a tasklet.

> >>As I said earlier, if we want to solve that problem a better idea is to
> >>actually split the prepare as we discussed in [1]
> >>
> >>This way we can get a non atomic descriptor allocate/prepare and release.
> >>Yes we need to redesign the APIs to solve this, but if you guys are up for
> >>it, I think we can do it and avoid any further round abouts :)
> >Adding/re-designing dma APIs is a viable option to solve the runtime PM case.
> >
> >Changes would be needed for all related dma client drivers as well,
> >although if that's what we need to do - let's do it.
> >
> >[...]
> >
> >>>So besides solving the irq-safe issue for dma driver, using the
> >>>device-links has additionally two advantages. I already mentioned the
> >>>-EPROBE_DEFER issue above.
> >>>
> >>>The second thing, is the runtime/system PM relations we get for free
> >>>by using the links. In other words, the dma driver/core don't need to
> >>>care about dealing with pm_runtime_get|put() as that would be managed
> >>>by the dma client driver.
> >>Yeah sorry took me a while to figure that out :), If we do a different API
> >>then dmaengine core can call pm_runtime_get|put() from non-atomic context.
> >Yes, it can and this works from runtime PM point of view. But the
> >following issues would remain unsolved.
> >
> >1)
> >Dependencies between dma drivers and dma client drivers during system
> >PM. For example, a dma client driver needs the dma controller to be
> >operational (remain system resumed), until the dma client driver
> >itself becomes system suspended.
> >
> >The *only* currently available solution for this, is to try to system
> >suspend the dma controller later than the dma client, via using the
> >*late or the *noirq system PM callbacks. This works for most cases,
> >but it becomes a problem when the dma client also needs to be system
> >suspended at the *late or the *noirq phase. Clearly this solution that
> >doesn't scale.
> >
> >Using device links explicitly solves this problem as it allows to
> >specify this dependency between devices.
> 
> Frankly, then creating device links has to be added to EVERY subsystem,
> which involves getting access to the resources provided by the other
> device. More or less this will apply to all kernel frameworks, which
> provide kind of ABC_get_XYZ(dev, ...) functions (like clk_get, phy_get,
> dma_chan_get, ...). Sounds like a topic for another loooong discussion.

Yeah, that was my view too :-)

> >2)
> >We won't avoid dma clients from getting -EPROBE_DEFER when requesting
> >their dma channels in their ->probe() routines. This would be
> >possible, if we can set up the device links at device initialization.
> 
> The question is which core (DMA engine?, kernel device subsystem?) and
> how to find all clients before they call dma_chan_get().

Thanks
-- 
~Vinod
