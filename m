From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/1] device core: Add flag to autoremove device link on
 supplier unbind
Date: Tue, 26 Jun 2018 15:33:44 +0530
Message-ID: <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
References: <20180530095704.5788-1-vivek.gautam@codeaurora.org>
 <a85d44e7-3bb1-f282-088d-c4311a108bcd@intel.com> <541c84e9-47fc-e7bc-8249-1477b9e63455@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <541c84e9-47fc-e7bc-8249-1477b9e63455@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, lukas@wunner.de, dmitry.torokhov@gmail.com, aspriel@gmail.com, Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 30, 2018 at 6:21 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:

Adding Ulf and Marek for their side of comments.
In summary, we do not want to not maintain a device link pointer
when adding a device link in supplier's driver, to delete the link later.
An autoremove flag from the suppliers side (similar to what we already
have for consumer side) can help autoremove the device link
when supplier driver goes away.

Hi Rafael, Lukas,
Gentle ping. Can you please consider reviewing this patch.

Best regards
Vivek

> Hi Rafael,
>
>
> On 5/30/2018 4:29 PM, Rafael J. Wysocki wrote:
>>
>> On 5/30/2018 11:57 AM, Vivek Gautam wrote:
>>>
>>> When using the device links without the consumers or
>>> suppliers maintaining pointers to these links, a flag can
>>> help in autoremoving the links on supplier driver unbind.
>>> We remove these links only when the supplier's link to its
>>> consumers has gone in DL_STATE_SUPPLIER_UNBIND state.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>> ---
>>>
>>> Lukas, as suggested in the thread [1] this change adds additional flag
>>> to autoremove device links on supplier unbind.
>>> For arm-smmu, we want to _not_ keep references to the device links
>>> added between arm-smmu, and consumer devices.
>>> Robin also pointed to [2] the need to autoremove the device link on
>>> supplier unbind rather than consumer unbind.
>>
>>
>> Please CC device links patches to linux-pm.
>
>
> Thanks for the quick review. Sure, will keep this noted from now on.
>
>
>>
>>> [1] https://lkml.org/lkml/2018/3/14/390
>>> [2] https://lkml.org/lkml/2018/5/21/381
>>>
>>>   drivers/base/core.c    | 10 ++++++++++
>>>   include/linux/device.h |  2 ++
>>>   2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index b610816eb887..52c7222bb3c4 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -490,6 +490,16 @@ void device_links_driver_cleanup(struct device *dev)
>>>             WARN_ON(link->flags & DL_FLAG_AUTOREMOVE);
>>>           WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
>>> +
>>> +        /*
>>> +         * autoremove the links between this @dev and its consumer
>>> +         * devices that are not active, i.e. where the link state
>>> +         * has moved to DL_STATE_SUPPLIER_UNBIND.
>>> +         */
>>> +        if (link->status == DL_STATE_SUPPLIER_UNBIND &&
>>> +            link->flags & DL_FLAG_AUTOREMOVE_S)
>>> +            kref_put(&link->kref, __device_link_del);
>>> +
>>>           WRITE_ONCE(link->status, DL_STATE_DORMANT);
>>>       }
>>>   diff --git a/include/linux/device.h b/include/linux/device.h
>>> index 477956990f5e..6033bf58453d 100644
>>> --- a/include/linux/device.h
>>> +++ b/include/linux/device.h
>>> @@ -779,11 +779,13 @@ enum device_link_state {
>>>    * AUTOREMOVE: Remove this link automatically on consumer driver
>>> unbind.
>>>    * PM_RUNTIME: If set, the runtime PM framework will use this link.
>>>    * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link
>>> creation.
>>> + * AUTOREMOVE_S: Remove this link automatically on supplier driver
>>> unbind.
>>>    */
>>>   #define DL_FLAG_STATELESS    BIT(0)
>>>   #define DL_FLAG_AUTOREMOVE    BIT(1)
>>>   #define DL_FLAG_PM_RUNTIME    BIT(2)
>>>   #define DL_FLAG_RPM_ACTIVE    BIT(3)
>>> +#define DL_FLAG_AUTOREMOVE_S    BIT(4)
>>
>>
>> Couldn't you invent a better name for this one?
>
>
> Frankly, I wanted to have something like DL_FLAG_AUTOREMOVE_SUPPLIER, but
> that
> felt a bit too long considering other flags.
> Can you please consider suggesting a concise name?
>
> Regards
> Vivek
>
>>
>>>     /**
>>>    * struct device_link - Device link representation.
>>
>>
>>
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
