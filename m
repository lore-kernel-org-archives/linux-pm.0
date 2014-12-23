From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 12/13] cpufreq: stats: Fix locking
Date: Tue, 23 Dec 2014 16:25:42 +0530
Message-ID: <CAKohpo=B99MdiJRvH021kOhU08V-W1g+a=FFpcC9tEHEDKjOvw@mail.gmail.com>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
	<6277a557b0102524ca317bf0aa94d7b479375d6e.1418902789.git.viresh.kumar@linaro.org>
	<CAKohpok+7b3t3-82EO+9tpmBHavMxBT1r2ORhPcQbT3hT=p9mA@mail.gmail.com>
	<54994842.3000801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:39639 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbaLWKzn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Dec 2014 05:55:43 -0500
Received: by mail-oi0-f51.google.com with SMTP id e131so13254226oig.10
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2014 02:55:42 -0800 (PST)
In-Reply-To: <54994842.3000801@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 23 December 2014 at 16:17, Prarit Bhargava <prarit@redhat.com> wrote:
>>       sysfs_remove_group(&policy->kobj, &stats_attr_group);
>
> ^^^ this line is not guaranteed to have removed the group files by the time it

Strange .. Under what conditions can the above statement be true?

> returns.  That is important in this code IMO, as we are adding and removing the
> stats entries rapidly.  You may hit the dreaded "sysfs file already exists"
> WARNING if this is done too fast, or if sysfs is locked for some other reason
> and delays the removal of the group.  In the worst case, it is possible you hit
> a NULL pointer due to stale data access (because you kfree and set to a NULL
> pointer below).

Hmm, I have seen such stuff yet for sure. But anyway, that would be out of scope
of this patch. As w or w/o locking, it is broken :)

> I've never found a good method to block this sort of add/remove sysfs file race
> from happening.  Perhaps someone else may have a suggestion.  In the past I've
> thought about adding a usage count to the sysfs file handlers themselves but
> that seems to lead to blocking on userspace access...

Some more details and we can drag Greg-kh into this, but lets be sure of what we
are asking..

>>       kfree(stat->time_in_state);
>>       kfree(stat);
>>       policy->stats_data = NULL;
>> +     spin_unlock(&cpufreq_stats_lock);
>>  }
>
> There may not be an easy way around this ...

You were just completing the earlier horror story or is this a new comment which
I couldn't understand ?

Which IRC do you hangout on? Just in case I need..

--
viresh
