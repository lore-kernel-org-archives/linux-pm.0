From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [regression] cross core scheduling frequency drop bisected to 0c313cb20732
Date: Sun, 10 Apr 2016 05:44:47 +0200
Message-ID: <CAJZ5v0hDe=pNmWFC6fYADi=vP+WFN+7yvwOZvq_pRMARzUnoiw@mail.gmail.com>
References: <1460092854.4051.1.camel@gmail.com>
	<20160408064510.GK3448@twins.programming.kicks-ass.net>
	<1460098254.5582.17.camel@gmail.com>
	<2428384.mEkP3EOpsR@vostro.rjw.lan>
	<1460184056.3765.160.camel@gmail.com>
	<CAJZ5v0ig1qTTMw5GHO_-vuyETD46tin8bS2deyvtw0OvuDSCng@mail.gmail.com>
	<1460214622.3714.8.camel@gmail.com>
	<1460219974.3700.39.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34268 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbcDJDot (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 23:44:49 -0400
In-Reply-To: <1460219974.3700.39.camel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@redhat.com>

On Sat, Apr 9, 2016 at 6:39 PM, Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
>
> Hm, setting gov=performance, and taking the average of 3 30 second
> interval PkgWatt samples as pipe-test runs..
>
> 714KHz/28.03Ws = 25.46
> 877KHz/30.28Ws = 28.96
>
> ..for pipe-test, the tradeoff look a bit more like red than green.

Well, fair enough, but that's just pipe-test, and what about the
people who don't see the performance gain and see the energy loss,
like Doug?

Essentially, this trades performance gains in somewhat special
workloads for increased energy consumption in idle.  Those workloads
need not be run by everybody, but idle is.

That said I applied the patch you're complaining about mostly because
the commit that introduced the change in question in 4.5 claimed that
it wouldn't affect idle power on systems with reasonably fast C1, but
that didn't pass the reality test.  I'm not totally against restoring
that change, but it would need to be based on very solid evidence.
