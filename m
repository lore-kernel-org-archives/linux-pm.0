From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: Re: [RESEND PATCH v2 1/2] power/cpuidle: enhance the precision of
 state select
Date: Mon, 27 Jun 2016 09:13:55 +0800
Message-ID: <CAN2waFujOGS9HZT6usB7wPSTUZVCrwA1zj0uwnH9Gh=3a2m1EQ@mail.gmail.com>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com> <CAJZ5v0jzF6MuA7yQqYuDBCHDfG0cJZ_qtQvfbDL8dNw2XGDL_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jzF6MuA7yQqYuDBCHDfG0cJZ_qtQvfbDL8dNw2XGDL_Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, =?UTF-8?B?Wmhhb3lhbmcgSHVhbmcgKOm7hOacnemYsyk=?= <zhaoyang.huang@spreadtrum.com>, Thomas Gleixner <tglx@linutronix.de>, Geng Ren <geng.ren@spreadtrum.com>, Alex Wang <alex.wang@spreadtrum.com>
List-Id: linux-pm@vger.kernel.org

On 25 June 2016 at 09:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Jun 17, 2016 at 11:13 AM, Zhaoyang Huang
> <zhaoyang.huang@linaro.org> wrote:
>> In previous version, cpu_pm_enter is invoked
>
> By whom?  Not by the core surely?
>
>> after the governor select the state, which cause the executing time of cpu_pm_enter
>> is included in the idle time. Moving it before the state selection.
>>
>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
>> ---
>>  kernel/sched/idle.c |   18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index bd12c6c..929da2e 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/cpu.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpuhotplug.h>
>> +#include <linux/cpu_pm.h>
>>  #include <linux/tick.h>
>>  #include <linux/mm.h>
>>  #include <linux/stackprotector.h>
>> @@ -130,6 +131,7 @@ static void cpuidle_idle_call(void)
>>         struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
>>         struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>>         int next_state, entered_state;
>> +       int ret;
>>
>>         /*
>>          * Check if the idle task must be rescheduled. If it is the
>> @@ -174,12 +176,16 @@ static void cpuidle_idle_call(void)
>>                 /*
>>                  * Ask the cpuidle framework to choose a convenient idle state.
>>                  */
>> -               next_state = cpuidle_select(drv, dev);
>> -               entered_state = call_cpuidle(drv, dev, next_state);
>> -               /*
>> -                * Give the governor an opportunity to reflect on the outcome
>> -                */
>> -               cpuidle_reflect(dev, entered_state);
>> +               ret = cpu_pm_enter();
>
> "To move" usually means "take it away from there and put it here" as
> far as kernel patches are concerned, but I only see it added here.
>
The API is provided by kernel, while invoked by cpuidle driver now. We
have ever move 'CPUFREQ_PRECHANGE' from cpufreq driver to framework. I
do the same thing here.

>> +               if (!ret) {
>> +                       next_state = cpuidle_select(drv, dev);
>> +                       entered_state = call_cpuidle(drv, dev, next_state);
>> +                       cpu_pm_exit();
>> +                       /*
>> +                        * Give the governor an opportunity to reflect on the outcome
>> +                        */
>> +                       cpuidle_reflect(dev, entered_state);
>> +               }
>>         }
>>
>>  exit_idle:
>> --
>
> No way I will agree to add that notification stuff to the core.
>
It is not add, just move.
> Thanks,
> Rafael
