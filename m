From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC v1 2/8] kernel/cpu_pm: Manage runtime PM in the idle path for CPUs
Date: Thu, 11 Oct 2018 22:52:51 +0200
Message-ID: <8161939.SRDo8Qx48D@aspire.rjw.lan>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org> <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 10, 2018 11:20:49 PM CEST Raju P.L.S.S.S.N wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> To allow CPUs being power managed by PM domains, let's deploy support for
> runtime PM for the CPU's corresponding struct device.
> 
> More precisely, at the point when the CPU is about to enter an idle state,
> decrease the runtime PM usage count for its corresponding struct device,
> via calling pm_runtime_put_sync_suspend(). Then, at the point when the CPU
> resumes from idle, let's increase the runtime PM usage count, via calling
> pm_runtime_get_sync().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> (am from https://patchwork.kernel.org/patch/10478153/)
> ---
>  kernel/cpu_pm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 67b02e1..492d4a8 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -16,9 +16,11 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  #include <linux/syscore_ops.h>
>  
> @@ -91,6 +93,7 @@ int cpu_pm_enter(void)
>  {
>  	int nr_calls;
>  	int ret = 0;
> +	struct device *dev = get_cpu_device(smp_processor_id());
>  
>  	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
>  	if (ret)
> @@ -100,6 +103,9 @@ int cpu_pm_enter(void)
>  		 */
>  		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
>  
> +	if (!ret && dev && dev->pm_domain)
> +		pm_runtime_put_sync_suspend(dev);

This may cause a power domain to go off, but if it goes off, then the idle
governor has already selected idle states for all of the CPUs in that domain.

Is there any way to ensure that turning the domain off (and later on) will
no cause the target residency and exit latency expectations for those idle
states to be exceeded?

> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cpu_pm_enter);
> @@ -118,6 +124,11 @@ int cpu_pm_enter(void)
>   */
>  int cpu_pm_exit(void)
>  {
> +	struct device *dev = get_cpu_device(smp_processor_id());
> +
> +	if (dev && dev->pm_domain)
> +		pm_runtime_get_sync(dev);
> +
>  	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpu_pm_exit);
> 
