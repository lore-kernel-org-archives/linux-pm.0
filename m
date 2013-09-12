From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
Date: Thu, 12 Sep 2013 06:09:38 +0530
Message-ID: <CAKohpokEZcwF-zL6rTXYyC_x=SJzGFvdvxqvmvyhJHa8nPXogQ@mail.gmail.com>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
	<2703632.ul5ekQh5oq@vostro.rjw.lan>
	<CAKohpo=RKB-_EO=cjaOorAfN=y_cMgJg-j6=xtX71a-TwujgsA@mail.gmail.com>
	<2013615.oHjWkmedue@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:54884 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab3ILAjj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 20:39:39 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so9300677obb.9
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2013 17:39:39 -0700 (PDT)
In-Reply-To: <2013615.oHjWkmedue@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On 11 September 2013 18:48, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 11, 2013 02:08:44 PM Viresh Kumar wrote:

>> That looked like a straight forward issue/bug to me and so I haven't
>> gotten deep into it..
>
> Which you should always do when you're going to deal with concurrency issues.
> Even if they appear to be obvious, they often are far from that, like in this
> case.

/me Nods

>> Scenario 2:
>> --------------
>> Governor is changing freq and has called __cpufreq_driver_target().
>> At the same time we are changing scaling_{min|max}_freq from
>> sysfs, which would eventually end up calling governors:
>> CPUFREQ_GOV_LIMITS notification, that will also call:
>> __cpufreq_driver_target()..
>>
>> So, we eventually have two concurrent calls to ->target() and we
>> don't really know how hardware will behave in this case.. Most of
>> the implementations of ->target() routines just go and change
>> freq/voltage without checking if we are already in progress of doing
>> that (i.e. based on expectation that this call is not re entrant)..
>>
>> Now anything can happen at hardware level, which I don't have
>> all insight of :(
>
> That is more theoretical, however.

Maybe we can get more deeper into it then :)
Platform have something like this in their target()

A. If new freq is more than old: Increase voltage
B. Change freq
C. If new freq is less than old: decrease voltage

Now, two concurrent calls to target are X and Y, where X is trying to increase
freq and Y is trying to decrease it..

And this is the sequence that followed due to races..

X.A: voltage increased for larger freq
Y.A: nothing happened here
Y.B: freq decreased
Y.C: voltage decreased
X.B: freq increased
X.C: nothing happened..

We ended up setting a freq which is not supported by the voltage we have
set.. That will probably make clock to CPU unstable and system wouldn't
be workable anymore...

And so I think even this case must also get some space in the changelog :)
