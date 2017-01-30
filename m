From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 1/2] ACPI: processor_perflib: Simplify code and stop
 using CPUFREQ_START
Date: Mon, 30 Jan 2017 08:07:01 +0100
Message-ID: <CAJZ5v0i2SW9+T-RbegaoFu0xuN473BZ25iQdwU=gPrOvRW60EQ@mail.gmail.com>
References: <1547465.PvRbYVlVrB@aspire.rjw.lan> <e608c76ea40e4f0d50bfe821174dfebef924e35b.1485750547.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <e608c76ea40e4f0d50bfe821174dfebef924e35b.1485750547.git.viresh.kumar@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 30, 2017 at 5:29 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> acpi_processor_ppc_notifier() can live without using CPUFREQ_START
> (which is gonna be removed soon), as it is only used while setting
> ignore_ppc to 0. This can be done with the help of "ignore_ppc < 0"
> check alone. The notifier function anyway ignores all events except
> CPUFREQ_ADJUST and dropping CPUFREQ_START wouldn't harm at all.
>
> Once CPUFREQ_START event is removed from the cpufreq core,
> acpi_processor_ppc_notifier() will get called only for CPUFREQ_NOTIFY or
> CPUFREQ_ADJUST event. Drop the return statement from the first if block
> to make sure we don't ignore any such events.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> V1->V2:
> - Improved changelog
> - Don't move the first if block to a later point, as it becomes useless
>   then.
> ---
>  drivers/acpi/processor_perflib.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index f0b4a981b8d3..18b72eec3507 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -75,10 +75,8 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
>         struct acpi_processor *pr;
>         unsigned int ppc = 0;
>
> -       if (event == CPUFREQ_START && ignore_ppc <= 0) {
> +       if (ignore_ppc < 0)
>                 ignore_ppc = 0;
> -               return 0;
> -       }

Don't we want to return from here if ignore_ppc is 0?

>
>         if (ignore_ppc)
>                 return 0;
> --

Thanks,
Rafael
