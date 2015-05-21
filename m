From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/2] Adds cpu power accounting per-pid basis.
Date: Thu, 21 May 2015 16:34:43 +0200
Message-ID: <555DED03.9070002@linaro.org>
References: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Ruchi,

On 05/15/2015 02:12 AM, Ruchi Kandoi wrote:
> These patches add a mechanism which will accurately caculate the CPU =
power
> used by all the processes in the system. In order to account for the =
power
> used by all the processes a data field "cpu_power" has been added in =
the
> task_struct.

The term 'energy' makes more sense than 'power'.

> This field adds power for both the system as well as user
> time. cpu_power contains the total amount of charge(in uAmsec units) =
used

Why not use the Joules unit ?

> by the process. This model takes into account the frequency at which =
the
> process was running(i.e higher power for processes running at higher
> frequencies). It requires the cpufreq_stats module to be initialized =
with
> the current numbers for each of the CPU core at each frequency. This =
will
> be initialized during init time.

The energy task accounting is an interesting feature in my opinion. But=
=20
your patchset does not deal with the power management hardware complexi=
ty.

If we reduce the scope of the task energy accounting to the cpu, we are=
=20
facing several issues:

  * A cpu may be supposed to run at a specific OPP but it could share a=
=20
clock line with another cpu which is in a higher frequency. So the=20
frequency is actually at a higher rate than what is assumed

  * The firmware may override the cpufreq decisions

  * A process may be idle but its behavior forces the cpuidle governor=20
to choose shallow states (that won't occur without the process). For=20
example, the process is using very short timers, does a small processin=
g=20
and then go to sleep again waiting for the next timer expiration. The=20
result will be a process having a low energy consumption but actually=20
because of these timers, it will prevent the cpu to enter deep idle sta=
te

Beside that, the process may be soliciting a subsystem (another process=
=20
or hardware) which consumes a lot of energy. That won't be accounted=20
even if the process is responsible of this extra consumption.

And the last point is: how do you expect to have the energy numbers as=20
nobody is willing to share them for their platform ?

> Ruchi Kandoi (2):
>    cpufreq_stats: Adds sysfs file
>      /sys/devices/system/cpu/cpufreq/current_in_state
>    sched: cpufreq: Adds a field cpu_power in the task_struct
>
>   drivers/cpufreq/cpufreq_stats.c | 191 +++++++++++++++++++++++++++++=
++++++++++-
>   include/linux/cpufreq.h         |   8 ++
>   include/linux/sched.h           |   2 +
>   kernel/fork.c                   |   1 +
>   kernel/sched/cputime.c          |   7 ++
>   5 files changed, 207 insertions(+), 2 deletions(-)



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
