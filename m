From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] drivers: cpuidle: remove stale irq disabling call in cpuidle_enter_freeze()
Date: Thu, 26 Feb 2015 17:39:46 +0100
Message-ID: <CAJZ5v0ha2kA887_BKDNN2dJmseucXE9f-6-FhCNq-OuYpai5Ow@mail.gmail.com>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
	<54EDD883.30608@linaro.org>
	<20150225143917.GC20214@red-moon>
	<1789709.hzh3CkisvM@vostro.rjw.lan>
	<20150226094816.GA25057@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150226094816.GA25057@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 26, 2015 at 10:48 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Feb 25, 2015 at 11:36:10PM +0000, Rafael J. Wysocki wrote:
>> On Wednesday, February 25, 2015 02:39:17 PM Lorenzo Pieralisi wrote:
>> > On Wed, Feb 25, 2015 at 02:13:23PM +0000, Daniel Lezcano wrote:

[cut]

>> I'm not entirely against of re-arranging things here, but a patch like the
>> (untested) one below might be more appropriate.
>>
>> Rafael (who would appreciate it if people asked questions instead of sending
>> patches on a hunch).
>
> I understand that, I wanted to just send [patch 2], this patch was more
> a way to get a clarification than anything else, asking would have been more
> appropriate, sorry.
>
> Anyway, I did not like disabling IRQs to just re-enable them on function
> return, in particular the comment below seemed to apply to the following
> line, which is a bit misleading.

I see.

>
> /* Interrupts are enabled again here. */
> local_irq_disable();
>
>>
>>
>> ---
>>  drivers/cpuidle/cpuidle.c |    2 +-
>>  kernel/sched/idle.c       |    1 -
>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> Index: linux-pm/drivers/cpuidle/cpuidle.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
>> +++ linux-pm/drivers/cpuidle/cpuidle.c
>> @@ -132,6 +132,7 @@ void cpuidle_enter_freeze(void)
>>       index = cpuidle_find_deepest_state(drv, dev, true);
>>       if (index >= 0) {
>>               enter_freeze_proper(drv, dev, index);
>> +             local_irq_enable();
>>               return;
>>       }
>>
>> @@ -146,7 +147,6 @@ void cpuidle_enter_freeze(void)
>>               arch_cpu_idle();
>>
>>       /* Interrupts are enabled again here. */
>> -     local_irq_disable();
>>  }
>>
>>  /**
>> Index: linux-pm/kernel/sched/idle.c
>> ===================================================================
>> --- linux-pm.orig/kernel/sched/idle.c
>> +++ linux-pm/kernel/sched/idle.c
>> @@ -116,7 +116,6 @@ static void cpuidle_idle_call(void)
>>        */
>>       if (idle_should_freeze()) {
>>               cpuidle_enter_freeze();
>> -             local_irq_enable();
>>               goto exit_idle;
>>       }
>>
>
> It looks fine, I will test it. I would add a comment to
> cpuidle_enter_freeze() to document it must return with IRQs
> enabled.

OK

Rafael
