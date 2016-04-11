From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Mon, 11 Apr 2016 05:04:54 +0200
Message-ID: <1460343894.3682.11.camel@gmail.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <20160409110729.GS3448@twins.programming.kicks-ass.net>
	 <CAJZ5v0j-5Eva2QReG4LHvyZR-iL5rrrWp-3erdfz-u+5xbwRKA@mail.gmail.com>
	 <1460302797.4383.44.camel@gmail.com> <1460319890.25336.2.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33505 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbcDKDE6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2016 23:04:58 -0400
In-Reply-To: <1460319890.25336.2.camel@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On Sun, 2016-04-10 at 16:24 -0400, Rik van Riel wrote:
> On Sun, 2016-04-10 at 17:39 +0200, Mike Galbraith wrote:

> > Should the default idle state not then be governor dependent?  When I
> > set gov=performance, I'm expecting box to go just as fast as it can
> > go
> > without melting.  Does polling risk CPU -> lava conversion?
> 
> Current CPUs can only have some cores run at full speed
> (turbo mode) if other cores are idling and/or running at
> lower speeds.

The real world is very unlikely to miss the prettier numbers I'm
grieving over one tiny bit.  Knowing that doesn't make giving them up
any easier though.. byebye cycles (sniff) ;-)

	-Mike
