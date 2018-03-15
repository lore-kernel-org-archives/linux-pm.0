From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 23/47] cpufreq: remove cris specific drivers
Date: Thu, 15 Mar 2018 08:17:32 +0530
Message-ID: <20180315024732.GI15832@vireshk-i7>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-24-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-24-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14-03-18, 16:35, Arnd Bergmann wrote:
> The cris architecture is getting removed, including the artpec3
> and etraxfs SoCs, so these cpufreq drivers are now unused.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Makefile               |  2 -
>  drivers/cpufreq/cris-artpec3-cpufreq.c | 93 ----------------------------------
>  drivers/cpufreq/cris-etraxfs-cpufreq.c | 92 ---------------------------------
>  3 files changed, 187 deletions(-)
>  delete mode 100644 drivers/cpufreq/cris-artpec3-cpufreq.c
>  delete mode 100644 drivers/cpufreq/cris-etraxfs-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 2e4495cf9aa8..8d24ade3bd02 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -102,8 +102,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
>  ##################################################################################
>  # Other platform drivers
>  obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
> -obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
> -obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
>  obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
>  obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
>  obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
> diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
> deleted file mode 100644
> index 455b4fb78cba..000000000000
> diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
> deleted file mode 100644
> index 4c4b5dd685e3..000000000000

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
