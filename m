From: Michele DiGiorgio <michele.digiorgio@arm.com>
Subject: Re: [PATCH] thermal: fix race condition when updating cooling device
Date: Mon, 27 Jun 2016 09:54:25 +0100
Message-ID: <5770E9C1.1010208@arm.com>
References: <1464877531-2161-1-git-send-email-michele.digiorgio@arm.com>
 <20160606125113.GC2897@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:33208 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751215AbcF0IzF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jun 2016 04:55:05 -0400
In-Reply-To: <20160606125113.GC2897@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Peter Feuerer <peter@piie.net>

Hi Eduardo, Rui,

On 06/06/16 13:51, Javi Merino wrote:
> On Thu, Jun 02, 2016 at 03:25:31PM +0100, Michele Di Giorgio wrote:
>> When multiple thermal zones are bound to the same cooling device, multiple
>> kernel threads may want to update the cooling device state by calling
>> thermal_cdev_update(). Having cdev not protected by a mutex can lead to a race
>> condition. Consider the following situation with two kernel threads k1 and k2:
>>
>>          Thread k1                           Thread k2
>>                                      ||
>>                                      ||  call thermal_cdev_update()
>>                                      ||      ...
>>                                      ||      set_cur_state(cdev, target);
>>      call power_actor_set_power()    ||
>>          ...                         ||
>>          instance->target = state;   ||
>>          cdev->updated = false;      ||
>>                                      ||      cdev->updated = true;
>>                                      ||      // completes execution
>>      call thermal_cdev_update()      ||
>>          // cdev->updated == true    ||
>>          return;                     ||
>>                                      \/
>>                                      time
>>
>> k2 has already looped through the thermal instances looking for the deepest
>> cooling device state and is preempted right before setting cdev->updated to
>> true. Now, k1 runs, modifies the thermal instance state and sets cdev->updated
>> to false. Then, k1 is preempted and k2 continues the execution by setting
>> cdev->updated to true, therefore preventing k1 from performing the update.
>> Notice that this is not an issue if k2 looks at the instance->target modified by
>> k1 "after" it is assigned by k1. In fact, in this case the update will happen
>> anyway and k1 can safely return immediately from thermal_cdev_update().
>>
>> This may lead to a situation where a thermal governor never updates the cooling
>> device. For example, this is the case for the step_wise governor: when calling
>> the function thermal_zone_trip_update(), the governor may always get a new state
>> equal to the old one (which, however, wasn't notified to the cooling device) and
>> will therefore skip the update.
>>
>> CC: Zhang Rui <rui.zhang@intel.com>
>> CC: Eduardo Valentin <edubezval@gmail.com>
>> CC: Peter Feuerer <peter@piie.net>
>> Reported-by: Toby Huang <toby.huang@arm.com>
>> Signed-off-by: Michele Di Giorgio <michele.digiorgio@arm.com>
>> ---
>> Protecting only the assignment of cdev->updated with mutexes may look
>> suspicious, but it is necessary to guarantee synchronization and avoiding the
>> situation described in the commit message.
>>
>> There are other two possible solutions.
>>
>> Moving the cdev->lock mutex outside thermal_cdev_update() and protect both the
>> assignment and the function. This would work, but will probably cause many
>> issues when updating all the modules that use thermal_cdev_update().
>>
>> The other solution is to make cdev->updated an atomic_t, change the if
>> condition to an atomic_cmpxchg and extend the critical section to include the
>> call to cdev->ops->set_cur_state().
>
> True.  In any case, the mutex needs to cover set_cur_state() in
> thermal_cdev_update().  This fixes the race condition, so I'm happy
> with it.
>
> Reviewed-by: Javi Merino <javi.merino@arm.com>
>
>>   drivers/thermal/fair_share.c      |  2 ++
>>   drivers/thermal/gov_bang_bang.c   |  2 ++
>>   drivers/thermal/power_allocator.c |  2 ++
>>   drivers/thermal/step_wise.c       |  2 ++
>>   drivers/thermal/thermal_core.c    | 10 +++++++---
>>   5 files changed, 15 insertions(+), 3 deletions(-)
>

If there are no comments/issues, could you please consider this for next
merge window?

Thanks,
Michele
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

