From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
Date: Fri, 30 May 2014 13:34:45 +0200
Message-ID: <53886CD5.8010301@gmail.com>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org> <53594D17.6020107@samsung.com> <53884FD2.7020700@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40050 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbaE3LfB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 07:35:01 -0400
In-Reply-To: <53884FD2.7020700@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, kgene.kim@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, ccross@google.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Daniel,

On 30.05.2014 11:30, Daniel Lezcano wrote:
> On 04/24/2014 07:42 PM, Tomasz Figa wrote:
>> Hi Daniel,
>>
>> Please see my comments inline.
>>
>> Btw. Please fix your e-mail composer to properly wrap your messages
>> around 7xth column, as otherwise they're hard to read.
>>
>> On 04.04.2014 11:48, Daniel Lezcano wrote:
>>> The following driver is for exynos4210. I did not yet finished the
>>> other boards, so
>>> I created a specific driver for 4210 which could be merged later.
>>>
>>> The driver is based on Colin Cross's driver found at:
>>>
>>> https://android.googlesource.com/kernel/exynos/+/e686b1ec67423c40b4fdf811f9a4dfa3b393a010%5E%5E!/
>>>
>>>
>>>
>>> This one was based on a 3.4 kernel and an old API.
>>>
>>> It has been refreshed, simplified and based on the recent code cleanup
>>> I sent
>>> today.
>>>
>>> The AFTR could be entered when all the cpus (except cpu0) are down. In
>>> order to
>>> reach this situation, the couple idle states are used.
>>>
>>> There is a sync barrier at the entry and the exit of the low power
>>> function. So
>>> all cpus will enter and exit the function at the same time.
>>>
>>> At this point, CPU0 knows the other cpu will power down itself. CPU0
>>> waits for
>>> the CPU1 to be powered down and then initiate the AFTR power down
>>> sequence.
>>>
>>> No interrupts are handled by CPU1, this is why we switch to the timer
>>> broadcast
>>> even if the local timer is not impacted by the idle state.
>>>
>>> When CPU0 wakes up, it powers up CPU1 and waits for it to boot. Then
>>> they both
>>> exit the idle function.
>>>
>>> This driver allows the exynos4210 to have the same power consumption
>>> at idle
>>> time than the one when we have to unplug CPU1 in order to let CPU0 to
>>> reach
>>> the AFTR state.
>>>
>>> This patch is a RFC because, we have to find a way to remove the macros
>>> definitions and cpu powerdown function without pulling the arch
>>> dependent
>>> headers.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   arch/arm/mach-exynos/common.c        |   11 +-
>>>   drivers/cpuidle/Kconfig.arm          |    8 ++
>>>   drivers/cpuidle/Makefile             |    1 +
>>>   drivers/cpuidle/cpuidle-exynos4210.c |  226
>>> ++++++++++++++++++++++++++++++++++
> 
> [ ... ]
> 
> 
>> Otherwise, I quite like the whole idea. I need to play a bit with CPU
>> hotplug and PMU to verify that things couldn't really be simplified a
>> bit, but in general this looks reasonably.
> 
> Hi Tomasz,
> 
> did you have time to look at this simplification ?

Unfortunately I got preempted with other things to do and now I'm on
vacation. I worked a bit with Bart (added on CC) on this and generally
the conclusion was that all the things are necessary. He was also
working to extend the driver to support Exynos4x12.

Bart, has anything interesting showed up since we talked about this last
time?

Best regards,
Tomasz
