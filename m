From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC] Should we add Android's Interactive governor into mainline
 now?
Date: Thu, 12 May 2016 14:10:12 -0700
Message-ID: <20160512211012.GA28594@graphite.smuckle.net>
References: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
 <20160512163648.GB12886@graphite.smuckle.net>
 <CAJZ5v0jYqLKf-ckpEm7dm_jHeUkD6ey_cAgdrgFFuFnMYa-HUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36455 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbcELVKR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 17:10:17 -0400
Received: by mail-pf0-f180.google.com with SMTP id c189so35749857pfb.3
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 14:10:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jYqLKf-ckpEm7dm_jHeUkD6ey_cAgdrgFFuFnMYa-HUw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, May 12, 2016 at 10:34:39PM +0200, Rafael J. Wysocki wrote:
> > That said my understanding is that the goal is to eventually deprecate
> > the non-sched governors. That will be made harder by adding another one
> > into the tree.
> 
> We can't really deprecate any out-of-the-tree code, because it is
> beyond the scope of our influence, so one can argue that taking it
> into the tree may actually allow us to deprecate it at one point going
> forward. :-)
> 
> Seriously, though, "deprecation" may not be the right term to use
> here.  Our goal, IMO, should be to persuade the users of the code in
> question to switch over to something else and I'm not really sure if
> refusing to take that code into the tree is the best way to achieve
> that goal.
> 
> I do believe that if there's a significant piece of code living out of
> the tree for a sufficiently long time, the tree is likely to be
> missing something important.  Then, it is really difficult to figure
> out what is missing without even trying to take that code into the
> tree.

By far the biggest user of interactive is Android (I'm not aware of its
use elsewhere). Persuading Google to switch is relatively doable once a
viable alternative exists. After that point I'd expect the desire to
merge and maintain interactive would almost immediately disappear. Folks
wanting to run upstream kernels on already released devices have much
bigger hurdles than merging the interactive governor.

But if interactive is merged I'm worried that many other users on random
platforms will adopt it, for whatever reason, introducing a support
burden during a time that we're trying to develop and encourage an
alternative.

Anyway that's just my $.02 - it'd actually be good for me as
again it'd permit easier comparison with schedutil, so I won't complain
if it goes in :) .
