From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 02/14] clk: Create of_clk_shared_by_cpus()
Date: Wed, 9 Jul 2014 10:38:34 -0400
Message-ID: <53BD53EA.8050708@ti.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org> <5f7164d789e87c62d722b575980c92dfd0504334.1404231535.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <5f7164d789e87c62d722b575980c92dfd0504334.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, t.figa@samsung.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, thomas.ab@samsung.com, arvind.chauhan@arm.com, spk.linux@gmail.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

+ Lorenzo

On Tuesday 01 July 2014 12:32 PM, Viresh Kumar wrote:
> Create a new routine of_clk_shared_by_cpus() that finds if clock lines are
> shared between two CPUs. This is verified by comparing "clocks" property from
> CPU's DT node.
> 
> Returns 1 if clock line is shared between them, 0 if clock isn't shared and
> return appropriate errors in case nodes/properties are missing.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/clk/clk.c   | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h |  6 ++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 8b73ede..497735c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/clk-private.h>
> +#include <linux/cpu.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> @@ -2528,6 +2529,61 @@ const char *of_clk_get_parent_name(struct device_node *np, int index)
>  }
>  EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
>  
> +/**
> + * of_clk_shared_by_cpus - Finds if clock line is shared between CPUs
> + * @cpu1, cpu2: CPU numbers
> + *
> + * Finds if clock lines are shared by two CPUs. This is verified by comparing
> + * "clocks" property from CPU's DT node.
> + *
> + * Returns 1 if clock line is shared between them, 0 if clock isn't shared.
> + * Return appropriate errors in case some requirements aren't met.
> + */
> +int of_clk_shared_by_cpus(int cpu1, int cpu2)

I might be wrong but this API seems to bit short cited. We should probably
handle it bit better since there are more cases instead of just checking CPU
tuple. More than two CPUs may share the clock so discovering that in one iteration
is better. I also think this is closely related to CPU topology.

- CPUs part of 'a cluster' shares same clock.
- Multiple clusters may share same clock
- Every CPU might be clocked from separate PLL.

What you say ?

Regards,
Santosh
