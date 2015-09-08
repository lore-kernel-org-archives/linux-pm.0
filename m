From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V6] Report interrupt(s) that caused system wakeup
Date: Tue, 08 Sep 2015 17:09:30 +0200
Message-ID: <1528648.teEtKm1WHf@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1509081013450.1533-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55283 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754718AbbIHOlm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 10:41:42 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509081013450.1533-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

On Tuesday, September 08, 2015 10:18:46 AM Alan Stern wrote:
> On Tue, 8 Sep 2015, Rafael J. Wysocki wrote:
> 
> > On Thursday, August 27, 2015 01:00:43 PM Alexandra Yates wrote:
> > > This feature reports which IRQs cause the system to wakeup from sleep last
> > > time it was suspended.
> 
> A minor complaint...  This doesn't actually report which IRQs caused
> the system to wake up.  In reality, it reports all the wakeup-enabled
> IRQs that have occurred since the system went to sleep.

The current version of the patch reports the last one to be precisie.
It should report the first one though I think.

> _One_ of those IRQs was responsible for waking the system up, but the
> others weren't.
>
> In fact, even that previous sentence need not be true.  If a 
> wakeup-enabled IRQ occurs at the right point during a system sleep 
> transition, it can cause the entire transition to be aborted.  The 
> sleep returns to normal operation without ever going fully to sleep.  
> 
> Thus, it would be more accurate to say above that one of those IRQs was
> responsible for waking the system up or preventing the system from
> going to sleep.

Right.

Thanks,
Rafael

