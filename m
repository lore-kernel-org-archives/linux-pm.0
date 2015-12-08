From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][experimantal] cpufreq: governor: Use an atomic variable for synchronization
Date: Tue, 08 Dec 2015 15:30:39 +0100
Message-ID: <1843141.WbisoTkq1u@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <10138182.WjU9yqx6Gs@vostro.rjw.lan> <20151208135518.GE3692@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53775 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755218AbbLHOAk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 09:00:40 -0500
In-Reply-To: <20151208135518.GE3692@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, December 08, 2015 07:25:18 PM Viresh Kumar wrote:
> On 08-12-15, 15:19, Rafael J. Wysocki wrote:
> > We know what should be done.  We need to wait for the timer function to
> > complete, then cancel the work item spawned by it (if any) and then
> > cancel the timers set by that work item.
> 
> Yeah, there is no race, but it looks ugly to me. I have written it
> earlier, and then the spinlock thing looked better to me. :)

It doesn't look nice, but then having a lockless timer function is worth
it in my view.

The code in gov_cancel_work() runs relatively rarely, but the timer
function can run very often, so avoiding the lock in there is a priority
to me.

Plus we can avoid disabling interrupts in two places this way.

Thanks,
Rafael

