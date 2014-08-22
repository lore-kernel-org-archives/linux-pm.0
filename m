From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add CPU ID for Braswell processor
Date: Fri, 22 Aug 2014 15:49:50 +0530
Message-ID: <CAKohpo=7CyRT7szhJAQXjRfBFyw_6LuHSdVS39z=899T0eBoMg@mail.gmail.com>
References: <1408701944-14734-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:52957 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbaHVKTv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Aug 2014 06:19:51 -0400
Received: by mail-oi0-f46.google.com with SMTP id i138so7604193oig.33
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2014 03:19:51 -0700 (PDT)
In-Reply-To: <1408701944-14734-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 22 August 2014 15:35, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> This is pretty much the same as Intel Baytrail, only the CPU ID is
> different. Add the new ID to the supported CPU list.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>

Dirk might be away on holidays..

> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index c5eac949760d..a3cf8994160b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -660,6 +660,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>         ICPU(0x3f, core_params),
>         ICPU(0x45, core_params),
>         ICPU(0x46, core_params),
> +       ICPU(0x4c, byt_params),
>         ICPU(0x4f, core_params),
>         ICPU(0x56, core_params),
>         {}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
