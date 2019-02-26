From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Tue, 26 Feb 2019 22:31:01 +0100
Message-ID: <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
References: <20190226145415.19411-1-ulf.hansson@linaro.org> <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>Linux
List-Id: linux-pm@vger.kernel.org

On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v11:
> >  - This version contains only the infrastructure changes that is needed for
> > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > post them separately. Still, to provide completeness, I have published a branch
> > containing everything to a git tree [1], feel free to have a look and test.
> >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > which has been replaced by a couple of new patches, whom reworks the existing
> > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > instead of the duration.
> >  - More changelogs are available per patch.
>
> NAK for patches [4-6/8].
>
> The code as is specifically avoids calling ktime_get() from the
> governors as that can be quite expensive, so these patches potentially
> make things worse.

Yeah, good point! What do you think about folding in a patch into the
series, like below, and then let the cpuidle governors use it?

One questions about when CONFIG_NO_HZ_COMMON is unset for the below
suggested code, does it make sense to "return -1" for that case, or
should I return ktime_get()? Does it matter?

Thanks for reviewing!

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Feb 2019 21:43:46 +0100
Subject: [PATCH] time: tick-sched: Add a helper function returning the idle
 entry time

To avoid calling ktime_get() unnecessary times during the idle path, let's
export the timestamp we stored in the per CPU variable,
tick_cpu_sched.idle_entrytime, at the point when we entered idle.

Following changes to the cpuidle governors makes use of this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/tick.h     |  2 ++
 kernel/time/tick-sched.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 5b10a0e4acbb..b641f6e4a50f 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -126,6 +126,7 @@ extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern ktime_t tick_nohz_get_next_timer(void);
+extern ktime_t tick_nohz_get_idle_entrytime(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
@@ -158,6 +159,7 @@ static inline ktime_t
tick_nohz_get_sleep_length(ktime_t *delta_next)
        *delta_next = TICK_NSEC;
        return *delta_next;
 }
+static inline ktime_t tick_nohz_get_idle_entrytime(void) { return -1; }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9966be665074..e5d66b618bfa 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1127,6 +1127,16 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
        return ktime_sub(next_event, now);
 }

+/**
+ * tick_nohz_get_idle_entrytime - return the time when we entered idle
+ *
+ * Called from power state control code with interrupts disabled
+ */
+ktime_t tick_nohz_get_idle_entrytime(void)
+{
+       return __this_cpu_read(tick_cpu_sched.idle_entrytime);
+}
+
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
-- 
2.17.1
