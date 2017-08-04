From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Improve IO performance
Date: Fri, 4 Aug 2017 02:34:51 +0200
Message-ID: <CAJZ5v0henjb2Y0rJdc92BJVgGHg1Nb=eWLnd75eVBP5PJVmCog@mail.gmail.com>
References: <1501645506-29398-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36221 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHDAew (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2017 20:34:52 -0400
Received: by mail-io0-f196.google.com with SMTP id j32so187824iod.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Aug 2017 17:34:52 -0700 (PDT)
In-Reply-To: <1501645506-29398-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Wed, Aug 2, 2017 at 5:45 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> In the current implementation the latency from SCHED_CPUFREQ_IOWAIT is
> set to actual P-state adjustment can be upto 10ms. This can be improved
> by reacting to SCHED_CPUFREQ_IOWAIT by jumping to max P-state immediately
> . With this change the IO performance improves significantly.
>
> With a simple "grep -r . linux" (Here linux is kernel source folder) with
> dropped caches every time on a platform with per core P-states on a
> Broadwell Xeon workstation, the user and system time improves as much as
> 30% to 40%.
>
> The same performance difference was not observed on clients, which don't
> have per core P-state support.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8c67b77..7762255 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1527,6 +1527,15 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>
>         if (flags & SCHED_CPUFREQ_IOWAIT) {
>                 cpu->iowait_boost = int_tofp(1);
> +               /*
> +                * The last time the busy was 100% so P-state was max anyway
> +                * so avoid overhead of computation.
> +                */
> +               if (fp_toint(cpu->sample.busy_scaled) == 100) {
> +                       cpu->last_update = time;
> +                       return;
> +               }
> +               goto set_pstate;

cpu->last_update should also be updated when you jump to set_pstate,
shouldn't it?

>         } else if (cpu->iowait_boost) {
>                 /* Clear iowait_boost if the CPU may have been idle. */
>                 delta_ns = time - cpu->last_update;
> @@ -1538,6 +1547,7 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
>         if ((s64)delta_ns < INTEL_PSTATE_DEFAULT_SAMPLING_INTERVAL)
>                 return;
>
> +set_pstate:
>         if (intel_pstate_sample(cpu, time)) {
>                 int target_pstate;
>
> --
> 2.7.4
>
