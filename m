From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Fri, 27 Feb 2015 23:18:46 +0100
Message-ID: <1559887.83x0eLBBFx@vostro.rjw.lan>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com> <4892716.Bf612zPN6E@vostro.rjw.lan> <54F0A04F.20706@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59005 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754632AbbB0VzS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 16:55:18 -0500
In-Reply-To: <54F0A04F.20706@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On Friday, February 27, 2015 05:50:23 PM Daniel Lezcano wrote:
> On 02/26/2015 10:55 PM, Rafael J. Wysocki wrote:
> > On Thursday, February 26, 2015 06:20:48 PM Gregory CLEMENT wrote:
> >> As stated in kernel/cpu_pm.c, "Platform is responsible for ensuring
> >> that cpu_pm_enter is not called twice on the same CPU before
> >> cpu_pm_exit is called.". In the current code in case of failure when
> >> calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is never
> >> called whereas cpu_pm_enter() was called just before.
> >>
> >> This patch moves the cpu_pm_exit() in order to balance the
> >> cpu_pm_enter() calls.
> >>
> >> Reported-by: Fulvio Benini <fbf@libero.it>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> > Should that go to "stable" too?  Which "stable" series it should go to if so?
> 
> Hi Rafael,
> 
> do you mind if I take this fix in my tree ?

Not at all, please go ahead.

> There is the same issue for cpuidle-arm64.c I fixed.

OK


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
