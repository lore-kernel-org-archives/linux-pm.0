From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Don't use smp_processor_id() in preemptible context
Date: Wed, 28 Aug 2013 12:04:53 +0530
Message-ID: <CAKohpo=RLmXK+vX9b7yBOGiS=d0ZEt3RpJETNvBeSRhYfoYWuA@mail.gmail.com>
References: <1377629249-1177-1-git-send-email-sboyd@codeaurora.org>
	<1377640884-16827-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:50062 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab3H1Gey (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 02:34:54 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so7086465oah.23
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2013 23:34:53 -0700 (PDT)
In-Reply-To: <1377640884-16827-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@sisk.pl>

On 28 August 2013 03:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index b9b20fd..523af48 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -137,7 +137,7 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>                 return;
>
>         if (!all_cpus) {
> -               __gov_queue_work(smp_processor_id(), dbs_data, delay);
> +               __gov_queue_work(policy->cpu, dbs_data, delay);

This is probably wrong.. We wanted to queue work on current cpu and
not policy->cpu.. Can you use raw_smp_processor_id()?

>         } else {
>                 for_each_cpu(i, policy->cpus)
>                         __gov_queue_work(i, dbs_data, delay);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
>
