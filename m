From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kernel/...: Convert pr_warning to pr_warn
Date: Fri, 4 Mar 2016 22:23:50 +0100
Message-ID: <CAJZ5v0jWDLrFT2eLaY2hAi79wAkNyN8bEGigHbNaSR8NnieHJw@mail.gmail.com>
References: <1c47e70d5aa4ac129621e4c49a8b896b5cab4b64.1457092467.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1c47e70d5aa4ac129621e4c49a8b896b5cab4b64.1457092467.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-block@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 4, 2016 at 7:15 PM, Joe Perches <joe@perches.com> wrote:
> Use the more common logging method with the eventual goal
> of removing pr_warning altogether.
>
> Miscellanea:
>
> o Realign arguments
> o Coalesce formats
> o Add missing space between a few coalesced formats
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  kernel/irq/manage.c                  |  4 ++--
>  kernel/power/suspend.c               |  3 +--
>  kernel/time/tick-sched.c             |  8 ++++----
>  kernel/trace/blktrace.c              |  4 ++--
>  kernel/trace/ftrace.c                |  7 +++----
>  kernel/trace/trace.c                 | 40 ++++++++++++++++++------------------
>  kernel/trace/trace_functions_graph.c |  6 +++---
>  kernel/trace/trace_kprobe.c          | 27 ++++++++++--------------
>  kernel/trace/trace_mmiotrace.c       |  2 +-
>  kernel/trace/trace_probe.c           |  4 ++--
>  kernel/trace/trace_stat.c            |  3 +--
>  kernel/trace/trace_uprobe.c          |  2 +-
>  kernel/tracepoint.c                  |  2 +-
>  13 files changed, 52 insertions(+), 60 deletions(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 3ddd229..083ddd5 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1322,8 +1322,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>
>                 if (nmsk != omsk)
>                         /* hope the handler works with current  trigger mode */
> -                       pr_warning("irq %d uses trigger mode %u; requested %u\n",
> -                                  irq, nmsk, omsk);
> +                       pr_warn("irq %d uses trigger mode %u; requested %u\n",
> +                               irq, nmsk, omsk);
>         }
>
>         *old_ptr = new;
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 230a772..5b70d64 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -473,8 +473,7 @@ static int enter_state(suspend_state_t state)
>         if (state == PM_SUSPEND_FREEZE) {
>  #ifdef CONFIG_PM_DEBUG
>                 if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
> -                       pr_warning("PM: Unsupported test mode for suspend to idle,"
> -                                  "please choose none/freezer/devices/platform.\n");
> +                       pr_warn("PM: Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
>                         return -EAGAIN;
>                 }
>  #endif

For the above:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
