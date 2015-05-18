From: Ruchi Kandoi <kandoiruchi@google.com>
Subject: Re: [PATCH v2 0/2] Adds cpu power accounting per-pid basis.
Date: Mon, 18 May 2015 14:00:31 -0700
Message-ID: <CAL8qYTNf2sFXEVOTMoSjsZVeA9gg33Eycq_C8jRVcYzAN9K7Pw@mail.gmail.com>
References: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
	<5555936A.7040304@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35119 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbbERVAc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 17:00:32 -0400
Received: by oign205 with SMTP id n205so128660978oig.2
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2015 14:00:31 -0700 (PDT)
In-Reply-To: <5555936A.7040304@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 14, 2015 at 11:34 PM, Heinrich Schuchardt
<xypron.glpk@gmx.de> wrote:
>
> On 15.05.2015 02:12, Ruchi Kandoi wrote:
> > These patches add a mechanism which will accurately caculate the CPU power
> > used by all the processes in the system. In order to account for the power
> > used by all the processes a data field "cpu_power" has been added in the
> > task_struct.
>
> Hello Ruchi,
>
> could you, please, explain why the CPU power consumption per task
> information is needed. Please, consider that the CPU causes only part of
> the total system power consumption which also comprises GPU, cooling,
> RAM, etc.

In order to accurately account for the battery used by each of the
process, keeping a track of how long the process ran is not
sufficient. Since running at different frequency has varying power
consumption, we want to track a power number which takes into
consideration the frequency as well as the core on which it was
running. There are similar efforts for other subsystems too to account
for the power used by each process which can then accurately be
aggregated for an application.
>
> The patch series increases the memory size of the kernel, the memory
> consumption per thread and the thread switching time. So, please,
> introduce a configuration switch to enable/disable the function.
>

Yes, configuration can be added. Will update that in the next patch.

> > This field adds power for both the system as well as user
> > time. cpu_power contains the total amount of charge(in uAmsec units) used
> > by the process.
>
> Is there any reasonable way to assign the power consumption to a single
> task if multiple tasks are executed on the same core at the same time
> (e.g. using hyperthreading)?
>
I think the power will be accounted for both the processes on their
respective cores. With hyperthreading, as far as kernel is concerned
they are running on different cores and the time for all the tasks
will be accounted appropriately and hence power. Correct me if I am
wrong.

> > This model takes into account the frequency at which the
> > process was running(i.e higher power for processes running at higher
> > frequencies). It requires the cpufreq_stats module to be initialized with
> > the current numbers for each of the CPU core at each frequency. This will
> > be initialized during init time.
>
> This does not account for power consumption depending on anything else
> but frequency, e.g. floating point commands consuming more power than NOPs.

Currently we have been able to get power numbers for a core when they
are active and running at a particular frequency. Agreed that will be
a better and more accurate mode.But getting the power numbers for the
type of instruction and keeping track of number of such instructions
will be cumbersome.
>
>
> Best regards
>
> Heinrich Schuchardt
> >
> > Ruchi Kandoi (2):
> >   cpufreq_stats: Adds sysfs file
> >     /sys/devices/system/cpu/cpufreq/current_in_state
> >   sched: cpufreq: Adds a field cpu_power in the task_struct
> >
> >  drivers/cpufreq/cpufreq_stats.c | 191 +++++++++++++++++++++++++++++++++++++++-
> >  include/linux/cpufreq.h         |   8 ++
> >  include/linux/sched.h           |   2 +
> >  kernel/fork.c                   |   1 +
> >  kernel/sched/cputime.c          |   7 ++
> >  5 files changed, 207 insertions(+), 2 deletions(-)
> >
>
