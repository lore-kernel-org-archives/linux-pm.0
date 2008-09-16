From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Tue, 16 Sep 2008 07:16:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809160715120.3606@apollo.tec.linutronix.de>
References: <alpine.LFD.1.10.0809140455470.5283@apollo.tec.linutronix.de> <20080914100913.GB7909@elf.ucw.cz> <20080914101406.GA1625@elf.ucw.cz> <20080914173536.GA1687@elf.ucw.cz> <alpine.LFD.1.10.0809141049570.5283@apollo.tec.linutronix.de>
 <20080914181228.GA18934@elf.ucw.cz> <alpine.LFD.1.10.0809141214110.5283@apollo.tec.linutronix.de> <20080915091925.GB1787@elf.ucw.cz> <alpine.LFD.1.10.0809150704420.5283@apollo.tec.linutronix.de> <20080915192600.GA1627@elf.ucw.cz>
 <20080915195951.GA1651@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754566AbYIPORl@vger.kernel.org>
In-Reply-To: <20080915195951.GA1651@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Mon, 15 Sep 2008, Pavel Machek wrote:
> > cg-seek here, and problem is back. Good. I can get the
> > /proc/timer_list ;-)... attached.
> 
> (Actually, timer_list was from more recent kernel, sorry about that, I
> was confused. But I verified, and 72d... is still broken).

Is the timer_list output is from that "sleepy" state ? If not please
provide one.

Thanks,
	tglx
