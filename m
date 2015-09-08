From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V6] Report interrupt(s) that caused system wakeup
Date: Tue, 8 Sep 2015 10:18:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509081013450.1533-100000@iolanthe.rowland.org>
References: <7458110.bud3pBbYxc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42192 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754623AbbIHOSr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 10:18:47 -0400
In-Reply-To: <7458110.bud3pBbYxc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

On Tue, 8 Sep 2015, Rafael J. Wysocki wrote:

> On Thursday, August 27, 2015 01:00:43 PM Alexandra Yates wrote:
> > This feature reports which IRQs cause the system to wakeup from sleep last
> > time it was suspended.

A minor complaint...  This doesn't actually report which IRQs caused
the system to wake up.  In reality, it reports all the wakeup-enabled
IRQs that have occurred since the system went to sleep.  _One_ of those
IRQs was responsible for waking the system up, but the others weren't.

In fact, even that previous sentence need not be true.  If a 
wakeup-enabled IRQ occurs at the right point during a system sleep 
transition, it can cause the entire transition to be aborted.  The 
sleep returns to normal operation without ever going fully to sleep.  

Thus, it would be more accurate to say above that one of those IRQs was
responsible for waking the system up or preventing the system from
going to sleep.

Alan Stern

