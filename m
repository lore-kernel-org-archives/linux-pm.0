From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/4] Documentation: intel_pstate: Update per core limits
Date: Sat, 22 Oct 2016 03:26:43 +0200
Message-ID: <16081121.n67ICnujRF@vostro.rjw.lan>
References: <1477066466-22367-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1477066466-22367-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61989 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S934996AbcJVBTq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 21:19:46 -0400
In-Reply-To: <1477066466-22367-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Friday, October 21, 2016 09:14:25 AM Srinivas Pandruvada wrote:
> Document restriction on per core P-State control.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/cpu-freq/intel-pstate.txt | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
> index 5528d6d..18156ce 100644
> --- a/Documentation/cpu-freq/intel-pstate.txt
> +++ b/Documentation/cpu-freq/intel-pstate.txt
> @@ -48,7 +48,7 @@ In addition to the frequency-controlling interfaces provided by the cpufreq
>  core, the driver provides its own sysfs files to control the P-State selection.
>  These files have been added to /sys/devices/system/cpu/intel_pstate/.
>  Any changes made to these files are applicable to all CPUs (even in a
> -multi-package system).
> +multi-package system, Refer to later section on placing "Per core limits").
>  
>        max_perf_pct: Limits the maximum P-State that will be requested by
>        the driver. It states it as a percentage of the available performance. The
> @@ -120,6 +120,27 @@ frequency is fictional for Intel Core processors. Even if the scaling
>  driver selects a single P-State, the actual frequency the processor
>  will run at is selected by the processor itself.
>  
> +Per core limits

Those are per logical CPU rather than per core.

What about

"Per-CPU limits"

> +
> +Per core limits are not enabled without kernel command line
> + intel_pstate=per_cpu_perf_limits
> +
> +When user wants to control performance per core, there are some limitations
> +in sysfs control, which are described above.

I'd reword the above this way:

"The kernel command line option

 intel_pstate=per_cpu_perf_limits

forces intel_pstate to use per-CPU performance limits.  When it is set, the
sysfs control interface described above is subject to limitations."

> +-  The following controls are not available for both read and write

"- The following controls are not present:"

> +	/sys/devices/system/cpu/intel_pstate/max_perf_pct
> +	/sys/devices/system/cpu/intel_pstate/min_perf_pct
> +- User can change limits using the following, respecting processor
> +architecture

"- The following controls can be used to set performance limits, as far as
the architecture of the processor permits:"

> +	/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
> +	/sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
> +	/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> +- User can still observe turbo percent and number of P-States from
> +	/sys/devices/system/cpu/intel_pstate/turbo_pct
> +	/sys/devices/system/cpu/intel_pstate/num_pstates
> +- User can read write system wide turbo status
> +	/sys/devices/system/cpu/no_turbo
> +
>  Tuning Intel P-State driver
>  
>  When the performance can be tuned using PID (Proportional Integral
> 

Thanks,
Rafael

