From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/9] ia64: cpufreq: move cpufreq driver to drivers/cpufreq
Date: Mon, 1 Apr 2013 10:31:48 +0530
Message-ID: <CAKohpokkyQK+650aPLtdXJ0wHWupR=-bcTM_eCoZRDy3N47HJQ@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
	<afc636963b63becccf34d092203c53369bd1b735.1364229828.git.viresh.kumar@linaro.org>
	<CAKohponax2iDZeA-WG_L2XVHU5GGJB2nSPWVoVxbZUoez1ZpDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponax2iDZeA-WG_L2XVHU5GGJB2nSPWVoVxbZUoez1ZpDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 30 March 2013 15:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Fixup:
>
> commit 509bc3c30aff65045918f69f750d8845f004cc0a
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Sat Mar 30 15:20:41 2013 +0530
>
>     fixup! ia64: cpufreq:  move cpufreq driver to drivers/cpufreq
> ---
>  arch/ia64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index dd59848..152b5f2 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -593,6 +593,7 @@ source "drivers/acpi/Kconfig"
>  if PM
>  menu "CPU Frequency scaling"
>  source "drivers/cpufreq/Kconfig"
> +endmenu
>  endif
>
>  endmenu

Hi Tony/Fenghua,

Any comments on this patch?
