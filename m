From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Tue, 10 Jun 2014 14:26:45 -0700
Message-ID: <1402435605.4082.3.camel@joe-AO725>
References: <5396208F.6070400@semaphore.gr>
	 <1875587.zmLYOIAyby@vostro.rjw.lan> <53977251.2090804@semaphore.gr>
	 <1894836.tjrHdJ7Duz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:47038 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752715AbaFJV0w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 17:26:52 -0400
In-Reply-To: <1894836.tjrHdJ7Duz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.brandewie@gmail.com>, dirk.j.brandewie@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, 2014-06-10 at 23:38 +0200, Rafael J. Wysocki wrote:

> > > is.  And the result of (a * 100) / b may generally be different from
> > > a * 100 / b for integers (if the division is carried out first).
> > 
> > I thought that (a * 100) / b is always equivalent to a * 100 / b.
> 
> I'm not actually sure if that's guaranteed by C standards.

It is.  left to right, same precedence.

> It surely
> wasn't some time ago (when there was no formal C standard).

c89 is 25 years ago now.

> Either way, in my opinion it's better to put the parens into the expression
> in this particular case to clearly state the intention.

I don't think so.


