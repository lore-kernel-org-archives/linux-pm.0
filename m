From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 6/7] iommu/exynos: Add runtime pm support
Date: Mon, 24 Oct 2016 07:19:44 +0200
Message-ID: <91601a86-253a-3fe8-85e1-a8c55a2ceb09@samsung.com>
References: <1476948173-21093-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161020072335eucas1p209675d6fbf39e5045281e8023fa9d234@eucas1p2.samsung.com>
 <1476948173-21093-7-git-send-email-m.szyprowski@samsung.com>
 <000701d22c28$2da381d0$88ea8570$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <000701d22c28$2da381d0$88ea8570$@codeaurora.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sricharan <sricharan@codeaurora.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: 'Tomeu Vizoso' <tomeu.vizoso@collabora.com>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Kevin Hilman' <khilman@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Inki Dae' <inki.dae@samsung.com>, 'Tobias Jakobi' <tjakobi@math.uni-bielefeld.de>, "'Luis R. Rodriguez'" <mcgrof@kernel.org>, 'Kukjin Kim' <kgene@kernel.org>, 'Mark Brown' <broonie@kernel.org>, 'Lukas Wunner' <lukas@wunner.de>
List-Id: linux-pm@vger.kernel.org

Hi Sricharan


On 2016-10-22 07:50, Sricharan wrote:
>
>> This patch adds runtime pm implementation, which is based on previous
>> suspend/resume code. SYSMMU controller is now being enabled/disabled mainly
> > from the runtime pm callbacks. System sleep callbacks relies on generic
>> pm_runtime_force_suspend/pm_runtime_force_resume helpers. To ensure
>> internal state consistency, additional lock for runtime pm transitions
>> was introduced.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> drivers/iommu/exynos-iommu.c | 45 +++++++++++++++++++++++++++++++++++---------
>> 1 file changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index a959443e6f33..5e6d7bbf9b70 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -206,6 +206,7 @@ struct sysmmu_fault_info {
>> struct exynos_iommu_owner {
>> 	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
>> 	struct iommu_domain *domain;	/* domain this device is attached */
>> +	struct mutex rpm_lock;		/* for runtime pm of all sysmmus */
>> };
>>
>> /*
>> @@ -594,40 +595,46 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>> 	return 0;
>> }
>>
>> -#ifdef CONFIG_PM_SLEEP
>> -static int exynos_sysmmu_suspend(struct device *dev)
>> +static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
>> {
>> 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
>> 	struct device *master = data->master;
>>
>> 	if (master) {
>> -		pm_runtime_put(dev);
>> +		struct exynos_iommu_owner *owner = master->archdata.iommu;
>> +
>> +		mutex_lock(&owner->rpm_lock);
> More of a device link question,
> To understand, i see that with device link + runtime, the supplier
> callbacks are not called for irqsafe clients, even if supplier is irqsafe.
> Why so ?

Frankly I didn't care about irqsafe runtime pm, because there is no such 
need
for Exynos platform and its drivers. Exynos power domain driver also doesn't
support irqsafe mode.

>
>> 		if (data->domain) {
>> 			dev_dbg(data->sysmmu, "saving state\n");
>> 			__sysmmu_disable(data);
>> 		}
>> +		mutex_unlock(&owner->rpm_lock);
>> 	}
>> 	return 0;
>> }
>>
>> -static int exynos_sysmmu_resume(struct device *dev)
>> +static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
>> {
>> 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
>> 	struct device *master = data->master;
>>
>> 	if (master) {
>> -		pm_runtime_get_sync(dev);
>> +		struct exynos_iommu_owner *owner = master->archdata.iommu;
>> +
>> +		mutex_lock(&owner->rpm_lock);
>> 		if (data->domain) {
>> 			dev_dbg(data->sysmmu, "restoring state\n");
>> 			__sysmmu_enable(data);
>> 		}
>> +		mutex_unlock(&owner->rpm_lock);
>> 	}
>> 	return 0;
>> }
>> -#endif
>>
>> static const struct dev_pm_ops sysmmu_pm_ops = {
>> -	SET_LATE_SYSTEM_SLEEP_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume)
>> +	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
>> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +				     pm_runtime_force_resume)
>> };
>   Is this needed to be LATE_SYSTEM_SLEEP_PM_OPS with device links to take care
>    of the order ?

Hmmm. LASE_SYSTEM_SLEEP_PM_OPS is a left over from the previous versions 
of the driver,
which doesn't use device links. You are right, that "normal" 
SYSTEM_SLEEP_PM_OPS should
be enough assuming that device links will take care of the proper call 
sequence between
consumer and supplier device.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
