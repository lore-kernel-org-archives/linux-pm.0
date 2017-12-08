From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / PM: Do not reconfigure GPEs for suspend-to-idle
Date: Fri, 8 Dec 2017 15:29:07 +0100
Message-ID: <CAJZ5v0jhviHiij0EidmKZpWpCNJOwM6_=WQX-1=Rok2PVr_vZw@mail.gmail.com>
References: <1563861.ZpJ5HHSL6q@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1563861.ZpJ5HHSL6q@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 7, 2017 at 3:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Currently, non-wakeup GPEs are disabled on suspend-to-idle
> entry to avoid spurious wakeups, but that should not be strictly
> necessary any more after commit 33e4f80ee69b (ACPI / PM: Ignore
> spurious SCI wakeups from suspend-to-idle) which prevents spurious
> GPE wakeups from resuming the system.  The only consequence of
> leaving non-wakeup GPEs enabled may be more interrupt-related
> activity while suspended, which is not ideal (more energy is
> used if that happens), but it is not critical too.
>
> On the other hand, this change allows Dells XPS13 9360 blacklisted by
> commit 71630b7a832f (ACPI / PM: Blacklist Low Power S0 Idle _DSM for
> Dell XPS13 9360) to use the power button for waking up from suspend-
> to-idle and it helps at least one other older Dell system (the
> wakeup button GPE on that one is not listed in _PRW for any
> devices, so it is not regarded as a wakeup one and gets disabled
> on suspend-to-idle entry today).
>
> For the above reasons, leave GPE configuration as is over
> suspend-to-idle on all systems.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/sleep.c |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -951,15 +951,8 @@ static int acpi_s2idle_prepare(void)
>         if (lps0_device_handle) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> -       } else {
> -               /*
> -                * The configuration of GPEs is changed here to avoid spurious
> -                * wakeups, but that should not be necessary if this is a
> -                * "low-power S0" platform and the low-power S0 _DSM is present.
> -                */
> -               acpi_enable_all_wakeup_gpes();
> -               acpi_os_wait_events_complete();
>         }
> +
>         if (acpi_sci_irq_valid())
>                 enable_irq_wake(acpi_sci_irq);
>
> @@ -1005,8 +998,6 @@ static void acpi_s2idle_restore(void)
>         if (lps0_device_handle) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> -       } else {
> -               acpi_enable_all_runtime_gpes();
>         }
>  }
>

I have to withdraw this as it leads to a regression on one of my test machines.

That is unexpected, so I need to investigate what's going on in there.

Thanks,
Rafael
