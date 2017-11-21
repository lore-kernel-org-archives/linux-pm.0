From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Tue, 21 Nov 2017 10:12:24 -0800
Message-ID: <20171121181222.GA4075@localhost.localdomain>
References: <20171116152058.GR3257@vireshk-i7>
 <2810372.fJ2vMN0cWO@aspire.rjw.lan>
 <20171116234422.GA6141@localhost.localdomain>
 <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
 <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com>
 <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org>
 <5A144CB3.50806@gmail.com>
 <CAKfTPtBBSxV+weYf-9yTf9azc78--8a8x8wNad3OGCYfvEJ4qw@mail.gmail.com>
 <20171121165703.GA2499@localhost.localdomain>
 <20171121180006.GA26638@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:41329 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdKUSM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 13:12:29 -0500
Content-Disposition: inline
In-Reply-To: <20171121180006.GA26638@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Luba <llu.ker.dev@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Nov 21, 2017 at 06:00:07PM +0000, Javi Merino wrote:
> Hi,
> 
> On Tue, Nov 21, 2017 at 08:57:06AM -0800, Eduardo Valentin wrote:
> 
> [snip]
> 
> > As I said before, the minimal you guys (ARM and Linaro) can do is to at
> > least upstream the Juno code! as a reference. Come on guys?  what is
> > preventing you to upstream Juno model?
> 
> As Ionela pointed out earlier in the thread, the cpufreq driver for Juno
> was not acceptable for mainline because it used platform specific code.
> When it was converted to cpufreq-dt, the static power was left behind
> because it can't be represented in device tree.  This is because there

Or we still haven't figure what to represent. Once decided what to
represent, then we can claim if is doable in DT or not.


> isn't a function that works for every SoC, different process nodes
> (among other things) will need different functions.  So it can't be just
> a bunch of coefficients in DT, we need a function.  Hence the callback.

Well, DT is full of vendor specific stuff.

> 
> In a nutshell, mainline does not want platform specific code, but we
> haven't figured out how to calculate static power without platform
> specific code.

To, that is still fine to have it as a callback, as long as you have at
least one user! I still do not understand why Juno static power cannot
go as platform code that register the callback to implement the static
power model.

> 
> Cheers,
> Javi
