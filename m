From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Limit the scope of HWP dynamic
 boost platforms
Date: Tue, 31 Jul 2018 09:03:37 +0100
Message-ID: <20180731080337.nomq6pwophsvib4s@techsingularity.net>
References: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eero.t.tamminen@intel.com, ggherdovich@suse.cz, currojerez@riseup.net
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 30, 2018 at 03:00:29PM -0700, Srinivas Pandruvada wrote:
> Dynamic boosting of HWP performance on IO wake showed significant
> improvement to IO workloads. This series was intended for Skylake Xeon
> platforms only and feature was enabled by default based on CPU model
> number.
> 
> But some Xeon platforms reused the Skylake desktop CPU model number. This
> caused some undesirable side effects to some graphics workloads. Since
> they are heavily IO bound, the increase in CPU performance decreased the
> power available for GPU to do its computing and hence decrease in graphics
> benchmark performance.
> 
> For example on a Skylake desktop, GpuTest benchmark showed average FPS
> reduction from 529 to 506.
> 
> This change makes sure that HWP boost feature is only enabled for Skylake
> server platforms by using ACPI FADT preferred PM Profile. If some desktop
> users wants to get benefit of boost, they can still enable boost from
> intel_pstate sysfs attribute "hwp_dynamic_boost".
> 
> Fixes: 41ab43c9c89e (cpufreq: intel_pstate: enable boost for Skylake Xeon)
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=107410
> Reported-by: Eero Tamminen <eero.t.tamminen@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
