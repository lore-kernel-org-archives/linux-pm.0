From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when
 cpufreq updates the policy cpu
Date: Tue, 3 Mar 2015 09:33:34 +0530
Message-ID: <CAOh2x=m9c-gOYcesgh+4oc9NucFdD1y0Mcit5gPwLxGFt__Lng@mail.gmail.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
	<1425316643-31991-6-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:47495 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbbCCEDf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 23:03:35 -0500
In-Reply-To: <1425316643-31991-6-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, punit.agrawal@arm.com, Lina Iyer <lina.iyer@linaro.org>, Mark Brown <broonie@kernel.org>, Jon Medhurst <tixy@linaro.org>, Kapileshwar Singh <kapileshwar.singh@arm.com>

On Mon, Mar 2, 2015 at 10:47 PM, Javi Merino <javi.merino@arm.com> wrote:
> From: Kapileshwar Singh <kapileshwar.singh@arm.com>
>
> When cpufreq changes the policy cpu, we need to update our cached cpu
> device accordingly.
>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
> ---
>  drivers/thermal/cpu_cooling.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index c4974144c787..e306d6bc3cf1 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -269,6 +269,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>                 mutex_unlock(&cooling_cpufreq_lock);
>                 break;
>
> +       case CPUFREQ_UPDATE_POLICY_CPU:
> +               update_cpu_device(policy->cpu);
> +               break;
>         case CPUFREQ_CREATE_POLICY:
>                 update_cpu_device(policy->cpu);
>                 break;

First of all, I wasn't able to find 3/5 on LKML and I looked at 3/7
from an earlier
version to look at how update_cpu_device() looks like.

What I couldn't understand is why do you need to update things if policy->cpu
is changing ?

I am expecting a detailed answer here according to your design, and we may
be able to work out without such updates. Lets see..
