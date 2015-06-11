From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/PATCH V2] PM / Domains: Remove intermediate states from the
 power off sequence
Date: Thu, 11 Jun 2015 12:53:01 +0200
Message-ID: <CAPDyKFqSctMriniQpHxTgpDknxv0woG7ezQO3xBJPnLhpUoCDg@mail.gmail.com>
References: <1432735844-21629-1-git-send-email-ulf.hansson@linaro.org>
	<20150603183859.GR32700@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35691 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbbFKKxC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:53:02 -0400
Received: by qchs1 with SMTP id s1so944327qch.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:53:01 -0700 (PDT)
In-Reply-To: <20150603183859.GR32700@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[...]

>> static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>> -       __releases(&genpd->lock) __acquires(&genpd->lock)
>> {
>>         struct gpd_link *link;
>> -       DEFINE_WAIT(wait);
>>         int ret = 0;
>>
>> -       /* If the domain's master is being waited for, we have to wait
>> too. */
>> -       for (;;) {
>> -               prepare_to_wait(&genpd->status_wait_queue, &wait,
>> -                               TASK_UNINTERRUPTIBLE);
>> -               if (genpd->status != GPD_STATE_WAIT_MASTER)
>> -                       break;
>> -               mutex_unlock(&genpd->lock);
>> -
>> -               schedule();
>> -
>> -               mutex_lock(&genpd->lock);
>> -       }
>> -       finish_wait(&genpd->status_wait_queue, &wait);
>> -
>>         if (genpd->status == GPD_STATE_ACTIVE
>>             || (genpd->prepared_count > 0 && genpd->suspend_power_off))
>>                 return 0;
>>
>> -       if (genpd->status != GPD_STATE_POWER_OFF) {
>> -               genpd_set_active(genpd);
>> -               return 0;
>> -       }
>> -
>>         if (genpd->cpuidle_data) {
>>                 cpuidle_pause_and_lock();
>>                 genpd->cpuidle_data->idle_state->disabled = true;
>> @@ -285,20 +229,8 @@ static int __pm_genpd_poweron(struct
>> generic_pm_domain *genpd)
>>          */
>>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
>>                 genpd_sd_counter_inc(link->master);
>> -               genpd->status = GPD_STATE_WAIT_MASTER;
>> -
>> -               mutex_unlock(&genpd->lock);
>>
>>                 ret = pm_genpd_poweron(link->master);
>> -
>> -               mutex_lock(&genpd->lock);
>> -
>> -               /*
>> -                * The "wait for parent" status is guaranteed not to
>> change
>> -                * while the master is powering on.
>> -                */
>> -               genpd->status = GPD_STATE_POWER_OFF;
>> -               wake_up_all(&genpd->status_wait_queue);
>>                 if (ret) {
>>                         genpd_sd_counter_dec(link->master);
>>                         goto err;
>> @@ -310,14 +242,15 @@ static int __pm_genpd_poweron(struct
>> generic_pm_domain *genpd)
>>                 goto err;
>>
>>  out:
>> -       genpd_set_active(genpd);
>> -
>> +       genpd->status = GPD_STATE_ACTIVE;
>>         return 0;
>>
>>  err:
>>         list_for_each_entry_continue_reverse(link, &genpd->slave_links,
>> slave_node)
>>                 genpd_sd_counter_dec(link->master);
>>
>> +       /* In case we powered on a master, try to power it off again. */
>> +       pm_genpd_poweroff_unused();
>>
> This is an expensive operation, it locks the list and for each domain
> tries to power off the domain. You probably only need to traverse up the
> hierarchy of this domain to ensure that the parents domains do not
> remain unnecessarily powered on in this error clause.

You're right!

Although I now realize that this particular change shall not be part
of $subject patch, as this is more of a separate bug-fix to the
earlier behaviour. Let me cook a patch to deal with this, I will base
it on top of $subject patch.

>
> Also, the function uses mutex_locks to lock the genpd list. In the
> atomic genpd that I am proposing [1], we cannot call this function when
> the domain power_on fails.

That's another good reason, thanks for letting me know!

Kind regards
Uffe
