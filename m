From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq-cpu0: fix CPU_THERMAL dependency
Date: Fri, 13 Jun 2014 14:53:56 +0530
Message-ID: <CAKohponnsaPQ=XrdX5VYYBzdk1+KQxWp9WtGzXCtMMS7cwQy1A@mail.gmail.com>
References: <9629532.nBvvttN1Sz@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:39712 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbaFMJX4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 05:23:56 -0400
Received: by mail-oa0-f42.google.com with SMTP id eb12so2552368oac.29
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2014 02:23:56 -0700 (PDT)
In-Reply-To: <9629532.nBvvttN1Sz@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 13 June 2014 14:10, Arnd Bergmann <arnd@arndb.de> wrote:
> 5fbfbcd3e842d ("cpufreq: cpufreq-cpu0: remove dependency on THERMAL and
> REGULATOR") was a little too quick in completely removing the dependency
> on the THERMAL driver.

Sigh

> The problem is that while there are inline wrappers to turn the thermal
> API calls into empty functions, those do not help if the cpu-thermal
> driver is a loadable module and cpufreq-cpu0 is builtin.
>
> Since CONFIG_CPU_THERMAL is a bool option that decides whether the cpu
> code is built into the thermal module or not, we have to use a dependency
> on the thermal driver itself. However, if CPU_THERMAL is disabled, we
> don't need the dependency, hence the strange '!CPU_THERMAL || THERMAL'
> construct.

Yeah, it took me few minutes to make sure its perfectly fine :)

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index e473d65..ffe350f 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -186,6 +186,8 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  config GENERIC_CPUFREQ_CPU0
>         tristate "Generic CPU0 cpufreq driver"
>         depends on HAVE_CLK && OF
> +       # if CPU_THERMAL is on and THERMAL=m, CPU0 cannot be =y:
> +       depends on !CPU_THERMAL || THERMAL
>         select PM_OPP
>         help
>           This adds a generic cpufreq driver for CPU0 frequency management.

Since that was a corner case which I couldn't think of, can I be forgiven
for my incomplete patch ? :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
