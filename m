From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/3] cpuidle,menu: use interactivity_req to disable
 polling
Date: Thu, 14 Jan 2016 10:33:36 +0000
Message-ID: <56977980.8080009@arm.com>
References: <1446590059-18897-1-git-send-email-riel@redhat.com>
 <1446590059-18897-3-git-send-email-riel@redhat.com>
 <CAPKp9ubg3V0979dGTGi+kjXGiBczCG2+QBGgfrZBKjMgSuhy-A@mail.gmail.com>
 <CAJZ5v0ipLZ3o_f_bZ=ddhvx=_OrGwzZq0bbzo7tSNbu_JDJd1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45219 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbcANKdk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jan 2016 05:33:40 -0500
In-Reply-To: <CAJZ5v0ipLZ3o_f_bZ=ddhvx=_OrGwzZq0bbzo7tSNbu_JDJd1Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, riel@redhat.com, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, arjan@linux.intel.com, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>



On 13/01/16 21:58, Rafael J. Wysocki wrote:
> Hi,
>
> On Wed, Jan 13, 2016 at 6:27 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi Rik,
>>
>> This change break idle on ARM64(may be on other ARM?) platform.
>> Sorry for reporting late, but missed to check cpuidle in -next.
>
> OK, so first of all, how exactly is idle broken on those systems?
>

Sorry for the hasty bug report.

> Do they crash or does something different happen?  If something
> different happens, then what's that?
>

No they just don't enter any idle states(as if CPUIdle was disabled)

[...]

>>
>> diff --git i/drivers/cpuidle/governors/menu.c w/drivers/cpuidle/governors/menu.c
>> index 7b0971d97cc3..7c7f4059705a 100644
>> --- i/drivers/cpuidle/governors/menu.c
>> +++ w/drivers/cpuidle/governors/menu.c
>> @@ -330,7 +330,8 @@ static int menu_select(struct cpuidle_driver *drv,
>> struct cpuidle_device *dev)
>>           * We want to default to C1 (hlt), not to busy polling
>>           * unless the timer is happening really really soon.
>>           */
>> -       if (interactivity_req > 20 &&
>> +       if (((interactivity_req && interactivity_req > 20) ||
>
> Well, if interactivity_req > 20, then it also is different from 0, so
> the first check should not be necessary here.
>

True, I just wanted to avoid using interactivity_req when 0, it was just
a quick hack.

>> +               data->next_timer_us > 20) &&
>
> I guess that this simply restores the previous behavior on the
> platforms in question.
>

Yes.

> Now, the reason why it may matter is because
> CPUIDLE_DRIVER_STATE_START is 0 and so data->last_state_idx may end up
> as -1 on them.  So I think this piece of code only ever makes sense if
> CPUIDLE_DRIVER_STATE_START is 1.
>

That's correct.

-- 
Regards,
Sudeep
