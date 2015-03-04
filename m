From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Wed, 04 Mar 2015 15:53:11 +0100
Message-ID: <3654949.JbH3Ca4PON@vostro.rjw.lan>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <54F5CC0D.6060509@libero.it> <54F5D13A.1020002@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53068 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758454AbbCDO3g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 09:29:36 -0500
In-Reply-To: <54F5D13A.1020002@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Fulvio <fbf@libero.it>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On Tuesday, March 03, 2015 04:20:26 PM Daniel Lezcano wrote:
> On 03/03/2015 03:58 PM, Fulvio wrote:
> >
> >> I didn't know you experimented random kernel panics and that you thought
> >> it was related to the CPU Idle driver.
> >>
> >>> All i can say is that the system use the "armadaxp_idle" driver and
> >>> works fine when running "stress --cpu 8" in background.
> >>> I asked Netgear to provide a firmware without the idle driver to
> >>> confirm if it's the cause of the problem, but they did not answered.
> >>
> >> I think that if you disable all the state using by doing an
> >>
> >> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/stateNUM/disable
> >>
> >> where NUM is the nuymbert of the state. Then it should disable the
> >> cpuidle on the fly.
> > Thanks, i'll try that as soon as possible (i gave back the unit to my
> > client) and report back.
> >
> > However, the description of the cpu_pm_enter function state:
> > "Must be called on the affected CPU with interrupts disabled.  Platform
> > is responsible for ensuring that cpu_pm_enter is not called twice on the
> > same CPU before cpu_pm_exit is called. Notified drivers can include VFP
> > co-processor, interrupt controller and its PM extensions, local CPU
> > timers context save/restore which shouldn't be interrupted. Hence it
> > must be called with interrupts disabled."
> >
> > and the point is: it that an invariant? Do current code and future code
> > safely assume that cpu_pm_enter is not called twice?
> 
> The fix is correct. The cpu_pm_enter/exit symmetry must be kept because 
> we don't know what the notifier clients are doing.
> 
> The point is : can we send it to stable@ as a bug fix or not ?

Yes, we can, unless there's a risk of breaking things that cannot be
ignored.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
