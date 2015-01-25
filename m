From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 16/17] cpufreq: remove check for cpufreq_disabled() from cpufreq_cpu_{get|put}()
Date: Sun, 25 Jan 2015 18:54:27 +0530
Message-ID: <CAKohpomwDr2B+4ncjFyfem1o03gJ+N6bdDEDtdJTvreN6ivp9Q@mail.gmail.com>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
	<49250a2946ff12500a5474eb9384c125b3ede23c.1420181916.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33752 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbbAYNY2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 08:24:28 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so4216499obc.6
        for <linux-pm@vger.kernel.org>; Sun, 25 Jan 2015 05:24:27 -0800 (PST)
In-Reply-To: <49250a2946ff12500a5474eb9384c125b3ede23c.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>

On 2 January 2015 at 12:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> In most of the cases cpufreq wouldn't be disabled and this adds unnecessary
> delay for its users. In the case if cpufreq is really disabled, then the per-cpu
> variable will also return NULL and things will continue working as is. Remove
> this unnecessary check.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 14d637a28dd8..62c6a0b8b0d1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -202,9 +202,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
>         struct cpufreq_policy *policy = NULL;
>         unsigned long flags;
>
> -       if (cpufreq_disabled())
> -               return NULL;
> -
>         if (!down_read_trylock(&cpufreq_rwsem))
>                 return NULL;
>
> @@ -229,9 +226,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
>
>  void cpufreq_cpu_put(struct cpufreq_policy *policy)
>  {
> -       if (cpufreq_disabled())
> -               return;
> -
>         kobject_put(&policy->kobj);
>         up_read(&cpufreq_rwsem);
>  }

@Rafael: Are you fine with this patch as is? I meant, you just left it for
rebase conflict or because you want it to be part of the WARN() you
suggested?

The WARN here might not be a good idea as this can be called by
users while cpufreq is disabled. But we don't need this check because
of the reasons I mentioned in commit log.
