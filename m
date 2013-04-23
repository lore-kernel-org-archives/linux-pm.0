From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq_conservative: initialize the cpu_dbs_info_s cpu field
Date: Tue, 23 Apr 2013 20:49:13 +0530
Message-ID: <CAOh2x=nZir=RohrbVJa1iWR47nmLKfG3it1UnWdt49oAKrBhWw@mail.gmail.com>
References: <51769DB3.7030404@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:55160 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab3DWPTO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 11:19:14 -0400
In-Reply-To: <51769DB3.7030404@ccur.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Blackwood <john.blackwood@ccur.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Apr 23, 2013 at 8:11 PM, John Blackwood <john.blackwood@ccur.com> wrote:
> In the cpufreq conservative module, the cpu field in the cpu_dbs_info_s
> structure was not being initialized, and thus all cpus were scheduling
> their do_dbs_timer() delayed work processing on cpu 0.
>
> Signed-off-by: John Blackwood <john.blackwood@ccur.com>
> Index: b/drivers/cpufreq/cpufreq_conservative.c
> ===================================================================
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -506,6 +506,7 @@ static int cpufreq_governor_dbs(struct c
>                 }
>                 this_dbs_info->down_skip = 0;
>                 this_dbs_info->requested_freq = policy->cur;
> +               this_dbs_info->cpu = cpu;
>
>                 mutex_init(&this_dbs_info->timer_mutex);
>                 dbs_enable++;

What have you rebased this on? I don't think its the latest code and is probably
a bit old.
