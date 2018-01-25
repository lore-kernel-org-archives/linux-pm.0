From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: enable HWP before manipulating
 on corresponding registers
Date: Thu, 25 Jan 2018 14:44:59 -0800
Message-ID: <1516920299.16193.21.camel@linux.intel.com>
References: <20180125110802.15141-1-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:42854 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbeAYWpB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jan 2018 17:45:01 -0500
In-Reply-To: <20180125110802.15141-1-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2018-01-25 at 19:08 +0800, Yu Chen wrote:

Thanks for debugging.

> The following warning was triggered after resumed from S3 -
> if all the nonboot CPUs were put offline before suspend:
> 
> [ 1840.329515] unchecked MSR access error: RDMSR from 0x771 at rIP:
> 0xffffffff86061e3a (native_read_msr+0xa/0x30)
[...]

[ 1840.329556]  acpi_processor_ppc_has_changed+0x65/0x80

This is the problem. You are getting a _PPC during resume which needs
_PSS table to really do anything.

So the correct fix should not in intel_pstate IMO but

diff --git a/drivers/acpi/processor_perflib.c
b/drivers/acpi/processor_perflib.c
index 18b72ee..c7cf48a 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -159,7 +159,7 @@ void acpi_processor_ppc_has_changed(struct
acpi_processor *pr, int event_flag)
 {
        int ret;
 
-       if (ignore_ppc) {
+       if (ignore_ppc || !pr->performance) {
                /*
                 * Only when it is notification event, the _OST object
                 * will be evaluated. Otherwise it is skipped.


...
Since we don't call acpi_processor_register_performance(), the pr-
>performance will be NULL. When this is NULL we don't need to do PPC
change notification.
Even if we register performance, processing a PPC notification is
complex as we have to wait for PPC=0 before enabling HWP otherwise we
will be stuck with low performance (The event may not come once in HWP
is in control).

The important bug which you identified need a fix in resume when
maxcpus=1.

diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index 93a0e88..10e5efc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -779,13 +779,16 @@ static int intel_pstate_hwp_save_state(struct
cpufreq_policy *policy)
        return 0;
 }
 
+static void intel_pstate_hwp_enable(struct cpudata *cpudata);
+
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
        if (!hwp_active)
                return 0;
 
        mutex_lock(&intel_pstate_limits_lock);
-
+       if (!policy->cpu)
+               intel_pstate_hwp_enable(all_cpu_data[policy->cpu]);
        all_cpu_data[policy->cpu]->epp_policy = 0;
        intel_pstate_hwp_set(policy->cpu);


Thanks,
Srinivas


> This is because if there's only one online CPU, the MSR_PM_ENABLE
> (package wide)can not be enabled after resumed, due to
> intel_pstate_hwp_enable() will only be invoked on AP's online
> process after resumed - if there's no AP online, the HWP remains
> disabled after resumed (BIOS has disabled it in S3).
> 
> The re-enabling of HWP can not be put into intel_pstate_resume()
> as it is too late according to the log above. It is applicable
> to do it in syscore_resume() but this requires a new notifier.
> Thus forcely enable the HWP before manipulating on them, and this
> should not impact much because users seldom touch HWP registers.
> 
> Reported-by: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Yu Chen <yu.c.chen@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 93a0e88bef76..b808f0127192 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -689,6 +689,8 @@ static void intel_pstate_get_hwp_max(unsigned int
> cpu, int *phy_max,
>  {
>  	u64 cap;
>  
> +	/* In case HWP is disabled after resumed from S3. */
> +	wrmsrl_on_cpu(cpu, MSR_PM_ENABLE, 0x1);
>  	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
>  	if (global.no_turbo)
>  		*current_max = HWP_GUARANTEED_PERF(cap);
> @@ -711,6 +713,8 @@ static void intel_pstate_hwp_set(unsigned int
> cpu)
>  	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
>  		min = max;
>  
> +	/* In case HWP is disabled after resumed from S3. */
> +	wrmsrl_on_cpu(cpu, MSR_PM_ENABLE, 0x1);
>  	rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
>  
>  	value &= ~HWP_MIN_PERF(~0L);
