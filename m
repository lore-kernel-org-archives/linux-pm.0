From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] fix intel_pstate to update MSR values when changing governors
Date: Sat, 17 Oct 2015 03:15:29 +0200
Message-ID: <CAJZ5v0j0es9FEp1kFxbrHfnK1c55LzgP326fsqU8qYYpjN=26Q@mail.gmail.com>
References: <1445043101-19079-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34915 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbJQBPe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 21:15:34 -0400
Received: by lbbes7 with SMTP id es7so21376668lbb.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 18:15:30 -0700 (PDT)
In-Reply-To: <1445043101-19079-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: kristen@linux.intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, root <root@skl-s-fedora22.jf.intel.com>

Hi,

On Sat, Oct 17, 2015 at 2:51 AM, Alexandra Yates
<alexandra.yates@linux.intel.com> wrote:
> From: root <root@skl-s-fedora22.jf.intel.com>
>
> When changing from powersave to performance governors
> Intel_pstate fails to update the MSR values that reflect the
> max_perf_pct to 100%. For instance:
>
> Governor        MSR     max_perf_pct
> =========       ====    ============
> Powersave       2828    100%
> Powersave       2028    80%
> Performance     2028    100% <-
>
> The arrow shows the culprit. At this point the  MSR should
> reflect the max_perf_pct that is 100% that corresponds MSR 2828
> the maximum performance for the Performance governor.
> Instead it holds back the MSR value previously set
> by the Powersave governor 2028.
>
> Signed-off-by: root <root@skl-s-fedora22.jf.intel.com>

It looks like you need to update your git configuration.

More to the point, I wonder if this commit addresses the problem your seeing:

http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=51443fbf3d2cde16011b994252c8004ebcd66fb0

> ---
>  drivers/cpufreq/intel_pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index cde38c8..992dbb5 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1239,6 +1239,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>             policy->max >= policy->cpuinfo.max_freq) {
>                 pr_debug("intel_pstate: set performance\n");
>                 limits = &performance_limits;
> +               if (hwp_active)
> +                       intel_pstate_hwp_set();
>                 return 0;
>         }
>
> --

Thanks,
Rafael
