From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/2] trace: power allocator: add trace for divvyup
 algorithm
Date: Mon, 8 May 2017 15:58:25 +0100
Message-ID: <78de7691-32ee-3703-5e6b-0d0da12c55fd@arm.com>
References: <1494250802-6663-1-git-send-email-lukasz.luba@arm.com>
 <1494250802-6663-3-git-send-email-lukasz.luba@arm.com>
 <20170508094432.1010ee75@gandalf.local.home>
 <cf2867c3-8a26-7b05-a209-dd82d7ca7292@arm.com>
 <20170508103714.1ad473b1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754152AbdEHO62 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 May 2017 10:58:28 -0400
In-Reply-To: <20170508103714.1ad473b1@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Ingo Molnar <mingo@redhat.com>


On 08/05/17 15:37, Steven Rostedt wrote:
> On Mon, 8 May 2017 15:21:53 +0100
> Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>> Hi Steven,
>>
>> On 08/05/17 14:44, Steven Rostedt wrote:
>>> On Mon,  8 May 2017 14:40:02 +0100
>>> Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>>> This trace function helps to figure out the divvyup algorithm
>>>> on some platforms.
>>>>
>>>> CC: Steven Rostedt <rostedt@goodmis.org>
>>>> CC: Ingo Molnar <mingo@redhat.com>
>>>> CC: Zhang Rui <rui.zhang@intel.com>
>>>> CC: Eduardo Valentin <edubezval@gmail.com>
>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> ---
>>>>  drivers/thermal/power_allocator.c              |  4 +++
>>>>  include/trace/events/thermal_power_allocator.h | 40 ++++++++++++++++++++++++++
>>>>  2 files changed, 44 insertions(+)
>>>>
>>>> diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
>>>> index db74e05..b71125a 100644
>>>> --- a/drivers/thermal/power_allocator.c
>>>> +++ b/drivers/thermal/power_allocator.c
>>>> @@ -331,6 +331,10 @@ static void siblings_grants(struct thermal_zone_device *tz,
>>>>  		total_avail_room += avail_room[i];
>>>>  	}
>>>>
>>>> +	trace_thermal_power_allocator_divvyup(tz, granted_power, avail_room,
>>>> +					      spare_power, max_power,
>>>> +					      num_actors);
>>>
>>> I'm curious, how big can "num_actors" be?
>> That's a good question.
>> Normally max is around 5 (2 CPU clusters + 3 devfreq devices).
>> However, when you have per-core DVFS for CPUs
>> and you have N cores (i.e. 32), then you can register N cooling
>> devices for them.
>
> Hmm, is it cores per CPU, or just cores? If I boot up a box with 240
> cores, can that N = 240?
If you can change the voltage and frequency (or even only the frequency
  - less efficient) independently for each core, then yes, you can
register N cpu cooling devices and can control them independently.
>
> An event has a max size of PAGE_SIZE - buffer_header, where
> sizeof(buffer_header) is usually 16. That means an event can be 4080
> bytes at most. An event has a 8 byte header (on large events), and
> ftrace adds another 8 bytes. The pay load of TRACE_EVENT is a max of
> 4064.
>
> Each dynamic_array has a 4 byte header, to save the size and offset of
> the array data. With two 4 byte fields, we have for this event, a
> minimum of 24 bytes. This gives up 1010 bytes per array. That gives us
> a max of num_actors = 252 before the event size is exhausted. The
> output of events has some limits but I'm not going into that.
>
> I'm guessing this wont be an issue anytime soon. If we do exhaust the
> size, the trace event will fail to allocate, and you'll just lose
> events. Nothing else will break.
Well, I don't know if some vendor is going to implement ARM platform
with more than 256 cores with per-core DVFS feature. In that case I 
would be really delighted to change the approach and support them.
>
> Just letting you know.
>
Thank you for this detailed information.

Regards,
Lukasz
