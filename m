From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC] Should we add Android's Interactive governor into mainline now?
Date: Thu, 12 May 2016 22:34:39 +0200
Message-ID: <CAJZ5v0jYqLKf-ckpEm7dm_jHeUkD6ey_cAgdrgFFuFnMYa-HUw@mail.gmail.com>
References: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
	<20160512163648.GB12886@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36687 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcELUel (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 16:34:41 -0400
Received: by mail-wm0-f47.google.com with SMTP id n129so273933606wmn.1
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 13:34:40 -0700 (PDT)
In-Reply-To: <20160512163648.GB12886@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, May 12, 2016 at 6:36 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On Thu, May 12, 2016 at 07:34:01AM +0530, Viresh Kumar wrote:
>> Since we have moved away from the background timers to scheduler
>> callbacks, should we consider merging the Interactive governor into
>> mainline ?
>
> Merging interactive will help us more easily compare schedutil against
> it and get schedutil at or beyond feature parity.

Exactly.

> That said my understanding is that the goal is to eventually deprecate
> the non-sched governors. That will be made harder by adding another one
> into the tree.

We can't really deprecate any out-of-the-tree code, because it is
beyond the scope of our influence, so one can argue that taking it
into the tree may actually allow us to deprecate it at one point going
forward. :-)

Seriously, though, "deprecation" may not be the right term to use
here.  Our goal, IMO, should be to persuade the users of the code in
question to switch over to something else and I'm not really sure if
refusing to take that code into the tree is the best way to achieve
that goal.

I do believe that if there's a significant piece of code living out of
the tree for a sufficiently long time, the tree is likely to be
missing something important.  Then, it is really difficult to figure
out what is missing without even trying to take that code into the
tree.
