From: Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH 11/11] cpufreq: X86_AMD_FREQ_SENSITIVITY: select
 CPU_FREQ_TABLE
Date: Wed, 12 Jun 2013 09:23:43 -0500
Message-ID: <20130612142343.GA15934@jshin-Toonie>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
 <3f143e3112c038c805ea4e66ea91d12c5800acdf.1371022830.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f143e3112c038c805ea4e66ea91d12c5800acdf.1371022830.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, arnd@arndb.de
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 12, 2013 at 01:45:18PM +0530, Viresh Kumar wrote:
> This CPUFreq driver uses APIs from freq_table.c and so must select
> CPU_FREQ_TABLE.
> 

Ah, thanks for cathcing this!

> Cc: Jacob Shin <jacob.shin@amd.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Jacob Shin <jacob.shin@amd.com>

> ---
>  drivers/cpufreq/Kconfig.x86 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 6bd63d6..e2b6eab 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -132,6 +132,7 @@ config X86_POWERNOW_K8
>  config X86_AMD_FREQ_SENSITIVITY
>  	tristate "AMD frequency sensitivity feedback powersave bias"
>  	depends on CPU_FREQ_GOV_ONDEMAND && X86_ACPI_CPUFREQ && CPU_SUP_AMD
> +	select CPU_FREQ_TABLE
>  	help
>  	  This adds AMD-specific powersave bias function to the ondemand
>  	  governor, which allows it to make more power-conscious frequency
> -- 
> 1.7.12.rc2.18.g61b472e
> 
> 

