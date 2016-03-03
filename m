From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Thu, 3 Mar 2016 09:34:54 +0000
Message-ID: <20160303093454.GS18792@e106622-lin>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-4-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan>
 <56CF9D8F.7010607@linaro.org>
 <20160302074910.10178.35029@quark.deferred.io>
 <CAJZ5v0h7HeQYgx91Z4EQLrWh=xa+NP9zunMUvBy6XLt-863n_A@mail.gmail.com>
 <56D7B46B.9070508@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35475 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756727AbcCCJdv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Mar 2016 04:33:51 -0500
Content-Disposition: inline
In-Reply-To: <56D7B46B.9070508@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ricky Liang <jcliang@chromium.org>

On 02/03/16 19:50, Steve Muckle wrote:
> On 03/02/2016 06:49 PM, Rafael J. Wysocki wrote:
> > I'm not actually sure if RT is the right answer here.  DL may be a
> > better choice.  After all, we want the thing to happen shortly, but
> > not necessarily at full speed.
> > 
> > So something like a DL workqueue would be quite useful here it seems.
> 
> The DL idea seems like a good one to me.
> 
> It would also prevent cpufreq changes from being delayed by other RT or
> DL tasks.
> 

Dimensioning period and runtime could require some experimenting, but
it's worth a try, I agree.

Best,

- Juri
