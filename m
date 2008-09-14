From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Sun, 14 Sep 2008 19:35:36 +0200
Message-ID: <20080914173536.GA1687@elf.ucw.cz>
References: <20080912083113.GA1625@elf.ucw.cz> <alpine.LFD.1.10.0809140455470.5283@apollo.tec.linutronix.de> <20080914100913.GB7909@elf.ucw.cz> <20080914101406.GA1625@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755349AbYINReX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080914101406.GA1625@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-09-14 12:14:06, Pavel Machek wrote:
> On Sun 2008-09-14 12:09:13, Pavel Machek wrote:
> > On Sun 2008-09-14 04:56:48, Thomas Gleixner wrote:
> > > Pavel,
> > > 
> > > On Fri, 12 Sep 2008, Pavel Machek wrote:
> > > > The old "you have to press keys to get machine to progress" seems to
> > > > be back :-(. Thinkpad x60.
> > > 
> > > Is there a chance that we get some more information than that ?
> > 
> > Yep.
> > 
> > It does not happen after _every_ s2ram, but when it happens the system
> > limps around in half-dead state with non-blinking cursor etc. Next
> > s2ram will not fix it.
> > 
> > nohz=off helps.
> > 
> > Will try 2.6.27-rc6 w/o any custom patches next (not that I have
> > anything interesting in that area), and then probably 2.6.26.
> 
> It _does_ happen with mainline 2.6.27-rc6.

s2ram hs problem in mainline 2.6.26, too. (Different problem: no
ammount pressing shift helps there.) nohz=off cures it, too.

How to proceed?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
