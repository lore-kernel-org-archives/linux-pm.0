From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter() failures
Date: Wed, 13 May 2015 17:31:28 -0700
Message-ID: <7h1tik2e5b.fsf@deeprootsystems.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
	<1842725.60y5FMGEPh@vostro.rjw.lan>
	<CAMAWPa_69wXtOAKkerLcXN3AcCMC7oBCH_K3MQ-A7A8nmXQzfQ@mail.gmail.com>
	<3381363.cclTYyKPz9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32799 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbENAbc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 20:31:32 -0400
Received: by pacwv17 with SMTP id wv17so66349593pac.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2015 17:31:31 -0700 (PDT)
In-Reply-To: <3381363.cclTYyKPz9@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Thu, 14 May 2015 02:42:11 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rlippert@google.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>, linuxppc-dev@lists.ozlabs.org, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Wednesday, May 13, 2015 05:13:27 PM Kevin Hilman wrote:
>> On Wed, May 13, 2015 at 5:16 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Wednesday, May 13, 2015 03:59:55 PM Kevin Hilman wrote:
>> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> >>
>> >> [...]
>> >>
>> >> > Second, quite honestly, I don't see a connection to genpd here.
>> >>
>> >> The connection with genpd is because the *reason* the timer was
>> >> shutdown/stopped is because it shares power with the CPU, which is why
>> >> the timer stops when the CPU hits ceratin low power states.  IOW, it's
>> >> in the same power domain as the CPU.
>> >
>> > Well, what if you don't have genpd on that system?  Is the problem at hand not
>> > relevant then magically?
>> 
>> Well, if you're not using genpd to model hardware power domain
>> dependencies, then yes you'll definitely need a different solution.
>> 
>> And, as we discussed on IRC.  If you only care about timers, and genpd
>> is not in use, then $SUBJECT series is a fine approach, and I have no
>> objections.  But for SoCs where there are several other things that
>> share power with CPU, we need a more generic, genpd based solution,
>> which it seems we're in agreement on.  And since the two approaches
>> are not mutually exclusive, then I have real objections to applying
>> this series.
>
> I guess a "no" is missing in the last sentence. ;-)

Correct.  I have *no* real objections to applying this series.

Kevin

