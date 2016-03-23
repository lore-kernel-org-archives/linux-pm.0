From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/5] cpufreq: acpi-cpufreq: Clean up hot plug notifier callback.
Date: Wed, 23 Mar 2016 22:26:45 +0100
Message-ID: <6345603.OpCxeV2k9k@vostro.rjw.lan>
References: <1458336371-17748-5-git-send-email-rcochran@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458336371-17748-5-git-send-email-rcochran@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Cochran <rcochran@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, March 18, 2016 10:26:11 PM Richard Cochran wrote:
> This driver has two issues.  First, it tries to fiddle with the hot
> plugged CPU's MSR on the UP_PREPARE event, at a time when the CPU is
> not yet online.  Second, the driver sets the "boost-disable" bit for a
> CPU when going down, but does not clear the bit again if the CPU comes
> up again due to DOWN_FAILED.
> 
> This patch fixes the issues by changing the driver to react to the
> ONLINE/DOWN_FAILED events instead of UP_PREPARE.  As an added benefit,
> the driver also becomes symmetric with respect to the hot plug
> mechanism.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 51eef87..7006a43 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -540,8 +540,10 @@ static int boost_notify(struct notifier_block *nb, unsigned long action,
>  	 */
>  
>  	switch (action) {
> -	case CPU_UP_PREPARE:
> -	case CPU_UP_PREPARE_FROZEN:
> +	case CPU_DOWN_FAILED:
> +	case CPU_DOWN_FAILED_FROZEN:
> +	case CPU_ONLINE:
> +	case CPU_ONLINE_FROZEN:
>  		boost_set_msrs(acpi_cpufreq_driver.boost_enabled, cpumask);
>  		break;

Applied, thanks!
