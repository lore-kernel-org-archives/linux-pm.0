From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Add time accounting to various genpd
 states.
Date: Mon, 12 Jun 2017 14:51:04 -0400
Message-ID: <593EE298.1060805@linaro.org>
References: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
 <1495756293-29534-2-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqfVN4KDQETdq9_edkNE0wi2Ff-g0w9i6UFE-NKbwhJGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35647 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdFLSvI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 14:51:08 -0400
Received: by mail-qt0-f173.google.com with SMTP id w1so137580941qtg.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 11:51:08 -0700 (PDT)
In-Reply-To: <CAPDyKFqfVN4KDQETdq9_edkNE0wi2Ff-g0w9i6UFE-NKbwhJGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>

On 06/07/2017 09:28 AM, Ulf Hansson wrote:
> On 26 May 2017 at 01:51, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>> This patch adds support to calculate the time spent by the generic
>> power domains in on and various idle states.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |  4 ++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index da49a83..e733796 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -207,6 +207,25 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>>         smp_mb__after_atomic();
>>  }
>>
>> +static void genpd_update_accounting(struct generic_pm_domain *genpd)
> 
> I suggest we have all this within #ifdef CONFIG_DEBUG_FS and add a
> stub for !CONFIG_DEBUG_FS.

Ok.
> 
>> +{
>> +       ktime_t delta, now;
>> +
>> +       now = ktime_get();
>> +       delta = ktime_sub(now, genpd->accounting_time);
>> +
>> +       if (genpd->status == GPD_STATE_ACTIVE) {
>> +               genpd->on_time = ktime_add(genpd->on_time, delta);
>> +       } else {
>> +               int state_idx = genpd->state_idx;
>> +
>> +               genpd->states[state_idx].active_time =
> 
> "active_time" seems to be a misleading, can we rename it to "idle_time" instead?

I meant it as the the active time in each state. But yes it is
confusing. Ideally states should be renamed to idle_states. But yes I
can change active_time to idle_time.
> 
>> +                       ktime_add(genpd->states[state_idx].active_time, delta);
>> +               genpd->off_time = ktime_add(genpd->off_time, delta);
> 
> Isn't the off_time the summary of the states' genpd->states[i].active_time?

Yes. it is.
> 
> Then we could do that computation quite easily at the point when
> producing the debugfs output instead.

Are yu suggesting doing away with off_time parameter all together. It is
possible.
> 
>> +       }
>> +       genpd->accounting_time = now;
>> +}
>> +
>>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>>  {
>>         unsigned int state_idx = genpd->state_idx;
>> @@ -358,6 +377,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>>                         return ret;
>>         }
>>
>> +       genpd_update_accounting(genpd);
> 
> It find it a bit odd to update accounting just before changing the
> status. Can we re-work this and update accounting right afterwards
> instead? At least to me, that makes this easier to understand.

Agreed.
> 
>>         genpd->status = GPD_STATE_POWER_OFF;
>>
>>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
>> @@ -410,6 +430,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>>         if (ret)
>>                 goto err;
>>
>> +       genpd_update_accounting(genpd);
> 
> Ditto.
> 
>>         genpd->status = GPD_STATE_ACTIVE;
>>         return 0;
>>
>> @@ -774,6 +795,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>>         if (_genpd_power_off(genpd, false))
>>                 return;
>>
>> +       genpd_update_accounting(genpd);
> 
> Timekeeping gets disabled at a certain point during suspend. Therefore
> you can't update accounting here, as this function gets called in this
> stages.

I will remove the update of accounting at this point. But then the
statistics  can be skewed for some power domains atleast. Other option
is to restart the accounting every time after device suspend and resume.

Regards
Thara

> 
>>         genpd->status = GPD_STATE_POWER_OFF;
>>
>>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
>> @@ -821,6 +843,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>>
>>         _genpd_power_on(genpd, false);
>>
>> +       genpd_update_accounting(genpd);
> 
> Ditto.
> 
>>         genpd->status = GPD_STATE_ACTIVE;
>>  }
>>
>> @@ -1486,6 +1509,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>>         genpd->max_off_time_changed = true;
>>         genpd->provider = NULL;
>>         genpd->has_provider = false;
>> +       genpd->accounting_time = ktime_get();
>>         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>>         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
>>         genpd->domain.ops.prepare = pm_genpd_prepare;
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index b7803a2..8bee0e3 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -43,6 +43,7 @@ struct genpd_power_state {
>>         s64 power_on_latency_ns;
>>         s64 residency_ns;
>>         struct fwnode_handle *fwnode;
>> +       ktime_t active_time;
>>  };
>>
>>  struct genpd_lock_ops;
>> @@ -78,6 +79,9 @@ struct generic_pm_domain {
>>         unsigned int state_count; /* number of states */
>>         unsigned int state_idx; /* state that genpd will go to when off */
>>         void *free; /* Free the state that was allocated for default */
>> +       ktime_t on_time;
>> +       ktime_t off_time;
>> +       ktime_t accounting_time;
>>         const struct genpd_lock_ops *lock_ops;
>>         union {
>>                 struct mutex mlock;
>> --
>> 2.1.4
>>
> 
> Kind regards
> Uffe
> 


-- 
Regards
Thara
