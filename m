From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is
 set correctly
Date: Mon, 30 Mar 2015 18:57:53 +0530
Message-ID: <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33000 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbbC3N1z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 09:27:55 -0400
Received: by oifl3 with SMTP id l3so128534111oif.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2015 06:27:54 -0700 (PDT)
In-Reply-To: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Mike Turquette <mike.turquette@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 30 March 2015 at 17:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
> The actual frequency is set through "clk_change_rate" which is void
> function. If the underlying hardware fails and returns error, the error
> is lost in the clk layer. In order to track such failures, we need to
> read back the frequency(just the cached value as clk_recalc called after
> clk->ops->set_rate gets the frequency)
>
> This patch adds check to see if the frequency is set correctly or if
> they were any hardware failures and sends the appropriate errors to the
> cpufreq core.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/arm_big_little.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index e1a6ba66a7f5..3fc676c63f91 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -186,6 +186,8 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>                 mutex_unlock(&cluster_lock[old_cluster]);
>         }
>
> +       if (bL_cpufreq_get_rate(cpu) != new_rate)
> +               return -EIO;
>         return 0;
>  }

This doesn't look to me the right place for fixing this.

@Mike ??
