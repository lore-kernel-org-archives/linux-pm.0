From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH v3] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Sun, 19 Jun 2016 23:55:32 -0700
Message-ID: <CAJFUiJiK8ALAwPD602cLD_wDcKZofPB8J=KUXaDG0PSQpQkv9Q@mail.gmail.com>
References: <1465541008-12476-1-git-send-email-lianwei.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465541008-12476-1-git-send-email-lianwei.wang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Lianwei Wang <lianwei.wang@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 9, 2016 at 11:43 PM, Lianwei Wang <lianwei.wang@gmail.com> wrote:
> Currently it just print a warning message but did not
> reset cpu_hotplug_disabled when the enable/disable is
> unbalanced. The unbalanced enable/disable will lead
> the cpu hotplug work abnormally.
>
> Do nothing if an unablanced hotplug enable detected.
>
> Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
> ---
>  kernel/cpu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 3e3f6e49eabb..5e26a3c64934 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -245,6 +245,14 @@ void cpu_hotplug_done(void)
>         cpuhp_lock_release();
>  }
>
> +static void __cpu_hotplug_enable(void)
> +{
> +       if (WARN_ONCE(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
> +               return;
> +
> +       cpu_hotplug_disabled--;
> +}
> +
>  /*
>   * Wait for currently running CPU hotplug operations to complete (if any) and
>   * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
> @@ -263,7 +271,7 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_disable);
>  void cpu_hotplug_enable(void)
>  {
>         cpu_maps_update_begin();
> -       WARN_ON(--cpu_hotplug_disabled < 0);
> +       __cpu_hotplug_enable();
>         cpu_maps_update_done();
>  }
>  EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
> @@ -1091,7 +1099,7 @@ void enable_nonboot_cpus(void)
>
>         /* Allow everyone to use the CPU hotplug again */
>         cpu_maps_update_begin();
> -       WARN_ON(--cpu_hotplug_disabled < 0);
> +       __cpu_hotplug_enable();
>         if (cpumask_empty(frozen_cpus))
>                 goto out;
>
> --
> 1.9.1
>

Hi Thomas Gleixner,

Does this change look good to you?
