From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Tue, 1 Mar 2016 14:26:47 +0100
Message-ID: <20160301132647.GV6357@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan>
 <56CF9D8F.7010607@linaro.org>
 <2385082.eyZDGGeAFk@vostro.rjw.lan>
 <56D1236A.3030301@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60458 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbcCAN0v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 08:26:51 -0500
Content-Disposition: inline
In-Reply-To: <56D1236A.3030301@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Fri, Feb 26, 2016 at 08:17:46PM -0800, Steve Muckle wrote:
> > But then it would only make a difference if cpufreq_update_util() was not
> > used at all (ie. no callbacks installed for any policies by anyone).  The
> > only reason why it may matter is that the total number of systems using
> > the performance governor is quite large AFAICS and they would benefit from
> > that.
> 
> I'd think that's a benefit worth preserving, but I guess that's Peter
> and Ingo's call.

Probably worth it, most of this is on rather fast paths.

See commit 1cde2930e154 ("sched/preempt: Add static_key() to
preempt_notifiers") for example.
