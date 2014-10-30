From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: allow powersave governor as the default without expert mode
Date: Thu, 30 Oct 2014 22:18:33 +0100
Message-ID: <1463060.7rHn3OIKry@vostro.rjw.lan>
References: <1413322689-6195-1-git-send-email-jgeboski@gmail.com> <1413459431-12355-1-git-send-email-jgeboski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50026 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933386AbaJ3U55 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 16:57:57 -0400
In-Reply-To: <1413459431-12355-1-git-send-email-jgeboski@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Geboski <jgeboski@gmail.com>, 'Dirk Brandewie' <dirk.j.brandewie@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 'Dirk Brandewie' <dirk.brandewie@gmail.com>

On Thursday, October 16, 2014 07:37:11 AM James Geboski wrote:
> The intel_pstate driver only supports the performance and the powersave
> governors. With the performance governor ensuring the highest possible
> performance settings, userspace tools fail to make any lasting changes.
> In order to allow userspace tools to make modifications to the settings,
> the powersave governor must be in use. This makes having the powersave
> governor as the default convenient for systems where the intel_pstate
> driver is being employed. Having to enable expert mode in the kernel
> configuration is just a headache for such a trivial task.
> 
> This patch applies to all kernel versions 2.6.38 or greater after the
> migration from CONFIG_EMBEDDED to CONFIG_EXPERT (6a108a14fa35). Most
> importantly, this applies to kernel versions 3.9 or greater when the
> intel_pstate driver was introduced.
> 
> Signed-off-by: James Geboski <jgeboski@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Dirk, any objections?

> ---
> ChangeLog v2:
>   - Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 3489f8f..73df7db 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -63,7 +63,6 @@ config CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>  
>  config CPU_FREQ_DEFAULT_GOV_POWERSAVE
>  	bool "powersave"
> -	depends on EXPERT
>  	select CPU_FREQ_GOV_POWERSAVE
>  	help
>  	  Use the CPUFreq governor 'powersave' as default. This sets
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
