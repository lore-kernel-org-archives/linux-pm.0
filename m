From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Wed, 11 Jun 2014 02:23:27 +0200
Message-ID: <2859027.TirvIA2s2c@vostro.rjw.lan>
References: <5396208F.6070400@semaphore.gr> <1894836.tjrHdJ7Duz@vostro.rjw.lan> <1402435605.4082.3.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50475 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751554AbaFKAGD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 20:06:03 -0400
In-Reply-To: <1402435605.4082.3.camel@joe-AO725>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.brandewie@gmail.com>, dirk.j.brandewie@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, June 10, 2014 02:26:45 PM Joe Perches wrote:
> On Tue, 2014-06-10 at 23:38 +0200, Rafael J. Wysocki wrote:
> 
> > > > is.  And the result of (a * 100) / b may generally be different from
> > > > a * 100 / b for integers (if the division is carried out first).
> > > 
> > > I thought that (a * 100) / b is always equivalent to a * 100 / b.
> > 
> > I'm not actually sure if that's guaranteed by C standards.
> 
> It is.  left to right, same precedence.
> 
> > It surely
> > wasn't some time ago (when there was no formal C standard).
> 
> c89 is 25 years ago now.

Apparently, I'm old.

> > Either way, in my opinion it's better to put the parens into the expression
> > in this particular case to clearly state the intention.
> 
> I don't think so.

Of course, you're free to disagree, but I guess you'll admit that
a * b / c is generally different from b / c * a and if you see something
like this it is hard to say at first sight whether or not this is intentional
or an expression ordering bug.

Rafael

