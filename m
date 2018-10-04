From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Date: Thu, 4 Oct 2018 10:47:04 +0200
Message-ID: <CAJZ5v0i+TMAeaMp8D8qGph1VZKg0L23RsqdPMEQ0xHhpTCHgQA@mail.gmail.com>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iLAtfo0w=BE-G+YW1WAxXsAdveiRvNhBSkpVPsd+TC9A@mail.gmail.com> <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 4, 2018 at 10:40 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 04/10/2018 10:22, Rafael J. Wysocki wrote:
> > On Thu, Oct 4, 2018 at 9:42 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[cut]

> >> -               interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> >> +               interactivity_req = data->predicted_us /
> >> +                       performance_multiplier(nr_iowaiters);
> >
> > I wouldn't break this line.
>
> Ok, mind if I break the line in a separate patch before ? (my git
> pre-commit hook runs checkpatch and it complains and prevent to commit
> the patch because of the line length (94)).

OK, just keep it the way it is, then.  I can remove the line break
before applying the patch easily enough. :-)

> >>                 if (latency_req > interactivity_req)
> >>                         latency_req = interactivity_req;
> >>         }
> >> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> >> index 04f1321..f30954c 100644
> >> --- a/include/linux/sched/stat.h
> >> +++ b/include/linux/sched/stat.h
> >> @@ -20,7 +20,6 @@ extern unsigned long nr_running(void);
> >>  extern bool single_task_running(void);
> >>  extern unsigned long nr_iowait(void);
> >>  extern unsigned long nr_iowait_cpu(int cpu);
> >> -extern void get_iowait_load(unsigned long *nr_waiters, unsigned long *load);
> >>
> >>  static inline int sched_info_on(void)
> >>  {
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index b88a145..5605f03 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -2873,25 +2873,12 @@ unsigned long long nr_context_switches(void)
> >>
> >>         return sum;
> >>  }
> >> -/*
> >> - * Consumers of these two interfaces, like for example the cpufreq menu
> >> - * governor are using nonsensical data. Boosting frequency for a CPU that has
> >> - * IO-wait which might not even end up running the task when it does become
> >> - * runnable.
> >> - */
> >
> > Doesn't the comment still apply to nr_iowait_cpu()?
>
> The comment is very confusing. I talks about a cpufreq menu governor and
> boosting frequency.

So it should be talking about the *cpuidle* menu governor and
preferring shallow idle state selection.

I guess I'll send a patch to update it. :-)

> I don't see this function used in the cpufreq framework but in:
>
> kernel/time/tick-sched.c
> fs/proc/stat.c
> drivers/cpuidle/governors/menu.c
>
> The comment is irrelevant as the remaining function is used for
> statistics in addition to the perf multiplier. It does exactly what the
> function name is.

Which is my point.  It shouldn't be dropped entirely, but updated IMO.
