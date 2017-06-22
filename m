From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Bug in cpufreq_update_util hook handling?
Date: Thu, 22 Jun 2017 02:36:34 +0200
Message-ID: <CAJZ5v0j_ZAkNffse920BngRe6kEn5_7crQw8KFgaMMh-4YhLww@mail.gmail.com>
References: <594B0E53.7020208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36182 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdFVAgf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 20:36:35 -0400
Received: by mail-it0-f65.google.com with SMTP id 185so2441069itv.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2017 17:36:35 -0700 (PDT)
In-Reply-To: <594B0E53.7020208@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

On Thu, Jun 22, 2017 at 2:24 AM, Saravana Kannan <skannan@codeaurora.org> wrote:
> cpufreq_add_update_util_hook() registers the "data" and we are using RCUs to
> store "data".
>
> When we need to send util updates, scheduler calls cpufreq_update_util()
> that just uses a rcu_dereference_sched() to access the data pointer.
>
> When the governor is stopped, to unregister the hook, it calls
> cpufreq_remove_update_util_hook() and calls synchronize_sched(). The
> assumption that the governor is making (and is allowed to make) is that
> after synchronize_sched() all references to "data" and "func" are no longer
> used (since cpufreq_remove_update_util_hook is supposed to replace data with
> NULL).
>
> I'm no RCU, expert, if I understand it right, if we don't use
> "rcu_read_lock()" and "rcu_read_unlock()" in cpufreq_update_util(), then the
> scheduler can continue calling into the governor hooks after the governor
> has stopped.
>
> rcu_read_lock();
> data = rcu_dereference_sched(*per_cpu_ptr(&cpufreq_update_util_data,
>                                 cpu_of(rq)));
> if (data)
>         data->func(data, sched_clock(), flags);
> rcu_read_unlock();
>
> Is my understanding right?

No, it isn't.

This is RCU-sched (as documented) and this code already runs in a
read-side critical section.

Thanks,
Rafael
