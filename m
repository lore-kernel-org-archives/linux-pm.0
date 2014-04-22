From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched / idle: Make cpuidle_idle_call() void
Date: Wed, 23 Apr 2014 01:36:42 +0200
Message-ID: <107574725.ErYUTC83FZ@vostro.rjw.lan>
References: <4717784.WmVEpDoliM@vostro.rjw.lan> <20140422114930.GH11182@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61919 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751402AbaDVXUX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 19:20:23 -0400
In-Reply-To: <20140422114930.GH11182@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>

On Tuesday, April 22, 2014 01:49:30 PM Peter Zijlstra wrote:
> On Mon, Apr 21, 2014 at 01:26:58AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The only value ever returned by cpuidle_idle_call() is 0 and its
> > only caller ignores that value anyway, so make it void.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Thanks!

OK, thanks, so should it go through my tree or through tip?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
