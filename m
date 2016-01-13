From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3] cpuidle,menu: use interactivity_req to disable polling
Date: Wed, 13 Jan 2016 22:58:13 +0100
Message-ID: <CAJZ5v0ipLZ3o_f_bZ=ddhvx=_OrGwzZq0bbzo7tSNbu_JDJd1Q@mail.gmail.com>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
	<1446590059-18897-3-git-send-email-riel@redhat.com>
	<CAPKp9ubg3V0979dGTGi+kjXGiBczCG2+QBGgfrZBKjMgSuhy-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34644 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcAMV6Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 16:58:16 -0500
In-Reply-To: <CAPKp9ubg3V0979dGTGi+kjXGiBczCG2+QBGgfrZBKjMgSuhy-A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: riel@redhat.com, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, arjan@linux.intel.com, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

Hi,

On Wed, Jan 13, 2016 at 6:27 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Rik,
>
> This change break idle on ARM64(may be on other ARM?) platform.
> Sorry for reporting late, but missed to check cpuidle in -next.

OK, so first of all, how exactly is idle broken on those systems?

Do they crash or does something different happen?  If something
different happens, then what's that?

> On Tue, Nov 3, 2015 at 10:34 PM,  <riel@redhat.com> wrote:
>> From: Rik van Riel <riel@redhat.com>
>>
>> The menu governor carefully figures out how much time we typically
>> sleep for an estimated sleep interval, or whether there is a repeating
>> pattern going on, and corrects that estimate for the CPU load.
>>
>> Then it proceeds to ignore that information when determining whether
>> or not to consider polling. This is not a big deal on most x86 CPUs,
>> which have very low C1 latencies, and the patch should not have any
>> effect on those CPUs.
>>
>> However, certain CPUs (eg. Atom) have much higher C1 latencies, and
>> it would be good to not waste performance and power on those CPUs if
>> we are expecting a very low wakeup latency.
>>
>> Disable polling based on the estimated interactivity requirement, not
>> on the time to the next timer interrupt.
>>
>> Signed-off-by: Rik van Riel <riel@redhat.com>
>> ---
>>  drivers/cpuidle/governors/menu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index ecc242a586c9..b1a55731f921 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -330,7 +330,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>>          * We want to default to C1 (hlt), not to busy polling
>>          * unless the timer is happening really really soon.
>>          */
>> -       if (data->next_timer_us > 20 &&
>> +       if (interactivity_req > 20 &&
>
> I found that data->predicted_us is gets overwritten in get_typical_interval
> when avg computed = 0 which is the case initially on boot when the past
> intervals are not yet accumulated.
>
> I just tried a hack and that seem to work and proved what I anticipated
> (i.e. interactivity_req = 0). Let me know if you have any clues on how to
> solve it ? I can help you getting the change tested.
>
> Regards,
> Sudeep
>
> --->8
>
> diff --git i/drivers/cpuidle/governors/menu.c w/drivers/cpuidle/governors/menu.c
> index 7b0971d97cc3..7c7f4059705a 100644
> --- i/drivers/cpuidle/governors/menu.c
> +++ w/drivers/cpuidle/governors/menu.c
> @@ -330,7 +330,8 @@ static int menu_select(struct cpuidle_driver *drv,
> struct cpuidle_device *dev)
>          * We want to default to C1 (hlt), not to busy polling
>          * unless the timer is happening really really soon.
>          */
> -       if (interactivity_req > 20 &&
> +       if (((interactivity_req && interactivity_req > 20) ||

Well, if interactivity_req > 20, then it also is different from 0, so
the first check should not be necessary here.

> +               data->next_timer_us > 20) &&

I guess that this simply restores the previous behavior on the
platforms in question.

Now, the reason why it may matter is because
CPUIDLE_DRIVER_STATE_START is 0 and so data->last_state_idx may end up
as -1 on them.  So I think this piece of code only ever makes sense if
CPUIDLE_DRIVER_STATE_START is 1.

>             !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
>                 dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
>                 data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
> --

Thanks,
Rafael
