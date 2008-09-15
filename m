From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Mon, 15 Sep 2008 21:59:53 +0200
Message-ID: <20080915195951.GA1651@elf.ucw.cz>
References: <alpine.LFD.1.10.0809140455470.5283@apollo.tec.linutronix.de> <20080914100913.GB7909@elf.ucw.cz> <20080914101406.GA1625@elf.ucw.cz> <20080914173536.GA1687@elf.ucw.cz> <alpine.LFD.1.10.0809141049570.5283@apollo.tec.linutronix.de> <20080914181228.GA18934@elf.ucw.cz> <alpine.LFD.1.10.0809141214110.5283@apollo.tec.linutronix.de> <20080915091925.GB1787@elf.ucw.cz> <alpine.LFD.1.10.0809150704420.5283@apollo.tec.linutronix.de> <20080915192600.GA1627@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756919AbYIOV1s@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080915192600.GA1627@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org


> > to
> > 
> > 72d43d9bc9210d24d09202eaf219eac09e17b339
> 
> cg-seek here, and problem is back. Good. I can get the
> /proc/timer_list ;-)... attached.

(Actually, timer_list was from more recent kernel, sorry about that, I
was confused. But I verified, and 72d... is still broken).

Trying commit 7cfb0435330364f90f274a26ecdc5f47f738498c now... bad,
too.

Trying 1fb9b7d29d8e85ba3196eaa7ab871bf76fc98d36... bad, too.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
