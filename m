From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 22/47] cpufreq: remove blackfin driver
Date: Thu, 15 Mar 2018 08:17:18 +0530
Message-ID: <20180315024718.GH15832@vireshk-i7>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-23-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-23-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14-03-18, 16:35, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this driver is
> now obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Makefile           |   1 -
>  drivers/cpufreq/blackfin-cpufreq.c | 217 -------------------------------------
>  2 files changed, 218 deletions(-)
>  delete mode 100644 drivers/cpufreq/blackfin-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 4987227b67df..2e4495cf9aa8 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -101,7 +101,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
>  
>  ##################################################################################
>  # Other platform drivers
> -obj-$(CONFIG_BFIN_CPU_FREQ)		+= blackfin-cpufreq.o
>  obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
>  obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
>  obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
> diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
> deleted file mode 100644
> index 12e97d8a9db0..000000000000

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
