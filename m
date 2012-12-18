From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] [RFC] cpufreq: can't raise max frequency with cpu_thermal
Date: Tue, 18 Dec 2012 08:03:36 -0800
Message-ID: <CAD=FV=XP9sPUEJPGZtrFqyPhBbAzsPYFBb6sAgbsSuj8qtiX=A@mail.gmail.com>
References: <1355819384-25983-1-git-send-email-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:51214 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932220Ab2LRQ2D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Dec 2012 11:28:03 -0500
Received: by mail-vc0-f173.google.com with SMTP id f13so1084909vcb.18
        for <linux-pm@vger.kernel.org>; Tue, 18 Dec 2012 08:28:02 -0800 (PST)
In-Reply-To: <1355819384-25983-1-git-send-email-sonnyrao@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Sameer Nanda <snanda@chromium.org>, Subash <subash.rp@samsung.com>

On Tue, Dec 18, 2012 at 12:29 AM, Sonny Rao <sonnyrao@chromium.org> wrote:
> The cpu_thermal generic thermal management code has a bug where once
> max cpu frequency has been lowered in sysfs (scaling_max_freq) it is
> not possible to raise the max back up later.  The bug is that the
> notifer gets called by __cpufreq_set_policy() before the user policy
> max is raised, and is incorrectly trying to enforce the max frequency
> policy even when we are trying to change the policy.  It is also not
> clear why this driver is looking at the user policy since it is
> primarily supposed to enforce thermal policy, not user set policy.
>
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>  drivers/thermal/cpu_cooling.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 836828e..63bc708 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -219,10 +219,6 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>         if (cpumask_test_cpu(policy->cpu, &notify_device->allowed_cpus))
>                 max_freq = notify_device->cpufreq_val;
>
> -       /* Never exceed user_policy.max*/
> -       if (max_freq > policy->user_policy.max)
> -               max_freq = policy->user_policy.max;
> -
>         if (policy->max != max_freq)
>                 cpufreq_verify_within_limits(policy, 0, max_freq);
>
> --
> 1.7.7.3
>

Sonny's change matches what the "ACPI version" of this code
(drivers/acpi/processor_thermal.c) does as well.  I would certainly be
interested to know why the code was added here in the first place.
Amit: do you know?

Reviewed-by: Doug Anderson <dianders@chromium.org>
