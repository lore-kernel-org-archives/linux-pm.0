From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Tue, 21 Jul 2015 22:11:28 +0200
Message-ID: <20150721201128.GA4875@amd>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
 <55A668FE.80409@gmail.com>
 <1A7043D5F58CCB44A599DFD55ED4C948468A7978@fmsmsx115.amr.corp.intel.com>
 <1684935.fYtBRJbzgO@vostro.rjw.lan>
 <20150721093806.GA23841@amd>
 <CAJZ5v0gNKRRaXvfqvj4YEjb+7X1aEobfvWuWyAnAcKArcxtZPA@mail.gmail.com>
 <20150721151941.GA19581@amd>
 <55AE66FC.6060509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44152 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbGUULa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 16:11:30 -0400
Content-Disposition: inline
In-Reply-To: <55AE66FC.6060509@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Austin S Hemmelgarn <ahferroin7@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi!

> >>And I'm not sure what you're talking about here.  Who are the
> >>"affected users" in particular?
> >
> >Who does enter suspend to ram multiple times a second? Only android,
> >AFAICT. Can you run android on mainline kernel? No. Can you run
> >android on kernel with less that 100k lines of patches? No.
> >
> >So who benefits from the new config option? No one.
> You mean aside from the fact that calling sync multiple times during the
> suspend path is wasteful and (potentially) puts unnecessary stress on the
> hardware.  All userspace that I know of calls sync() at least once (and
> sometimes twice) before telling the kernel to enter suspend.  I will
> >>accede

Fix the userland, if that problem bothers you, then.

sync() in userland is racy, sync() after freezer is not supposed to
be.

If you suspend multiple times a second, surely removing extra sync()
calls from your userland is not that much to ask? And actually... do
you know someone who suspends that often an has extra sync? I bet not.

> Also, I'd be willing to bet that FirefoxOS, and whatever Amazon is using on
> their tablets and phones also suspend multiple times a second, and some
> ChromeOS systems might in the near future as well (and ChromeOS is pretty
> darn close to being able to run on mainline).

So can someone from FirefoxOS, Amazon, or ChromeOS present their
requirements?

Because Maemo is in the same league, but got their interfaces right,
and uses low-power CPU modes and runtime power saving to get very nice
results.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
