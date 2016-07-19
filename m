From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Check cpuid for MSR_HWP_INTERRUPT
Date: Wed, 20 Jul 2016 01:38:56 +0200
Message-ID: <CAJZ5v0iCouZ9xU8AOOL51RZZEsuRmY7fLLpidY+0mmoGB+R92Q@mail.gmail.com>
References: <1468971284-17686-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33694 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbcGSXjL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 19:39:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so4533049wme.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2016 16:38:58 -0700 (PDT)
In-Reply-To: <1468971284-17686-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, spandruv <spandruv@spandruv-mobl.jf.intel.com>

On Wed, Jul 20, 2016 at 1:34 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> From: spandruv <spandruv@spandruv-mobl.jf.intel.com>
>
> The MSR MSR_HWP_INTERRUPT is valid only when CPUID.06H:EAX[8] = 1, so
> check for feature before accessing this MSR.
>
> Signed-off-by: spandruv <spandruv@spandruv-mobl.jf.intel.com>

Do you really want this in the S-o-b tag?

> ---
>  drivers/cpufreq/intel_pstate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 2fe9af1..712afbd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -822,8 +822,10 @@ static void __init intel_pstate_sysfs_expose_params(void)
>
>  static void intel_pstate_hwp_enable(struct cpudata *cpudata)
>  {
> +
>         /* First disable HWP notification interrupt as we don't process them */
> -       wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
> +       if (static_cpu_has(X86_FEATURE_HWP_NOTIFY))
> +               wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
>
>         wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
>  }
> --
