From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/14] cpufreq: intel_pstate: Update pid_params.sample_rate_ns
 in pid_param_set()
Date: Mon, 13 Mar 2017 09:30:04 +0530
Message-ID: <CAOh2x=m-AS3CCHu9eo2K1ZMMOGBCx6vtk7qdv6Kfadr0X=Vkzg@mail.gmail.com>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan> <1870069.9aRhgp95Gh@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34560 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdCMEAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 00:00:06 -0400
In-Reply-To: <1870069.9aRhgp95Gh@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Sun, Mar 12, 2017 at 10:42 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Fix the debugfs interface for PID tuning to actually update
> pid_params.sample_rate_ns on PID parameters updates, as changing
> pid_params.sample_rate_ms via debugfs has no effect now.
>
> Fixes: a4675fbc4a7a (cpufreq: intel_pstate: Replace timers with utilization update callbacks)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |    1 +
>  1 file changed, 1 insertion(+)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -983,6 +983,7 @@ static void intel_pstate_update_policies
>  static int pid_param_set(void *data, u64 val)
>  {
>         *(u32 *)data = val;
> +       pid_params.sample_rate_ns = pid_params.sample_rate_ms * NSEC_PER_MSEC;
>         intel_pstate_reset_all_pid();
>         return 0;
>  }
>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
