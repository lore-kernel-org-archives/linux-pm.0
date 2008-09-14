From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Sun, 14 Sep 2008 10:51:04 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809141049570.5283@apollo.tec.linutronix.de>
References: <20080912083113.GA1625@elf.ucw.cz> <alpine.LFD.1.10.0809140455470.5283@apollo.tec.linutronix.de> <20080914100913.GB7909@elf.ucw.cz> <20080914101406.GA1625@elf.ucw.cz> <20080914173536.GA1687@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755459AbYINRva@vger.kernel.org>
In-Reply-To: <20080914173536.GA1687@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Sun, 14 Sep 2008, Pavel Machek wrote:
> > It _does_ happen with mainline 2.6.27-rc6.
> 
> s2ram hs problem in mainline 2.6.26, too. (Different problem: no
> ammount pressing shift helps there.) nohz=off cures it, too.

Ok, so it's not a regression.

Is the problem in the suspend path or in the resume ?

Thanks,

	tglx
