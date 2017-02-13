From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Mon, 13 Feb 2017 16:09:56 +0100
Message-ID: <CAPDyKFr6qB7j23E2pVqkBn8OWRZkwE_Diex8ttPiyPWZrruFYw@mail.gmail.com>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
 <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
 <20170210045004.GN19244@localhost>
 <d299ae6c-78dc-9049-6bed-dc84fff17db3@samsung.com>
 <CAPDyKFqW2av1mjDvRP=R1my2kepeX69TS6cchzoHmwaoydT5Sg@mail.gmail.com>
 <cbccef67-54da-27ce-d0c0-ac57ef251b9b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cbccef67-54da-27ce-d0c0-ac57ef251b9b@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

[...]

>> The only related PM thing, that shall be the decision of the driver,
>> is whether it wants to enable runtime PM or not, during ->probe().
>
>
> So do you want to create the links during the DMAengine driver probe? How do
> you
> plan to find all the client devices? Please note that you really want to
> create
> links to devices which will really use the DMA engine calls. Some client
> drivers might decide in runtime weather to use DMA engine or not, depending
> on
> other data.

I don't have great plan, just wanted to share my thoughts around the
problems we want to solve.

[...]

>>
>> If we could set up the device link already at device initialization,
>> it should also be possible to avoid getting -EPROBE_DEFER for dma
>> client drivers when requesting their dma channels.
>
>
> At the first glance this sounds like an ultimate solution for all problems,
> but I don't think that device links can be used this way. If I get it right,
> you would like to create links on client device initialization, preferably
> somewhere in the kernel driver core. This will be handled somehow by a
> completely generic code, which will create a link each pair of devices,
> which are connected by a phandle. Is this what you meant? Please note that
> that time no driver for both client and provider are probed. IMHO that
> doesn't look like a right generic approach
>
> How that code will know get following information:
> 1. is it really needed to create a link for given device pair?
> 2. what link flags should it use?
> 3. what about circular dependencies?
> 4. what about runtime optional dependencies?
> 5. what about non-dt platforms? acpi?
>

To give a good answer of these questions, I need to spend more time
investigating.

However, from a top-level point of view, I think the device links
seems like the perfect match for solving the runtime/system PM
problems.

No matter whether we can set up the links at device initialization
time, driver probe or whatever time.

> This looks like another newer ending story of "how can we avoid deferred
> probe
> in a generic way". IMHO we should first solve the problem of irq-safe
> runtime
> PM in DMA engine drivers first. I proposed how it can be done with device
> links.
> With no changes in the client API. Later if one decide to extend the client
> API
> in a way it will allow other runtime PM implementation - I see no problem to
> convert pl330 driver to the new approach, but for the time being - this
> would
> be the easiest way to get it really functional.

Agree, let's drop the deferred probe topic from the discussions - it's
just going to be overwhelming. :-)

[...]

>> So besides solving the irq-safe issue for dma driver, using the
>> device-links has additionally two advantages. I already mentioned the
>> -EPROBE_DEFER issue above.
>
>
> Not really. IMHO device links can be properly established once both drivers
> are probed...

Okay.

>
>>
>> The second thing, is the runtime/system PM relations we get for free
>> by using the links. In other words, the dma driver/core don't need to
>> care about dealing with pm_runtime_get|put() as that would be managed
>> by the dma client driver.
>
>
> IMHO there might be drivers which don't want to use device links based
> runtime
> PM in favor of irq-safe PM or something else. This should be really left to
> drivers.

Okay.

Kind regards
Uffe
