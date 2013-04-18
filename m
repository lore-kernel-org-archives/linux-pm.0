From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 11:07:49 +0530
Message-ID: <CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com>
References: <516CFA57.3060709@intel.com>
	<CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com>
	<516F42EE.6080802@intel.com>
	<CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com>
	<516F81BD.3030306@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:41548 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab3DRFhu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 01:37:50 -0400
Received: by mail-ob0-f178.google.com with SMTP id ni5so2187617obc.9
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2013 22:37:49 -0700 (PDT)
In-Reply-To: <516F81BD.3030306@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 18 April 2013 10:46, Alex Shi <alex.shi@intel.com> wrote:
> On 04/18/2013 12:26 PM, Viresh Kumar wrote:

> Yes. current value is similar to 3.8: 18fps, compare to 3.9-rc1, that is
> also bad.
> I mean the good performance started from 3.9-rc1 kernel.

Hmm... that means a bug gave you better fps, because cpus are kept at
higher freqs... But 3.8 is the last stable release and so current version is
the best for all of us. And we don't have to revert the patch we were talking
about.

In case there is a scope of making performance better then we can do it
with a more relevant change.

>> About your system: Can you give output of cpufreq-info for v3.8 and
>> v3.9-latestrc?
>> Your cpus share a clock line or not?
>
> Yes our cpu shares a clock line. So the cpufreq-info is same. SNB CPU
> p-state is per cpu package, and hardware will coordinate the software
> asking, then decide which cpufreq should be.

Can you paste cpufreq-info output, that will give us a better picture of your
system.

> That's sth I am also confused. Yes, that cpu share a clock line. But
> Arjan and Len both said affected_cpus should only include the cpu self,
> because cpu will do hardware coordination for them.

Why? we need a reason for that.... Do they mean Linux shouldn't be aware
of any requirement of freq sync? But why?
