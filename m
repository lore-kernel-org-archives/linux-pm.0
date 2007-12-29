From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] sleepy linux
Date: Sat, 29 Dec 2007 23:48:20 +0000
Message-ID: <20071229234820.GB17823@ucw.cz>
References: <20071225230731.GA29030@elf.ucw.cz> <200712262123.37152.oliver@neukum.org> <20071226203258.GE8094@elf.ucw.cz> <200712270015.40165.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756067AbXL2WuX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200712270015.40165.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Is there an easy way to tell if all the devices are runtime suspended?
> > > 
> > > Do you really want to know whether they are suspended or whether they
> > > could be suspended?
> > 
> > If they are suspended.
> > 
> > My plan is: let the drivers autosuspend on their own. If I see all of
> > them are autosuspended, then it looks like great time to put whole
> > system into s2ram...
> 
> Your calculation of cost/benefit will be wrong. A driver will have timeouts
> based on the cost of a suspend/resume cycle of that device only.
> You'd have to calculate of keeping the whole system awake against that.

Hmm, right. Driver probably should have chance to autosuspend but tell
the core that whole system probably should not sleep... Hmm....

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
