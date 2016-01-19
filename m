From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM / Runtime: use deferrable timer for autosuspend
Date: Tue, 19 Jan 2016 01:28:38 +0100
Message-ID: <4212628.DRPQ7ihXsj@vostro.rjw.lan>
References: <1452619040-27137-1-git-send-email-l.stach@pengutronix.de> <1452619040-27137-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44946 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755517AbcASA14 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 19:27:56 -0500
In-Reply-To: <1452619040-27137-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de

On Tuesday, January 12, 2016 06:17:20 PM Lucas Stach wrote:
> The timeouts used in PM autosuspend are relatively coarse (the shortest
> I could find in a quick search through the kernel is 50ms). As they are
> already handled relaxed by saving the overhead of always rearming the
> timer by opportunistically suspending a device a bit early, it should
> not matter if the the timeout is missed slightly.
> 
> By using a deferrable timer the CPU will not be woken just to handle
> the autosuspend timeout, but handling will be batched with other
> wakeups in the system.

On some platforms this may increase energy consumption.

Say you have a deep platform-wide idle state (say it is called "C10").
Say this state can only be entered by the platform if device X has
been suspended.  The driver for X has an autosuspend delay of 50 ms,
but the platform can stay up to 0.5s in idle on the average.

Say the last CPU core goes idle and asks for "C10", but X hasn't been
suspended yet, so the platform enters a shallower idle state and
with this change applied it stays in that state for up to 0.5s, but
otherwise it would have been woken up by the X driver's autosuspend
timer and might be able to enter "C10" earlier.

So, I'm not really liking this change that much.

Thanks,
Rafael

