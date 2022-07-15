Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EECC433EF
	for <linux-pm@archiver.kernel.org>; Fri, 15 Jul 2022 17:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiGORVJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiGORVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 13:21:08 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0B7BE00;
        Fri, 15 Jul 2022 10:21:07 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id y195so9594413yby.0;
        Fri, 15 Jul 2022 10:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXO9HHeJnu/ftHXZZquFI+I2jU4V4gvvQkgnXPEuw2E=;
        b=itF3OA81B+WUW3CIUrqeZ9JDxIUG/MuO7jloORGouF+sC7lDo8uflrrT1SVWna8xd6
         r7SnadgLRFLf3niqiM4LQwAbbtUMsB7GZ7kTdqG3UPx4GTePrbmZgH4OCNX1YLKp4GoQ
         4CjlayIlXXvUJIGyfRW/JniAXofJRSkSlLgmJAXjwbb09drcqHJcI9yEhtQqUfgyl63i
         NjIrb1/MZcl788iHVWDRYHSJRyu+5WEsZ9C55lkdQ39wbZFb4JYp4lm+Sjl9m8/zOEvp
         erSpKRS3V2Q1ZcE+OM73VNmdUAUWlqRkCzePIGuptqoV00Rr1b1jdeW1CX/NWKvn4bYB
         EvYg==
X-Gm-Message-State: AJIora+3xMhx3rtlLlYrhRBMItLA+adAQFuMK5fiBqxHJUFCbd2rQCav
        mz2o8Tsw4QZap1PrnX03ZHDzZHYrXdP9wrlvhk0=
X-Google-Smtp-Source: AGRyM1sjI3GMJPwqcC1ilY1D10Oj4epnBsiNC/Xts3uiCvsAiPeDAq1UA9wJf5bfs4hEIWQnBoSonuR+sWm4aDMWwV8=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr14135181ybu.365.1657905666289; Fri, 15
 Jul 2022 10:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <0af6e95f8da395f75c5a58363d8b1b40483252c8.1657187391.git.viresh.kumar@linaro.org>
In-Reply-To: <0af6e95f8da395f75c5a58363d8b1b40483252c8.1657187391.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 19:20:55 +0200
Message-ID: <CAJZ5v0i9+xyqcp+Ohmjh8J45xXqdGvNgFQ6WSx8NLcNMYS_khA@mail.gmail.com>
Subject: Re: [PATCH V3] cpufreq: Warn users while freeing active policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 7, 2022 at 11:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> With the new design in place, the show() and store() callbacks check if
> the policy is active or not before proceeding any further to avoid
> potential races. And in order to guarantee that cpufreq_policy_free()
> must be called after clearing the policy->cpus mask, i.e. by marking the
> policy inactive.
>
> In order to avoid introducing a bug around this later, print a warning
> message if we end up freeing an active policy.
>
> Also update cpufreq_online() a bit to make sure we clear the cpus mask
> for each error case before calling cpufreq_policy_free().
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3: BUG_ON() -> pr_warn()
>
>  drivers/cpufreq/cpufreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 73432360e6e9..954eef26685f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1273,6 +1273,13 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>         unsigned long flags;
>         int cpu;
>
> +       /*
> +        * The callers must ensure the policy is inactive by now, to avoid any
> +        * races with show()/store() callbacks.
> +        */
> +       if (unlikely(!policy_is_inactive(policy)))
> +               pr_warn("%s: Freeing active policy\n", __func__);
> +
>         /* Remove policy from list */
>         write_lock_irqsave(&cpufreq_driver_lock, flags);
>         list_del(&policy->policy_list);
> @@ -1527,8 +1534,6 @@ static int cpufreq_online(unsigned int cpu)
>         for_each_cpu(j, policy->real_cpus)
>                 remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
>
> -       cpumask_clear(policy->cpus);
> -
>  out_offline_policy:
>         if (cpufreq_driver->offline)
>                 cpufreq_driver->offline(policy);
> @@ -1538,6 +1543,7 @@ static int cpufreq_online(unsigned int cpu)
>                 cpufreq_driver->exit(policy);
>
>  out_free_policy:
> +       cpumask_clear(policy->cpus);
>         up_write(&policy->rwsem);
>
>         cpufreq_policy_free(policy);
> --

Applied as 5.20 material, thanks!
