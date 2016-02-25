From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Thu, 25 Feb 2016 12:04 +0100
Message-ID: <6080807.PFHSVxFDKN@vostro.rjw.lan>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org> <1456190570-4475-4-git-send-email-smuckle@linaro.org> <8427745.Y8N2bqC3SO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59831 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760225AbcBYLC1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 06:02:27 -0500
In-Reply-To: <8427745.Y8N2bqC3SO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>, Juri Lelli <juri.lelli@arm.com>

On Thursday, February 25, 2016 04:55:57 AM Rafael J. Wysocki wrote:
> Hi,
> 

[cut]

> > +	while (true) {
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		if (kthread_should_stop()) {
> > +			set_current_state(TASK_RUNNING);
> > +			break;
> > +		}
> > +		new_request = gd->requested_freq;
> > +		if (!gd->enabled || new_request == last_request) {
> 
> This generally is a mistake.
> 
> You can't assume that if you had requested a CPU to enter a specific P-state,
> that state was actually entered.  In the platform-coordinated case the hardware
> (or firmware) may choose to ignore your request and you won't be told about
> that.
> 
> For this reason, you generally need to make the request every time even if it
> is identical to the previous one.  Even in the one-CPU-per-policy case there
> may be HW coordination you don't know about.

Please scratch this bit, actually (and analogous comments below).

It is reasonable to expect that the platform will remember your last request,
so you don't have to repeat it.

Which means that I can optimize the schedutil thing somewhat. :-)

Thanks,
Rafael

