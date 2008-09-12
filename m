From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Fri, 12 Sep 2008 23:05:15 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0809122303210.13819@apollo.tec.linutronix.de>
References: <20080912083113.GA1625@elf.ucw.cz> <200809122117.05750.rjw@sisk.pl> <alpine.LFD.1.10.0809122113270.13819@apollo.tec.linutronix.de> <200809122245.45723.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757875AbYILVFw@vger.kernel.org>
In-Reply-To: <200809122245.45723.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, 12 Sep 2008, Rafael J. Wysocki wrote:
> > > We seem to be doing a "one step forward, one step back" thing here ...
> > 
> > Well, the fixes for HPET/clockevents fix real bugs and there are no
> > evident side effects vs. s2ram inside. quite the contrary.
> 
> So that must be something different.

well, there is no way to exclude those patches for sure, but Pavel
should be able to identify the one which causes problems.

Thanks,

	tglx
 
