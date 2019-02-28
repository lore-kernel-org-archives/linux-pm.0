From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2][RFC v2] ACPI: add "processor.broadcast_ppc" hook to
 broadcast _PPC
Date: Thu, 28 Feb 2019 23:18:39 +0100
Message-ID: <CAJZ5v0iw=THw4Cr7asFoNdUaAu7tG0nz0S4NWzqxGEDvyS11ng@mail.gmail.com>
References: <cover.1551375162.git.yu.c.chen@intel.com> <ee0250bfc7709ce0a0cc93bf83336133d5e248c4.1551375162.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee0250bfc7709ce0a0cc93bf83336133d5e248c4.1551375162.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yu Chen <yu.chen.surf@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 28, 2019 at 6:59 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On some problematic platforms, the _PPC notifier is
> only delivered to one CPU, which might cause information
> inconsistent between CPUs within the package. Thus introduce a boot up parameter to broadcast this _PPC notifier onto all
> online CPUs.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index a303fd0e108c..737dbf5aa7f7 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
>  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
>                  "limited by BIOS, this should help");
>
> +static int broadcast_ppc;
> +module_param(broadcast_ppc, int, 0644);
> +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> +
>  #define PPC_REGISTERED   1
>  #define PPC_IN_USE       2
>
> @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
>                 else
>                         acpi_processor_ppc_ost(pr->handle, 0);
>         }
> -       if (ret >= 0)
> -               cpufreq_update_policy(pr->id);
> +       if (ret >= 0) {
> +               if (broadcast_ppc) {
> +                       int cpu;
> +
> +                       for_each_possible_cpu(cpu)
> +                               cpufreq_update_policy(cpu);

This doesn't actually help AFAICS, because it only causes
acpi_processor_ppc_notifier() to be called for all policies, but
pr->performance_platform_limit is re-computed for the target CPU only
anyway, so the limit will only be applied to that one.

What happens in the BZ is that invoking cpufreq_update_policy() for
all CPUs causes ->verify() to run on all of them which triggers
update_turbo_state() and cpuinfo.max_freq update, because
global.turbo_disabled has changed.

That is rather less than straightforward and intel_pstate really
doesn't need any _PPC change notifications to notice that the
MSR_IA32_MISC_ENABLE_TURBO_DISABLE bit has changed as it checks that
bit on every P-state update.

So no, we are not going to do this to fix the particular issue at hand.

> +               } else {
> +                       cpufreq_update_policy(pr->id);
> +               }
> +       }
>  }
>
>  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> --
> 2.17.1
>
