From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Add time accounting to various genpd states.
Date: Wed, 14 Jun 2017 11:18:49 +0200
Message-ID: <CAPDyKFpVnvCv5P8xXBmnabgzvhLAFDVKn1bSM4MysXAzReMsjA@mail.gmail.com>
References: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
 <1495756293-29534-2-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqfVN4KDQETdq9_edkNE0wi2Ff-g0w9i6UFE-NKbwhJGg@mail.gmail.com> <59404863.1030608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36692 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdFNJS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2017 05:18:56 -0400
Received: by mail-qk0-f178.google.com with SMTP id g83so22255233qkb.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2017 02:18:55 -0700 (PDT)
In-Reply-To: <59404863.1030608@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>

On 13 June 2017 at 22:17, Thara Gopinath <thara.gopinath@linaro.org> wrote:
> On 06/07/2017 09:28 AM, Ulf Hansson wrote:
> Hello Ulf,
>
>> On 26 May 2017 at 01:51, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>> This patch adds support to calculate the time spent by the generic
>>> power domains in on and various idle states.
>>>
>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>> ---
>>>  drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
>>>  include/linux/pm_domain.h   |  4 ++++
>>>  2 files changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index da49a83..e733796 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -207,6 +207,25 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>>>         smp_mb__after_atomic();
>>>  }
>>>
>>> +static void genpd_update_accounting(struct generic_pm_domain *genpd)
>>
>> I suggest we have all this within #ifdef CONFIG_DEBUG_FS and add a
>> stub for !CONFIG_DEBUG_FS.
>>
>>> +{
>>> +       ktime_t delta, now;
>>> +
>>> +       now = ktime_get();
>>> +       delta = ktime_sub(now, genpd->accounting_time);
>>> +
>>> +       if (genpd->status == GPD_STATE_ACTIVE) {
>>> +               genpd->on_time = ktime_add(genpd->on_time, delta);
>>> +       } else {
>>> +               int state_idx = genpd->state_idx;
>>> +
>>> +               genpd->states[state_idx].active_time =
>>
>> "active_time" seems to be a misleading, can we rename it to "idle_time" instead?
>>
>>> +                       ktime_add(genpd->states[state_idx].active_time, delta);
>>> +               genpd->off_time = ktime_add(genpd->off_time, delta);
>>
>> Isn't the off_time the summary of the states' genpd->states[i].active_time?
>>
>> Then we could do that computation quite easily at the point when
>> producing the debugfs output instead.
>>
>>> +       }
>>> +       genpd->accounting_time = now;
>>> +}
>>> +
>>>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>>>  {
>>>         unsigned int state_idx = genpd->state_idx;
>>> @@ -358,6 +377,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>>>                         return ret;
>>>         }
>>>
>>> +       genpd_update_accounting(genpd);
>>
>> It find it a bit odd to update accounting just before changing the
>> status. Can we re-work this and update accounting right afterwards
>> instead? At least to me, that makes this easier to understand.
>
> The accounting is being updated for the previous state and not the
> current state. For eg if the domain has been previously off and just
> turned on, the time spent in off state is updated. So it
> upadte_accounting has to be before changing the status.
> Sorry I did not mention this earlier as I just realized this as
> I was reworking the patches.
>

Yes, I understand.

However, of course changing this also means that you need to change
how genpd_update_accounting works. That's was my main point, sorry if
that wasn't clear.

Kind regards
Uffe
