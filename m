From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 3/4] PM / OPP: take RCU lock in dev_pm_opp_get_opp_count
Date: Wed, 24 Dec 2014 09:31:43 -0800
Message-ID: <CAE_wzQ-WQE1q4njE4TRFz55zs1+6SH7XZqXrk2tToyX-hRz+Fg@mail.gmail.com>
References: <1418771379-24369-1-git-send-email-dtor@chromium.org>
	<1418771379-24369-4-git-send-email-dtor@chromium.org>
	<549AEE52.9080607@ti.com>
	<CAE_wzQ92VK6Jv+j-LDTupMJzJj_AZyAqUe2Vxo5YRhkFEFF=sw@mail.gmail.com>
	<549AF4F3.1090600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35751 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaLXRbp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Dec 2014 12:31:45 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so7728729iga.14
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2014 09:31:44 -0800 (PST)
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com. [209.85.213.176])
        by mx.google.com with ESMTPSA id b194sm11604989iob.38.2014.12.24.09.31.43
        for <linux-pm@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Dec 2014 09:31:43 -0800 (PST)
Received: by mail-ig0-f176.google.com with SMTP id l13so7663091iga.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2014 09:31:43 -0800 (PST)
In-Reply-To: <549AF4F3.1090600@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Dmitry Torokhov <dtor@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 24, 2014 at 9:16 AM, Nishanth Menon <nm@ti.com> wrote:
> On 12/24/2014 11:09 AM, Dmitry Torokhov wrote:
>> On Wed, Dec 24, 2014 at 8:48 AM, Nishanth Menon <nm@ti.com> wrote:
>>> On 12/16/2014 05:09 PM, Dmitry Torokhov wrote:
>>>> A lot of callers are missing the fact that dev_pm_opp_get_opp_count
>>>> needs to be called under RCU lock. Given that RCU locks can safely be
>>>> nested, instead of providing *_locked() API, let's take RCU lock inside
>>>> dev_pm_opp_get_opp_count() and leave callers as is.
>>>
>>> While it is true that we can safely do nested RCU locks, This also
>>> encourages wrong usage.
>>>
>>> count = dev_pm_opp_get_opp_count(dev)
>>> ^^ point A
>>> array   = kzalloc(count * sizeof (*array));
>>> rcu_read_lock();
>>> ^^ point B
>>> .. work down the list and add OPPs..
>>> ...
>>>
>>> Between A and B, we might have had list modification (dynamic OPP
>>> addition or deletion) - which implies that the count is no longer
>>> accurate between point A and B. instead, enforcing callers to have the
>>> responsibility of rcu_lock is exactly what we have to do since the OPP
>>> library has no clue how to enforce pointer or data accuracy.
>>
>> No, you seem to have a misconception that rcu_lock protects you past
>> the point B, but that is also wrong. The only thing rcu "lock"
>> provides is safe traversing the list and guarantee that elements will
>> not disappear while you are referencing them, but list can both
>> contract and expand under you. In that regard code in
>> drivers/cpufreq/cpufreq_opp.c is utterly wrong. If you want to count
>> the list and use number of elements you should be taking a mutex.
>> Luckily all cpufreq drivers at the moment only want to see if OPP
>> table is empty or not, so as a stop-gap we can take rcu_lock
>> automatically as we are getting count. We won't get necessarily
>> accurate result, but at least we will be safe traversing the list.
>
> So, instead of a half solution, lets consider this in the realm of
> dynamic OPPs as well. agreed to the point that we only have safe
> traversal and pointer validity. the real problem however is with
> "dynamic OPPs" (one of the original reasons why i did not add dynamic
> OPPs in the original version was to escape from it's complexity for
> users - anyways.. we are beyond that now). if OPPs can be removed on
> the fly, we need the following:
> a) use OPP notifiers to adequately handle list modification
> b) lock down list modification (and associated APIs) to ensure that
> the original cpufreq /devfreq list is correct.
>
> I still dont see the need to do this half solution.

The need for half solution at the moment is that you can't safely
travel the lists and may crash on an invalid pointer.

Going forward I think (I mentioned that in my other email) that we
should rework the OPP API so that callers fetch OPP table object for a
device at init/probe time and then use it to get OPPs. This way won't
have to travel two lists any time we want to reference an OPP.

And instead of relying notifiers, maybe look into using OPP tables
directly in cpufreq drivers instead of converting OPP into static-ish
cpufreq tables.

Thanks.

-- 
Dmitry
