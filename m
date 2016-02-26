From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 01/10] sched: Compute cpu capacity available at
 current frequency
Date: Fri, 26 Feb 2016 10:14:46 +0100
Message-ID: <20160226091446.GW6356@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <CAJZ5v0hB7KeUPiwie10TeB3cMSPDLVHB5PMgjFn91SCjjC_KjQ@mail.gmail.com>
 <20160223091916.GF6356@twins.programming.kicks-ass.net>
 <1913831.CWh4G0m0Lj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52400 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcBZJO5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 04:14:57 -0500
Content-Disposition: inline
In-Reply-To: <1913831.CWh4G0m0Lj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Fri, Feb 26, 2016 at 02:37:19AM +0100, Rafael J. Wysocki wrote:

> That's all correct, but my question should rather be: is arch the right
> granularity?
> 
> In theory, there may be ARM64-based platforms using ACPI and behaving
> like x86 in that respect in the future.

Ah, so I started these hooks way before the cpufreq/cpuidle etc.
integration push.

Maybe we should look at something like that, but performance is really
critical, you most definitely do not want 3 indirections just because
abstract framework crap, that's measurable overhead on these callsites.

Hence the current inline with constant value or single function call.
And if archs would want a selector, I would recommend boot time call
instruction rewrites a-la alternatives/paravirt.
