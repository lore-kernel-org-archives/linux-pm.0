From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Thu, 12 Sep 2013 12:16:12 +0530
Message-ID: <52316334.6080603@linux.vnet.ibm.com>
References: <522E1FEF.6080803@wwwdotorg.org> <1775778.MeiRhuYy7o@vostro.rjw.lan>	<522F86AD.6010603@wwwdotorg.org> <2521560.SfeNbV74nj@vostro.rjw.lan>	<52304439.3030301@linux.vnet.ibm.com> <CAKohpokTVzikxunqSdUYmLjTOkfhWFJ=N4TTa4rdbj2euCFY-g@mail.gmail.com> <CAKohpomzQ8Yzk+OU0btQM6DGm4xsY1RR9uYFrZD3ZHO-bhrwKQ@mail.gmail.com> <5230509D.6040205@linux.vnet.ibm.com> <CAKohpo=DfmNSMnyVRK0gfx7QGr=jOTbFo6uuGhEOaa2UMkeQAQ@mail.gmail.com> <CAKohpo=8mqRmmk17D52yiR9w1V4Z+2UzZ2kzABtrxHbYR+sQzw@mail.gmail.com> <52315E9A.3000607@linux.vnet.ibm.com> <CAKohpo=LuoKTf+mX1oBt97K3sJVu0iN=whN7VGw6kuartnrr+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:49406 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab3ILGuO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2013 02:50:14 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 12 Sep 2013 16:41:18 +1000
In-Reply-To: <CAKohpo=LuoKTf+mX1oBt97K3sJVu0iN=whN7VGw6kuartnrr+w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Warren <swarren@wwwdotorg.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>

On 09/12/2013 12:11 PM, Viresh Kumar wrote:
> On 12 September 2013 11:56, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> I had the same thought when solving this bug.. We have had similar issues with
>> CPU hotplug notifiers too: why are they invoked in the same order during both
>> CPU down and up, instead of reversing the order? I even had a patchset to perform
>> reverse-invocation of notifiers.. http://lwn.net/Articles/508072/
>> ... but people didn't find that very compelling to have.
>>
> 
>> It does to me too, but I think the reason nobody really bothered is because perhaps
>> not many other subsystems care about the order in which CPUs are torn down or
>> brought up; they just need the total number to match.. cpufreq is one exception
>> as we saw with this bug.
> 
> Probably its time to re-spin that series and make CPUFreq as one of the users
> of that patchset.. Resume should be just opposite of suspend and so
> that patchset
> would make sense even if not many people care about it :)
> 
> Over that there is one more problem that I see, don't know if it is really a big
> issue..
> 
> After a suspend/resume value of policy->cpu may get changed... And so the
> hierarchy of sysfs cpufreq files too.. Folder that had links to other
> CPUs folder
> can now be actual folders instead of links and vice versa..
> 
> Don't know if this can break something ??
> 

Interesting observation :-) But we just managed to retain sysfs file permissions
across suspend/resume with a lot of trouble and regressions. That's probably
good enough for some time to come ;-) We can retain folder/links when somebody
really finds a need to do that ;-)

Of course, if we change the suspend/resume sequence and that fixes this, that
would be like getting it for free, nobody would say no to it ;-)

Regards,
Srivatsa S. Bhat

