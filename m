From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Thu, 3 May 2007 10:00:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705030946400.3548-100000@iolanthe.rowland.org>
References: <1178097912.13233.54.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178097912.13233.54.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 2 May 2007, Johannes Berg wrote:

> On Wed, 2007-05-02 at 11:16 +0200, Pavel Machek wrote:
> 
> > Well... the powerdown during hibernation... does not have _anything_
> > to do with snapshot/restore. It is really a very deep sleep; similar
> > to soft powerdown, but not quite.

Is this really a good idea?

For that matter, what are the differences among the various sorts of 
poweroff?

	Which devices remain minimally powered for wakeup purposes?

	Anything else?

In fact, shouldn't the poweroff at the end of a hibernate be exactly the 
same as a normal non-hibernate poweroff?  Aren't drivers required to 
assume (during the processing after the snapshot has been restored) that 
power could have been lost and devices might need to be completely 
reinitialized?

We are letting ourselves in for problems if we say that when the snapshot
is restored, devices may or may not need to be reinitialized.  Drivers
might not be able to tell which, so they would have to reinitialize
regardless, losing any advantage.  Even worse, the device may _appear_ not
to need reinitialization because the firmware (BIOS) has already
initialized it but left it in a state that's useless for the kernel's
purposes.  (That's part of the reason why PRETHAW was added.)

If the only remaining difference between poweroff for hibernate and normal 
poweroff is which wakeup devices will function, then it seems pointless.  
Why shouldn't the same devices work for wakeup from hibernate and wakeup 
from normal poweroff?

Or have I misunderstood something and is this all nonsense?

Alan Stern
