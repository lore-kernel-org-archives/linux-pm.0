From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ondemand: Change the calculation of target frequency
Date: Sat, 1 Jun 2013 20:26:47 +0530
Message-ID: <CAKohpokmn-Rf-1w2aQHMMMkMbJqxokWXm5ye3DNuc-yzzk=7pQ@mail.gmail.com>
References: <51A7BFA6.3070800@semaphore.gr>
	<CAKohpo=oD9Wgr0Y9zA3aVCdMq5MUC5GESWyL45h=izRyp9-CLA@mail.gmail.com>
	<51A8D0C2.1080801@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36180 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab3FAO4s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2013 10:56:48 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so4810710obc.24
        for <linux-pm@vger.kernel.org>; Sat, 01 Jun 2013 07:56:47 -0700 (PDT)
In-Reply-To: <51A8D0C2.1080801@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 31 May 2013 22:03, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> On 05/31/2013 11:51 AM, Viresh Kumar wrote:
>> I believe you should have removed other users of getavg() in a separate
>> patch and also cc'd relevant people so that you can some review comments
>> from  them.
>
> I will split the patch in two. If it's OK, I will keep the removal of
> __cpufreq_driver_getavg in the original patch and move the clean up of
> APERF/MPERF support in a second patch. I will also cc relevant people.

Even removal of __cpufreq_driver_getavg() should be done in a separate
patch, so that it can be reverted easily if required later.

>> "Proportional to load" means C * load, so why is "policy->max / 100" *the* right C?
>
> I think, finally(?) I see your point. The right C should be "policy->cpuinfo.max_freq / 100".

Why are you changing it to cpuinfo.max_freq?? This is fixed once a driver is
initialized.. but user may request a lower max freq for a governor or policy.
Which is actually reflected in policy->max I believe.

Over that why keeping following check is useful anymore?

if (load_freq > od_tuners->up_threshold)
    goto max.

As, if load is over 95, then even policy->max * 95 / 100 will even give almost
the same freq.
