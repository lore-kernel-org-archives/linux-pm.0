From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Sun, 10 Apr 2016 16:54:01 +0200
Message-ID: <1460300041.4383.31.camel@gmail.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <1460184056.3765.160.camel@gmail.com>
	 <CAJZ5v0ig1qTTMw5GHO_-vuyETD46tin8bS2deyvtw0OvuDSCng@mail.gmail.com>
	 <1460214622.3714.8.camel@gmail.com> <1460219974.3700.39.camel@gmail.com>
	 <CAJZ5v0hDe=pNmWFC6fYADi=vP+WFN+7yvwOZvq_pRMARzUnoiw@mail.gmail.com>
	 <1460280912.4251.27.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33927 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbcDJOyF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2016 10:54:05 -0400
In-Reply-To: <1460280912.4251.27.camel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@redhat.com>

On Sun, 2016-04-10 at 11:35 +0200, Mike Galbraith wrote:
> On Sun, 2016-04-10 at 05:44 +0200, Rafael J. Wysocki wrote:
> > On Sat, Apr 9, 2016 at 6:39 PM, Mike Galbraith <
> > umgwanakikbuti@gmail.com> wrote:
> > > 
> > > Hm, setting gov=performance, and taking the average of 3 30 second
> > > interval PkgWatt samples as pipe-test runs..
> > > 
> > > 714KHz/28.03Ws = 25.46
> > > 877KHz/30.28Ws = 28.96
> > > 
> > > ..for pipe-test, the tradeoff look a bit more like red than green.
> > 
> > Well, fair enough, but that's just pipe-test, and what about the
> > people who don't see the performance gain and see the energy loss,
> > like Doug?
> 
> Perhaps Doug sees increased power because he's not throttling no_hz,
> whereas I am, so he burns more power getting _to_ idle?  Dunno, maybe
> he'll try the attached.  If it's a general case energy loser, so be it,
> numbers talk, bs walks and all that ;-)

And here are the rest of my numbers..

> tbench     1      2      4     8
> base     752   1283   2250  3362
> 
> select_idle_sibling() off
>          735   1344   2080  2884
> delta   .977  1.047   .924  .857
> 
> select_idle_sibling() on, 0c313cb20732 reverted
>          816   1317   2240  3388
> delta  1.085  1.026   .995 1.007 vs base
> delta  1.110   .979  1.076 1.174 vs off
>                (^hm)

tbench 2 turboboost off
base          1215  1.00   1215/32.24=37.68
revert        1252  1.03   1252/35.82=34.95=loser

tbench 2 throughput hm is apparently a turboboost oddity, and..

tbench (turboboost back on)
power      1      2      4     8
base   23.88  37.41  54.64 62.25
revert 31.25  42.53  55.11 62.66

MB/s/Ws    1      2      4     8
base   31.49  34.29  41.17 54.00
revert 26.11  30.96  40.64 54.06

..while single pipe-test pair said green/green, tbench numbers say
throughput green, but energy efficiency red across the board.

	-Mike
