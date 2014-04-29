From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/5] cpufreq: Catch double invocations of cpufreq_freq_transition_begin/end
Date: Tue, 29 Apr 2014 11:46:18 +0530
Message-ID: <535F43B2.2000309@linux.vnet.ibm.com>
References: <20140428185331.28755.899.stgit@srivatsabhat.in.ibm.com> <20140428185507.28755.6483.stgit@srivatsabhat.in.ibm.com> <CAKohpomaJ0ubnzzQ7AwAd6z+Zm085i+UwB7XMa=si7qthZdgZg@mail.gmail.com> <CAKohpokiy2Fvry=uTVnOCymH7Co1ka+JCFT3ndtPQBSD94Mnew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:36766 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266AbaD2GRN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 02:17:13 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 29 Apr 2014 16:17:10 +1000
In-Reply-To: <CAKohpokiy2Fvry=uTVnOCymH7Co1ka+JCFT3ndtPQBSD94Mnew@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Meelis Roos <mroos@linux.ee>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 04/29/2014 10:25 AM, Viresh Kumar wrote:
> On 29 April 2014 10:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Nice effort.
>>
>> On 29 April 2014 00:25, Srivatsa S. Bhat
>> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>>> Now all such drivers have been fixed, but debugging this issue was not
>>> very straight-forward (even lockdep didn't catch this). So let us add a
>>> debug infrastructure to the cpufreq core to catch such issues more easily
>>> in the future.
>>
>> BUT, I am not sure if we really need it :(
>>
>> I think we just got into the 'barrier' stuff as we had some doubts about it
>> earlier and were quite sure that nothing else could go wrong. Otherwise
>> the only problem could have been present was the second queuing
>> from the same thread. And we will surely get stuck if that happens and
>> we can't just miss that error..
>>
>>> Scenario 1: (Deadlock-free)
>>> ----------
>>>
>>>          Task A                                         Task B
>>>
>>>     /* 1st freq transition */
>>>     Invoke _begin() {
>>>             ...
>>>             ...
>>>     }
>>>
>>>     Change the frequency
>>>
>>>                                                 Got interrupt for successful
>>>                                                 change of frequency.
>>>
>>>                                                 /* 1st freq transition */
>>>                                                 Invoke _end() {
>>>                                                         ...
>>>                                                         ...
>>>     /* 2nd freq transition */                           ...
>>>     Invoke _begin() {                                   ...
>>>             ... //waiting for B                         ...
>>>             ... //to finish _end()              }
>>>             ...
>>>             ...
>>>     }
>>>
>>>
>>> This scenario is actually deadlock-free because Task A can wait inside the
>>> second call to _begin() without self-deadlocking, because it is the
>>> responsibility of Task B to finish the first sequence by invoking the
>>> corresponding _end().
> 
> WTF, I was writing my mail and it just got send due to some stupid combination
> of keys :( .. Sorry.
>

No problem!
 
> Also, this might not work as expected. Consider this scenario:
> 
>      /* 1st freq transition */
>      Invoke _begin() {
>              ...
>              ...
>      }
> 
>      Start Change of frequency and return
>      back as there is no end from same thread.
> 
>      /* 2nd freq transition as there is nobody stopping us */
>      Invoke _begin() {
>              ... //waiting for B
>              ... //to finish _end()
>              ...
>              ...
>      }
> 
>                                                               Got
> interrupt for successful
>                                                               change
> of frequency.
> 
>                                                               /* 1st
> freq transition */
>                                                               Invoke _end() {
>                                                                      ...
>                                                                      ...
>                                                              }
> 
> And your patch will probably break this ?

Yes, I'm aware that this corner case doesn't work well with my debug
patch. I tried to avoid this but couldn't think of any solution.
(One big-hammer way to avoid this is to exclude this infrastructure
for all ASYNC_NOTIFICATION drivers, but I didn't want to go with that
approach, since it makes it look ugly). Do you have any better ideas
to deal with this scenario?

Also, do we really have cases in mind where a single thread does
multiple frequency transitions in one go? That too in such quick
successions? Echo's to sysfs, changing of governors from userspace etc
all do one frequency transition at a time per-task...


Regards,
Srivatsa S. Bhat

