From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: acpi: Add comment under ACPI_ADR_SPACE_SYSTEM_IO case
Date: Sat, 12 Oct 2013 15:38:15 +0200
Message-ID: <1922770.iubCDBg3Zg@vostro.rjw.lan>
References: <6334c0aed4840857944d1b267871ada4d7014d57.1381541632.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <6334c0aed4840857944d1b267871ada4d7014d57.1381541632.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, October 12, 2013 07:06:03 AM Viresh Kumar wrote:
> policy->cur is now set by cpufreq core when cpufreq_driver->get() is defined and
> so drivers aren't required to set it. When space_id is ACPI_ADR_SPACE_SYSTEM_IO
> for acpi cpufreq driver it doesn't set ->get to a valid function pointer and so
> policy->cur is required to be set by driver.
> 
> This is already followed in acpi-cpufreq driver. This patch adds a comment
> describing why we need to set policy->cur from driver.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> This change was requested by Rafael here:
> http://www.spinics.net/lists/linux-acpi/msg46748.html
> 
>  drivers/cpufreq/acpi-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index a8dac7b..8ecd74e 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -838,6 +838,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	switch (perf->control_register.space_id) {
>  	case ACPI_ADR_SPACE_SYSTEM_IO:
>  		/* Current speed is unknown and not detectable by IO port */
> +		/* ->cur wouldn't be set by core as ->get() is NULL */

Well, please merge it with the existing comment and use the usual format for
comments that are longer than two lines.

>  		policy->cur = acpi_cpufreq_guess_freq(data, policy->cpu);
>  		break;
>  	case ACPI_ADR_SPACE_FIXED_HARDWARE:
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
