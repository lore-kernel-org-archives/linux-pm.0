From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] PM / Runtime: use deferrable timer for autosuspend
Date: Wed, 13 Jan 2016 20:02:20 +0100
Message-ID: <20160113190220.GC9821@amd>
References: <1452619040-27137-1-git-send-email-l.stach@pengutronix.de>
 <1452619040-27137-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452619040-27137-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Tue 2016-01-12 18:17:20, Lucas Stach wrote:
> The timeouts used in PM autosuspend are relatively coarse (the shortest
> I could find in a quick search through the kernel is 50ms). As they are
> already handled relaxed by saving the overhead of always rearming the
> timer by opportunistically suspending a device a bit early, it should
> not matter if the the timeout is missed slightly.
> 
> By using a deferrable timer the CPU will not be woken just to handle
> the autosuspend timeout, but handling will be batched with other
> wakeups in the system.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
