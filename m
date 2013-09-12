From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Thu, 12 Sep 2013 22:56:17 +0530
Message-ID: <5231F939.2010502@linux.vnet.ibm.com>
References: <522E1FEF.6080803@wwwdotorg.org> <1775778.MeiRhuYy7o@vostro.rjw.lan>	<522F86AD.6010603@wwwdotorg.org> <2521560.SfeNbV74nj@vostro.rjw.lan>	<52304439.3030301@linux.vnet.ibm.com> <CAKohpokTVzikxunqSdUYmLjTOkfhWFJ=N4TTa4rdbj2euCFY-g@mail.gmail.com> <CAKohpomzQ8Yzk+OU0btQM6DGm4xsY1RR9uYFrZD3ZHO-bhrwKQ@mail.gmail.com> <5230509D.6040205@linux.vnet.ibm.com> <CAKohpo=DfmNSMnyVRK0gfx7QGr=jOTbFo6uuGhEOaa2UMkeQAQ@mail.gmail.com> <CAKohpo=8mqRmmk17D52yiR9w1V4Z+2UzZ2kzABtrxHbYR+sQzw@mail.gmail.com> <52315E9A.3000607@linux.vnet.ibm.com> <5231E3E2.1050101@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:39403 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab3ILRa1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2013 13:30:27 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 13 Sep 2013 03:30:24 +1000
In-Reply-To: <5231E3E2.1050101@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>

On 09/12/2013 09:25 PM, Stephen Warren wrote:
> On 09/12/2013 12:26 AM, Srivatsa S. Bhat wrote:
>> On 09/12/2013 11:22 AM, Viresh Kumar wrote:
> ...
>>> Now coming back to the ideas I have...
>>> Same code will work if hotplug sequence is fixed a bit. Why aren't we doing
>>> exact opposite of suspend in resume?
>>>
>>> We are removing CPUs (leaving the boot cpu) in ascending order and then
>>> adding them back in same order.. Why?
>>>
>>> Why not remove CPUs in descending order and add in ascending order? Or
>>> remove in ascending order and add in descending order?
>>
>> I had the same thought when solving this bug.. We have had similar issues with
>> CPU hotplug notifiers too: why are they invoked in the same order during both
>> CPU down and up, instead of reversing the order? I even had a patchset to perform
>> reverse-invocation of notifiers.. http://lwn.net/Articles/508072/
>> ... but people didn't find that very compelling to have.
> 
> I'm not sure if you're talking about the order the CPUs get plugged back
> in after resume, or the order of the (pair of?) notifiers that gets
> called for each individual CPU.

Well, initially we were discussing about the order the CPUs get plugged back
in after resume, then I gave an example of a similar ordering issue in the
way the registered CPU hotplug notifiers are invoked: during *both* CPU online
and offline, the chain of notifiers are invoked in the same order, rather than
in the opposite order. To work around this unnatural ordering, subsystems have
resorted to splitting up their callbacks into multiple callbacks and then
assigning appropriate priorities etc., to them, to get the ordering right.
We could have done away with all that complexity/confusion if the core CPU
hotplug code had set the ordering right. And that's what my patchset tried to
do. Anyway, nevermind, as of now, subsystems do work around this suitably, so
there is no known bug as such at the present. Just that we could have probably
done it a better way, that's all.

> 
> Sorry if this is blindingly obvious, but with CPU hotplug, I can
> manually unplug/re-plug CPUs in any order I feel like, and cpufreq had
> better work if I do that. Given that, I don't think there's any
> particular need for suspend/resume to unplug/re-plug CPUs in any
> particular order for correctness at least, although perhaps it'd be nice
> cosmetically for some reason?
> 

You're absolutely right! Regular CPU hotplug is more demanding than
suspend/resume in the context we are discussing, since any CPU can be
hotplugged at any time and put back in any order. So code like cpufreq should
be prepared to work with any ordering. So yes, its not very compelling to
change the suspend/resume CPU hotplug ordering, since cpufreq has to deal
with the regular (and harsher) situation anyway.

That said, one subtle but key distinction between regular CPU hotplug and
suspend/resume is that, the kernel guarantees that the state of the system
after resume will be exactly the same as it was before suspend (atleast to
the extent that is practically possible). On the other hand, no such
guarantees are made for regular CPU hotplug, since its almost as if the user
is mutating the system at runtime!. However, suspend/resume as a concept
itself provides the above mentioned guarantee, and in fact, the very fact
that CPU hotplug is used under the hood for suspend/resume is just an
implementation detail, and should not affect the guarantees.

That's the reason we often pay special attention to CPU hotplug handling in
the suspend/resume path, such as preserving sysfs file permissions etc..
On those lines, Viresh and me were just wondering if 'fixing' the suspend/
resume CPU hotplug sequence would yield any additional benefits to better
serve this guarantee. That was the context in which this discussion happened.

Regards,
Srivatsa S. Bhat

