From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
	masters and smmu
Date: Tue, 17 Jul 2018 09:46:10 +0200
Message-ID: <CAJZ5v0ijB6ZX9q0i+YrkWg1-nQBx+FuTjbGq1xRoJS113uoA-g@mail.gmail.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
	<20180708173413.1965-4-vivek.gautam@codeaurora.org>
	<5179668.PHK6S3sxLu@aspire.rjw.lan>
	<741cc78b-59a7-5289-e42f-1511ebedb15d@codeaurora.org>
	<CAFp+6iFTgEhPLYQEyBX_Fb0k3n0OzGhKuSoBNV5XzpD01+V8qw@mail.gmail.com>
	<CAJZ5v0iQ2wxsXvuaLK2M9a_Jwe_fnwR2Afrq_Oa8h0--Ch7-5g@mail.gmail.com>
	<93d16301-4bef-203f-24de-4d010de84b22@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <93d16301-4bef-203f-24de-4d010de84b22-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 16, 2018 at 1:46 PM, Vivek Gautam
<vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
>
> On 7/16/2018 2:25 PM, Rafael J. Wysocki wrote:
>>
>> On Thu, Jul 12, 2018 at 2:41 PM, Vivek Gautam
>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>
>>> Hi Rafael,
>>>
>>>
>>> On Wed, Jul 11, 2018 at 4:06 PM, Vivek Gautam
>>> <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>>
>>>>
>>>> On 7/11/2018 3:23 PM, Rafael J. Wysocki wrote:
>>>>>
>>>>> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>>>>>>
>>>>>> From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>>>
>>>>>> Finally add the device link between the master device and
>>>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>>>> master needs it. This is done from add_device callback which gets
>>>>>> called once when the master is added to the smmu.
>>>>>>
>>>>>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>>>> Reviewed-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>>>> Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
>>>>>> Cc: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
>>>>>> ---
>>>>>>
>>>>>>    - Change since v11
>>>>>>      * Replaced DL_FLAG_AUTOREMOVE flag with
>>>>>> DL_FLAG_AUTOREMOVE_SUPPLIER.
>>>>>>
>>>>>>    drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>>>>>    1 file changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>>> index 09265e206e2d..916cde4954d2 100644
>>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device
>>>>>> *dev)
>>>>>>          iommu_device_link(&smmu->iommu, dev);
>>>>>>    +     if (pm_runtime_enabled(smmu->dev) &&
>>>>>
>>>>> Why does the creation of the link depend on whether or not runtime PM
>>>>> is enabled for the MMU device?
>>>>
>>>>
>>>> The main purpose of this device link is to handle the runtime PM
>>>> synchronization
>>>> between the supplier (iommu) and consumer (client devices, such as
>>>> GPU/display).
>>>> Moreover, the runtime pm is conditionally enabled for smmu devices that
>>>> support
>>>> such [1].
>>>
>>> Is there something you would like me to modify in this patch?
>>
>> Not really, as long as you are sure that it is correct. :-)
>>
>> You need to remember, however, that if you add system-wide PM
>> callbacks to the driver, the ordering between them and the client
>> device callbacks during system-wide suspend matters as well.  Don't
>> you need the link the ensure the correct system-wide suspend ordering
>> too?
>
>
> The fact that currently we handle clocks only through runtime pm callbacks,
> would it be better to call runtime pm put/get in system-wide PM callbacks.
> This would be same as i mentioned in the other thread.

Well, my point is that there's no reason for system-wide suspend to
depend directly on runtime PM (which can be effectively disabled by
user space as mentioned for multiple times in this thread).

It simply is not efficient to let the clock run while the system as a
whole is sleeping (even if power/control has been set to "on" for this
particular device) and it should not be too hard to prevent that from
happening.  You may need an additional flag in the driver for that or
similar, but it definitely should be doable.

Now, that's my advice and I'm not the maintainer of that code, so it
is your call (as long as the maintainer agrees with it).

Thanks,
Rafael
