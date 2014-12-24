From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 3/4] PM / OPP: take RCU lock in dev_pm_opp_get_opp_count
Date: Wed, 24 Dec 2014 09:09:02 -0800
Message-ID: <CAE_wzQ92VK6Jv+j-LDTupMJzJj_AZyAqUe2Vxo5YRhkFEFF=sw@mail.gmail.com>
References: <1418771379-24369-1-git-send-email-dtor@chromium.org>
	<1418771379-24369-4-git-send-email-dtor@chromium.org>
	<549AEE52.9080607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:51672 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaLXRJF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Dec 2014 12:09:05 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so7579868iec.25
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2014 09:09:04 -0800 (PST)
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com. [209.85.213.177])
        by mx.google.com with ESMTPSA id f1sm4169647igt.14.2014.12.24.09.09.02
        for <linux-pm@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Dec 2014 09:09:02 -0800 (PST)
Received: by mail-ig0-f177.google.com with SMTP id z20so7182535igj.4
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2014 09:09:02 -0800 (PST)
In-Reply-To: <549AEE52.9080607@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Dmitry Torokhov <dtor@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 24, 2014 at 8:48 AM, Nishanth Menon <nm@ti.com> wrote:
> On 12/16/2014 05:09 PM, Dmitry Torokhov wrote:
>> A lot of callers are missing the fact that dev_pm_opp_get_opp_count
>> needs to be called under RCU lock. Given that RCU locks can safely be
>> nested, instead of providing *_locked() API, let's take RCU lock inside
>> dev_pm_opp_get_opp_count() and leave callers as is.
>
> While it is true that we can safely do nested RCU locks, This also
> encourages wrong usage.
>
> count = dev_pm_opp_get_opp_count(dev)
> ^^ point A
> array   = kzalloc(count * sizeof (*array));
> rcu_read_lock();
> ^^ point B
> .. work down the list and add OPPs..
> ...
>
> Between A and B, we might have had list modification (dynamic OPP
> addition or deletion) - which implies that the count is no longer
> accurate between point A and B. instead, enforcing callers to have the
> responsibility of rcu_lock is exactly what we have to do since the OPP
> library has no clue how to enforce pointer or data accuracy.

No, you seem to have a misconception that rcu_lock protects you past
the point B, but that is also wrong. The only thing rcu "lock"
provides is safe traversing the list and guarantee that elements will
not disappear while you are referencing them, but list can both
contract and expand under you. In that regard code in
drivers/cpufreq/cpufreq_opp.c is utterly wrong. If you want to count
the list and use number of elements you should be taking a mutex.
Luckily all cpufreq drivers at the moment only want to see if OPP
table is empty or not, so as a stop-gap we can take rcu_lock
automatically as we are getting count. We won't get necessarily
accurate result, but at least we will be safe traversing the list.

Thanks.

-- 
Dmitry
