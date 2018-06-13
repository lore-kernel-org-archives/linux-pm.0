From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter
 imbalance
Date: Wed, 13 Jun 2018 12:23:00 +0200
Message-ID: <20180613102301eucas1p26feaa6ac1ceba2216bd9f2b696c89f86~3sSdhwfI42411224112eucas1p2y@eucas1p2.samsung.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
        <10125310.W3e2TP0641@aspire.rjw.lan>
        <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
        <1692795.7GA92aXxMT@aspire.rjw.lan>
        <20180613062316eucas1p2655d6b1f286e8d374fc4e7570ede0c95~3pBJGh1rJ0735307353eucas1p2O@eucas1p2.samsung.com>
        <CAJZ5v0gh-Vq=6X9Dn2x-x_REnOwPVAfNj+CTJRUkKNmsAPmsnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gh-Vq=6X9Dn2x-x_REnOwPVAfNj+CTJRUkKNmsAPmsnQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lukas Wunner <lukas@wunner.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 2018-06-13 10:16, Rafael J. Wysocki wrote:
> On Wed, Jun 13, 2018 at 8:23 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> On 2018-06-12 16:24, Rafael J. Wysocki wrote:
>>> On Tuesday, June 12, 2018 2:44:23 PM CEST Marek Szyprowski wrote:
>>>> On 2018-06-12 13:00, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> If a device link is added via device_link_add() by the driver of the
>>>>> link's consumer device, the supplier's runtime PM usage counter is
>>>>> going to be dropped by the pm_runtime_put_suppliers() call in
>>>>> driver_probe_device().  However, in that case it is not incremented
>>>>> unless the supplier driver is already present and the link is not
>>>>> stateless.  That leads to a runtime PM usage counter imbalance for
>>>>> the supplier device in a few cases.
>>>>>
>>>>> To prevent that from happening, bump up the supplier runtime
>>>>> PM usage counter in device_link_add() for all links with the
>>>>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>>>>> time.  Use pm_runtime_get_noresume() for that as the callers of
>>>>> device_link_add() who want the supplier to be resumed by it should
>>>>> pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
>>>>>
>>>>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>>>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>
>>>>> This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
>>>>> reference counting of device link suppliers at probe) that is going
>>>>> to be reverted.
>>>> Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.
>>> Thanks for testing! :-)
>>>
>>>> Let's get back to my IOMMU and codec case, mentioned here:
>>>> https://marc.info/?l=linux-pm&m=152878741527962&w=2
>>>>
>>>> Now, after applying your patch, when IOMMU creates a link with
>>>> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
>>>> being probed), it is not IOMMU is not runtime resumed anymore (that's
>>>> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
>>>> This means that until jpeg driver enables runtime pm for its device and
>>>> finally performs runtime pm suspends/resume cycle, the supplier won't be
>>>> resumed. On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
>>>> creation, the supplier is properly resumed, but then, once the jpeg
>>>> device probe finishes, the supplier is still in runtime active state
>>>> until a next runtime suspend/resume cycle of jpeg device.
>>> That additional suspend-resume cycle should not be necessary in theory
>>> unless I'm missing something.
>>>
>>> The pm_request_idle() call in driver_probe_device() should trigger a
>>> suspend of the jpeg device after probe (unless blocked by something)
>>> and that should drop the RPM usage counter of the IOMMU.  Next, the
>>> pm_runtime_put_suppliers() in there should actually suspend it.
>> I've also would expect such behavior of PM core, but checks on real
>> hardware gives other results.
>>
>>> It looks like the pm_request_idle() doesn't work as expected.
>> pm_request_idle() calls rpm_idle(), which returns early with -EAGAIN due to
>> (dev->power.runtime_status != RPM_ACTIVE) check. The device runtime_status
>> is RPM_SUSPENDED as initially set by pm_runtime_init() on device creation.
>> Notice that JPEG driver only calls pm_runtime_enable() and nothing more.
> But is the device really suspended during probe?

This is a runtime pm state of the newly created platform device when driver
core calls ->probe() from its driver. At that time it is not yet known if
the driver supports runtime pm or not and typically drivers do some hardware
access there. Platform device is created from device tree.

> Note that "suspend" means basically "not accessible to software", but
> I guess software needs to access it to set it up, right?  If that is
> the case, maybe the driver should set the initial RPM status of the
> device to "active" before enabling runtime PM for it?  That at least
> would be consistent with passing DL_FLAG_RPM_ACTIVE to
> device_link_add().
>
> There are drivers that don't actually touch the hardware in ->probe(),
> but it follows from your description that this is not one of them.

The JPEG driver was just an example, and it actually doesn't touch hw in
probe. However I would like to have the typical cases working:

1. runtime pm enabled, no hw access
2. runtime pm enabled, some hw access (guarded by either
    pm_runtime_get_sync or pm_runtime_get_noresume+pm_runtime_set_active)
3. runtime pm disabled (no runtime pm calls at all), some hw access.

For the last type it is important to enable IOMMU during the probe().

>>>> If I understand right, the DL_FLAG_RPM_ACTIVE flag should be there from the
>>>> beginning, but that time it runtime pm part of links worked in a bit
>>>> different way than now.
>>> Right, and evidently there are callers depending on the existing behavior.
>>>
>>>> Is there any way to keep old behavior?
>>> Yes, there is, please test the appended v2 of the $subject patch.
>>>
>>> That said, I'd like to remove the extra supplier resume from there going
>>> forward as there may be callers who actually don't want that to happen and
>>> DL_FLAG_RPM_ACTIVE is there for a purpose.
>> Frankly, if the current behavior matches the designed behavior of
>> DL_FLAG_RPM_ACTIVE flag,
> It doesn't match the DL_FLAG_RPM_ACTIVE exactly as you've already noticed.
>
> DL_FLAG_RPM_ACTIVE assumes that the initial RPM status of the device
> will be RPM_ACTIVE and therefore the suppliers need to be resumed at
> link creation time.  Therefore device_link_add() causes the suppliers
> to remain in the RPM_ACTIVE state with the rpm_active status bit of
> the link set, whereas currently they are simply suspended again by the
> pm_runtime_put_suppliers() in driver_probe_device() and the link is
> not marked as "rpm_active".
>
>> then maybe instead of adding workarounds now, we
>> should simply fix all existing callers of device_link_add()? 'git grep'
>> shows
>> only 6 places where links are created with DL_FLAG_PM_RUNTIME flag, I see no
>> problem to add DL_FLAG_RPM_ACTIVE there to keep current behavior after a fix
>> in runtime PM core. The description of DL_FLAG_RPM_ACTIVE should also be
>> a bit
>> updated, because I initially thought that it means that the runtime pm
>> counter
>> on supplier is increased for the whole lifetime of the device link (it
>> is not
>> clear when core will call a corresponding pm_runtime_put()).
>>
>> The other question is what need to be fixed to get proper behavior
>> without the
>> additional suspend/resume cycle mentioned a few paragraphs above.
> As stated already, if the driver passes DL_FLAG_RPM_ACTIVE to
> device_link_add() at probe time, then the initial RPM status of the
> device being probed is expected to be RPM_ACTIVE.

Okay, then this doesn't match the case of Exynos IOMMU and JPEG (and other
Exynos multimedia drivers), because the links are created from the 
add_device
platform bus notifier, which is executed just before ->probe() callback of
the newly created jpeg/multimedia device. That time of course 
jpeg/multimedia
driver is not able to enable runtime PM of the handled device yet...

>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Subject: [PATCH v2] PM / core: Fix supplier device runtime PM usage counter imbalance
>>>
>>> If a device link is added via device_link_add() by the driver of the
>>> link's consumer device, the supplier's runtime PM usage counter is
>>> going to be dropped by the pm_runtime_put_suppliers() call in
>>> driver_probe_device().  However, in that case it is not incremented
>>> unless the supplier driver is already present and the link is not
>>> stateless.  That leads to a runtime PM usage counter imbalance for
>>> the supplier device in a few cases.
>>>
>>> To prevent that from happening, bump up the supplier runtime
>>> PM usage counter in device_link_add() for all links with the
>>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>>> time.  Use pm_runtime_get_noresume() for that as the callers of
>>> device_link_add() who want the supplier to be resumed by it are
>>> expected to pass DL_FLAG_RPM_ACTIVE in flags to it anyway, but
>>> additionally resume the supplier if the link is added during
>>> consumer driver probe to retain the existing behavior for the
>>> callers depending on it.
>>>
>>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> I've tested this version of the patch and it keeps the current behavior for
>> links created with DL_FLAG_PM_RUNTIME flag. The questions is if we really
>> want it?
> I think so.
>
> Basically, there are two changes at hand: fixing the behavior for
> stateless links (and for stateful ones if the supplier driver is not
> present, but that arguably is a corner case) and the behavior change
> for stateful links (with supplier drivers present).
>
> Arguably, the former is more important than the latter and I'd like to
> be able to push that fix into -stable without dependencies.  The
> latter can be done when all of the current callers depending on the
> existing behavior have been adjusted.
>
> So, I'm going to add a Tested-by from you to this patch, if you don't
> mind, and queue it up.

Okay, fine for me.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
