From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Sun, 14 Sep 2008 20:12:28 +0200
Message-ID: <20080914181228.GA18934@elf.ucw.cz>
References: <20080912083113.GA1625@elf.ucw.cz> <alpine.LFD.1.10.0809140455470.5283@apollo.tec.linutronix.de> <20080914100913.GB7909@elf.ucw.cz> <20080914101406.GA1625@elf.ucw.cz> <20080914173536.GA1687@elf.ucw.cz> <alpine.LFD.1.10.0809141049570.5283@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755425AbYINSLT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809141049570.5283@apollo.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-09-14 10:51:04, Thomas Gleixner wrote:
> On Sun, 14 Sep 2008, Pavel Machek wrote:
> > > It _does_ happen with mainline 2.6.27-rc6.
> > 
> > s2ram hs problem in mainline 2.6.26, too. (Different problem: no
> > ammount pressing shift helps there.) nohz=off cures it, too.
> 
> Ok, so it's not a regression.
> 
> Is the problem in the suspend path or in the resume ?

During resume, on both 2.6.26 and 2.6.27-rc6. (27-rc6 actually resumes
if I keep hitting shift, and I get "sleepy" system after that --
cursor does not blink, but machine can be used -- as long as I keep
hitting keys).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
