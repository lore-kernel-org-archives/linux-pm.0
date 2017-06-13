From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Add time accounting to various genpd states.
Date: Tue, 13 Jun 2017 10:11:34 +0200
Message-ID: <CAPDyKFq9xDLP0_o4z0jQMtzA9rxTZT4Ns_BrmqPeMbNUr8suwQ@mail.gmail.com>
References: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
 <1495756293-29534-2-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqfVN4KDQETdq9_edkNE0wi2Ff-g0w9i6UFE-NKbwhJGg@mail.gmail.com> <593EE298.1060805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36863 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbdFMILg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 04:11:36 -0400
Received: by mail-qt0-f181.google.com with SMTP id u19so160622554qta.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 01:11:35 -0700 (PDT)
In-Reply-To: <593EE298.1060805@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>

[...]

>> Isn't the off_time the summary of the states' genpd->states[i].active_time?
>
> Yes. it is.
>>
>> Then we could do that computation quite easily at the point when
>> producing the debugfs output instead.
>
> Are yu suggesting doing away with off_time parameter all together. It is
> possible.

Yes, I think that makes sense.

>>
>>> +       }
>>> +       genpd->accounting_time = now;
>>> +}
>>> +

[...]

>>>
>>> @@ -774,6 +795,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>>>         if (_genpd_power_off(genpd, false))
>>>                 return;
>>>
>>> +       genpd_update_accounting(genpd);
>>
>> Timekeeping gets disabled at a certain point during suspend. Therefore
>> you can't update accounting here, as this function gets called in this
>> stages.
>
> I will remove the update of accounting at this point. But then the
> statistics  can be skewed for some power domains atleast. Other option
> is to restart the accounting every time after device suspend and resume.

I would suggest to start simple and just avoid updating the accounting
in these cases. Then we can look into improvements, if we think there
is a need for it.

What do you think?

[...]

Kind regards
Uffe
