From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: ppc: Add missing #include <asm/smp.h>
Date: Wed, 04 Mar 2015 15:22:57 +0100
Message-ID: <6947572.xHtck0sm5U@vostro.rjw.lan>
References: <1425470180-4650-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425470180-4650-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 04, 2015 12:56:20 PM Geert Uytterhoeven wrote:
> If CONFIG_SMP=n, <linux/smp.h> does not include <asm/smp.h>, causing:
> 
> drivers/cpufreq/ppc-corenet-cpufreq.c: In function 'corenet_cpufreq_cpu_init':
> drivers/cpufreq/ppc-corenet-cpufreq.c:173:3: error: implicit declaration of function 'get_hard_smp_processor_id' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Seen with e.g. corenet64_smp_defconfig + CONFIG_CPU_FREQ=y,
> CONFIG_PPC_CORENET_CPUFREQ=y, CONFIG_SMP=n
> 
> v2:
>   - Add comment for #include directive, as requested by Viresh

Applied, thanks!

> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index bee5df7794d33d10..7cb4b766cf948d3f 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -22,6 +22,8 @@
>  #include <linux/smp.h>
>  #include <sysdev/fsl_soc.h>
>  
> +#include <asm/smp.h>	/* for get_hard_smp_processor_id() in UP configs */
> +
>  /**
>   * struct cpu_data - per CPU data struct
>   * @parent: the parent node of cpu clock
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
