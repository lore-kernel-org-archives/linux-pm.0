From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC] Should we add Android's Interactive governor into mainline
 now?
Date: Thu, 12 May 2016 23:14:38 -0700
Message-ID: <20160513061438.GB28594@graphite.smuckle.net>
References: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
 <20160512163648.GB12886@graphite.smuckle.net>
 <CAJZ5v0jYqLKf-ckpEm7dm_jHeUkD6ey_cAgdrgFFuFnMYa-HUw@mail.gmail.com>
 <20160512211012.GA28594@graphite.smuckle.net>
 <20160513032156.GE3415@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33124 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcEMGOm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 02:14:42 -0400
Received: by mail-pf0-f170.google.com with SMTP id 206so39165692pfu.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 23:14:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160513032156.GE3415@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Fri, May 13, 2016 at 08:51:56AM +0530, Viresh Kumar wrote:
> On 12-05-16, 14:10, Steve Muckle wrote:
> > By far the biggest user of interactive is Android (I'm not aware of its
> > use elsewhere). Persuading Google to switch is relatively doable once a
> > viable alternative exists. After that point I'd expect the desire to
> > merge and maintain interactive would almost immediately disappear. Folks
> > wanting to run upstream kernels on already released devices have much
> > bigger hurdles than merging the interactive governor.
> > 
> > But if interactive is merged I'm worried that many other users on random
> > platforms will adopt it, for whatever reason, introducing a support
> > burden during a time that we're trying to develop and encourage an
> > alternative.
> 
> Lets assume that its going to take enough time for (specially) Android to start
> using the schedutil governor. That's how it works.

Perhaps I'm more optimistic about schedutil's swift adoption by Google
once it's reached feature parity with interactive.

> So, if we are worried about new users using it (who may not have a good reason
> to do that but did it by mistake), maybe we can make the interactive governor
> depend on CONFIG_ARM.

Is there precedent for putting in artificial dependencies (i.e. ones
with no real runtime technical justification) for this kind of purpose,
i.e. to limit who starts using a merged feature? It seems a bit messy to me.
