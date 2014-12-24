From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 12/13] cpufreq: stats: Fix locking
Date: Wed, 24 Dec 2014 14:01:01 -0500
Message-ID: <549B0D6D.8010705@redhat.com>
References: <cover.1418902789.git.viresh.kumar@linaro.org> <6277a557b0102524ca317bf0aa94d7b479375d6e.1418902789.git.viresh.kumar@linaro.org> <CAKohpok+7b3t3-82EO+9tpmBHavMxBT1r2ORhPcQbT3hT=p9mA@mail.gmail.com> <54994842.3000801@redhat.com> <CAKohpo=B99MdiJRvH021kOhU08V-W1g+a=FFpcC9tEHEDKjOvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbaLXTBM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Dec 2014 14:01:12 -0500
In-Reply-To: <CAKohpo=B99MdiJRvH021kOhU08V-W1g+a=FFpcC9tEHEDKjOvw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



On 12/23/2014 05:55 AM, Viresh Kumar wrote:
> On 23 December 2014 at 16:17, Prarit Bhargava <prarit@redhat.com> wrote:
>>>       sysfs_remove_group(&policy->kobj, &stats_attr_group);
>>
>> ^^^ this line is not guaranteed to have removed the group files by the time it
> 
> Strange .. Under what conditions can the above statement be true?

Suppose the following happens:

1.  CPU A holds a file descriptor in userspace for one of the cpu stats files.

2.  CPU B is removing the group

3.  CPU B calls sysfs_remove_group, which does not remove the file because there
is a use count on it (because CPU A holds the file open).

4.  CPU B now brings up stats again ... and we hit the a collision in the sysfs
space.

FWIW: I've hit this scenario in all types of hotplug (memory, pci, and cpu).  I
understand why the sysfs_group and sysfs_file remove functions do NOT block on
use counts because it is entirely possible that userspace has done something
braindead which would then prevent the kernel from making progress, or in the
case of an error return (ex, -EBUSY) prevent hotplug from succeeding.  I dunno
if there is a way out of this :/

> 
>> returns.  That is important in this code IMO, as we are adding and removing the
>> stats entries rapidly.  You may hit the dreaded "sysfs file already exists"
>> WARNING if this is done too fast, or if sysfs is locked for some other reason
>> and delays the removal of the group.  In the worst case, it is possible you hit
>> a NULL pointer due to stale data access (because you kfree and set to a NULL
>> pointer below).
> 
> Hmm, I have seen such stuff yet for sure. But anyway, that would be out of scope
> of this patch. As w or w/o locking, it is broken :)

Yeah, I agree ... I'm just pointing it out as a problem here.  I'm simply trying
to make you aware of the conditions on which this locking may fail.

> 
>> I've never found a good method to block this sort of add/remove sysfs file race
>> from happening.  Perhaps someone else may have a suggestion.  In the past I've
>> thought about adding a usage count to the sysfs file handlers themselves but
>> that seems to lead to blocking on userspace access...
> 
> Some more details and we can drag Greg-kh into this, but lets be sure of what we
> are asking..
> 
>>>       kfree(stat->time_in_state);
>>>       kfree(stat);
>>>       policy->stats_data = NULL;
>>> +     spin_unlock(&cpufreq_stats_lock);
>>>  }
>>
>> There may not be an easy way around this ...
> 
> You were just completing the earlier horror story or is this a new comment which
> I couldn't understand ?

Sorry -- completing the earlier horror story :)

> 
> Which IRC do you hangout on? Just in case I need..

You can usually find me in freenode, #fedora-kernel.  I'm *really* bad about
marking myself away though ;) so don't be annoyed if I don't answer right away.

P.

> 
> --
> viresh
> 
