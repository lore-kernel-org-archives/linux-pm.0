From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Add time accounting to various genpd
 states.
Date: Tue, 13 Jun 2017 08:44:44 -0400
Message-ID: <593FDE3C.1090408@linaro.org>
References: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
 <1495756293-29534-2-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqfVN4KDQETdq9_edkNE0wi2Ff-g0w9i6UFE-NKbwhJGg@mail.gmail.com>
 <593EE298.1060805@linaro.org>
 <CAPDyKFq9xDLP0_o4z0jQMtzA9rxTZT4Ns_BrmqPeMbNUr8suwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33405 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdFMMor (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 08:44:47 -0400
Received: by mail-yw0-f176.google.com with SMTP id 63so48141476ywr.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 05:44:47 -0700 (PDT)
In-Reply-To: <CAPDyKFq9xDLP0_o4z0jQMtzA9rxTZT4Ns_BrmqPeMbNUr8suwQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>

On 06/13/2017 04:11 AM, Ulf Hansson wrote:
> [...]
> 
>>> Isn't the off_time the summary of the states' genpd->states[i].active_time?
>>
>> Yes. it is.
>>>
>>> Then we could do that computation quite easily at the point when
>>> producing the debugfs output instead.
>>
>> Are yu suggesting doing away with off_time parameter all together. It is
>> possible.
> 
> Yes, I think that makes sense.
> 
>>>
>>>> +       }
>>>> +       genpd->accounting_time = now;
>>>> +}
>>>> +
> 
> [...]
> 
>>>>
>>>> @@ -774,6 +795,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>>>>         if (_genpd_power_off(genpd, false))
>>>>                 return;
>>>>
>>>> +       genpd_update_accounting(genpd);
>>>
>>> Timekeeping gets disabled at a certain point during suspend. Therefore
>>> you can't update accounting here, as this function gets called in this
>>> stages.
>>
>> I will remove the update of accounting at this point. But then the
>> statistics  can be skewed for some power domains atleast. Other option
>> is to restart the accounting every time after device suspend and resume.
> 
> I would suggest to start simple and just avoid updating the accounting
> in these cases. Then we can look into improvements, if we think there
> is a need for it.
> 
> What do you think?
I do agree. Will post the updated series.

Regards
Thara

> 
> [...]
> 
> Kind regards
> Uffe
> 


-- 
Regards
Thara
