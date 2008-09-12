From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.27-rc6: nohz + s2ram = need to press keys to get progress
Date: Fri, 12 Sep 2008 22:45:44 +0200
Message-ID: <200809122245.45723.rjw@sisk.pl>
References: <20080912083113.GA1625@elf.ucw.cz> <200809122117.05750.rjw@sisk.pl> <alpine.LFD.1.10.0809122113270.13819@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757961AbYILUlH@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0809122113270.13819@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Friday, 12 of September 2008, Thomas Gleixner wrote:
> On Fri, 12 Sep 2008, Rafael J. Wysocki wrote:
> 
> > On Friday, 12 of September 2008, Pavel Machek wrote:
> > > Hi!
> > > 
> > > The old "you have to press keys to get machine to progress" seems to
> > > be back :-(. Thinkpad x60.
> > 
> > I guess the last bunch of HPET/clockevents patches caused that to happen.
> 
> Guessing is hardly a good method to get down to the root cause of
> those problems.

Well, sure.

> > We seem to be doing a "one step forward, one step back" thing here ...
> 
> Well, the fixes for HPET/clockevents fix real bugs and there are no
> evident side effects vs. s2ram inside. quite the contrary.

So that must be something different.

Thanks,
Rafael
