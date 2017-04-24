From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely
 since 4.6
Date: Mon, 24 Apr 2017 02:59:10 +0200
Message-ID: <CAJZ5v0gBhVOYJ5a7YWpRHSH20qx3Cjx_Lg0qk52st-p+fQS9bQ@mail.gmail.com>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>
 <000a01d2b9e6$393afef0$abb0fcd0$@net> <000301d2bb31$c0037790$400a66b0$@net> <000501d2bc46$ad4b1fc0$07e15f40$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34610 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163813AbdDXA7L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Apr 2017 20:59:11 -0400
In-Reply-To: <000501d2bc46$ad4b1fc0$07e15f40$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mel Gorman <mgorman@techsingularity.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>, =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Sun, Apr 23, 2017 at 5:31 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2017.04.22 14:08 Rafael wrote:
>> On Friday, April 21, 2017 11:29:06 PM Doug Smythies wrote:
>>> On 2017.04.20 18:18 Rafael wrote:
>>>> On Thursday, April 20, 2017 07:55:57 AM Doug Smythies wrote:
>>>>> On 2017.04.19 01:16 Mel Gorman wrote:
>>>>>> On Fri, Apr 14, 2017 at 04:01:40PM -0700, Doug Smythies wrote:
>>>>>>> Hi Mel,
>>>>
>>>> [cut]
>>>>
>>>>>> And the revert does help albeit not being an option for reasons Rafael
>>>>>> covered.
>>>>>
>>>>> New data point: Kernel 4.11-rc7  intel_pstate, powersave forcing the
>>>>> load based algorithm: Elapsed 3178 seconds.
>>>>>
>>>>> If I understand your data correctly, my load based results are the opposite of yours.
>>>>>
>>>>> Mel: 4.11-rc5 vanilla: Elapsed mean: 3750.20 Seconds
>>>>> Mel: 4.11-rc5 load based: Elapsed mean: 2503.27 Seconds
>>>>> Or: 33.25%
>>>>>
>>>>> Doug: 4.11-rc6 stock: Elapsed total (5 runs): 2364.45 Seconds
>>>>> Doug: 4.11-rc7 force load based: Elapsed total (5 runs): 3178 Seconds
>>>>> Or: -34.4%
>>>>
>>>> I wonder if you can do the same thing I've just advised Mel to do.  That is,
>>>> take my linux-next branch:
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>>>>
>>>> (which is new material for 4.12 on top of 4.11-rc7) and reduce
>>>> INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL (in intel_pstate.c) in it by 1/2
>>>> (force load-based if need be, I'm not sure what PM profile of your test system
>>>> is).
>>>
>>> I did not need to force load-based. I do not know how to figure it out from
>>> an acpidump the way Srinivas does. I did a trace and figured out what algorithm
>>> it was using from the data.
>>>
>>> Reference test, before changing INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL:
>>> 3239.4 seconds.
>>>
>>> Test after changing INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL:
>>> 3195.5 seconds.
>>
>> So it does have an effect, but relatively small.
>
> I don't know how repeatable the tests results are.
> i.e. I don't know if the 1.36% change is within experimental
> error or not. That being said, the trend does seem consistent.
>
>> I wonder if further reducing INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL to 2 ms
>> will make any difference.
>
> I went all the way to 1 ms, just for the test:
> 3123.9 Seconds
>
>>> By far, and with any code, I get the fastest elapsed time, of course next
>>> to performance mode, but not by much, by limiting the test to only use
>>> just 1 cpu: 1814.2 Seconds.
>>
>> Interesting.
>>
>> It looks like the cost is mostly related to moving the load from one CPU to
>> another and waiting for the new one to ramp up then.
>>
>> I guess the workload consists of many small tasks that each start on new CPUs
>> and cause that ping-pong to happen.
>
> Yes, and (from trace data) many tasks are very very very small. Also the test
> appears to take a few holidays, of up to 1 second, during execution.
>
>>> (performance governor, restated from a previous e-mail: 1776.05 seconds)
>>
>> But that causes the processor to stay in the maximum sustainable P-state all
>> the time, which on Sandy Bridge is quite costly energetically.
>
> Agreed. I only provide these data points as a reference and so that we know
> what the boundary conditions (limits) are.
>
>> We can do one more trick I forgot about.  Namely, if we are about to increase
>> the P-state, we can jump to the average between the target and the max
>> instead of just the target, like in the appended patch (on top of linux-next).
>>
>> That will make the P-state selection really aggressive, so costly energetically,
>> but it shoud small jumps of the average load above 0 to case big jumps of
>> the target P-state.
>
> I'm already seeing the energy costs of some of this stuff.
> 3050.2 Seconds.

Is this with or without reducing the sampling interval?

> Idle power 4.06 Watts.
>
> Idle power for kernel 4.11-rc7 (performance-based): 3.89 Watts.
> Idle power for kernel 4.11-rc7, using load-based: 4.01 watts
> Idle power for kernel 4.11-rc7 next linux-pm: 3.91 watts

Power draw differences are not dramatic, so this might be a viable
change depending on the influence on the results elsewhere.

Anyway, your results are somewhat counter-intuitive.

Would it be possible to run this workload with the linux-next branch
and the schedutil governor and see if the patch at
https://patchwork.kernel.org/patch/9671829/ makes any difference?

Thanks,
Rafael
