From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers
 providing ->target_index()
Date: Fri, 22 Jul 2016 01:53:13 +0200
Message-ID: <CAJZ5v0j1vX+TwjcDxhbfd2ZruxWz7hFfiMUD6NL_+ZHyDqcU5g@mail.gmail.com>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
 <1490801.bHMYROVPDC@vostro.rjw.lan> <20160721232228.GT27987@graphite.smuckle.net>
 <CAJZ5v0idFG6nr3dRzt66L7gxHpxf05RP4CMQc6Edn0zkzXSKow@mail.gmail.com> <20160721234558.GX27987@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33673 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbcGUXxP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 19:53:15 -0400
In-Reply-To: <20160721234558.GX27987@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Fri, Jul 22, 2016 at 1:45 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Fri, Jul 22, 2016 at 01:32:00AM +0200, Rafael J. Wysocki wrote:
>> On Fri, Jul 22, 2016 at 1:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
>> > On Fri, Jul 22, 2016 at 01:22:22AM +0200, Rafael J. Wysocki wrote:
>> >> OK, applied.
>> >
>> > FWIW I do have a concern on this patch, I think it adds unnecessary
>> > overhead.
>>
>> It isn't unnecessary.  It prevents an otherwise possible kernel crash
>> from happening.
>
> The logic may not be unecessary, but the overhead is. The crash could be
> prevented in a way that doesn't require repeatedly checking a pointer
> that doesn't change.

Well, you had the ->resolve_freq check in your patch, didn't you?

Viresh simply added a ->target_index check to it.

Now, you can argue that this is one check too many, but as long as
drivers are allowed to implement ->target without implementing
->resolve_freq, the *number* of checks in this routine cannot be
reduced.

There are three possible cases and two checks are required to
determine which case really takes place.
