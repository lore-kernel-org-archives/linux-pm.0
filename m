From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/4] perf: add OMAP support for the new power
	events
Date: Mon, 4 Oct 2010 21:45:46 +0200
Message-ID: <201010042145.48838.trenn__5128.58725055612$1286221615$gmane$org@suse.de>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<1286205661-24448-3-git-send-email-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1286205661-24448-3-git-send-email-jean.pihet@newoldbits.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Jean Pihet <j-pihet@ti.com>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Monday 04 October 2010 05:20:59 pm Jean Pihet wrote:
> The patch adds the new power management trace points for
> the OMAP architecture.
>
> The trace points are for cpuidle, cpufreq (DVFS), the clocks
> changes (enable, disable, set_rate) and the power domains
> transitions.
...
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index 6d3d333..19d5a6c 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <trace/events/power.h>
>
>  #include <mach/hardware.h>
>  #include <plat/clock.h>
> @@ -95,6 +96,7 @@ static int omap_target(struct cpufreq_policy *policy,
>  	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
>  	       freqs.old, freqs.new);
>  #endif
> +	trace_processor_frequency(freqs.new, freqs.cpu);
>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>  	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

This one is not needed, frequency power events are all fired in
drivers/cpufreq/cpufreq.c
for cpufreq drivers:
static struct cpufreq_driver omap_driver = {
        .target         = omap_target,
}
