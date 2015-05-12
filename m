From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/7] drivers/cpufreq: Convert non-modular drivers to use
 builtin_driver_register
Date: Tue, 12 May 2015 12:34:44 +0530
Message-ID: <20150512070444.GE32300@linux>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
 <1431287385-1526-5-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431287385-1526-5-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 10-05-15, 15:49, Paul Gortmaker wrote:
> These files depend on Kconfig options all of which are a bool, so
> we use the appropriate registration function, which avoids us
> relying on an implicit inclusion of <module.h> which we are
> doing currently.
> 
> While this currently works, we really don't want to be including
> the module.h header in non-modular code, which we'd be forced
> to do, pending some upcoming code relocation from init.h into
> module.h.  So we fix it now by using the non-modular equivalent.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c  | 2 +-

Exynos can be compiled as a module:

drivers/cpufreq/Kconfig.arm:

config ARM_EXYNOS_CPUFREQ
	tristate "SAMSUNG EXYNOS CPUfreq Driver"
	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250

--
viresh
