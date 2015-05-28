From: Ruchi Kandoi <kandoiruchi@google.com>
Subject: Re: [PATCH v2 0/2] Adds cpu power accounting per-pid basis.
Date: Thu, 28 May 2015 12:37:09 -0700
Message-ID: <CAL8qYTNJrjWB8=pb9mOH+wsWS5cQ18bGBQe+j82AOFzxsxpSiQ@mail.gmail.com>
References: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
	<555DED03.9070002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34287 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbbE1ThK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 15:37:10 -0400
Received: by obew15 with SMTP id w15so41392415obe.1
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2015 12:37:09 -0700 (PDT)
In-Reply-To: <555DED03.9070002@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 21, 2015 at 7:34 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> Hi Ruchi,
>
> On 05/15/2015 02:12 AM, Ruchi Kandoi wrote:
>>
>> These patches add a mechanism which will accurately caculate the CPU=
 power
>> used by all the processes in the system. In order to account for the=
 power
>> used by all the processes a data field "cpu_power" has been added in=
 the
>> task_struct.
>
>
> The term 'energy' makes more sense than 'power'.

>> This field adds power for both the system as well as user
>> time. cpu_power contains the total amount of charge(in uAmsec units)=
 used
>
>
> Why not use the Joules unit ?
>
Because most of the devices working on battery has their capacity
defined in mAh(to avoid floating point and to prevent losing precision
uAmsec is used). It will be be easier to keep it in that unit so that
it can be aggregated when we are trying to find the total capacity
which was used by a process(which will be combined for a particular
application).

>> by the process. This model takes into account the frequency at which=
 the
>> process was running(i.e higher power for processes running at higher
>> frequencies). It requires the cpufreq_stats module to be initialized=
 with
>> the current numbers for each of the CPU core at each frequency. This=
 will
>> be initialized during init time.
>
>
> The energy task accounting is an interesting feature in my opinion. B=
ut your
> patchset does not deal with the power management hardware complexity.
>
> If we reduce the scope of the task energy accounting to the cpu, we a=
re
> facing several issues:
>
>  * A cpu may be supposed to run at a specific OPP but it could share =
a clock
> line with another cpu which is in a higher frequency. So the frequenc=
y is
> actually at a higher rate than what is assumed
>
>  * The firmware may override the cpufreq decisions
>
>  * A process may be idle but its behavior forces the cpuidle governor=
 to
> choose shallow states (that won't occur without the process). For exa=
mple,
> the process is using very short timers, does a small processing and t=
hen go
> to sleep again waiting for the next timer expiration. The result will=
 be a
> process having a low energy consumption but actually because of these
> timers, it will prevent the cpu to enter deep idle state
>
> Beside that, the process may be soliciting a subsystem (another proce=
ss or
> hardware) which consumes a lot of energy. That won't be accounted eve=
n if
> the process is responsible of this extra consumption.
>
True, there will be cases where the accounting for the energy/power
will be deceptive, because we are not taking into consideration the
idle time and time intervals between which the process is running.
This was aimed to be a simplistic model where only the active time for
the process were taken into account and the processes were blamed for
the active power that they are consuming.
 There are similar efforts for other subsystem too which will be
keeping track of the subsystem power used by a particular pid/uid.

> And the last point is: how do you expect to have the energy numbers a=
s
> nobody is willing to share them for their platform ?
>
This is a tough question. Yes it is difficult to get these numbers,
but I don't think it is unfeasible. We get some numbers from SoC
vendors for the CPUs, trying to drive it to a point where we can get
more accurate numbers.
>> Ruchi Kandoi (2):
>>    cpufreq_stats: Adds sysfs file
>>      /sys/devices/system/cpu/cpufreq/current_in_state
>>    sched: cpufreq: Adds a field cpu_power in the task_struct
>>
>>   drivers/cpufreq/cpufreq_stats.c | 191
>> +++++++++++++++++++++++++++++++++++++++-
>>   include/linux/cpufreq.h         |   8 ++
>>   include/linux/sched.h           |   2 +
>>   kernel/fork.c                   |   1 +
>>   kernel/sched/cputime.c          |   7 ++
>>   5 files changed, 207 insertions(+), 2 deletions(-)
>
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
