From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/2] cpuidle: allow setting deepest idle
Date: Tue, 29 Nov 2016 00:19:01 +0100
Message-ID: <CAJZ5v0iR=oyqt3uwQpYv4oLgbagt+oA-cEnbaJ-+T7SNjumnKQ@mail.gmail.com>
References: <1480368809-23685-1-git-send-email-jacob.jun.pan@linux.intel.com> <1480368809-23685-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34062 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755790AbcK1XTD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 18:19:03 -0500
In-Reply-To: <1480368809-23685-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Mon, Nov 28, 2016 at 10:33 PM, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
> When idle injection is used to cap power, we need to override
> governor's choice of idle states. This patch allows caller to select
> the deepest idle state on a CPU therefore achieve the maximum
> potential power saving.
>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/cpuidle/cpuidle.c | 11 +++++++++++
>  include/linux/cpuidle.h   |  4 +++-
>  kernel/sched/idle.c       | 13 ++++++++-----
>  3 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c73207a..887a52a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -97,6 +97,17 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>         return ret;
>  }
>
> +/* Set the current cpu to use the deepest idle state, override governors */
> +void cpuidle_use_deepest_state(bool enable)
> +{
> +       struct cpuidle_device *dev;
> +
> +       preempt_disable();
> +       dev = cpuidle_get_device();
> +       dev->use_deepest_state = enable;
> +       preempt_enable();
> +}
> +
>  #ifdef CONFIG_SUSPEND
>  /**
>   * cpuidle_find_deepest_state - Find the deepest available idle state.
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index bb31373..97c169b 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -74,6 +74,7 @@ struct cpuidle_state {
>  struct cpuidle_device {
>         unsigned int            registered:1;
>         unsigned int            enabled:1;
> +       unsigned int            use_deepest_state:1;
>         unsigned int            cpu;
>
>         int                     last_residency;
> @@ -192,11 +193,12 @@ static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
>  static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>  #endif
>
> -#if defined(CONFIG_CPU_IDLE) && defined(CONFIG_SUSPEND)
> +#ifdef CONFIG_CPU_IDLE

The corresponding change in cpuidle.c is missing (and 0-day has just
found that too).

Thanks,
Rafael
