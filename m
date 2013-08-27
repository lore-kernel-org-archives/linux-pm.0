From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix timer/workqueue corruption due to double queueing
Date: Tue, 27 Aug 2013 12:01:03 +0530
Message-ID: <CAKohpoktPNtSMRn0dEVjcEW5_62E+_UEgySOBJ-hG+r=NU3V2w@mail.gmail.com>
References: <1377557137-1157-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:41638 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab3H0GbF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2013 02:31:05 -0400
Received: by mail-oa0-f45.google.com with SMTP id m1so1824697oag.32
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2013 23:31:04 -0700 (PDT)
In-Reply-To: <1377557137-1157-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 27 August 2013 04:15, Stephen Boyd <sboyd@codeaurora.org> wrote:
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -133,7 +133,7 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>  {
>         int i;
>
> -       if (!all_cpus) {
> +       if (!all_cpus || !policy->governor_enabled) {
>                 __gov_queue_work(smp_processor_id(), dbs_data, delay);
>         } else {
>                 for_each_cpu(i, policy->cpus)

Shouldn't we simply do this instead at the top of this function?

> +       if (!policy->governor_enabled)
> +              return;
