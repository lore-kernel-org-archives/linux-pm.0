From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: acpi: Allow new dynamics attributes to be added
 to acpi_cpufreq_attr
Date: Thu, 3 Mar 2016 18:29:23 +0100
Message-ID: <CAJZ5v0i1HxQha52+G+G_1RC2Gv7Fr7Wifohhx8pqkh-MXbo6Zg@mail.gmail.com>
References: <1456945994-5616-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<f73d4b3690f7166730bafa2e0d7b5b9dcf29f2de.1456983554.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f73d4b3690f7166730bafa2e0d7b5b9dcf29f2de.1456983554.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 3, 2016 at 6:40 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> acpi_cpufreq_attr contains at least one dynamically populated (removed)
> attribute today, cpb. But the code isn't friendly enough for new
> attributes to be populated in a similar way.
>
> Make some changes to allow new attributes to be easily added to the
> struct.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Srinivas,
>
> This should make it easy for you to add another dynamic entry into the
> acpi_cpufreq_attr structure.
>
>  drivers/cpufreq/acpi-cpufreq.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 59a7b380fbe2..c37617ddcc9e 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -866,7 +866,7 @@ static struct freq_attr *acpi_cpufreq_attr[] = {
>         &cpufreq_freq_attr_scaling_available_freqs,
>         &freqdomain_cpus,
>  #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
> -       &cpb,
> +       NULL,   /* Extra space for cpb if required */
>  #endif
>         NULL,
>  };
>
> @@ -917,6 +917,7 @@ static void acpi_cpufreq_boost_exit(void)
>
>  static int __init acpi_cpufreq_init(void)
>  {
> +       struct freq_attr **attr;
>         int ret;
>
>         if (acpi_disabled)
> @@ -932,6 +933,10 @@ static int __init acpi_cpufreq_init(void)
>         if (ret)
>                 return ret;
>
> +       /* Find first empty entry */
> +       for (attr = acpi_cpufreq_attr; *attr; attr++)
> +               ;
> +
>  #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
>         /* this is a sysfs file with a strange name and an even stranger
>          * semantic - per CPU instantiation, but system global effect.
> @@ -939,17 +944,11 @@ static int __init acpi_cpufreq_init(void)
>          * only if configured. This is considered legacy code, which
>          * will probably be removed at some point in the future.
>          */
> -       if (!check_amd_hwpstate_cpu(0)) {
> -               struct freq_attr **attr;
> -
> +       if (check_amd_hwpstate_cpu(0))
> +               *attr++ = &cpb;
> +       else
>                 pr_debug("CPB unsupported, do not expose it\n");
>
> -               for (attr = acpi_cpufreq_attr; *attr; attr++)
> -                       if (*attr == &cpb) {
> -                               *attr = NULL;
> -                               break;
> -                       }
> -       }
>  #endif
>         acpi_cpufreq_boost_init();

OK, this makes sense.

The table definition starts to look somewhat ugly with all of those
NULLs at the end, but then adding the base_frequency thing to it would
be easy.

Srinivas, can you please take this and rebase your patch on top of it?
 Or if you prefer, I can take it into my linux-next branch.

Thanks,
Rafael
