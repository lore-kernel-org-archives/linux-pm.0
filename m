From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Thu, 3 May 2007 19:17:23 +0200
Message-ID: <200705031917.24417.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705030946400.3548-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705030946400.3548-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 16:00, Alan Stern wrote:
> On Wed, 2 May 2007, Johannes Berg wrote:
> 
> > On Wed, 2007-05-02 at 11:16 +0200, Pavel Machek wrote:
> > 
> > > Well... the powerdown during hibernation... does not have _anything_
> > > to do with snapshot/restore. It is really a very deep sleep; similar
> > > to soft powerdown, but not quite.
> 
> Is this really a good idea?
> 
> For that matter, what are the differences among the various sorts of 
> poweroff?
> 
> 	Which devices remain minimally powered for wakeup purposes?
> 
> 	Anything else?
> 
> In fact, shouldn't the poweroff at the end of a hibernate be exactly the 
> same as a normal non-hibernate poweroff?

Not quite (see (*) below).

> Aren't drivers required to assume (during the processing after the snapshot
> has been restored) that power could have been lost and devices might need to
> be completely reinitialized?
> 
> We are letting ourselves in for problems if we say that when the snapshot
> is restored, devices may or may not need to be reinitialized.

Agreed.

> Drivers might not be able to tell which, so they would have to reinitialize
> regardless, losing any advantage.  Even worse, the device may _appear_ not
> to need reinitialization because the firmware (BIOS) has already
> initialized it but left it in a state that's useless for the kernel's
> purposes.  (That's part of the reason why PRETHAW was added.)

Yes.

> If the only remaining difference between poweroff for hibernate and normal 
> poweroff is which wakeup devices will function, then it seems pointless.

No, this is not the only difference (*).

> Why shouldn't the same devices work for wakeup from hibernate and wakeup 
> from normal poweroff?
> 
> Or have I misunderstood something and is this all nonsense?

The problem, generally speaking, is that we have to prepare devices for waking
up the system.  On an ACPI system this is done, among other things, by
executing the devices' _PSW control methods after the system-level _PTS method
has run.  For this purpose the devices must be in (low) power states from which
the wake is possible, so in particular they must not be powered off.  Later, by
making the platform enter the suspend-to-disk (ACPI S4) state we prevent it
from powering off the wake-up devices, among other things.

That's why I'm thinking that it might be a good idea to do a
suspend-before-poweroff, but it doesn't mean that device drivers would be
allowed to make any assumptions regarding the state of the device after the
resume.  IMO, if this is a resume from disk, devices should be initialized from
scratch.

(*) Another issue is that, for example, on my notebook the status of the AC
power supply (and sometimes of the battery too) is not reported correctly by
the platform after the resume if the suspend-to-disk (ACPI S4) state has not
been entered during the hibernation. I don't understand why this happens, but
I'm going to find out.

Greetings,
Rafael
