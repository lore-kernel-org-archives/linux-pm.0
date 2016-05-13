From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC] Should we add Android's Interactive governor into mainline now?
Date: Fri, 13 May 2016 13:56:41 +0200
Message-ID: <CAJZ5v0igpMqgrLdJdNRkb7qFG65UJ4XCUtr7fae1eoVCF-coig@mail.gmail.com>
References: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
	<20160512163648.GB12886@graphite.smuckle.net>
	<CAJZ5v0jYqLKf-ckpEm7dm_jHeUkD6ey_cAgdrgFFuFnMYa-HUw@mail.gmail.com>
	<20160512211012.GA28594@graphite.smuckle.net>
	<20160513114456.GL9525@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38590 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbcEML4n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 07:56:43 -0400
Received: by mail-wm0-f42.google.com with SMTP id g17so26165447wme.1
        for <linux-pm@vger.kernel.org>; Fri, 13 May 2016 04:56:42 -0700 (PDT)
In-Reply-To: <20160513114456.GL9525@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Fri, May 13, 2016 at 1:44 PM, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi,
>
> On 12/05/16 14:10, Steve Muckle wrote:
>> On Thu, May 12, 2016 at 10:34:39PM +0200, Rafael J. Wysocki wrote:
>> > > That said my understanding is that the goal is to eventually deprecate
>> > > the non-sched governors. That will be made harder by adding another one
>> > > into the tree.
>> >
>> > We can't really deprecate any out-of-the-tree code, because it is
>> > beyond the scope of our influence, so one can argue that taking it
>> > into the tree may actually allow us to deprecate it at one point going
>> > forward. :-)
>> >
>> > Seriously, though, "deprecation" may not be the right term to use
>> > here.  Our goal, IMO, should be to persuade the users of the code in
>> > question to switch over to something else and I'm not really sure if
>> > refusing to take that code into the tree is the best way to achieve
>> > that goal.
>> >
>> > I do believe that if there's a significant piece of code living out of
>> > the tree for a sufficiently long time, the tree is likely to be
>> > missing something important.  Then, it is really difficult to figure
>> > out what is missing without even trying to take that code into the
>> > tree.
>>
>> By far the biggest user of interactive is Android (I'm not aware of its
>> use elsewhere). Persuading Google to switch is relatively doable once a
>> viable alternative exists. After that point I'd expect the desire to
>> merge and maintain interactive would almost immediately disappear. Folks
>> wanting to run upstream kernels on already released devices have much
>> bigger hurdles than merging the interactive governor.
>>
>> But if interactive is merged I'm worried that many other users on random
>> platforms will adopt it, for whatever reason, introducing a support
>> burden during a time that we're trying to develop and encourage an
>> alternative.
>>
>
> Right. It looks a bit odd to merge (and then maintain) something while
> we are actively working on an alternative designed to suit the same kind
> of needs.

I'm not worried too much about the maintenance part.  The code seems
to be mostly self-contained and it shouldn't add too many additional
constraints on the core as far as the interface is concerned.

> Also considering that, with Viresh's effort, the merge
> request will not come from the original authors.

Which may not be a bad thing. ;-)

>> Anyway that's just my $.02 - it'd actually be good for me as
>> again it'd permit easier comparison with schedutil, so I won't complain
>> if it goes in :) .
>>
>
> Anyway, I can't say that comparison would not be much easier. :-)
> Even though we won't run the workloads interactive has been designed for
> on mainline, I guess.

Think about running Android on top of the mainline, though.  That
would be somewhat easier if we had interactive in the mainline,
wouldn't it?
