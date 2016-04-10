From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Sun, 10 Apr 2016 17:39:57 +0200
Message-ID: <1460302797.4383.44.camel@gmail.com>
References: <1460092854.4051.1.camel@gmail.com>
	 <20160408064510.GK3448@twins.programming.kicks-ass.net>
	 <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
	 <20160409110729.GS3448@twins.programming.kicks-ass.net>
	 <CAJZ5v0j-5Eva2QReG4LHvyZR-iL5rrrWp-3erdfz-u+5xbwRKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37184 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbcDJPkC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2016 11:40:02 -0400
In-Reply-To: <CAJZ5v0j-5Eva2QReG4LHvyZR-iL5rrrWp-3erdfz-u+5xbwRKA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@redhat.com>

On Sat, 2016-04-09 at 14:31 +0200, Rafael J. Wysocki wrote:
> On Sat, Apr 9, 2016 at 1:07 PM, Peter Zijlstra <peterz@infradead.org>
> wrote:
> > On Fri, Apr 08, 2016 at 10:59:59PM +0200, Rafael J. Wysocki wrote:
> > > On Friday, April 08, 2016 08:50:54 AM Mike Galbraith wrote:
> > > > On Fri, 2016-04-08 at 08:45 +0200, Peter Zijlstra wrote:
> > > > 
> > > > > Cute, I thought you used governor=performance for your runs?
> > > > 
> > > > I do, and those numbers are with it thus set.
> > > 
> > > Well, this is a trade-off.
> > > 
> > > 4.5 introduced a power regression here so this one goes back to
> > > the previous
> > > state of things.
> > 
> > Just for my elucidation; how can gov=performance have a 'power'
> > regression?
> 
> Because of what is used as the "default" idle state most of the time.
> 
> C1 was used before 4.5 and that changed to polling in 4.5.

Should the default idle state not then be governor dependent?  When I
set gov=performance, I'm expecting box to go just as fast as it can go
without melting.  Does polling risk CPU -> lava conversion?

	-Mike
