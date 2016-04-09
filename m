From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [regression] cross core scheduling frequency drop bisected to
 0c313cb20732
Date: Sat, 9 Apr 2016 13:07:29 +0200
Message-ID: <20160409110729.GS3448@twins.programming.kicks-ass.net>
References: <1460092854.4051.1.camel@gmail.com>
 <20160408064510.GK3448@twins.programming.kicks-ass.net>
 <1460098254.5582.17.camel@gmail.com>
 <2428384.mEkP3EOpsR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49899 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbcDILHj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 07:07:39 -0400
Content-Disposition: inline
In-Reply-To: <2428384.mEkP3EOpsR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@redhat.com>

On Fri, Apr 08, 2016 at 10:59:59PM +0200, Rafael J. Wysocki wrote:
> On Friday, April 08, 2016 08:50:54 AM Mike Galbraith wrote:
> > On Fri, 2016-04-08 at 08:45 +0200, Peter Zijlstra wrote:
> > 
> > > Cute, I thought you used governor=performance for your runs?
> > 
> > I do, and those numbers are with it thus set.
> 
> Well, this is a trade-off.
> 
> 4.5 introduced a power regression here so this one goes back to the previous
> state of things.

Just for my elucidation; how can gov=performance have a 'power'
regression?
