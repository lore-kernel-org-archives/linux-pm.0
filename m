From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control
 function
Date: Wed, 29 Apr 2015 10:50:57 +0100
Message-ID: <5540A981.6060209@arm.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <553F920D.6090404@arm.com> <2361707.7eGhMTvCz6@vostro.rjw.lan> <6185796.9I7OmaAAcQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <6185796.9I7OmaAAcQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Sudeep Holla <sudeep.holla@arm.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 29/04/15 02:04, Rafael J. Wysocki wrote:
> On Wednesday, April 29, 2015 02:50:22 AM Rafael J. Wysocki wrote:

[...]

>>
>> Below is the patch I came up with in the meantime.
>>
>> This moves the "switch to broadcast" timer logic into
>> cpuidle_enter_state() which allows tick_broadcast_exit() to be
>> called directly with interrupts disabled (as required), but
>> it also adds a fallback branch reflecting the 4.0 and earlier
>> behavior for idle states that enable interrupts on exit
>> from their ->enter callbacks.
>>
>> I'm not aware of any valid cases when CPUIDLE_FLAG_TIMER_STOP can be
>> set for such states, but people may try to add stuff like that in the
>> future, so it's better to catch that (hence the WARN_ON_ONCE) and do
>> our best to handle it gracefully anyway, IMO.
>>
>> The "if (entered_state == -EBUSY)" check is conservative.  It may
>> be better to do "if (entered_state < 0)" and fall back to the default
>> on all errors, but that's not what we do today (I guess the concern
>> would be "what if the state ->enter returns an error after entering
>> and exiting the idle state, in which case we may miss a wakeup event
>> if we fall back to the default").
>
> Actually, if my understanding of things is correct (the local clock event
> device cannot go away from under code executed with interrupts disabled
> on the local CPU), the simplified one below should be sufficient.
>

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
