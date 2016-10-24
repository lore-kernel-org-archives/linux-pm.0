From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH v5 6/7] iommu/exynos: Add runtime pm support
Date: Mon, 24 Oct 2016 17:45:13 +0530
Message-ID: <004701d22df0$4b34acf0$e19e06d0$@codeaurora.org>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com> <CGME20161020072335eucas1p209675d6fbf39e5045281e8023fa9d234@eucas1p2.samsung.com> <1476948173-21093-7-git-send-email-m.szyprowski@samsung.com> <000701d22c28$2da381d0$88ea8570$@codeaurora.org> <91601a86-253a-3fe8-85e1-a8c55a2ceb09@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41479 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757081AbcJXMP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 08:15:27 -0400
In-Reply-To: <91601a86-253a-3fe8-85e1-a8c55a2ceb09@samsung.com>
Content-Language: en-us
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: 'Tomeu Vizoso' <tomeu.vizoso@collabora.com>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Kevin Hilman' <khilman@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Inki Dae' <inki.dae@samsung.com>, 'Tobias Jakobi' <tjakobi@math.uni-bielefeld.de>, "'Luis R. Rodriguez'" <mcgrof@kernel.org>, 'Kukjin Kim' <kgene@kernel.org>, 'Mark Brown' <broonie@kernel.org>, 'Lukas Wunner' <lukas@wunner.de>

Hi Marek,

>Hi Sricharan
>
>
>On 2016-10-22 07:50, Sricharan wrote:
>>
>>> This patch adds runtime pm implementation, which is based on previous
>>> suspend/resume code. SYSMMU controller is now being enabled/disabled mainly
>> > from the runtime pm callbacks. System sleep callbacks relies on generic
>>> pm_runtime_force_suspend/pm_runtime_force_resume helpers. To ensure
>>> internal state consistency, additional lock for runtime pm transitions
>>> was introduced.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>> drivers/iommu/exynos-iommu.c | 45 +++++++++++++++++++++++++++++++++++---------
>>> 1 file changed, 36 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>>> index a959443e6f33..5e6d7bbf9b70 100644
>>> --- a/drivers/iommu/exynos-iommu.c
>>> +++ b/drivers/iommu/exynos-iommu.c
>>> @@ -206,6 +206,7 @@ struct sysmmu_fault_info {
>>> struct exynos_iommu_owner {
>>> 	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
>>> 	struct iommu_domain *domain;	/* domain this device is attached */
>>> +	struct mutex rpm_lock;		/* for runtime pm of all sysmmus */
>>> };
>>>
>>> /*
>>> @@ -594,40 +595,46 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>>> 	return 0;
>>> }
>>>
>>> -#ifdef CONFIG_PM_SLEEP
>>> -static int exynos_sysmmu_suspend(struct device *dev)
>>> +static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
>>> {
>>> 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
>>> 	struct device *master = data->master;
>>>
>>> 	if (master) {
>>> -		pm_runtime_put(dev);
>>> +		struct exynos_iommu_owner *owner = master->archdata.iommu;
>>> +
>>> +		mutex_lock(&owner->rpm_lock);
>> More of a device link question,
>> To understand, i see that with device link + runtime, the supplier
>> callbacks are not called for irqsafe clients, even if supplier is irqsafe.
>> Why so ?
>
>Frankly I didn't care about irqsafe runtime pm, because there is no such
>need
>for Exynos platform and its drivers. Exynos power domain driver also doesn't
>support irqsafe mode.
  ok, i asked this because, i was doing the same thing for arm-smmu driver
   and thought that when we depend on device-link for doing the runtime pm,
   then it might not work for irqsafe master. Probably i can ask this on device link
    series post.

Regards,
 Sricharan

