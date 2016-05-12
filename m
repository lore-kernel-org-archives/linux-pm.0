From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC] Should we add Android's Interactive governor into mainline
 now?
Date: Thu, 12 May 2016 09:36:48 -0700
Message-ID: <20160512163648.GB12886@graphite.smuckle.net>
References: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33730 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbcELQgw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 12:36:52 -0400
Received: by mail-pf0-f176.google.com with SMTP id 206so32651162pfu.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 09:36:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, May 12, 2016 at 07:34:01AM +0530, Viresh Kumar wrote:
> Since we have moved away from the background timers to scheduler
> callbacks, should we consider merging the Interactive governor into
> mainline ?

Merging interactive will help us more easily compare schedutil against
it and get schedutil at or beyond feature parity.

That said my understanding is that the goal is to eventually deprecate
the non-sched governors. That will be made harder by adding another one
into the tree.

