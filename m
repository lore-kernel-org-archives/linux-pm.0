From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi-cpufreq: Add a miss ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
Date: Fri, 10 Jul 2015 22:44:25 +0200
Message-ID: <CAJZ5v0jwgtgC+01p8f5a7amPcTGUfps5f2Ph9rtt77=3BEk5Cg@mail.gmail.com>
References: <559F5D13.8050104@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34883 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932831AbbGJUo0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 16:44:26 -0400
In-Reply-To: <559F5D13.8050104@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

Hi,

On Fri, Jul 10, 2015 at 7:50 AM, Pan Xinhui <xinhuix.pan@intel.com> wrote:
>
> If CONFIG_X86_ACPI_CPUFREQ_CPB has not been defined, the placeholder for
> cpb is not needed. Add ifdef around it.
>
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index e7fcaa6..314a19e 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
>  static struct freq_attr *acpi_cpufreq_attr[] = {
>         &cpufreq_freq_attr_scaling_available_freqs,
>         &freqdomain_cpus,
> +#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
>         NULL,   /* this is a placeholder for cpb, do not remove */
> +#endif

Adding the ifdef here doesn't change anything, because the next NULL
will play the role of the one you've just #ifdefed and the structure
will be filled with zeros from that point on anyway.

You'd need to #ifdef it in the struct freq_attr definition, but I'm
not sure it's worth the effort.

>         NULL,
>  };

Thanks,
Rafael
