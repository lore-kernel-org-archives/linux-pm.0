From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] cpufreq: pxa2xx: remove incorrect __init annotation
Date: Thu, 7 Mar 2019 08:26:33 -0700
Message-ID: <20190307152633.GH20201@archlinux-ryzen>
References: <20190307102250.1140038-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307102250.1140038-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 07, 2019 at 11:22:41AM +0100, Arnd Bergmann wrote:
> pxa_cpufreq_init_voltages() is marked __init but usually inlined into
> the non-__init pxa_cpufreq_init() function. When building with clang,
> it can stay as a standalone function in a discarded section, and produce
> this warning:
> 
> WARNING: vmlinux.o(.text+0x616a00): Section mismatch in reference from the function pxa_cpufreq_init() to the function .init.text:pxa_cpufreq_init_voltages()
> The function pxa_cpufreq_init() references
> the function __init pxa_cpufreq_init_voltages().
> This is often because pxa_cpufreq_init lacks a __init
> annotation or the annotation of pxa_cpufreq_init_voltages is wrong.
> 
> Fixes: 50e77fcd790e ("ARM: pxa: remove __init from cpufreq_driver->init()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/cpufreq/pxa2xx-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
> index 46254e583982..74e0e0c20c46 100644
> --- a/drivers/cpufreq/pxa2xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa2xx-cpufreq.c
> @@ -143,7 +143,7 @@ static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
>  	return ret;
>  }
>  
> -static void __init pxa_cpufreq_init_voltages(void)
> +static void pxa_cpufreq_init_voltages(void)
>  {
>  	vcc_core = regulator_get(NULL, "vcc_core");
>  	if (IS_ERR(vcc_core)) {
> @@ -159,7 +159,7 @@ static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
>  	return 0;
>  }
>  
> -static void __init pxa_cpufreq_init_voltages(void) { }
> +static void pxa_cpufreq_init_voltages(void) { }
>  #endif
>  
>  static void find_freq_tables(struct cpufreq_frequency_table **freq_table,
> -- 
> 2.20.0
> 
