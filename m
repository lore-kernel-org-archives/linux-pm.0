From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers
 providing ->target_index()
Date: Thu, 21 Jul 2016 17:34:05 -0700
Message-ID: <20160722003405.GZ27987@graphite.smuckle.net>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
 <1490801.bHMYROVPDC@vostro.rjw.lan>
 <20160721232228.GT27987@graphite.smuckle.net>
 <CAJZ5v0idFG6nr3dRzt66L7gxHpxf05RP4CMQc6Edn0zkzXSKow@mail.gmail.com>
 <20160721234558.GX27987@graphite.smuckle.net>
 <CAJZ5v0j1vX+TwjcDxhbfd2ZruxWz7hFfiMUD6NL_+ZHyDqcU5g@mail.gmail.com>
 <20160722000903.GY27987@graphite.smuckle.net>
 <CAJZ5v0iH0J5JK+PUMsDN3K7aJNKiBt=5p5N3mry=KEL+=ZM94w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35581 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcGVAeJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 20:34:09 -0400
Received: by mail-pa0-f41.google.com with SMTP id iw10so33762067pac.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2016 17:34:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iH0J5JK+PUMsDN3K7aJNKiBt=5p5N3mry=KEL+=ZM94w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Fri, Jul 22, 2016 at 02:18:54AM +0200, Rafael J. Wysocki wrote:
> > My thinking was that one of these two would be preferable:
> >
> > - Forcing ->target() drivers to install a ->resolve_freq callback,
> >   enforcing this at cpufreq driver init time.
> 
> That would have been possible, but your series didn't do that.
> 
> >   My understanding is
> >   ->target() drivers are deprecated anyway
> 
> No, they aren't.

Ok. I didn't follow Documentation/cpu-freq/cpu-drivers.txt section 1.5
then - it suggests something about target() is deprecated, perhaps it's
out of date.

> There simply are cases in which frequency tables are not workable
> (like the ACPI CPPC one).

Sure that makes sense.

> >  and theren't aren't many of
> >   them, though I don't know offhand exactly how many or how hard it
> >   would be to do for each one.
> >
> > - Forcing callers (schedutil in this case) to check that either
> >   ->target() or ->resolve_freq() is implemented. It means
> >   catching and scrutinizing future callers of resolve_freq.
> 
> But that doesn't reduce the number of checks in cpufreq_driver_resolve_freq().
> 
> There still are three choices in there: return a frequency from the
> table (if present), or call ->resolve_freq (if implemented), or return
> target_freq (as the last resort).

Sorry, that should've been "check that either ->target_index() or
->resolve_freq() is implemented." 

Implementing resolve_freq for the target() drivers and requiring it at
driver init time is probably the better way to go though. Perhaps I can
work on this at some point.

