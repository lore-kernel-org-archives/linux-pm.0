From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 7/7] iommu/exynos: Use device dependency links to
 control runtime pm
Date: Tue, 08 Nov 2016 08:27:12 +0100
Message-ID: <4bc652ce-6cf9-f4df-4793-e126cf81079d@samsung.com>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161020072336eucas1p24a2b020f69b6ae1f55e1760e6e0e94f9@eucas1p2.samsung.com>
 <1476948173-21093-8-git-send-email-m.szyprowski@samsung.com>
 <20161107214747.GJ1764@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20161107214747.GJ1764@wotan.suse.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-pm@vger.kernel.org

Hi Luis,


On 2016-11-07 22:47, Luis R. Rodriguez wrote:
> On Thu, Oct 20, 2016 at 09:22:53AM +0200, Marek Szyprowski wrote:
>> This patch uses recently introduced device dependency links to track the
>> runtime pm state of the master's device. This way each SYSMMU controller
>> is set to runtime active only when its master's device is active and can
>> restore or save its state instead of being activated all the time when
>> attached to the given master device. This way SYSMMU controllers no longer
>> prevents respective power domains to be turned off when master's device
>> is not being used.
> Its unclear why you need this based on this commit log -- is this
> needed only on platforms that lack ACPI and use device tree ?

Nope, it has nothing to device tree nor ACPI. The dependency is a direct
result of the way the devices operate.

> If so
> why? If this issue is present also on systems that only use ACPI is
> this possibly due to an ACPI firmware bug  or the lack of some semantics
> in ACPI to express ordering in a better way? If the issue is device
> tree related only is this due to the lack of semantics in device tree
> to express some more complex dependency ?

The main feature of device links that is used in this patch is enabling
runtime pm dependency between Exynos SYSMMU controller (called it client
device) and the device, for which it implements DMA address translation
(called master device). The assumptions are following:
1. master device driver is completely unaware of the Exynos SYSMMU presence,
    IOMMU is transparently hooked up and managed by DMA-mapping framework
2. SYSMMU belongs to the same power domain as it's master device
3. SYSMMU is optional, master device can fully operate without it, with
    simple DMA address translation (DMA address == physical address)
4. Master device implements runtime pm, what in turn causes respective
    power domain to be turned on/off
5. DMA-mapping and IOMMU frameworks provides no calls to notify SYSMMU
    when its master device is performing DMA operations, so SYSMMU has
    to be runtime active
6. Currently SYSMMU always sets its runtime pm status to active after
    attaching to its master device to ensure proper hardware state. This
    prevents power domain to be turned off, even when master device sets
    its runtime pm status to suspended.
7. Exynos SYSMMU has to be runtime active at the same time when its
    master device is runtime active to it to perform DMA operations and
    allow the power domain to be turned off, when master device is
    runtime suspended.
8. The terms of device links, Exynos SYSMMU is a 'consumer' and master
    device is a 'supplier'.

> Has there been any review of the existing similar solutions out there
> such as the DRM / audio component framework? Would that help ?

Nope, none of that solution deals with runtime pm.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
