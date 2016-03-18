From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Sat, 19 Mar 2016 00:29:25 +0100
Message-ID: <CAJZ5v0hN-T66MZkW-GtdHTogEg=h+PeFeqh+cy3fCsW157MX6w@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0iRn7eZY_g8UYze_Wq4v9pCTBMrgjHcuM1OVuTvJHUpAg@mail.gmail.com>
	<1458337969.14723.44.camel@redhat.com>
	<1596370.PSmUAlHJf5@vostro.rjw.lan>
	<1458340139.14723.50.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33628 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbcCRX31 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 19:29:27 -0400
Received: by mail-lb0-f171.google.com with SMTP id oe12so97533097lbc.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 16:29:26 -0700 (PDT)
In-Reply-To: <1458340139.14723.50.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Fri, Mar 18, 2016 at 11:28 PM, Rik van Riel <riel@redhat.com> wrote:
> On Fri, 2016-03-18 at 23:09 +0100, Rafael J. Wysocki wrote:
>> On Friday, March 18, 2016 05:52:49 PM Rik van Riel wrote:
>> >
>> > On Fri, 2016-03-18 at 22:48 +0100, Rafael J. Wysocki wrote:
>> > >
>> > > On Fri, Mar 18, 2016 at 10:35 PM, Rik van Riel <riel@redhat.com>
>> > > wrote:
>> > > >
>> > > >
>> > > > On Fri, 18 Mar 2016 11:32:28 -0700
>> > > > "Doug Smythies" <dsmythies@telus.net> wrote:
>> > > >
>> > > > >
>> > > > >
>> > > > > Energy:
>> > > > > Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
>> > > > >
>> > > > > Trace data (very crude summary):
>> > > > > Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU
>> > > > > load
>> > > > > (idle state 0)
>> > > > > Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but
>> > > > > less,
>> > > > > CPU load (not all idle state 0)
>> > > > This is a bit of a big hammer, but since the polling loop
>> > > > already
>> > > > uses
>> > > > full CPU power anyway, this could be harmless, and solve your
>> > > > problem.
>> > > Yes, it would be good to test this.
>> > >
>> > > No, I don't like it.
>> > >
>> > > If we are to break out of the polling loop after a specific time,
>> > > we
>> > > shouldn't be using polling at all in the first place.
>> > >
>> > > So I very much prefer to compare data->next_timer_us with the
>> > > target
>> > > residency of C1 instead of doing this.
>> > The problem is that data->next_timer_us does not tell us
>> > when the next network packet is about to arrive, though.
>> >
>> > This could cause issues when dealing with a fast stream
>> > of network traffic, which get_typical_interval() would
>> > be able to deal with.
>> If it predicted things correctly for small intervals, that is.
>>
>> It doesn't seem to be able to do that, however.
>
> It appears to get it right the vast majority of the
> time, it is just that when it gets wrong in a tiny
> minority of the cases, the penalty for polling is
> really high.

The overall penalty is what matters, though (and it is cumulative,
unfortunately).

>> You seem to want to trade energy consumption for performance with a
>> very narrow
>> use case in mind and that by changing bahavior that's been there
>> pretty much
>> forever, so by now it really has become the expected one.
>>
>> Needless to say I'm not a fan of changes like that.
>
> I am not sure it is a narrow use case, and I suspect
> cases with over half a million wakeups a second are
> not going to be all that unusual.

Well, the definition of "unusual" is somewhat elusive. :-)

> The same thing applies not just to network traffic,
> but also to tasks ping-ponging info between CPUs,
> eg. because some tasks are pinned, or because we
> are dealing with a controller thread and a larger
> number of workers.

All true, but still 10% energy consumption increase is rather a big deal.

I'd like to hear if there's any difference from going to nanosecond
time scale in the first place at this point.
