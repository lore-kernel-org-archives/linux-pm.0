From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Tue, 10 Jun 2014 18:41:19 -0700
Message-ID: <1402450879.4082.6.camel@joe-AO725>
References: <5396208F.6070400@semaphore.gr>
	 <1894836.tjrHdJ7Duz@vostro.rjw.lan> <1402435605.4082.3.camel@joe-AO725>
	 <2859027.TirvIA2s2c@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:60342 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751255AbaFKBlZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 21:41:25 -0400
In-Reply-To: <2859027.TirvIA2s2c@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Dirk Brandewie <dirk.brandewie@gmail.com>, dirk.j.brandewie@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, 2014-06-11 at 02:23 +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 10, 2014 02:26:45 PM Joe Perches wrote:
> > c89 is 25 years ago now.
> Apparently, I'm old.

nah, just older than yesterday.
No doubt better too.

> > > Either way, in my opinion it's better to put the parens into the expression
> > > in this particular case to clearly state the intention.
> > 
> > I don't think so.
> 
> Of course, you're free to disagree, but I guess you'll admit that
> a * b / c is generally different from b / c * a and if you see something
> like this it is hard to say at first sight whether or not this is intentional
> or an expression ordering bug.

true enough.

