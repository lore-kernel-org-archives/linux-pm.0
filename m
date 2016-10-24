From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH v5 7/7] iommu/exynos: Use device dependency links to control runtime pm
Date: Mon, 24 Oct 2016 17:59:24 +0530
Message-ID: <004a01d22df2$45ecd450$d1c67cf0$@codeaurora.org>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com> <CGME20161020072336eucas1p24a2b020f69b6ae1f55e1760e6e0e94f9@eucas1p2.samsung.com> <1476948173-21093-8-git-send-email-m.szyprowski@samsung.com> <001e01d22d12$d2a4e990$77eebcb0$@codeaurora.org> <7a69ca4e-e276-1bdc-edf2-b881a91f820a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934818AbcJXM3f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 08:29:35 -0400
In-Reply-To: <7a69ca4e-e276-1bdc-edf2-b881a91f820a@samsung.com>
Content-Language: en-us
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: 'Tomeu Vizoso' <tomeu.vizoso@collabora.com>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Kevin Hilman' <khilman@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Inki Dae' <inki.dae@samsung.com>, 'Tobias Jakobi' <tjakobi@math.uni-bielefeld.de>, "'Luis R. Rodriguez'" <mcgrof@kernel.org>, 'Kukjin Kim' <kgene@kernel.org>, 'Mark Brown' <broonie@kernel.org>, 'Lukas Wunner' <lukas@wunner.de>

Hi Marek,

>>> This patch uses recently introduced device dependency links to track the
>>> runtime pm state of the master's device. This way each SYSMMU controller
>>> is set to runtime active only when its master's device is active and can
>>> restore or save its state instead of being activated all the time when
>>> attached to the given master device. This way SYSMMU controllers no longer
>>> prevents respective power domains to be turned off when master's device
>>> is not being used.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>> drivers/iommu/exynos-iommu.c | 16 ++++++++--------
>>> 1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>>> index 5e6d7bbf9b70..59b4f2ce4f5f 100644
>>> --- a/drivers/iommu/exynos-iommu.c
>>> +++ b/drivers/iommu/exynos-iommu.c
>>> @@ -781,10 +781,6 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
>>> 	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
>>> 		return;
>>>
>>> -	list_for_each_entry(data, &owner->controllers, owner_node) {
>>> -		pm_runtime_put_sync(data->sysmmu);
>>> -	}
>>> -
>>> 	mutex_lock(&owner->rpm_lock);
>>>
>>> 	list_for_each_entry(data, &owner->controllers, owner_node) {
>>> @@ -848,10 +844,6 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
>>>
>>> 	mutex_unlock(&owner->rpm_lock);
>>>
>>> -	list_for_each_entry(data, &owner->controllers, owner_node) {
>>> -		pm_runtime_get_sync(data->sysmmu);
>>> -	}
>>> -
>>> 	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa\n", __func__,
>>> 		&pagetable);
>>>
>>> @@ -1232,6 +1224,14 @@ static int exynos_iommu_of_xlate(struct device *dev,
>>>
>>> 	list_add_tail(&data->owner_node, &owner->controllers);
>>> 	data->master = dev;
>>> +
>>> +	/*
>>> +	 * SYSMMU will be runtime activated via device link (dependency) to its
>>> +	 * master device, so there are no direct calls to pm_runtime_get/put
>>> +	 * in this driver.
>>> +	 */
>>> +	device_link_add(dev, data->sysmmu, DL_FLAG_PM_RUNTIME);
>>> +
>>    So in the case of master with multiple sids, this would be called multiple times
>>    for the same master ?
>
>I don't know what is "multiple sids" case, but if given SYSMMU master
>device (supplier)
>has multiple SYSMMU controllers (consumers), then links will be created
>for each SYSMMU
>controller. Please note that this code is based on vanilla v4.9-rc1,
>which calls
>of_xlate() callback only once for every iommu for given master device.
>Your IOMMU
>deferred probe patches change this, but I already posted a fix for
>Exynos IOMMU driver
>to handle such case.
      By multiple sids, i meant iommus = <&phandle sid1 sid2 .. sidn> case,
      so xlate would be called multiples for the same master without deferred
       probing also. But the fix that you showed on the other thread would work
       here as well or maybe if you dont have masters with multiple sids you wont
      have any issues as well.

Regards,
 Sricharan

