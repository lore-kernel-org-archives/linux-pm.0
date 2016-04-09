From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [regression] cross core scheduling frequency drop bisected to 0c313cb20732
Date: Sat, 9 Apr 2016 14:33:38 +0200
Message-ID: <CAJZ5v0ig1qTTMw5GHO_-vuyETD46tin8bS2deyvtw0OvuDSCng@mail.gmail.com>
References: <1460092854.4051.1.camel@gmail.com>
	<20160408064510.GK3448@twins.programming.kicks-ass.net>
	<1460098254.5582.17.camel@gmail.com>
	<2428384.mEkP3EOpsR@vostro.rjw.lan>
	<1460184056.3765.160.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33983 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbcDIMdk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 08:33:40 -0400
In-Reply-To: <1460184056.3765.160.camel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@redhat.com>

On Sat, Apr 9, 2016 at 8:40 AM, Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> On Fri, 2016-04-08 at 22:59 +0200, Rafael J. Wysocki wrote:
>> On Friday, April 08, 2016 08:50:54 AM Mike Galbraith wrote:
>> > On Fri, 2016-04-08 at 08:45 +0200, Peter Zijlstra wrote:
>> >
>> > > Cute, I thought you used governor=performance for your runs?
>> >
>> > I do, and those numbers are with it thus set.
>>
>> Well, this is a trade-off.
>>
>> 4.5 introduced a power regression here so this one goes back to the previous
>> state of things.
>
> That sounds somewhat reasonable.  Too bad I don't have a super duper
> watt meter handy.. seeing that you really really are saving me money
> would perhaps make me less fond of those prettier numbers.

You can look at the turbostat Watts numbers ("turbostat --debug" and
the last three columns of the output in turbostat as included in the
kernel source).

That requires an Intel CPU with RAPL.
