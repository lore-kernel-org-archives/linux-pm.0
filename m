From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/5] sched: idle: Get the next timer event and pass it
 the cpuidle framework
Date: Tue, 28 Oct 2014 19:02:01 +0100
Message-ID: <544FDA19.4070705@linaro.org>
References: <1413822343-1972-1-git-send-email-daniel.lezcano@linaro.org>	<1413822343-1972-2-git-send-email-daniel.lezcano@linaro.org> <CAM4v1pOzC2riePt4sfsdG=SLYvZmhMc4KgT-hfq6XkjF2Mce7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM4v1pOzC2riePt4sfsdG=SLYvZmhMc4KgT-hfq6XkjF2Mce7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti Murthy <preeti.lkml@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 10/28/2014 07:40 AM, Preeti Murthy wrote:
> Hi Daniel,
>
> On Mon, Oct 20, 2014 at 9:55 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> Following the logic of the previous patch, retrieve from the idle ta=
sk the
>> expected timer sleep duration and pass it to the cpuidle framework.
>>
>> Take the opportunity to remove the unused headers in the menu.c file=
=2E
>>
>> This patch does not change the current behavior.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/cpuidle/cpuidle.c          | 11 +++++------
>>   drivers/cpuidle/governors/ladder.c |  3 ++-
>>   drivers/cpuidle/governors/menu.c   |  8 ++------
>>   include/linux/cpuidle.h            |  8 +++++---
>>   kernel/sched/idle.c                | 16 ++++++++++++----
>>   5 files changed, 26 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 372c36f..64f5800 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -8,16 +8,12 @@
>>    * This code is licenced under the GPL.
>>    */
>>
>> -#include <linux/clockchips.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mutex.h>
>> -#include <linux/sched.h>
>>   #include <linux/notifier.h>
>>   #include <linux/pm_qos.h>
>>   #include <linux/cpu.h>
>>   #include <linux/cpuidle.h>
>> -#include <linux/ktime.h>
>> -#include <linux/hrtimer.h>
>>   #include <linux/module.h>
>>   #include <trace/events/power.h>
>>
>> @@ -155,11 +151,13 @@ int cpuidle_enter_state(struct cpuidle_device =
*dev, struct cpuidle_driver *drv,
>>    *
>>    * @drv: the cpuidle driver
>>    * @dev: the cpuidle device
>> + * @latency_req: the latency constraint when choosing an idle state
>
> You might want to include this change in the previous patch itself.

Ah, yes. Thanks.

>> + * @next_timer_event: the duration until the timer expires
>>    *
>>    * Returns the index of the idle state.
>>    */
>
> Regards
> Preeti U Murthy
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
