Return-Path: <SRS0=ZSGc=DA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B04C4363D
	for <linux-pm@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1432206D9
	for <linux-pm@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600874101;
	bh=QrmDjCOTcLloGMxnxbgwXU5bOxnECiEbzk1EQNAqoE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nNhVLeforGjs1KFqpqvDhZmLjwxW69FA+cPhtPSEI9T0ff8lkgYZmj6R2ac1hRfcO
	 SDRuCt+L81vmE+2Lwhscn5JaX4Ds7VpG8oR08iS5r1Dv16XuiV0y1C1tttMx/Chg0c
	 TfQC4SAttEhv+8yfcxN4iSjEcqd1agIRP5UN/Qqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIWPPB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:15:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45197 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPPB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 11:15:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id g96so8223otb.12;
        Wed, 23 Sep 2020 08:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLhyE7P88DmYg4/i6cdyiyPI9KCBG/i6ZZuiz/aXSLc=;
        b=Q4lxKB/nQ2UAVawqaeqehqOj4qKewY+w30Q3EQjP+XK9vEKi3RUeFlDuzFNQo61Pe4
         WS7dQ8/kBbF7TwIU3gsB2I0t8lCJiG46s34Ws9mCLtg9h0MqwEAhagW36TGgZ8iUdL6V
         Eyyhr76muktuxSimtfiicvfgZx0W7ELDhITlbRvJWk8srBR7O0s36CPeoU9eBS73ehn7
         z/QpkOUDslgKZOiwpP8AufndbFmBb3Dw1DPFeLp59GLqNjzmeZbVuJLOSiEGJm+8eFdD
         UEjVCv0cHX1yax4yS1X1/0cWNRYzPFdb7VyDpgYLXkkfowg+3Sp84awGAwJgJzw9zwTn
         jEPg==
X-Gm-Message-State: AOAM53133+ATG7rk9L+BYQqwWbtkN8KOEig6m9w/G5t8UjehwVwD1xmB
        c3eGcjhvKtxrH3w8ldftKn2LP6ljZZdwAUMxr0F2uNC2gfg=
X-Google-Smtp-Source: ABdhPJykR8lBZF2HGW4t494yDOxxknw2beOWkCZU2P5J0lda09bal7FRXuYyNAdAJoX9HWknleYb3Y466Xlu/6zqt2E=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr114896otj.262.1600874100200;
 Wed, 23 Sep 2020 08:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600238586.git.viresh.kumar@linaro.org> <c9dc39f9956ad9851511d6710e8f8a5cb142789e.1600238586.git.viresh.kumar@linaro.org>
In-Reply-To: <c9dc39f9956ad9851511d6710e8f8a5cb142789e.1600238586.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Sep 2020 17:14:49 +0200
Message-ID: <CAJZ5v0hpT9CAb1hxKcQVA-OJP3UYja=Kqvgh-Ed4N8Ln+=2b5A@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] cpufreq: stats: Enable stats for fast-switch as well
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 16, 2020 at 8:46 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Now that all the blockers are gone for enabling stats in fast-switching
> case, enable it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c       | 6 +++++-
>  drivers/cpufreq/cpufreq_stats.c | 6 ------
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 47aa90f9a7c2..d5fe64e96be9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2057,8 +2057,12 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>                                         unsigned int target_freq)
>  {
>         target_freq = clamp_val(target_freq, policy->min, policy->max);
> +       target_freq = cpufreq_driver->fast_switch(policy, target_freq);
>
> -       return cpufreq_driver->fast_switch(policy, target_freq);
> +       if (target_freq)
> +               cpufreq_stats_record_transition(policy, target_freq);

So this adds two extra branches in the scheduler path for the cases
when the stats are not used at all which seems avoidable to some
extent.

Can we check policy->stats upfront here and bail out right away if it
is not set, for example?

> +
> +       return target_freq;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 314fa1d506d0..daea17f0c36c 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -69,9 +69,6 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>         ssize_t len = 0;
>         int i;
>
> -       if (policy->fast_switch_enabled)
> -               return 0;
> -
>         for (i = 0; i < stats->state_num; i++) {
>                 if (pending) {
>                         if (i == stats->last_index)
> @@ -115,9 +112,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>         ssize_t len = 0;
>         int i, j, count;
>
> -       if (policy->fast_switch_enabled)
> -               return 0;
> -
>         len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
>         len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
>         for (i = 0; i < stats->state_num; i++) {
> --
> 2.25.0.rc1.19.g042ed3e048af
>
