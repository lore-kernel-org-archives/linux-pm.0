From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [regression] cross core scheduling frequency drop bisected to 0c313cb20732
Date: Fri, 08 Apr 2016 22:59:59 +0200
Message-ID: <2428384.mEkP3EOpsR@vostro.rjw.lan>
References: <1460092854.4051.1.camel@gmail.com> <20160408064510.GK3448@twins.programming.kicks-ass.net> <1460098254.5582.17.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41125 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752864AbcDHU51 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 16:57:27 -0400
In-Reply-To: <1460098254.5582.17.camel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@redhat.com>

On Friday, April 08, 2016 08:50:54 AM Mike Galbraith wrote:
> On Fri, 2016-04-08 at 08:45 +0200, Peter Zijlstra wrote:
> 
> > Cute, I thought you used governor=performance for your runs?
> 
> I do, and those numbers are with it thus set.

Well, this is a trade-off.

4.5 introduced a power regression here so this one goes back to the previous
state of things.

Thanks,
Rafael

