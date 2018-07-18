From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
	masters and smmu
Date: Wed, 18 Jul 2018 13:43:23 +0100
Message-ID: <48139f68-5a79-8531-00fa-fbdd787f50f5@arm.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
	<20180708173413.1965-4-vivek.gautam@codeaurora.org>
	<5179668.PHK6S3sxLu@aspire.rjw.lan>
	<CAFp+6iGcwdK=wyPf++u3B+ORghuB1YhYmnJLSwvt1efG9H4YeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFp+6iGcwdK=wyPf++u3B+ORghuB1YhYmnJLSwvt1efG9H4YeA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 18/07/18 10:30, Vivek Gautam wrote:
> On Wed, Jul 11, 2018 at 3:23 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
>> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>
>>> Finally add the device link between the master device and
>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>> master needs it. This is done from add_device callback which gets
>>> called once when the master is added to the smmu.
>>>
>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>> Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>>> Cc: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
>>> ---
>>>
>>>   - Change since v11
>>>     * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
>>>
>>>   drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 09265e206e2d..916cde4954d2 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>>>
>>>        iommu_device_link(&smmu->iommu, dev);
>>>
>>> +     if (pm_runtime_enabled(smmu->dev) &&
>>
>> Why does the creation of the link depend on whether or not runtime PM
>> is enabled for the MMU device?
>>
>> What about system-wide PM and system shutdown?  Are they always guaranteed
>> to happen in the right order without the link?
> 
> Hi Robin,
> 
> As Rafael pointed, we should the device link creation should not depend on
> runtime PM being enabled or not, as we would also want to guarantee
> that system wide PM callbacks are called in the right order for smmu
> and clients.
> 
> Does this change of removing the check for pm_runtime_enabled() from here
> looks okay to you?

FWIW the existing system PM ops make no claim to be perfect, and I 
wouldn't be at all surprised if it was only by coincidence that my 
devices happened to put on the relevant lists in the right order to 
start with. If we no longer need to worry about explicit device_link 
housekeeping in the SMMU driver, then creating them unconditionally 
sounds like the sensible thing to do. I'd be inclined to treat failure 
as non-fatal like we do for the sysfs link, though, since it's another 
thing that correct SMMU operation doesn't actually depend on (at this 
point we don't necessarily know if this consumer even has a driver at all).

> FYI, as discussed in the first patch [1] of this series, I will add a
> system wide
> suspend callback - arm_smmu_pm_suspend, that would do clock disable, and will
> add corresponding clock enable calls in arm_smmu_pm_resume().

OK, I still don't really understand the finer points of how system PM 
and runtime PM interact, but if making it robust is just a case of 
calling the runtime suspend/resume hooks as appropriate from the system 
ones, that sounds reasonable.

Robin.

> 
> [1] https://lore.kernel.org/patchwork/patch/960460/
> 
> 
> Best regards
> Vivek
> 
>>
>>> +         !device_link_add(dev, smmu->dev,
>>> +                     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
>>> +             dev_err(smmu->dev, "Unable to add link to the consumer %s\n",
>>> +                     dev_name(dev));
>>> +             ret = -ENODEV;
>>> +             goto out_unlink;
>>> +     }
>>> +
>>>        return 0;
>>>
>>> +out_unlink:
>>> +     iommu_device_unlink(&smmu->iommu, dev);
>>> +     arm_smmu_master_free_smes(fwspec);
>>>   out_cfg_free:
>>>        kfree(cfg);
>>>   out_free:
>>>
>>
>>
> 
> 
> 
