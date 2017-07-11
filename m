From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH V3 2/2] PM / Domains: Extend generic power domain debugfs.
Date: Tue, 11 Jul 2017 17:30:26 -0400
Message-ID: <59654372.3090300@linaro.org>
References: <1498235543-30064-1-git-send-email-thara.gopinath@linaro.org>
 <1498235543-30064-3-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFoFhegBOEbw6YHJK+AG7dmPFh9nY-pt+7q27ZSN-JkejA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36083 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbdGKVa3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 17:30:29 -0400
Received: by mail-qk0-f171.google.com with SMTP id p21so4268341qke.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2017 14:30:29 -0700 (PDT)
In-Reply-To: <CAPDyKFoFhegBOEbw6YHJK+AG7dmPFh9nY-pt+7q27ZSN-JkejA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 07/11/2017 05:06 AM, Ulf Hansson wrote:
> On 23 June 2017 at 18:32, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>> This patch extends the existing generic power domain debugfs.
>> Changes involve the following
>> - Introduce a unique debugfs entry for each generic power domain with the
>>   following attributes
>>         - current_state - Displays current state of the domain.
>>         - devices - Displays the devices associated with this domain.
>>         - sub_domains - Displays the sub power domains.
>>         - active_time - Displays the time the domain was in active state
>>                         in ms.
>>         - total_idle_time - Displays the time the domain was in any of the idle
>>                         states in ms.
>>         - idle_states - Displays the various idle states and the time
>>                         spent in each idle state in ms.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 205 ++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 197 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 40768cc..a10f789 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -2328,21 +2328,191 @@ static int pm_genpd_summary_show(struct seq_file *s, void *data)
>>         return ret;
>>  }
>>
>> -static int pm_genpd_summary_open(struct inode *inode, struct file *file)
>> +static int pm_genpd_status_show(struct seq_file *s, void *data)
> 
> Naming rules for static functions in genpd should have genpd_* as
> prefix and not pm_genpd_* as those are for exported APIs.
> 
> There still some static functions that doesn't follow that rule, but
> please don't add more. Following applies to all new functions adding
> in this change.
> 
>>  {
>> -       return single_open(file, pm_genpd_summary_show, NULL);
>> +       static const char * const status_lookup[] = {
>> +               [GPD_STATE_ACTIVE] = "on",
>> +               [GPD_STATE_POWER_OFF] = "off"
>> +       };
>> +
>> +       struct generic_pm_domain *genpd = s->private;
>> +       int ret = 0;
>> +
>> +       ret = genpd_lock_interruptible(genpd);
>> +       if (ret)
>> +               return -ERESTARTSYS;
>> +
>> +       if (WARN_ON_ONCE(genpd->status >= ARRAY_SIZE(status_lookup)))
>> +               goto exit;
>> +
>> +       if (genpd->status == GPD_STATE_POWER_OFF)
>> +               seq_printf(s, "%s-%u\n", status_lookup[genpd->status],
>> +                       genpd->state_idx);
>> +       else
>> +               seq_printf(s, "%s\n", status_lookup[genpd->status]);
>> +exit:
>> +       genpd_unlock(genpd);
>> +       return ret;
>>  }
>>
> 
> [...]
> 
> Fixing the nitpick above, then you may add my ack.

Thanks Ulf for the review. I will fix the above and resend
the series with your ack.

-- 
Regards
Thara
