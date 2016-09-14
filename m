From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iommu/exynos: Add proper runtime pm support
Date: Wed, 14 Sep 2016 12:50:46 +0200
Message-ID: <6f5e9bd4-10f6-e9cb-3e2a-ef6ff8a38bc5@samsung.com>
References: <CGME20160913124918eucas1p29f49efbb142d416215482c29b53daff8@eucas1p2.samsung.com>
	<1473770941-8337-1-git-send-email-m.szyprowski@samsung.com>
	<1473770941-8337-3-git-send-email-m.szyprowski@samsung.com>
	<CAPDyKFo5D3kGRt=4mBH9-XpLU6eOm4jah1xjyR3disFiJfXjoA@mail.gmail.com>
	<ca6b2547-dc67-bb3c-e5af-7f5eeddfd54d@samsung.com>
	<CAPDyKFqtBhA6kv-DFmeCiWbn0q0g2hFR5-+9M7CgvbzNH2iOzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CAPDyKFqtBhA6kv-DFmeCiWbn0q0g2hFR5-+9M7CgvbzNH2iOzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,


On 2016-09-14 12:28, Ulf Hansson wrote:
> [...]
>
>> There are some similarities between IOMMU and DMA engine devices (serial
>> drivers are imho completely different case). Both hw blocks do their work
>> on behalf of some other hardware block, which I will call master device.
>> DMA engine performs some DMA transaction on master's device request, while
>> IOMMU usually sits between system memory and master's device memory
>> interface, remapping addresses of each DMA transaction according to its
>> configuration and provided mapping tables (master device has some kind
>> of internal DMA controller and performs DMA transactions on their own).
>> IOMMU is usually used for a) mapping physically discontinuous memory into
>> contiguous DMA addresses and b) isolating devices, so they can access
>> only memory, which is dedicated or allocated for them.
>>
>> DMA engine devices provide explicit API for their master's device drivers,
>> while IOMMU drivers are usually hidden behind DMA-mapping API (for most
>> use cases, although it would be possible for master's device driver to
>> call IOMMU API directly and some GPU/DRM drivers do that).
>>
>> However from runtime pm perspective the DMA engine and IOMMU devices are
>> a bit different.
>>
>> DMA engine drivers have well defined start and end of operation (queuing
>> dma request and irq from hw about having it finished). During that time
>> the device has to be runtime active all the time. The problem with using
>> current implementation of runtime pm is the fact that both start and end
>> of operation can be triggered from atomic context, what is not really
>> suitable for runtime pm. So the problem is mainly about API
>> incompatibility and lack of something like dma_engine_prepare()/unprepare()
>> (as an analogy to clocks api).
> That's also a viable option. Although, DMA clients would then need to
> invoke such APIs from non-atomic contexts. Typically that would be
> from client driver's runtime PM callbacks.
>
> Me personally would rather avoid such solution, as it would sprinkle
> lots of drivers to deal with this. Although, perhaps this is the only
> option that actually works.

One might also introduce optional functions and notify DMA engine core with
some flag that the client driver wants to use them or not. If not core will
prepare dma engine on initialization. This is not really nice from the API
clearness perspective, but it would allow to have some time for transition
to the new approach till all clients gets updated.

>> In case of IOMMU the main problem is determining weather IOMMU controller
>> has to be activated. There is no calls in IOMMU and DMA-mapping API, which
>> would bracket all DMA transactions performed by the master device. Someone
>> proposed to keep IOMMU runtime active when there exist at least one
>> mapping created by the IOMMU/DMA-mapping layers. This however does not
>> cover all the cases. In case of our IOMMU, when it is disabled or runtime
>> suspended, it enters "pass-thought" mode, so master device can still
>> perform DMA operations with identity mappings (so DMA address equals to
>> physical memory address). Till now Exynos IOMMU called pm_runtime_get()
>> on attaching to the iommu domain (what happens during initialization of
>> dma-mapping structures for given master device) and kept it active all
>> the time.
>>
>> This patch series tries to address Exynos IOMMU runtime pm issue by forcing
>> IOMMU controller to follow runtime pm status of its master device. This way
>> we ensure that anytime when master's device is runtime activated, the iommu
>> will be also active and master device won't be able to bypass during its
>> DMA transactions mappings created by the IOMMU layer.
>>
>> Quite long answer, but I hope I managed to give you a bit more background
>> on this topic.
> Yes, indeed. Thank you for taking the time to respond!
>
>>> As we know, using the pm_runtime_irq_safe() option comes with some
>>> limitations, such as the runtime PM callbacks is not allowed to sleep.
>>> For a PM domain (genpd) that is attached to the device, this also
>>> means it must not be powered off.
>>
>> Right, if possible I would like to avoid using pm_runtime_irq_safe()
>> option, because it is really impractical.
>>
>>> To solve this problem, I was thinking we could convert to use the
>>> asynchronous pm_runtime_get() API, when trying to runtime resume the
>>> device from atomic contexts.
>> I'm not sure if this will work for DMA engine devices. If I understand
>> correctly some client's of DMA engine device might rely on the DMA
>> engine being configured and operational after queuing a request and
>> they might lock up if the DMA engine device activation if postponed
>> because of async runtime pm activation.
> I didn't know about this. If you have an example from the top of your
> head, could you perhaps point me to it?

No, I don't have any example. This is just my fear that there might be some
hardware which works this way. I can imagine a driver, which queue dma 
engine
request and then triggers 'start' command to its hw block. HW blocks usually
uses some additional signal lines for DMA, so the HW block might check 
if all
needed signals from DMA engine HW are ready. If not it will fail to start
avoid lockup of starting without DMA engine HW being ready.

However I don't have much experience with DMA engine and drivers. I only
helped in adding DMA engine support to Samsung UART driver and in the
hardware manual there is information about additional lines between DMA
controller and UART module, which are used in the DMA mode.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
