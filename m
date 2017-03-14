From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 10/14] cpufreq: intel_pstate: Use different utilization update callbacks
Date: Tue, 14 Mar 2017 09:07:48 -0700
Message-ID: <000101d29cdd$214bd8d0$63e38a70$@net>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan> n7P3c1QOAsVy3n7P5cDily
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: n7P3c1QOAsVy3n7P5cDily
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

I can not get this patch to apply.
My start point is kernel 4.11-rc2, so maybe (probably) it is my problem.

On 2017.03.12 10:22 Rafael J. Wysocki wrote:

... [cut] ...

> drivers/cpufreq/intel_pstate.c |   77 ++++++++++++++++++++++++++++-------------
> 1 file changed, 53 insertions(+), 24 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -37,6 +37,9 @@
> #include <asm/cpufeature.h>
> #include <asm/intel-family.h>
> 
> +#define INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
> +#define INTEL_PSTATE_HWP_SAMPLING_INTERVAL	(50 * NSEC_PER_MSEC)
> +
> #define INTEL_CPUFREQ_TRANSITION_LATENCY	20000
> 
> #define ATOM_RATIOS		0x66a

"git am" is getting upset because the above line is still there.
However it was removed in Len Brown's patch turbostat stuff
patch 15 of 44, which is in kernel 4.11-rc1.
(92134bdbc6272da6e98e9242cc6f1576cedc0735)

... [cut] ...

By the way, scripts/checkpatch.pl also complains about a line
length in the patch.

$ scripts/checkpatch.pl rjw_10_14.txt
WARNING: line over 80 characters
#148: FILE: drivers/cpufreq/intel_pstate.c:2031:
+       cpufreq_add_update_util_hook(cpu_num, &cpu->update_util, update_util_cb);

total: 0 errors, 1 warnings, 130 lines checked
 
