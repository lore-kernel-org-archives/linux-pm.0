From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v6 2/4] dmaengine: Forward slave device pointer to of_xlate
 callback
Date: Wed, 25 Jan 2017 11:13:57 +0100
Message-ID: <40e8364c-660e-6555-2a61-1ea9d66f1172@samsung.com>
References: <CGME20170124092751eucas1p1411586335ad7083f7fff451212e002a3@eucas1p1.samsung.com>
 <1485250055-22137-1-git-send-email-m.szyprowski@samsung.com>
 <1485250055-22137-3-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFp8rRXsnkJ+XR_rV1JotPAJmC8bb9OwC0e0FP=VsrKrvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAPDyKFp8rRXsnkJ+XR_rV1JotPAJmC8bb9OwC0e0FP=VsrKrvg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On 2017-01-24 16:09, Ulf Hansson wrote:
> On 24 January 2017 at 10:27, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Add pointer to slave device to of_dma_xlate to let DMA engine driver
>> to know which slave device is using given DMA channel. This will be
>> later used to implement non-irq-safe runtime PM for DMA engine driver.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> [...]
>
>> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
>> index b90d8ec57c1f..a0a6c8c17669 100644
>> --- a/include/linux/of_dma.h
>> +++ b/include/linux/of_dma.h
>> @@ -22,7 +22,8 @@ struct of_dma {
>>          struct list_head        of_dma_controllers;
>>          struct device_node      *of_node;
>>          struct dma_chan         *(*of_dma_xlate)
>> -                               (struct of_phandle_args *, struct of_dma *);
>> +                               (struct of_phandle_args *, struct of_dma *,
>> +                                struct device *);
>>          void                    *(*of_dma_route_allocate)
>>                                  (struct of_phandle_args *, struct of_dma *);
>>          struct dma_router       *dma_router;
>> @@ -37,7 +38,7 @@ struct of_dma_filter_info {
>>   #ifdef CONFIG_DMA_OF
>>   extern int of_dma_controller_register(struct device_node *np,
>>                  struct dma_chan *(*of_dma_xlate)
>> -               (struct of_phandle_args *, struct of_dma *),
>> +               (struct of_phandle_args *, struct of_dma *, struct device *),
>>                  void *data);
>>   extern void of_dma_controller_free(struct device_node *np);
>>
>> @@ -47,17 +48,17 @@ extern int of_dma_router_register(struct device_node *np,
>>                  struct dma_router *dma_router);
>>   #define of_dma_router_free of_dma_controller_free
>>
>> -extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>> +extern struct dma_chan *of_dma_request_slave_channel(struct device *slave,
>>                                                       const char *name);
> I noticed that this API is being used from sound/soc/sh/rcar/dma.c, so
> I assume this change triggers a compiler error. I guess you want to
> fold in a change dealing with that as well.

Right. Thanks for pointing this.

I didn't expect that of_dma_request_slave_channel() is used outside 
drivers/dma,
especially in such a creative way as in sh/rcar driver. I will change a 
function
signature to:

of_dma_request_slave_channel(struct device *slave, struct device_node 
*np, const char *name)

then, as there is no direct relation between device and of node pointer, 
from
which rcar driver extracts the dma channel data.

I would also expect that zero-day build robot will complain about missing
sh/rcar driver update, but I didn't get any message from it.

> [...]
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
