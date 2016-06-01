From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Wed, 01 Jun 2016 18:37:40 +0200
Message-ID: <73262725.a4M1UCMWse@vostro.rjw.lan>
References: <cover.1464694144.git.viresh.kumar@linaro.org> <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com> <20160601104243.GL3725@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62243 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751206AbcFAQdt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 12:33:49 -0400
In-Reply-To: <20160601104243.GL3725@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Steve Muckle <smuckle@linaro.org>

On Wednesday, June 01, 2016 04:12:43 PM Viresh Kumar wrote:
> On 01-06-16, 00:50, Rafael J. Wysocki wrote:
> > I'm not particularly liking this due to the possible confusion that
> > may result from it.
> 
> I have gotten rid of most of it now in V2.
> 
> > Perhaps we can require drivers implementing ->fast_switch to sort
> > their frequency tables to start with?
> 
> I wasn't *only* concerned about the fast-switch case, but the case of
> normal governors that we use today. After all that's what everybody is
> using right now.

Sure, but the "to start with" part of my question was essential.

The ordering didn't matter before, so drivers may do silly things related
to it and those may break if we try to change the rules wholesale.

In turn, if the (prospective) ->fast_switch users are required to clean up
their stuff while working on implementig it, we could avoid that breakage,
or at least some of it.

> And I feel (Maybe you as well), that we are better off using a single
> optimized path for all cases. Otherwise things start getting too messy
> too soon.
> 
> > Or maybe make the core check
> > whether or not the table is sorted
> 
> Platforms are already broken for this, and so wouldn't be possible to
> check for existing governors.

I really don't know what you wanted to say here.

> > and in what order and handle it
> > accordingly?
> 
> We should really be handling a single order to avoid complications in
> it :)

I'm not sure how complicated it would be to be honest.  The sorted cases are
both very similar and it should be possible to handle them both in the same
code regardless of the direction.  The unsorted case is special, but that's
a matter of an extra branch per function.

Anyway, I agree that using one ordering would be cleaner, but I'm sort of
concerned about how painful the switch-over may be to the users.

Thanks,
Rafael

