From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 2/2] iommu/exynos: Add proper runtime pm support
Date: Wed, 14 Sep 2016 09:11:57 +0200
Message-ID: <ca6b2547-dc67-bb3c-e5af-7f5eeddfd54d@samsung.com>
References: <CGME20160913124918eucas1p29f49efbb142d416215482c29b53daff8@eucas1p2.samsung.com>
 <1473770941-8337-1-git-send-email-m.szyprowski@samsung.com>
 <1473770941-8337-3-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFo5D3kGRt=4mBH9-XpLU6eOm4jah1xjyR3disFiJfXjoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:10662 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753872AbcINHMF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2016 03:12:05 -0400
In-reply-to: <CAPDyKFo5D3kGRt=4mBH9-XpLU6eOm4jah1xjyR3disFiJfXjoA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>

Hi Ulf,

On 2016-09-13 16:20, Ulf Hansson wrote:
> On 13 September 2016 at 14:49, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> This patch uses recently introduced device links to track the runtime pm
>> state of the master's device. This way each SYSMMU controller is runtime
>> activated when its master's device is active and can save/restore its state
>> instead of being enabled all the time. This way SYSMMU controllers no
>> longer prevents respective power domains to be turned off when master's
>> device is not used.
> Apologize for not reviewing earlier and if you find my
> questions/suggestions being silly. You may ignore them, if you don't
> think they deserves a proper answer. :-)

No problem. There are no silly questions, but there might be some silly
answers ;)

> I am not so familiar with the IOMMU subsystem, but I am wondering
> whether the issue you are solving, is similar to what can be observed
> for DMA and serial drivers. And of course also for other IOMMU
> drivers.
>
> In general the DMA/serial drivers requires to use the
> pm_runtime_irq_safe() option, to be able to easily deploy runtime PM
> support (of course there are some other workarounds as well).

There are some similarities between IOMMU and DMA engine devices (serial
drivers are imho completely different case). Both hw blocks do their work
on behalf of some other hardware block, which I will call master device.
DMA engine performs some DMA transaction on master's device request, while
IOMMU usually sits between system memory and master's device memory
interface, remapping addresses of each DMA transaction according to its
configuration and provided mapping tables (master device has some kind
of internal DMA controller and performs DMA transactions on their own).
IOMMU is usually used for a) mapping physically discontinuous memory into
contiguous DMA addresses and b) isolating devices, so they can access
only memory, which is dedicated or allocated for them.

DMA engine devices provide explicit API for their master's device drivers,
while IOMMU drivers are usually hidden behind DMA-mapping API (for most
use cases, although it would be possible for master's device driver to
call IOMMU API directly and some GPU/DRM drivers do that).

However from runtime pm perspective the DMA engine and IOMMU devices are
a bit different.

DMA engine drivers have well defined start and end of operation (queuing
dma request and irq from hw about having it finished). During that time
the device has to be runtime active all the time. The problem with using
current implementation of runtime pm is the fact that both start and end
of operation can be triggered from atomic context, what is not really
suitable for runtime pm. So the problem is mainly about API
incompatibility and lack of something like dma_engine_prepare()/unprepare()
(as an analogy to clocks api).

In case of IOMMU the main problem is determining weather IOMMU controller
has to be activated. There is no calls in IOMMU and DMA-mapping API, which
would bracket all DMA transactions performed by the master device. Someone
proposed to keep IOMMU runtime active when there exist at least one
mapping created by the IOMMU/DMA-mapping layers. This however does not
cover all the cases. In case of our IOMMU, when it is disabled or runtime
suspended, it enters "pass-thought" mode, so master device can still
perform DMA operations with identity mappings (so DMA address equals to
physical memory address). Till now Exynos IOMMU called pm_runtime_get()
on attaching to the iommu domain (what happens during initialization of
dma-mapping structures for given master device) and kept it active all
the time.

This patch series tries to address Exynos IOMMU runtime pm issue by forcing
IOMMU controller to follow runtime pm status of its master device. This way
we ensure that anytime when master's device is runtime activated, the iommu
will be also active and master device won't be able to bypass during its
DMA transactions mappings created by the IOMMU layer.

Quite long answer, but I hope I managed to give you a bit more background
on this topic.

> As we know, using the pm_runtime_irq_safe() option comes with some
> limitations, such as the runtime PM callbacks is not allowed to sleep.
> For a PM domain (genpd) that is attached to the device, this also
> means it must not be powered off.

Right, if possible I would like to avoid using pm_runtime_irq_safe()
option, because it is really impractical.

> To solve this problem, I was thinking we could convert to use the
> asynchronous pm_runtime_get() API, when trying to runtime resume the
> device from atomic contexts.

I'm not sure if this will work for DMA engine devices. If I understand
correctly some client's of DMA engine device might rely on the DMA
engine being configured and operational after queuing a request and
they might lock up if the DMA engine device activation if postponed
because of async runtime pm activation.

> Of course when it turns out that the device isn't yet runtime resumed
> immediately after calling pm_runtime_get(), the request needs to be
> put on a request queue to be managed shortly after instead. Doing it
> like this, would remove the need to use the pm_runtime_irq_safe()
> option.
>
> I realize that such change needs to be implemented in common code for
> IOMMU drivers, if at all possible.
>
> Anyway, I hope you at least get the idea and I just wanted to mention
> that I have been exploring this option for DMA and serial drivers.

I also have runtime pm for serial driver on my todo list, but it doesn't
have high priority. The other runtime pm integration subsystem that I
want to work on first is pinctrl. It is needed to fully support Exynos
5433 SoCs, because registers of some audio related pins are in the audio
power domain, what now prevent us from enabling support for audio power
domain.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

