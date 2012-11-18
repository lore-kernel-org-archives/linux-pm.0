From: Francesco Lavra <francescolavra.fl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 1/2] Thermal: Add ST-Ericsson DB8500 thermal driver.
Date: Sun, 18 Nov 2012 15:29:51 +0100
Message-ID: <50A8F0DF.8040509@gmail.com>
References: <1352977003-25095-1-git-send-email-hongbo.zhang@linaro.com>
	<1352977003-25095-2-git-send-email-hongbo.zhang@linaro.com>
	<1352983878.2080.25.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1352983878.2080.25.camel@rzhang1-mobl4>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, kernel-vMlcbD5RyM6HZuj8yyL1ah2eb7JE58TQ@public.gmane.org, "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/15/2012 01:51 PM, Zhang Rui wrote:
> On Thu, 2012-11-15 at 18:56 +0800, hongbo.zhang wrote:
>> From: "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
>>
>> This driver is based on the thermal management framework in thermal_sys.c. A
>> thermal zone device is created with the trip points to which cooling devices
>> can be bound, the current cooling device is cpufreq, e.g. CPU frequency is
>> clipped down to cool the CPU, and other cooling devices can be added and bound
>> to the trip points dynamically.  The platform specific PRCMU interrupts are
>> used to active thermal update when trip points are reached.
>>
>> Signed-off-by: hongbo.zhang <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
>> Reviewed-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Reviewed-by: Francesco Lavra <francescolavra.fl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Patch is refreshed and applied to thermal next.
> refreshed patch attached.
[...]
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 99b6587..d96da07 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -101,5 +101,25 @@ config EXYNOS_THERMAL
>  	  If you say yes here you get support for TMU (Thermal Managment
>  	  Unit) on SAMSUNG EXYNOS series of SoC.
>  
> +config DB8500_THERMAL
> +	bool "DB8500 thermal management"
> +	depends on ARCH_U8500

Shouldn't it depend on THERMAL as well, as in Hongbo's original patch?

> +	default y
> +	help
> +	  Adds DB8500 thermal management implementation according to the thermal
> +	  management framework. A thermal zone with several trip points will be
> +	  created. Cooling devices can be bound to the trip points to cool this
> +	  thermal zone if trip points reached.
> +
> +config DB8500_CPUFREQ_COOLING
> +	tristate "DB8500 cpufreq cooling"
> +	depends on ARCH_U8500
> +	depends on CPU_THERMAL
> +	default y
> +	help
> +	  Adds DB8500 cpufreq cooling devices, and these cooling devices can be
> +	  bound to thermal zone trip points. When a trip point reached, the
> +	  bound cpufreq cooling device turns active to set CPU frequency low to
> +	  cool down the CPU.
>  
>  endif

--
Francesco
